/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class CaseCommetTriggerHandlerTest {

    @isTest
    static void updateParentCasesTest() {
        Case caseObj = new Case();
        caseObj.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME).getrecordTypeId();
        caseObj.Status = 'Aguardando informação';
        insert caseObj;

        CaseComment__c caseCommetObj = new CaseComment__c();
        caseCommetObj.ParentId__c = caseObj.Id;
        caseCommetObj.Comment__c = 'Message from customer';
        caseCommetObj.Origin__c = 'App Vivo';
        insert caseCommetObj;

        Case updatedCaseObj = [SELECT Id, Status, OwnerId FROM Case WHERE Id =: caseObj.Id];
        String waitingforRoutingQueueId = CasesMyRequestsB2CService.getWaitingForRoutingQueueId();

        Assert.areEqual('Em fila', updatedCaseObj.Status);
        Assert.areEqual(waitingforRoutingQueueId, updatedCaseObj.OwnerId);
    }
}