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
        
        try {
            delete itemsToDelete;
            delete stepsToDelete;
        } catch (DmlException e) {
            System.debug('restartFlow Error:'+ e);
        }
        
    }
}