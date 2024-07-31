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
private class DocumentControllerTest
{
    @TestSetup
    static void makeData()
    {
        FileLink__c fileLinkRec = new FileLink__c();
        fileLinkRec.IDGedoc__c = 'link:anexo_abc';
        fileLinkRec.FileDescription__c = 'Anexo ABC';
        insert fileLinkRec;
    }

    @isTest
    static void ducumentControllerInstantiationDocumentIdIsEmptyTest()
    {
        try
        {
            DocumentController documentController = new DocumentController();
        }
        catch (Exception e)
        {
            String errorMessage = e.getMessage();
            System.debug(errorMessage);
            System.assert(errorMessage.contains('documentId não pode ser nulo.'));
        }
    }

    @isTest
    static void ducumentControllerInstantiationTest()
    {
        String documentId = [SELECT Id FROM FileLink__c WHERE IDGedoc__c = 'link:anexo_abc' LIMIT 1].Id;
        DocumentController documentController = new DocumentController();
        documentController.getVisualForcePageDocumentId();
        documentController.documentId = documentId;
        documentController.getDocument();

        System.debug(documentController);
        System.debug(documentController.base64EncodedDocument);

        System.assert(documentController != null);
        System.assert(documentController.base64EncodedDocument != null);
    }
}