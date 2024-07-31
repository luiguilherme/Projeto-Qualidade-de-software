@isTest
private class ContactCenterServiceTest {
    @isTest
    private static void buildOpenMediaInteractionPayLoadTest() {
        Case caseObj = new Case();
        caseObj.Id = TestingUtils.getFakeId(Case.getSobjectType(), 1);

        caseObj.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME).getrecordTypeId();
        caseObj.Protocol__c = '1234';
        caseObj.Description = 'Caso Teste';

        Account accountObj = new Account();
        accountObj.Id = TestingUtils.getFakeId(Account.getSobjectType(), 2);
        accountObj.Name = 'Test Account';
        accountObj.DocumentNumber__c = '1234';
        accountObj.DocumentType__c = 'CPF';
        accountObj.vlocity_cmt__CustomerValue__c = '';
        accountObj.HighTemperature__c = true;

        Asset assetObj = new Asset();
        assetObj.Type__c = '';
        assetObj.Technology__c = '';
        assetObj.MainProductDescription__c = 'Vivo Fibra';

        OpenMediaInteractionPayload payload = ContactCenterService.buildOpenMediaInteractionPayLoad(caseObj, accountObj, assetObj);

        Assert.isNotNull(payload);
        Assert.isInstanceOfType(payload, OpenMediaInteractionPayload.class);
    }

    @isTest
    private static void createOpenMediaInteractionTest() {
        OpenMediaInteractionPayload payload = new OpenMediaInteractionPayload();
        payload.caseId = TestingUtils.getFakeId(Case.getSobjectType(), 55);
        String payloadSerialized = JSON.serialize(payload);
        ContactCenterService.createOpenMediaInteraction(payloadSerialized);
    }

    @isTest
    private static void validadeCreatedStatusCodeTest() {
        Integer statusCode = 500;

        try {
            ContactCenterService.validadeCreatedStatusCode(statusCode);
        } 
        catch (ContactCenterServiceException e) {
            String errorMessage = e.getMessage();   
            Assert.areEqual('Status Code diferente de 201.', errorMessage);
        }  
    }

    @isTest
    private static void validadePayloadTest() {
        // payload válido, não lança exception
        try {
        	OpenMediaInteractionPayload payload = new OpenMediaInteractionPayload();
        	payload.caseId = TestingUtils.getFakeId(Case.getSObjectType(), 1);
        	ContactCenterService.validadePayload(payload);
        }
        catch (IllegalArgumentException e) {
            String errorMessage = e.getMessage();   
            Assert.areEqual('payload não pode ser nulo.', errorMessage);
        }

        // payload invalido, não lança exception
        try {
            OpenMediaInteractionPayload emptyPayload;
            ContactCenterService.validadePayload(emptyPayload);
        } 
        catch (IllegalArgumentException e) {
            String errorMessage = e.getMessage();   
            Assert.areEqual('payload não pode ser nulo.', errorMessage);
        } 
    }
}