public with sharing class HDECasesService {
    public static void validateNewOwnerSegment(List<Case> lstCases) {
        User currentUser = UserDAO.getById(UserInfo.getUserId());
        if (hasHDEPermission() && currentUser.Profile.UserLicense.name != 'Partner Community') {
            List<Case> lstChangedCase = new List<Case>();
            Set<Id> setOwnerId = new Set<Id>();
            for (Case iCase : lstCases) {
                if (iCase.Origin == 'HDE' && TriggerHelper.changedField(iCase, new Set<String>{'CaseOwnerFormula__c'})) {
                    lstChangedCase.add(iCase);
                    setOwnerId.add(iCase.OwnerId);
                }
            }

            if (!lstChangedCase.isEmpty()) {

                List<User> lstAllOwnersUsers = UserDAO.getById(setOwnerId);
                Set<String> setOwnersPartnerGroups = new Set<String>{currentUser.UserRole.DeveloperName};

                for (User iUser : lstAllOwnersUsers) {
                    setOwnersPartnerGroups.add(iUser.PartnerGroup__c);
                }

                List<FromToMapping__mdt> lstSegmentsAvailable = FromToMappingDAO.getLstByUsersRole(setOwnersPartnerGroups);

                if (lstSegmentsAvailable.isEmpty()) {
                    for (Case iCase : lstChangedCase) {
                        iCase.addError('Papel está sem o segmento cadastrado no De/Para');
                    }
                }
                setOwnersPartnerGroups.clear();
                
                String currentUserSegment;
                for(FromToMapping__mdt role : lstSegmentsAvailable){
                    if (role.OperatorSegment__c != null && role.OriginApiName__c == currentUser.UserRole.DeveloperName) {
                        currentUserSegment = role.OperatorSegment__c;
                    }

                    setOwnersPartnerGroups.add(role.OriginApiName__c);
                }

                List<User> lstAllUserWithSegment = UserDAO.getUserByRole(setOwnersPartnerGroups);
                Map<String, List<Id>> mapUserSegment = new Map<String, List<Id>>();

                fillMapWithAvailableSegments(mapUserSegment, lstSegmentsAvailable, lstAllUserWithSegment);

                for (Case iCase : lstChangedCase) {
                    if (currentUserSegment != iCase.Segment__c) {
                        iCase.addError('Este usuário não pode alterar o proprietário para outro se não estiver no mesmo segmento do caso');
                    } else if(!mapUserSegment.containsKey(iCase.Segment__c)){
                        iCase.addError('Não pode alterar o proprietário para outro se usuário destino não estiver no mesmo segmento do caso');
                    }
                }
            }
        }
    }

    public static Boolean hasHDEPermission() {
        List<PermissionSetAssignment> lstPermissionsAssigments = PermissionSetDAO.getAllPermissionSetByUserId(UserInfo.getUserId());
        Pattern regexPatternPerformance = Pattern.compile('\\b.*Performance.*\\b'); 
        Pattern regexPatternProcess = Pattern.compile('\\bHDE.*Processos.*Escalonamento\\b'); 
        Boolean hasAtLeastAHDEPermission = false;
        Boolean hasAtLeastPerfomancePermission = false;
        for(PermissionSetAssignment iPerm : lstPermissionsAssigments){
            Matcher matcherProcess = regexPatternProcess.matcher(iPerm.PermissionSet.Label); //Regex para validar se tem as palavras 'HDE' e 'Processos' e 'Escalonamento' na permission Set 
            Matcher matcherPerformance = regexPatternPerformance.matcher(iPerm.PermissionSet.Label); //Regex para validar se tem a palavra 'Perfomance' na permission Set 
            if (matcherProcess.find()) {
                hasAtLeastAHDEPermission = true;
            } else if (matcherPerformance.find()){
                hasAtLeastPerfomancePermission = true;
            }
        }

        return hasAtLeastPerfomancePermission && hasAtLeastAHDEPermission;
    }

    public static void fillMapWithAvailableSegments(Map<String, List<Id>> mapUserSegment, List<FromToMapping__mdt> lstSegmentsAvailable, List<User> lstAllUserWithSegment) {
        for (FromToMapping__mdt iFromMdt : lstSegmentsAvailable) {
            for (Integer i = 0; i < lstAllUserWithSegment.size(); i++) {
                if (iFromMdt.OriginApiName__c == lstAllUserWithSegment[i].PartnerGroup__c) {
                    if (mapUserSegment.containsKey(iFromMdt.OperatorSegment__c)) {
                        List<Id> lstUserTemp = mapUserSegment.get(iFromMdt.OperatorSegment__c);
                        lstUserTemp.add(lstAllUserWithSegment[i].Id);
                        mapUserSegment.put(iFromMdt.OperatorSegment__c, lstUserTemp);
                    } else{
                        mapUserSegment.put(iFromMdt.OperatorSegment__c, new List<Id> {lstAllUserWithSegment[i].Id});
                    }
                    lstAllUserWithSegment.remove(i);
                }
            }
        }
    }
}