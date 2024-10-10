public with sharing class CasesMyRequestsB2C
{
    public static final String CASE_API_NAME = 'Case';
    public static final String HELP_WITH_BILLING_RECORD_TYPE_API_NAME = 'Helpwithbilling';
    public static final String CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME = 'ChangeOfAddress';
    public static final String HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME = 'HelpWithTheOrder';
    public static final String PROBLEM_WITH_PORTABILITY_RECORD_TYPE_API_NAME = 'ProblemWithPortability';
    public static final String HELP_WITH_INVOICING_OR_BILLING_RECORD_TYPE_API_NAME = 'HelpWithInvoicingorBilling';
    public static final String INVOICE_OR_RECHARGE_COLECTION_RECORD_TYPE_API_NAME = 'InvoiceorRechargeCollection';
    
    private Map<String, Schema.RecordTypeInfo> recordTypeInfoByRecordTypeId;
    private Set<String> recordTypeApiNames;
    private Set<Id> recordTypeIds;
    private List<Case> newCases;
    private Map<Id,Case> oldCases;
    
    // variable to prevent multiple executions
    private Static Boolean requestAllocationOfAttendantsExecuted = false;

    public CasesMyRequestsB2C()
    {
        this.newCases = new List<Case>();
        this.oldCases = new Map<Id, Case>();
        this.setRecodTypeApiNames();
        this.setRecordTypeIds();
        this.setRecordTypeInfos();
        
    }

    public CasesMyRequestsB2C(List<Case> newCases)
    {   
        this.oldCases = new Map<Id, Case>();
        this.setNewCases(newCases);
        this.setRecodTypeApiNames();
        this.setRecordTypeIds();
        this.setRecordTypeInfos();
    }

    public CasesMyRequestsB2C(Map<Id, Case> oldCases)
    {
        this.newCases = new List<Case>();
        this.setOldCases(oldCases);
        this.setRecodTypeApiNames();
        this.setRecordTypeIds();
        this.setRecordTypeInfos();
    }

    public CasesMyRequestsB2C(List<Case> newCases, Map<Id, Case> oldCases)
    {
        this.setNewCases(newCases);
        this.setOldCases(oldCases);
        this.setRecodTypeApiNames();
        this.setRecordTypeIds();
        this.setRecordTypeInfos();
    }

    private void setNewCases(List<Case> newCases)
    {
        this.newCases = newCases;
    }

    private void setOldCases(Map<Id,Case> oldCases)
    {
        this.oldCases = oldCases;
    }

    private void setRecodTypeApiNames()
    {
        this.recordTypeApiNames = new Set<String>();
        this.recordTypeApiNames.add(HELP_WITH_BILLING_RECORD_TYPE_API_NAME);
        this.recordTypeApiNames.add(CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME);
        this.recordTypeApiNames.add(HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME);
        this.recordTypeApiNames.add(PROBLEM_WITH_PORTABILITY_RECORD_TYPE_API_NAME);
        this.recordTypeApiNames.add(HELP_WITH_INVOICING_OR_BILLING_RECORD_TYPE_API_NAME);
        this.recordTypeApiNames.add(INVOICE_OR_RECHARGE_COLECTION_RECORD_TYPE_API_NAME);
    }

    private void setRecordTypeInfos() {
        Map<String, Schema.RecordTypeInfo> recordTypesInfoCase = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName();
        
        Schema.RecordTypeInfo recordTypeInfo;
        this.recordTypeInfoByRecordTypeId = new Map<String, Schema.RecordTypeInfo>();

        recordTypeInfo = recordTypesInfoCase.get(HELP_WITH_BILLING_RECORD_TYPE_API_NAME);
        this.recordTypeInfoByRecordTypeId.put(recordTypeInfo.getRecordTypeId(), recordTypeInfo);

        recordTypeInfo = recordTypesInfoCase.get(CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME);
        this.recordTypeInfoByRecordTypeId.put(recordTypeInfo.getRecordTypeId(), recordTypeInfo);

        recordTypeInfo = recordTypesInfoCase.get(HELP_WITH_THE_ORDER_RECORD_TYPE_API_NAME);
        this.recordTypeInfoByRecordTypeId.put(recordTypeInfo.getRecordTypeId(), recordTypeInfo);

        recordTypeInfo = recordTypesInfoCase.get(PROBLEM_WITH_PORTABILITY_RECORD_TYPE_API_NAME);
        this.recordTypeInfoByRecordTypeId.put(recordTypeInfo.getRecordTypeId(), recordTypeInfo);

        recordTypeInfo = recordTypesInfoCase.get(HELP_WITH_INVOICING_OR_BILLING_RECORD_TYPE_API_NAME);
        this.recordTypeInfoByRecordTypeId.put(recordTypeInfo.getRecordTypeId(), recordTypeInfo);

        recordTypeInfo = recordTypesInfoCase.get(INVOICE_OR_RECHARGE_COLECTION_RECORD_TYPE_API_NAME);
        this.recordTypeInfoByRecordTypeId.put(recordTypeInfo.getRecordTypeId(), recordTypeInfo);
    }

    private void setRecordTypeIds()
    {
        this.recordTypeIds = RecordTypeUtil.getIdsByDevNames(CASE_API_NAME, this.recordTypeApiNames);
    }

    public void addNewCase(Case newCase)
    {
        this.newCases.add(newCase);
    }

    public List<Case> getNewCases()
    {
        return this.newCases;
    }

    public void addOldCase(Case oldCase)
    {
        this.oldCases.put(oldCase.Id, oldCase);
    }

    public Boolean containsRecordTypeId(Id recordTypeId)
    {
        return this.recordTypeIds.contains(recordTypeId);
    }

    public void validade()
    {
        CasesMyRequestsB2CService.validateDuplicates(this.newCases);
    }

    public Integer newCasesSize()
    {
        return this.newCases.size();
    }

    public Integer oldCasesSize()
    {
        return this.oldCases.size();
    }

    public void processFieldsBeforeInsert() {        
        for (Case caseObj : this.newCases) {
            if (caseObj.Status == 'New') {
                Schema.RecordTypeInfo rtInfo = this.recordTypeInfoByRecordTypeId.get(caseObj.RecordTypeId);
                String recordTypeLabel = rtInfo.getName();
                caseObj.Subject = recordTypeLabel;
            }
        }
    }

    public void processFieldsAfterInsert() {
        Set<Id> caseIdsToUpdate = new Set<Id>();
        
        for (Case caseObj : this.newCases) {
            if (caseObj.Status == 'New') {
                caseIdsToUpdate.add(caseObj.Id);
            }
        }

        if (caseIdsToUpdate.isEmpty()) { return; }
        List<Case> casesToUpdate = CaseDAO.get(caseIdsToUpdate);
        String waitingforRoutingQueueId = CasesMyRequestsB2CService.getWaitingForRoutingQueueId();

        for (Case caseObj : casesToUpdate) {
            CasesMyRequestsB2CService.putTheCaseInTheRouting(caseObj, waitingforRoutingQueueId);
            CasesMyRequestsB2CService.changeCaseOwner(caseObj, waitingforRoutingQueueId);
        }
        update casesToUpdate;
    }

    public void processFieldsBeforeUpdate() {
        String waitingforRoutingQueueId = CasesMyRequestsB2CService.getWaitingForRoutingQueueId();

        for (Case caseObj : this.newCases) {
            Case oldCaseObj = this.oldCases.get(caseObj.Id);
            if (CasesMyRequestsB2CService.isCaseOwnerValidForQueue(caseObj, oldCaseObj) && CasesMyRequestsB2CService.isCaseStatusValidForQueue(caseObj.Status)) {
                CasesMyRequestsB2CService.changeCaseOwner(caseObj, waitingforRoutingQueueId);
            }
        }
    }

    public void sendNotificationForCreatedCases() {
        List<Case> createdCases = CasesMyRequestsB2CService.getNewCases(this.newCases, this.oldCases);
        if (createdCases.isEmpty()) { return; }
        sendEmailNotification(createdCases);
    }

    public void sendNotificationForCasesWithUpdatedStatus() {
        List<Case> casesWithStatusChanged = CasesMyRequestsB2CService.getCasesWithUpdatedStatus(this.newCases, this.oldCases);
        if (casesWithStatusChanged.isEmpty()) { return; }
        sendEmailNotification(casesWithStatusChanged);
    }

    public static void sendEmailNotification(List<Case> caseList) {
        Set<Id> caseIds = new Set<Id>();
        Set<Id> accountIds = new Set<Id>();
        Set<Id> assetIds = new Set<Id>();

        for (Case caseRec : caseList) {
            caseIds.add(caseRec.Id);
            accountIds.add(caseRec.AccountId);
            assetIds.add(caseRec.ComplainedAsset__c);
        }

        Map<Id,Case> cases = new Map<Id,Case>(CaseDAO.get(caseIds));
        Map<Id, Account> accounts = new Map<Id, Account>(AccountDAO.getByIds(accountIds));
        Map<Id, Asset> assets = new Map<Id, Asset>(AssetDAO.getBy(assetIds));

        Set<String> accountDocumentNumbers = new Set<String>();
        for (Account accountRec : accounts.values()) { accountDocumentNumbers.add(accountRec.DocumentNumber__c); }

        List<Contact> contacts = ContactDAO.getBy(accountDocumentNumbers);
        Map<String, Contact> contactByAccountDocumentNumbers = new Map<String, Contact>();
        for (Contact contactRec : contacts) { 
            contactByAccountDocumentNumbers.put(contactRec.ExternalId__c, contactRec); }

        for (Case caseRec : cases.values()) {
            System.debug(LoggingLevel.DEBUG, caseRec);
            String templateId = CasesMyRequestsB2CService.determineTemplateId(caseRec.Status);
            Account accountRec = accounts.get(caseRec.AccountId);
            Asset assetRec = assets.get(caseRec.ComplainedAsset__c);
            Contact contactRec = accountRec?.DocumentNumber__c != null ? contactByAccountDocumentNumbers.get(accountRec.DocumentNumber__c) : null;

            if (hasDependencies(templateId, caseRec, accountRec, assetRec, contactRec)) {
                EmailMessagePayload payload = CustomerCommunicationService.buildEmailPaylod(caseRec, accountRec, assetRec, contactRec, templateId);
                System.debug(LoggingLevel.DEBUG, payload);
                CustomerCommunicationService.validadePayload(payload);
                String payloadSerialized = JSON.serialize(payload);
                CustomerCommunicationService.sendEmailMessage(payloadSerialized);
            }
        }
    }

    private static Boolean hasDependencies(String templateId, Case caseRec, Account accountRec, Asset assetRec, Contact contactRec) {
        Boolean returnResult = true;
        if (!hasTemplateId(templateId)) {
            System.debug(LoggingLevel.INFO, 'Não há tempelateId vinculado ao status do caso.');
            returnResult = false;
        }
        else if (!hasProtocol(caseRec)) { 
            System.debug(LoggingLevel.INFO, 'Caso sem Protocolo.');
            returnResult = false;
        }
        else if (!hasRecordDependencies(accountRec, assetRec, contactRec)) { 
            System.debug(LoggingLevel.INFO, 'Caso sem Conta, Produto ou Contato vinculado.');
            returnResult = false;
        } 
        else if (!hasEmail(contactRec)) { 
            System.debug(LoggingLevel.INFO, 'Contato sem Email vinculado.');
            returnResult = false;
        }
        return returnResult;
    }

    private static Boolean hasTemplateId(String templateId) {
        return !String.isBlank(templateId);
    }

    private static Boolean hasRecordDependencies(Account accountRec, Asset assetRec, Contact contactRec) {
        return (accountRec != null && assetRec != null && contactRec != null);
    }

    private static Boolean hasEmail(Contact contactRec) {
        return !String.isBlank(contactRec.Email);
    }

    public void requestAllocationOfAttendantsForCasesWithUpdatedStatus() {
        List<Case> casesWithStatusChanged = CasesMyRequestsB2CService.getCasesWithUpdatedStatus(this.newCases, this.oldCases);
        if (casesWithStatusChanged.isEmpty()) { return; }
        requestAllocationOfAttendants(casesWithStatusChanged);
    }

    public static void requestAllocationOfAttendants(List<Case> caseList) {
        
        // logic to prevent multiple executions
        if (requestAllocationOfAttendantsExecuted) { return; }
        requestAllocationOfAttendantsExecuted = true;

        Set<Id> caseIds = new Set<Id>();
        Set<Id> accountIds = new Set<Id>();
        Set<Id> assetIds = new Set<Id>();
        
        for (Case caseRec : caseList) {
            if(CasesMyRequestsB2CService.isCaseStatusValidForRouting(caseRec.Status)) {
                caseIds.add(caseRec.Id);
                accountIds.add(caseRec.AccountId);
                assetIds.add(caseRec.ComplainedAsset__c);
            }
            
        }

		Map<Id, Case> cases = new Map<Id, Case>(CaseDAO.get(caseIds));
        Map<Id, Account> accounts = new Map<Id, Account>(AccountDAO.getByIds(accountIds));
        Map<Id, Asset> assets = new Map<Id, Asset>(AssetDAO.getBy(assetIds));
        
        Map<Id, CaseDetail__c> caseDetails = new Map<Id, CaseDetail__c>();
        for (CaseDetail__c caseDetailRec: CaseDetailsDAO.getByCaseIds(caseIds)) {
            caseDetails.put(caseDetailRec.Case__c, caseDetailRec);
        }

        for (Case caseRec : cases.values()) {
            Account accountRec = accounts.get(caseRec.AccountId);
            Asset assetRec = assets.get(caseRec.ComplainedAsset__c);
            CaseDetail__c caseDetailRec = caseDetails.get(caseRec.Id);
                
            if (hasDependencies(caseRec, accountRec, assetRec)) {
                // Defines routing parameters
                String action = CasesMyRequestsB2CService.theCaseHasAlreadyBeenHandledByAnAgent(caseDetailRec) 
                    ? ContactCenterService.ACTION_AGENT_QUEUE : '';
                String agentLogin = CasesMyRequestsB2CService.theCaseHasAlreadyBeenHandledByAnAgent(caseDetailRec) 
                    ? caseDetailRec.LastSourceSystemAgent__r.Login__c : '';
            
                OpenMediaInteractionPayload payload;
                payload = ContactCenterService.buildOpenMediaInteractionPayLoad(caseRec, accountRec, assetRec);
                ContactCenterService.populateRountingFields(payload, agentLogin, action);
                ContactCenterService.validadePayload(payload);
                String payloadSerialized = JSON.serialize(payload);
                System.debug(LoggingLevel.INFO, payloadSerialized);
                ContactCenterService.createOpenMediaInteraction(payloadSerialized);
            }
        }
    }

    private static Boolean hasDependencies(Case caseRec, Account accountRec, Asset assetRec) {
        Boolean hasDependencies = true;
        if (!hasProtocol(caseRec)) { 
            System.debug(LoggingLevel.INFO, 'Caso sem Protocolo.');
            hasDependencies = false;
        }
        if (!hasRecordDependencies(accountRec, assetRec)) { 
            System.debug(LoggingLevel.INFO, 'Caso sem Conta ou Produto vinculado.');
            hasDependencies = false;
        } 
        return hasDependencies;
    }

    private static Boolean hasProtocol(Case caseRec) {
        return !String.isBlank(caseRec.Protocol__c);
    }

    private static Boolean hasRecordDependencies(Account accountRec, Asset assetRec) {
        return (accountRec != null && assetRec != null);
    }
}