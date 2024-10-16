public with sharing class SenderCaseNotificationService {
    private Set<Id> setRecordTypes;
    private List<Case> listCases;
    private Map<Id, Case> mapOldCases;
    private Map<String, List<String>> mapSendTypeToList;
    private SenderCaseNotification varSenderCaseNotification;

    public SenderCaseNotificationService() {
        this.setRecordTypes = getSetRecordTypes();
        this.mapSendTypeToList = getSetMessageType();
    }

    public void sendOnInsert(List<Case> newCases) {
        this.listCases = filterCasesByRecordType(newCases);
        if (this.listCases.isEmpty()) {
            return;
        }

        Map<String, List<Case>> sendTypeCaseMap = new Map<String, List<Case>>();

        for (Case varCase : listCases) {
            String sendType = getSendTypeForNewCase(varCase);

            if (!sendTypeCaseMap.containsKey(sendType)) {
                sendTypeCaseMap.put(sendType, new List<Case>());
            }
            sendTypeCaseMap.get(sendType).add(varCase);
        }

        for (String sendType : sendTypeCaseMap.keySet()) {
            List<Case> casesToSend = sendTypeCaseMap.get(sendType);
            List<String> messageTypes = mapSendTypeToList.get(sendType);
            if(messageTypes != null){
                for(String messageType : messageTypes){
                    sendByUser(casesToSend, messageType, sendType);
                }
            }
        }
    }

    public void sendOnUpdate(List<Case> newCases, Map<Id, Case> oldCases) {
        this.listCases = filterCasesByRecordType(newCases);
        if (this.listCases.isEmpty()) {
            return;
        }
        this.mapOldCases = oldCases;

        Map<String, List<Case>> sendTypeCaseMap = new Map<String, List<Case>>();

        for (Case varCase : listCases) {
            String sendType = getSendTypeForRoutingOrStatusChange(varCase);

            if (sendType != null) {
                if (!sendTypeCaseMap.containsKey(sendType)) {
                    sendTypeCaseMap.put(sendType, new List<Case>());
                }
                sendTypeCaseMap.get(sendType).add(varCase);
            }
        }

        for (String sendType : sendTypeCaseMap.keySet()) {
            List<Case> casesToSend = sendTypeCaseMap.get(sendType);
            List<String> messageTypes = mapSendTypeToList.get(sendType);
            if(messageTypes != null){
                for(String messageType : messageTypes){
                    sendByUser(casesToSend, messageType, sendType);
                }
            }
        }
    }

    private String getSendTypeForNewCase(Case varCase) {
       
        if (varCase.Status == 'A Iniciar') {
            return 'notification,NewA';  // Abertura de Novo Caso, Status = A Iniciar
        } else if (varCase.Status == 'Crítico') {
            return 'notification,email,NewC';  // Abertura de Novo Caso, Status = Crítico
        }
        return null;
    }

    private String getSendTypeForRoutingOrStatusChange(Case varCase) {
        Case oldCase = this.mapOldCases.get(varCase.Id);
        if (oldCase != null && oldCase.OwnerId != varCase.OwnerId) {
            if (varCase.Status == 'A Iniciar') {
                return 'notification,formerOwner,RotA';  // Roteamento para Novo Proprietário, Status = A Iniciar
            } else if (varCase.Status == 'Crítico') {
                return 'notification,email,notifyOnly1,RotC';  // Roteamento para Novo Proprietário, Status = Crítico
            } else if (varCase.Status == 'Aguardando' || varCase.Status == 'Em Andamento') {
                return 'notification,formerOwner,RotA';  // Roteamento para Novo Proprietário, Status = Aguardando/Em Andamento
            } else if (varCase.Status == 'Atenção') {
                return 'notification,email,notifyOnly1,RotAA';  // Roteamento para Novo Proprietário, Status = Atenção
            }
        }

        if (oldCase != null && oldCase.Status != varCase.Status) {
            if (varCase.Status == 'Atenção') {
                return 'notification,email,supervisor,SA';  // Mudança de Status, Status mudou para = Atenção
            } else if (varCase.Status == 'Crítico') {
                return 'notification,email,supervisor,SC';  // Mudança de Status, Status mudou para = Crítico
            }
        }

        return null;
    }

    @InvocableMethod(label = 'send Case notification' iconName = 'slds:utility:alert' category = 'Atendimento')
    public static void sendOnFlowScheduled(List<NoticationCaseModel> listNoticationCaseModels) {
        Map<String, List<Case>> casesGroupedByMessageType = new Map<String, List<Case>>();
        
        for (NoticationCaseModel noticationCaseModel : listNoticationCaseModels) {
           
            for (String message : noticationCaseModel.messageType) {
                
                if (!casesGroupedByMessageType.containsKey(message)) {
                    casesGroupedByMessageType.put(message, new List<Case>());
                }
                
                casesGroupedByMessageType.get(message).add(noticationCaseModel.varCase);
            }
        }
    
        SenderCaseNotificationService sender = new SenderCaseNotificationService();
    
        for (String messageType : casesGroupedByMessageType.keySet()) {
            List<Case> casesToSend = casesGroupedByMessageType.get(messageType);
            if (!casesToSend.isEmpty()) {
                sender.sendByUser(casesToSend, messageType, 'notification,email,supervisor');
            }
        }
    }
    
    private void sendByUser(List<Case> listCasesToSend, String messageType, String sendType) {
        Map<Id, List<Case>> mapOwnerIdListCases = new Map<Id, List<Case>>();
        Set<Id> ownerIds = new Set<Id>();
        this.varSenderCaseNotification = new SenderCaseNotification();
        
        for (Case varCase : listCasesToSend) {
            if (mapOwnerIdListCases.containsKey(varCase.OwnerId)) {
                mapOwnerIdListCases.get(varCase.OwnerId).add(varCase);
            } else {
                mapOwnerIdListCases.put(varCase.OwnerId, new List<Case>{varCase});
            }
            ownerIds.add(varCase.OwnerId);
        }
    
        Map<Id, User> ownersWithSupervisors = new Map<Id, User>(
            [SELECT Id, SupervisorId__c FROM User WHERE Id IN :ownerIds]
        );

        for (Id ownerId : mapOwnerIdListCases.keySet()) {
            List<Case> listCases = mapOwnerIdListCases.get(ownerId);
            Case oldCase;

            try {
                oldCase = this.mapOldCases.get(listCases.get(0).Id);
            }
            catch (Exception e) {
                oldCase = null;
            }
            
            if (!listCases.isEmpty()) {
                Id otherOwner = getOtherOwner(listCases.get(0), oldCase, sendType, ownersWithSupervisors);
                if (ownerId.getSobjectType() == User.SobjectType) {
                    varSenderCaseNotification.sendHub(listCases, messageType, sendType, otherOwner);
                }   
            }
        }
    }
    
    private Id getOtherOwner(Case newCase, Case oldCase, String sendType, Map<Id, User> ownersWithSupervisors) {
        Id otherOwner = null;
    
        if (sendType.contains('supervisor')) {
            if (ownersWithSupervisors.containsKey(newCase.OwnerId)) {
                User caseOwner = ownersWithSupervisors.get(newCase.OwnerId);
                if (caseOwner.SupervisorId__c != null) {
                    otherOwner = caseOwner.SupervisorId__c;
                }
            }
        } else if (sendType.contains('formerOwner') || sendType.contains('notifyOnly1') ) {
            if (oldCase != null) {
                otherOwner = oldCase.OwnerId;
            }
        }
    
        return otherOwner;
    }
    
    private List<Case> filterCasesByRecordType(List<Case> newCases) {
        List<Case> listFilteredCases = new List<Case>();
        for (Case varCase : newCases) {
            if (setRecordTypes.contains(varCase.RecordTypeId)) {
                listFilteredCases.add(varCase);
            }
        }
        return listFilteredCases;
    }

    private Set<Id> getSetRecordTypes() {
        Set<Id> setRecordTypes = new Set<Id>();
        setRecordTypes.add(getRecordTypeInfosByDeveloperName('EmailTrigger'));
        setRecordTypes.add(getRecordTypeInfosByDeveloperName('GoldProcessesEscalation'));
        setRecordTypes.add(getRecordTypeInfosByDeveloperName('WalletProcessesEscalation'));
        setRecordTypes.add(getRecordTypeInfosByDeveloperName('StoreProcessesEscalation'));
        setRecordTypes.add(getRecordTypeInfosByDeveloperName('CommunityOuvidoriaProcessesEscalation'));
        setRecordTypes.add(getRecordTypeInfosByDeveloperName('OuvidoriaProcessesEscalation'));
        setRecordTypes.add(getRecordTypeInfosByDeveloperName('PlatinumProcessesEscalation'));
        setRecordTypes.add(getRecordTypeInfosByDeveloperName('PurpuraProcessesEscalation'));
        setRecordTypes.add(getRecordTypeInfosByDeveloperName('ResellerStoreProcessesEscalation'));
        setRecordTypes.add(getRecordTypeInfosByDeveloperName('SilverProcessesEscalation'));
        setRecordTypes.add(getRecordTypeInfosByDeveloperName('VivoVProcessesEscalation'));
        setRecordTypes.add(getRecordTypeInfosByDeveloperName('VPRStoreProcessesEscalation'));
        return setRecordTypes;
    }

    private Map<String, List<String>> getSetMessageType() {
        Map<String, List<String>> mapListMessage = new Map<String, List<String>>();
        mapListMessage.put('notification,NewA', new List<String>{'RoutingNewOwnerOwner'});
        mapListMessage.put('notification,email,NewC', new List<String>{'RoutingNewOwnerOwnerCrítico'});
        mapListMessage.put('notification,formerOwner,RotA', new List<String>{'RoutingNewOwnerOwner','RoutingNewOwnerFormerOwner'});
        mapListMessage.put('notification,email,notifyOnly1,RotC', new List<String>{'RoutingNewOwnerOwnerCrítico','RoutingNewOwnerFormerOwner'});
        mapListMessage.put('notification,email,notifyOnly1,RotAA', new List<String>{'RoutingNewOwnerOwnerAtenção','RoutingNewOwnerFormerOwner'});
        mapListMessage.put('notification,email,supervisor,SA', new List<String>{'StatusChangeOwnerAtenção','StatusChangeUserAbove2ndAtenção'});
        mapListMessage.put('notification,email,supervisor,SC', new List<String>{'StatusChangeOwnerCrítico','StatusChangeUserAbove2ndCrítico'});
        return mapListMessage;
    }

    private Id getRecordTypeInfosByDeveloperName(String developerName) {
        return Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(developerName).getRecordTypeId();
    }

    public class NoticationCaseModel { 
        @InvocableVariable(label = 'varCase' required = true)
        public Case varCase;
        @InvocableVariable(label = 'messageType' required = true)
        public List<String> messageType;
    }
}