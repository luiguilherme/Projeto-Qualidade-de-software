@isTest
public with sharing class DisputedItemControllerTest {
    @isTest
    public static void getByCaseId(){
        Case nuCase = new Case();
        insert nuCase;

        DisputedItem__c nuItem = new DisputedItem__c();
        nuItem.CaseId__c = nuCase.id;
        insert nuItem;

        Test.startTest();
            List<DisputedItem__c> result =  DisputedItemController.getByCaseId(nuCase.Id);
        Test.stopTest();

        System.assert(result.size()>0);

    }
}