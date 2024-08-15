@isTest
public class DisputeFixedFlowConcessionVerifierTest {

    @TestSetup
    public static void testSetup(){
        Account account = new Account();
        account.Name = 'Teste';
        account.DocumentNumber__c = '111111111111';
        insert account;

        Account accountTwo = new Account();
        accountTwo.Name = 'Teste Dois';
        accountTwo.DocumentNumber__c = '22222222222';
        insert accountTwo;

        Case newCase = new Case();
        newCase.AccountId = account.Id;
        insert newCase;

        DisputedItem__c item = new DisputedItem__c();
        item.Status__c = 'Closed';
        item.IsConcession__c = true;
        item.CaseId__c = newCase.Id;
        insert item;
        
        Case newCase2 = new Case();
        newCase2.AccountId = accountTwo.Id;
        insert newCase2;

        DisputedItem__c item2 = new DisputedItem__c();
        item2.Status__c = 'Closed';
        item2.IsConcession__c = true;
        item2.CaseId__c = newCase2.Id;
        insert item2;
        
        Case newCase3 = new Case();
        newCase3.AccountId = account.Id;
        newCase3.CallerDDD__c = '333';
        insert newCase3;

        DisputedItem__c item3 = new DisputedItem__c();
        item3.Status__c = 'Closed';
        item3.IsConcession__c = true;
        item3.CaseId__c = newCase3.Id;
        insert item3;
    }

    @isTest
    public static void givenValidAccountShouldReturnYes() {
        List<DisputeFixedFlowConcessionVerifier.DisputeCheckConcessionInLast180Days> parameters = new List<DisputeFixedFlowConcessionVerifier.DisputeCheckConcessionInLast180Days>();
        DisputeFixedFlowConcessionVerifier.DisputeCheckConcessionInLast180Days parameter = new DisputeFixedFlowConcessionVerifier.DisputeCheckConcessionInLast180Days();

        Case caseX = [SELECT Id, Account.Id FROM Case WHERE Account.DocumentNumber__c = '111111111111' AND CallerDDD__c = '333'];

        parameter.caseAccountId = caseX.Account.Id;
        parameter.caseId = caseX.Id;
        parameters.add(parameter);
            
        Test.startTest();
        
        List<String> response = DisputeFixedFlowConcessionVerifier.customerHasConcessionInLast180Days(parameters);

        Test.stopTest();
        
        System.assertEquals('Sim', response[0]);
    }

    @isTest
    public static void givenInvalidAccountShouldRetunrNo() {
        List<DisputeFixedFlowConcessionVerifier.DisputeCheckConcessionInLast180Days> parameters = new List<DisputeFixedFlowConcessionVerifier.DisputeCheckConcessionInLast180Days>();
        DisputeFixedFlowConcessionVerifier.DisputeCheckConcessionInLast180Days parameter = new DisputeFixedFlowConcessionVerifier.DisputeCheckConcessionInLast180Days();

        Case caseX = [SELECT Id, Account.Id FROM Case WHERE Account.DocumentNumber__c = '22222222222'];

        parameter.caseAccountId = caseX.Account.Id;
        parameter.caseId = caseX.Id;
        parameters.add(parameter);
            
        Test.startTest();
        
        List<String> response = DisputeFixedFlowConcessionVerifier.customerHasConcessionInLast180Days(parameters);

        Test.stopTest();
        
        System.assertEquals('Não', response[0]);
    }
    
}