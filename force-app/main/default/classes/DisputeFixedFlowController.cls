public with sharing class DisputeFixedFlowController {
    @InvocableMethod(label='Funcionário tem Escopo?')
    public static LIST<String> DisputeCheckScope(LIST<DisputeCheckScopeInputs> parameters){
        GeneralSetting__c disputeScope = GeneralSettingDAO.getGeneralSettingbyName(parameters.get(0).Name,parameters.get(0).recortTypeName);
        User infoUser = UserDAO.getById(UserInfo.getUserId());
        FromToMapping__mdt fromToMap = FromToMappingDAO.getRecordByUsersRoleAndUsedIn(infoUser.Profile.UserLicense.name == 'Partner Community'? infoUser.PartnerGroup__c : infoUser.UserRole.DeveloperName , 'ServiceFlow');

        LIST<String> result =  new LIST<String>();
        result.add(disputeScope.OperatorSegment__c.contains(fromToMap.OperatorSegment__c.contains('Adm')? fromToMap.OperatorSegment__c : fromToMap.OperatorSegment__c.toUpperCase()) ? 'Sim' : 'Não');
        return result;
    }

    public class DisputeCheckScopeInputs{
        @InvocableVariable
        public String Name;
    
        @InvocableVariable
        public String recortTypeName;
    }
    @AuraEnabled()
    public static void restartFlow(String caseId){

        LIST<DisputedItem__c> itemsToDelete = DisputedItemDAO.getByCaseId(caseId);

        LIST<FlowExecutionStepHistory__c> stepsToDelete = FlowExecutionStepHistoryDAO.getByCaseId(caseId);

        DisputedInvoice__c invoiceToDelete = DisputedInvoiceDAO.findByCaseId(caseId);

        try {
            delete itemsToDelete;
            delete stepsToDelete;
            delete invoiceToDelete;
        } catch (DmlException e) {
            System.debug('restartFlow Error:'+ e);
        }
        
    }

    @AuraEnabled(cacheable=false)
    public static Map<String,String> getParamsByAccountId(Id accountId) {
        Map<String,String> result = new Map<String,String>();

        list<Asset> assets = AssetDAO.getAssetPhoneByAccount(accountId);
        String phoneNumber = assets.size() > 0 && assets[0].vlocity_cmt__ServiceIdentifier__c.length() == 11 ? assets[0].vlocity_cmt__ServiceIdentifier__c : '';
        result.put('customerPhoneNumber', phoneNumber);
        return result;
    }

    @AuraEnabled(cacheable=false)
    public static Case getCaseParam(Id caseId) {
        return CaseDAO.getCasebyId(caseId);
    }

    @AuraEnabled(cacheable=false)
    public static Map<String,String> getCustomerInteractions(Id caseId) {
        Map<String,String> result = new Map<String,String>();

        vlocity_cmt__CustomerInteractionTopic__c interactionTopic = CustomerInteractionTopicDAO.getByCaseId(caseId);
        Case interaction = CaseDAO.getCustomerInteractionByCaseId(caseId);
        result.put('interactionTopicId',interactionTopic.Id);
        result.put('interactionId', interaction.CustomerInteractionId__c);
        result.put('uraInteraction', interaction.CustomerInteractionId__r.InteractionNumber__c);
        return result;
    }
}