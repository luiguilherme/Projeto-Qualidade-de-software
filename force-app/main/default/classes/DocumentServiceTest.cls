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
private class DocumentServiceTest
{
    @TestSetup
    static void makeData(){
        FileLink__c fileLinkRec = new FileLink__c();
        fileLinkRec.IDGedoc__c = '3232521855456';
        fileLinkRec.FileDescription__c = 'Anexo ABC';
        insert fileLinkRec;
    }
    
    @isTest
    static void getBase64EncodedDocumentDocumentIdIsBlankTest()
    {
        String documentId = '';
        try { String base64EncodedDocument = DocumentService.getBase64EncodedDocument(documentId); }
        catch (Exception e)
        {
            String errorMessage = e.getMessage();
            System.debug(errorMessage);
            System.assert(errorMessage.contains('documentId não pode ser nulo.'));
        }
    }

    @isTest
    static void getBase64EncodedDocumentTest()
    {
        String documentId = [SELECT Id FROM FileLink__c WHERE IDGedoc__c = '3232521855456' LIMIT 1].Id;
        String base64EncodedDocument = DocumentService.getBase64EncodedDocument(documentId);
        System.assert(base64EncodedDocument != null, 'Deve retornar um documento em base64');
    }
}