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
private class RealContactCenterServiceIntegrationTest
{

    @TestSetup
    static void makeData(){
        insert new Webservice__c(
            Name = 'CreateOpenMediaInteractionGenesys',
            Endpoint__c = 'test:callout:APITelefonica/contactChannelManagement/V1/interactions',
            SubscriptionKey__c = '8b016b02-3b72-4c11-a183-03aa9fa8ffb1',
            switchedOn__c=true
        );
    }

    @isTest
    static void createOpenMediaInteractionTest()
    {
        Test.setMock(HttpCalloutMock.class, new RealContactCenterServiceIntegrationMock());
        
        OpenMediaInteractionPayload payload = new OpenMediaInteractionPayload();
        String payloadSerilaized = JSON.serialize(payload);

        Test.startTest();
        
        HttpResponse response = RealContactCenterServiceIntegration.createOpenMediaInteraction(payloadSerilaized);
        Test.stopTest();

        Integer statusCode = response.getStatusCode();
        String status = response.getStatus();
        String interaction = response.getHeader('Location');

        Assert.areEqual(201, statusCode, 'o statusCode deve ser 201');
        Assert.areEqual('Created', status, 'o status deve ser \'Created\'');
        Assert.areEqual('/interaction/A547418SASFA', interaction, 'a interaction deve ser \'/interaction/A547418SASFA\'');
    }
}