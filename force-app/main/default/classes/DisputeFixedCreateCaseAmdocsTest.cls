@isTest(seeAllData=true)
public with sharing class DisputeFixedCreateCaseAmdocsTest {

    @isTest
    public static void createCaseAmdocsTest() {
        Map <String, Object> response;

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"feedbackCaseAmdocs": {"Success": false}}');
        res.setStatusCode(200); 
 
        vlocity_cmt.IntegrationProcedureServiceTest.setMockHttpResponseByUrlOrActionName('callout:APITelefonicaUser', res);

        Test.startTest();
            response = DisputeFixedCreateCaseAmdocs.createCaseAmdocs(new Map<String, Object>());
        Test.stopTest();

        System.debug(response);
        //System.assertEquals('Error', response.get('status'));
    }
}