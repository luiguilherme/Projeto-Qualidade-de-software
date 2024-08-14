@IsTest
public with sharing class PaymentInstructionsControllerTest {
    @IsTest
    static void testfindPaymentMethodByBillingAccountId() {

        Webservice__c ws = new Webservice__c(
            Name = 'SearchInvoceCreditsCallout',
            Endpoint__c = 'https://contest.proxy.beeceptor.com/customerBillInvoiceManagement/v1/invoiceCredits',
            ServiceProvider__c = 'APIGW',
            SubscriptionKey__c = '89098b41c7884a3d8d55741b46389b61',
            Headers__c = 'application/json; charset=utf-8'
        );
        insert ws;
        
        List<PaymentInstructionsController.PaymentInstructionsFilter> filters = new List<PaymentInstructionsController.PaymentInstructionsFilter>();
        PaymentInstructionsController.PaymentInstructionsFilter nuFilter = new PaymentInstructionsController.PaymentInstructionsFilter();
        nuFilter.billingAccountId = 'teste123';
        filters.add(nuFilter);
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new PaymentInstructionsControllerMock());
            List<PaymentInstructionsController.PaymentInstructionsResponse> result =  PaymentInstructionsController.findPaymentMethodByBillingAccountId(filters);
        Test.stopTest();

        System.debug('result: ' + result);

        System.assert(result.size() == 1);
        PaymentInstructionsController.PaymentInstructionsResponse response = result.get(0);
        System.assert(response.paymentMethod != null);
        System.assertEquals('TESTE_PAYMENT_METHOD', response.paymentMethod);

    }

    private class PaymentInstructionsControllerErrorMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(500);
            return res;
        }
    }

    public class PaymentInstructionsControllerMock implements HttpCalloutMock {

      String jsonResponse = '{ "bankAccountForInstruction": { "authorizations": { "authorization": { "authorizationReference": "string", "authorizationStatus": "string" } }, "bankCode": "string", "bankName": "string", "branchCode": "string", "name": "string", "number": "string" }, "paymentInstructionCard": { "brand": "string", "imprintedName": "string", "validityMonth": "string", "validityYear": "string", "visibleNumber": "string" }, "paymentMethod": "TESTE_PAYMENT_METHOD" }"';      

      public HTTPResponse respond(HTTPRequest req) {
          HttpResponse res = new HttpResponse();
          res.setHeader('Content-Type', 'application/json');
          res.setBody(this.jsonResponse);
          res.setStatusCode(200);
          return res;
      }
    }
}