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
private class AttachmentControllerTest
{
    @TestSetup 
    static void makeData()
    {
        
        Case caseRec = new Case();
        caseRec.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME).getrecordTypeId();
        caseRec.Subject = 'Test Case';
        caseRec.Protocol__c = '32535';
        caseRec.Status = 'New';
        insert caseRec;

        FileLink__c fileLinkRec1 = new FileLink__c();
        fileLinkRec1.Case__c = caseRec.Id;
        fileLinkRec1.FileDescription__c = 'anexo a';
        fileLinkRec1.IDGedoc__c = 'link:anexo_a';
        insert fileLinkRec1;

        FileLink__c fileLinkRec2 = new FileLink__c();
        fileLinkRec2.Case__c = caseRec.Id;
        fileLinkRec2.FileDescription__c = 'anexo b';
        fileLinkRec2.IDGedoc__c = 'link:anexo_b';
        insert fileLinkRec2;
    }

    @isTest
    private static void getAttachmentsNullArgumentTest()
    {
        String caseId = '';
        try
        {
            List<DocumentAttachment> attachments = AttachmentController.getAttachments(caseId);
        }
        catch (Exception e)
        {
            String errorMessage = e.getMessage();
            System.debug(errorMessage);
            System.assert(errorMessage.contains('caseId não pode ser nulo.'));
        }
    }

    @isTest
    private static void getAttachmentsTest()
    {
        Integer expectedAttachments = 2;
        Case caseRec = [SELECT Id FROM Case LIMIT 1];

        List<DocumentAttachment> attachments = AttachmentController.getAttachments(caseRec.Id);

        System.assertEquals(expectedAttachments, attachments.size());
    }
}