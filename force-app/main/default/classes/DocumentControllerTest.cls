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
@IsTest
public class DocumentControllerTest {
    @TestSetup
    static void makeData() {
        FileLink__c fileLinkRec = new FileLink__c();
        fileLinkRec.IDGedoc__c = '651100';
        fileLinkRec.FileDescription__c = 'Anexo ABC';
        insert fileLinkRec;
    }

    @IsTest
    public static void testGetDocumentDocumentIdNull() {
        DocumentController controller = new DocumentController();

        try {
            controller.getDocument();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('documentId não pode ser nulo.', e.getMessage());
        }
    }

    @IsTest
    public static void getBase64EncodedDocumentSuccess() {
        String mockDocumentId = [SELECT Id FROM FileLink__c WHERE IDGedoc__c = '651100' LIMIT 1].Id;
        DocumentController controller = new DocumentController();
        controller.documentId = mockDocumentId;

        controller.getBase64EncodedDocument();

        Assert.isTrue(String.isNotBlank(controller.base64EncodedDocument));
        Assert.areEqual(mockDocumentId, controller.documentId);
    }

    @IsTest
    public static void getBase64EncodedDocumentFailEmptyId() {
        DocumentController controller = new DocumentController();

        try {
            controller.getDocument();
        } catch (IllegalArgumentException e) {
            Assert.areEqual('documentId não pode ser nulo.', e.getMessage());
        }

        Assert.isTrue(String.isBlank(controller.base64EncodedDocument));
        Assert.isTrue(String.isBlank(controller.documentId));
    }
}