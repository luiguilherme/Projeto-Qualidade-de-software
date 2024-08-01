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
private class RealDocumentServiceIntegrationTest
{

    @TestSetup
    static void makeData(){
        insert new Webservice__c(
            Name = 'DocumentRepository',
            Endpoint__c = 'test:callout:APITelefonicaArchives/caseDocumentRepository/v1/viewDocument',
            SubscriptionKey__c = '8b016b02-3b72-4c11-a183-03aa9fa8ffb1',
            switchedOn__c=true
        );
    }
    @isTest 
    private static void getDocumentEndpointIsBlankTest()
    {
        String protocol = '';

        Test.setMock(HttpCalloutMock.class, new RealDocumentServiceIntegrationMock());

        try
        {
            Test.startTest();
            HttpResponse response = RealDocumentServiceIntegration.getDocument(protocol); 
            Test.stopTest();
        }
        catch (Exception e)
        {
            String errorMessage = e.getMessage();
            System.debug(LoggingLevel.INFO, errorMessage);
            System.assert(errorMessage.contains('protocol não pode ser nulo'));
        }
    }

    @isTest 
    private static void getDocumentTest()
    {
        String protocol = '3232521855456';

        Test.setMock(HttpCalloutMock.class, new RealDocumentServiceIntegrationMock());

        Test.startTest();
        HttpResponse response = RealDocumentServiceIntegration.getDocument(protocol);
        Test.stopTest();

        String contentType = response.getHeader('Content-Type');
        Integer statusCode = response.getStatusCode();
        String body = response.getBody();

        System.assert(contentType == 'application/json', 'Content-Type deve ser application/json');
        System.assert(body != null, 'o body não pode está vazio');
        System.assertEquals(200, statusCode, 'o statusCode deve ser 200');
    }
}