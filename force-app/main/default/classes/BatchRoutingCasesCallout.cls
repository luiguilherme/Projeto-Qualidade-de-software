public class BatchRoutingCasesCallout implements Database.Batchable<sObject>, Database.AllowsCallouts { 
    public static final String ROUNTING_N1 = 'Automático N1';
    public static final String ROUNTING_N2 = 'Automático N2';
    public static final String ROUNTING_NX = 'Automático N2 e Automático N3';
    public static final String ROUNTING_MANUAL = 'Manual';
    
    public static final String ORG_VIVO = 'Vivo';
    public static final String ORG_COMUNIDADES = 'Comunidades';

    private List<Case> ltCases;
 	private Map<Id, String> casesWithPriorities = new Map<Id, String>();
    
    private Map<Id, Account> accountFromCases;
    private Map<Id, User> userFromCases;
    private List<FromToMapping__mdt> ltFromToMapping;
	private Map<String, String> operatorSegmentFromMdt;
    private Map<String, String> routingLevelFromMdt;
    private Map<String, String> interactionReasonMap;
        
    public BatchRoutingCasesCallout(List<Case> ltCases, Map<Id, String> casesWithPriorities) {
        this.ltCases = ltCases;
        this.casesWithPriorities = casesWithPriorities;
        
        Set<Id> accountIds = new Set<Id>();
        Set<Id> userIds = new Set<Id>();
		Id userAgentId;
        
        for (Case item : ltCases) {
            accountIds.add(item.accountId);

            userAgentId = (
                (item.OwnerId != null && !item.OwnerId.to15().startsWith('00G')) 
                ? item.OwnerId 
                : item.CreatedById
            );

            userIds.add(userAgentId);
        }
        
        accountFromCases = new Map<Id, Account>(AccountDAO.getByIds(accountIds));
        userFromCases = new Map<Id, User>(UserDAO.getById(userIds));

        ltFromToMapping = FromToMappingDAO.getByObjectNameAndUsedIn(
            new Set<String>{'User', 'Role'}, 
            'ServiceFlow'
        );

        operatorSegmentFromMdt = new Map<String, String>();

        for (FromToMapping__mdt item : ltFromToMapping) {
            operatorSegmentFromMdt.put(
                (item.Object__c + item.OriginName__c), 
                (item.OperatorSegment__c ?? '')
            );
        }

        List<ToFromHDE2__mdt> ltToFromHDE2 = [
            SELECT
                CustomerSegment__c, 
                OperatorSegment__c, 
                CaseRecordType__c, 
                ORG__c, 
                CustomerServiceReason__c, 
                Routing__c
            FROM
                ToFromHDE2__mdt
        ];

        routingLevelFromMdt = new Map<String, String>();

        for (ToFromHDE2__mdt item : ltToFromHDE2) {
            routingLevelFromMdt.put(
                (item.CustomerSegment__c + item.OperatorSegment__c + item.CaseRecordType__c + item.ORG__c + 
                    item.CustomerServiceReason__c
                ), 
                (item.Routing__c ?? '')
            );
        }

        interactionReasonMap = new Map<String, String>{
            'CRI E-mail V' => 'Acionamento E-mail V',
            'CRI Escalonamento Gold' => 'Processos Escalonamento Gold',
            'CRI Escalonamento Púrpura' => 'Processos Escalonamento Purpura',
            'CRI Escalonamento Silver' => 'Processos Escalonamento Silver',
            'CRI Escalonamento Loja' => 'Processos Escalonamento Lojas',
            'CRI Escalonamento Lojas (Revendas)' => 'Processos Escalonamento Revendas',
            'CRI Escalonamento Platinum' => 'Processos Escalonamento Platinum',
            'CRI Escalonamento Ouvidoria' => 'Processos Escalonamento Ouvidoria',
            'CRI Escalonamento Ouvidoria Comunidades' => 'Processos Escalonamento Ouvidoria',
            'CRI Escalonamento VPR Lojas' => 'Processos Escalonamento VPR',
            'CRI Escalonamento V' => 'Processos Escalonamento V',
            'CRI Escalonamento Carteira' => 'Processos Escalonamento Carteira'
        };
    }
    
    public Iterable<Case> start(Database.BatchableContext info) { 
        return (ltCases);
    }
    
    public void execute(Database.BatchableContext info, List<Case> ltCases) {
        String caseRecordTypeName;
        String interactionReason;
        String serviceReason;
        Id userAgentId;
        String priority;
        User userAgent;
        String userORG;
        Account accountRecord;
        String customerSegment;
        String operatorSegment;
        String routingLevel;
        String action;
        String agent;
        ContactCenterService.Params params;
        OpenMediaInteractionPayload payloadForRouting;
        String payloadAutomaticRouting;

        for (Case caseForRounting : ltCases) {
            caseRecordTypeName = caseForRounting.RecordType.DeveloperName;
            interactionReason = (caseForRounting.View__c ?? '');
            serviceReason = (caseForRounting.CustomerServiceReason__c ?? '');

            interactionReason = (
                interactionReasonMap.containsKey(interactionReason) 
                ? interactionReasonMap.get(interactionReason) 
                : ''
            );

            priority = this.casesWithPriorities.get(caseForRounting.Id);

            userAgentId = ((caseForRounting.OwnerId != null && !caseForRounting.OwnerId.to15().startsWith('00G')) 
                ? caseForRounting.OwnerId 
                : caseForRounting.CreatedById
            );
            
            userAgent = userFromCases.get(userAgentId);
            userORG = ((userAgent.Profile.UserLicense.Name == 'Partner Community') ? ORG_COMUNIDADES : ORG_VIVO);

            accountRecord = accountFromCases.get(caseForRounting.AccountId);
            customerSegment = (accountRecord.vlocity_cmt__CustomerValue__c ?? '');

            operatorSegment = operatorSegmentFromMdt.get(
                ((userORG == ORG_VIVO) ? 'Role': 'User') + 
                ((userORG == ORG_VIVO) ? userAgent.UserRole.DeveloperName : userAgent.PartnerGroup__c)
            );

            routingLevel = routingLevelFromMdt.get(
                customerSegment + operatorSegment + caseRecordTypeName + userORG + serviceReason
            );

            action = ((routingLevel == ROUNTING_N1 || (caseForRounting.OwnerId != null && !caseForRounting.OwnerId.to15().startsWith('00G')))
                ? ContactCenterService.ACTION_AGENT_STOP 
                : ''
            );

            agent = ((routingLevel == ROUNTING_N1 || (caseForRounting.OwnerId != null && !caseForRounting.OwnerId.to15().startsWith('00G')))
                ? userAgent.Login__c 
                : ''
            );

            if (!String.isBlank(interactionReason)) {
                interactionReason = (interactionReason + '_' + ((userORG == ORG_COMUNIDADES) ? 'OUT': 'IN'));
            }
        
            params = new ContactCenterService.Params();

            params.serviceType = ContactCenterService.INTEGRATIONTYPE_ROUTING;
            params.userAgent = userAgent;
            params.userORG = userORG;

            params.action = action;
            params.agent = agent;
            params.priority = priority;
            params.interactionReason = interactionReason;
            params.interactionDetail = serviceReason;
            params.productSubType = (accountRecord.vlocity_cmt__CustomerValue__c ?? '');
            
            params.caseRecord = caseForRounting;
            params.accountRecord = accountRecord;

            payloadForRouting = ContactCenterService.buildOpenMediaInteractionPayLoad(params);
            
            ContactCenterService.validadePayload(payloadForRouting);

            payloadAutomaticRouting = JSON.serialize(payloadForRouting, true);

            ContactCenterService.callCreateOpenMediaInteraction(payloadAutomaticRouting);
        }
    }
    
	public void finish(Database.BatchableContext info) {
        
    }
}
