@isTest
public with sharing class DisputedInvoiceControllerTest {
    @isTest
    public static void findByCaseIdTest(){
        Case nuCase = new Case();
        insert nuCase;

        DisputedInvoice__c nuInv = new DisputedInvoice__c();
        nuInv.case__c = nuCase.Id;
        insert nuInv;

        Test.startTest();
            DisputedInvoice__c result =  DisputedInvoiceController.findByCaseId(nuCase.Id);
        Test.stopTest();

        System.assert(result != null);
    }
}