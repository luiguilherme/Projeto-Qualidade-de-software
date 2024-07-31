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
private class CustomerCommunicationServiceTest {
    @isTest
    static void buildEmailPaylodAndSendEmailMessageTest() {
        String templateId = 'EMAIL_MS_SOLICITACAO_EXPIRADA';

        RecordType recordTypeRec = new RecordType();
        recordTypeRec.Name = 'Mudança de Endereço';

        Case caseRec = new Case();
        caseRec.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME).getrecordTypeId();
        caseRec.Protocol__c = '1234';
        caseRec.RecordType = recordTypeRec;

        Account accountRec = new Account();
        accountRec.Name = 'Test Account';

        Asset assetRec = new Asset();
        assetRec.MainProductDescription__c = 'Vivo Fibra';

        Contact contactRec = new Contact();
        contactRec.Email = 'contact@test.com';

        EmailMessagePayload payload =
            CustomerCommunicationService.buildEmailPaylod(caseRec, accountRec, assetRec, contactRec, templateId);

        Assert.isNotNull(payload);
        Assert.isNotNull(payload.emailSettings.templateId);
        Assert.isNotNull(payload.emailSettings.recipient);


        HttpResponse response = CustomerCommunicationService.sendEmailMessage(payload);
        
        Assert.areEqual(200, response.getStatusCode());
        Assert.areEqual('OK', response.getStatus());

        
        String payloadSerialized = JSON.serialize(payload);
        CustomerCommunicationService.sendEmailMessage(payloadSerialized);
    }

    @isTest
    static void validadePayloadFailTest() {
        EmailMessagePayload payload;
        try {
            CustomerCommunicationService.validadePayload(payload);
        } catch (CustomerCommunicationException e) {
            Assert.areEqual('Payload não pode ser nulo.', e.getMessage());
        }
    }

    @isTest
    static void validadeStatusCodeTest() {
        Integer statusCode = 200;
        CustomerCommunicationService.validadeStatusCode(statusCode);
    }

    @isTest
    static void validadeStatusCodeFailTest() {
        Integer statusCode = 500;
        try {
            CustomerCommunicationService.validadeStatusCode(statusCode);
        } catch (CustomerCommunicationException e) {
            Assert.areEqual('Status code diferente de 200.', e.getMessage());
        }
    }

    @isTest
    static void validadeStatusTest() {
        String status = 'OK';
        CustomerCommunicationService.validadeStatus(status);
    }

    @isTest
    static void validadeStatusFailTest() {
        String status = 'ERROR';
        try {
            CustomerCommunicationService.validadeStatus(status);
        } catch (CustomerCommunicationException e) {
            Assert.areEqual('Status diferente de \'OK\'', e.getMessage());
        }
    }
}