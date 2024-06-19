@isTest
public with sharing class DisputeCheckLast45DaysTest {
   
    @TestSetup
    static void makeData()
    {
        Account acc = new Account();
        acc.name = 'testDispute45Days';
        insert acc;

        Case case0 = new Case();
        case0.AccountId = acc.id;
        insert case0;

        DisputedItem__c itemEmAnalise = new DisputedItem__c();
        itemEmAnalise.CaseId__c = case0.id;
        itemEmAnalise.Description__c = 'itemEmAnalise';
        itemEmAnalise.Status__c = 'InAnalisys';
        insert itemEmAnalise;

        DisputedItem__c itemNegado = new DisputedItem__c();
        itemNegado.CaseId__c = case0.id;
        itemNegado.Description__c = 'itemNegado';
        itemNegado.Status__c = 'Denied';
        insert itemNegado;

        DisputedItem__c itemContestado = new DisputedItem__c();
        itemContestado.CaseId__c = case0.id;
        itemContestado.Description__c = 'itemContestado'; 
        itemNegado.Status__c = 'Approved';
        insert itemContestado;
    }
    
    @isTest
    static void disputeCheckLast45DaysDenied()
    {
        DisputeCheckLast45Days.DisputeCheckLast45DaysInputs parameters = new DisputeCheckLast45Days.DisputeCheckLast45DaysInputs();
        List<DisputeCheckLast45Days.DisputeCheckLast45DaysInputs> inputs = new List<DisputeCheckLast45Days.DisputeCheckLast45DaysInputs>();
        parameters.accountId = [SELECT Id FROM Account WHERE Account.Name = 'testDispute45Days' LIMIT 1].Id;
        parameters.description = 'itemNegado';
        inputs.add(parameters);

        Test.startTest();
        List<DisputeCheckLast45Days.DisputeCheckLast45DaysOutputs> result = DisputeCheckLast45Days.checkLast45Days(inputs);
        Test.stopTest();

        System.assertEquals(result.get(0).checaContestacao, 'Sim');
        System.assertEquals(result.get(0).checaNegada, 'Sim');
    }

    @isTest
    static void disputeCheckLast45DaysInAnalysis()
    {
        DisputeCheckLast45Days.DisputeCheckLast45DaysInputs parameters = new DisputeCheckLast45Days.DisputeCheckLast45DaysInputs();
        List<DisputeCheckLast45Days.DisputeCheckLast45DaysInputs> inputs = new List<DisputeCheckLast45Days.DisputeCheckLast45DaysInputs>();
        parameters.accountId = [SELECT Id FROM Account WHERE Account.Name = 'testDispute45Days' LIMIT 1].Id;
        parameters.description = 'itemEmAnalise';       
        inputs.add(parameters); 
        
        Test.startTest();
        List<DisputeCheckLast45Days.DisputeCheckLast45DaysOutputs> result = DisputeCheckLast45Days.checkLast45Days(inputs);
        Test.stopTest();

        System.assertEquals(result.get(0).checaContestacao, 'Não');
        System.assertEquals(result.get(0).checaNegada, 'Não');
    }

    @isTest
    static void disputeCheckLast45DaysContested()
    {
        DisputeCheckLast45Days.DisputeCheckLast45DaysInputs parameters = new DisputeCheckLast45Days.DisputeCheckLast45DaysInputs();
        List<DisputeCheckLast45Days.DisputeCheckLast45DaysInputs> inputs = new List<DisputeCheckLast45Days.DisputeCheckLast45DaysInputs>();
        parameters.accountId = [SELECT Id FROM Account WHERE Account.Name = 'testDispute45Days' LIMIT 1].Id;
        parameters.description = 'itemContestado';
        inputs.add(parameters);
        
        Test.startTest();
        List<DisputeCheckLast45Days.DisputeCheckLast45DaysOutputs> result = DisputeCheckLast45Days.checkLast45Days(inputs);
        Test.stopTest();
        
        System.assertEquals(result.get(0).checaContestacao, 'Sim');
        System.assertEquals(result.get(0).checaNegada, 'Não');
    }
}