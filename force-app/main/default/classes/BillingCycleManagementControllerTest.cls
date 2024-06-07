@isTest
private class BillingCycleManagementControllerTest {

    private class SuccessfulHttpMock implements HttpCalloutMock {
        String jsonResponse = '{'+
        '"billingCycles": {'+
            '"billingCycle": ['+
                '{'+
                    '"customerBill": {'+
                        '"billDate": "2024-05-13"'+
                    '},'+
                    '"customerBillingCycleSpecification": {'+
                        '"id": "SPEC001",'+
                        '"description": "Monthly Billing Cycle"'+
                    '},'+
                    '"cycleInstance": {'+
                        '"parameterQuantity": "5"'+
                    '},'+
                    '"cycleCloseDate": {'+
                        '"billingDateShift": "2024-06-01"'+
                    '},'+
                    '"customerBillingCycle": {'+
                        '"id": "CYCLE001",'+
                        '"statusBillingCycle": "Active",'+
                        '"populationCode": "POP001",'+
                        '"frequency": "Monthly",'+
                        '"status": "Active"'+
                    '},'+
                    '"timePeriod": {'+
                        '"startDateTime": "2024-05-01",'+
                        '"endDateTime": "2024-05-31",'+
                        '"billingDateOffset": "5"'+
                    '}'+
                '},'+
                '{'+
                    '"customerBill": {'+
                        '"billDate": "2024-05-13"'+
                    '},'+
                    '"customerBillingCycleSpecification": {'+
                        '"id": "SPEC002",'+
                        '"description": "Monthly Billing Cycle"'+
                    '},'+
                    '"cycleInstance": {'+
                        '"parameterQuantity": "5"'+
                    '},'+
                    '"cycleCloseDate": {'+
                        '"billingDateShift": "2024-06-01"'+
                    '},'+
                    '"customerBillingCycle": {'+
                        '"id": "CYCLE001",'+
                        '"statusBillingCycle": "Active",'+
                        '"populationCode": "POP001",'+
                        '"frequency": "Monthly",'+
                        '"status": "Active"'+
                    '},'+
                    '"timePeriod": {'+
                        '"startDateTime": "2024-05-01",'+
                        '"endDateTime": "2024-05-31",'+
                        '"billingDateOffset": "5"'+
                    '}'+
                '}'+
            '],'+
            '"parameter": {'+
                '"parameter": "ParamValue",'+
                '"parameterQuantity": "10"'+
            '},'+
            '"totalRowsCount": {'+
                '"parameterQuantity": "20"'+
            '}'+
        '}'+
    '}';
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(this.jsonResponse);
            res.setStatusCode(200);
            return res;
        }
    }

    private class ErrorHttpMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(500);
            return res;
        }
    }

    @isTest
    static void checkChangeOnDueDateTest() {
        Webservice__c ws = new Webservice__c();
        String endpoint = 'https://api-qa2.telefonica.com.br/dip/billInquiry/customerBillingCycle/v1/users/userID/{customerID}';
        String hashedEndpoint = String.valueOf(endpoint.hashCode());
        ws.Name = 'CustomerBillingCycleCallout';
        ws.Endpoint__c = endpoint;
        ws.ServiceProvider__c = 'APIGW';
        ws.SubscriptionKey__c = 'null';
        ws.Headers__c = 'application/json; charset=utf-8';
        insert ws;
        
        BillingCycleManagementController.BillingCycleFilter billingCycle = new BillingCycleManagementController.BillingCycleFilter();

        billingCycle.accountId = 'ACT123';
        billingCycle.serviceId = 'SRV123';
        billingCycle.triggeredByCustomer = true;
        billingCycle.startDate = Datetime.now();
        billingCycle.endDate = Datetime.now();

        
        System.debug('billingCycle: ' + JSON.serialize(billingCycle));

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SuccessfulHttpMock());
        List<BillingCycleManagementController.BillingCycleResponse> responseList = BillingCycleManagementController.checkChangeOnDueDate(new List<BillingCycleManagementController.BillingCycleFilter> { billingCycle });
        System.debug('responseList: ' + JSON.serialize(responseList));
        Test.stopTest();
        System.assertEquals(true, responseList[0].response);
    }
}