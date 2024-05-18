/* -------------------------------------------------------------------------
* Autor....: Renan S. de Freitas - Deloitte
* Data.....: 09/04/2024
* Objetivo.: J21 - Troca de SimCard - Loja Própria - Solicitar autorização para alçada
*  -------------------------------------------------------------------------
*/ 
@isTest
public class ApprovalProcessServiceTest
{
    @TestSetup
    static void setup()
    {
        Account objAccount = new Account();
        objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Billing').getrecordTypeId();
        objAccount.Name = 'Account Test';
        objAccount.DocumentNumber__c = '11111111111111';
        objAccount.vlocity_cmt__CustomerClass__c = 'Móvel';
        objAccount.CustomerSegment__c = 'PLATINUM';
        objAccount.vlocity_cmt__Active__c = 'Yes';
        objAccount.ExternalId__c = '899941326811';
        insert objAccount; 
        
        order objOrder = new Order();
        objOrder.Name = 'Teste Order';
        objOrder.AccountId = objAccount.Id;
        objOrder.EffectiveDate = Date.newInstance(1960, 2, 17);
        objOrder.Status = 'Draft';
        insert objOrder;
        
        Approval.ProcessSubmitRequest objProcessSubmitRequest = new Approval.ProcessSubmitRequest();
        objProcessSubmitRequest.setComments('Submitting request for approval.');
        objProcessSubmitRequest.setObjectId(objOrder.Id);
        objProcessSubmitRequest.setSubmitterId(UserInfo.getUserId());
        objProcessSubmitRequest.setProcessDefinitionNameOrId('ChangeSimCard');
        objProcessSubmitRequest.setSkipEntryCriteria(true);   
        objProcessSubmitRequest.setNextApproverIds(new Id[] {UserInfo.getUserId()});
        Approval.ProcessResult result = Approval.process(objProcessSubmitRequest);
        
    }
    
    @isTest
    static void approvalProcessTest()
    {
        Order objOrder = [SELECT ID FROM Order LIMIT 1];
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        inputs.put('TargetObjectId', objOrder.Id);
        
        ApprovalProcessService approvalProcessService = new ApprovalProcessService();
        approvalProcessService.invokeMethod('approvalProcess', inputs, output, options);
        System.debug('output: ' + JSON.serializePretty(output));
        
        System.assertEquals(true, (Boolean)output.get('success'), 'Processo de aprovação foi bem sucedido');
    }
}