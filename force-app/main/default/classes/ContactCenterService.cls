public with sharing class ContactCenterService {
    private static final String ORIGIN_SYSTEM = 'SALESFORCE_B2C';
    private static final String ORIGIN_INTERACTION = 'APP_VIVO';
    public static final String ACTION_AGENT_QUEUE = 'agent_queue';

    public static OpenMediaInteractionPayload buildOpenMediaInteractionPayLoad(Case caseRec, Account accountRec, Asset assetRec) {
        OpenMediaInteractionPayload payload = new OpenMediaInteractionPayload();
        populateCaseFields(payload, caseRec);
        populateCustomerFields(payload, accountRec);
        populateCustomerInteractionFields(payload, caseRec);
        populateProductFields(payload, accountRec, assetRec);
        populatePolicyApplicationFields(payload, ORIGIN_SYSTEM, ORIGIN_INTERACTION);
        return payload;
    }

    private static void populateCaseFields(OpenMediaInteractionPayload payload, Case caseRec) {
        payload.caseId = caseRec.Id ?? '';
        payload.protocolNumber = caseRec.Protocol__c ?? '';
    }

    private static void populateCustomerFields(OpenMediaInteractionPayload payload, Account accountRec) {
        payload.customer = new OpenMediaInteractionPayload.CustomerWrapper();
        payload.customer.documentNumber = accountRec.DocumentNumber__c ?? '';
        payload.customer.documentType = accountRec.DocumentType__c ?? '';
        payload.customer.customerId = accountRec.Id ?? '';
        payload.customer.customerSegment = accountRec.vlocity_cmt__CustomerValue__c ?? '';
        payload.customer.customerRank = accountRec.HighTemperature__c ? 'Alta' : 'Baixa';
    }

    private static void populateCustomerInteractionFields(OpenMediaInteractionPayload payload, Case caseRec) {
        payload.customerInteraction = new OpenMediaInteractionPayload.CustomerInteractionWrapper();
        payload.customerInteraction.interactionReason = caseRec.RecordType.Name ?? '';
        payload.customerInteraction.interactionDetail = caseRec.ServiceReason__c ?? '';
    }

    private static void populateProductFields(OpenMediaInteractionPayload payload, Account accountRec, Asset assetRec) {
        payload.product = new OpenMediaInteractionPayload.ProductWrapper();

        payload.product.productCharacteristic = new OpenMediaInteractionPayload.ProductCharacteristicWrapper();
        payload.product.productCharacteristic.type = assetRec.Type__c ?? '';
        payload.product.productCharacteristic.subType = accountRec.CustomerSegment__c ?? '';
        payload.product.productCharacteristic.technology = assetRec.Technology__c ?? '';

        payload.product.productSpecification = new OpenMediaInteractionPayload.ProductSpecificationWrapper();
        payload.product.productSpecification.name = assetRec.MainProductDescription__c ??  '';
    }

    private static void populatePolicyApplicationFields(OpenMediaInteractionPayload payload, String originSystem, String originInteraction) {
        payload.policyApplication = new OpenMediaInteractionPayload.PolicyApplicationWrapper();
        payload.policyApplication.systemId = originSystem;
        payload.policyApplication.systemIdInteraction = originInteraction;
    }

    public static void populateRountingFields(OpenMediaInteractionPayload payload, String agent, String action) {
        payload.employeeIdentification = new OpenMediaInteractionPayload.EmployeeIdentificationWrapper();
        payload.employeeIdentification.employeeNr = agent;
        payload.action = action;
    }

    @future(callout=true)
    public static void createOpenMediaInteraction(String payload)
    {
        String environmentName = Util.getEnvironmentName();
        ContactCenterServiceIntegration contactCenterServiceIntegration = ContactCenterServiceIntegrationConfig.getService(environmentName);

        try { 
            HttpResponse response = contactCenterServiceIntegration.createOpenMediaInteraction(payload);
            String interaction = response.getHeader('location');
            System.debug(LoggingLevel.INFO, 'OpenMediaInteraction');
            System.debug(LoggingLevel.INFO, interaction);            

            // TODO: Armazenar o id da interação criada no Genesys. A solução está a ser definida.
            // TODO: Implementar um mecanismo de retry para quando houver erro na integração com o Genensys. A solução está a ser definida.
        } 
        catch (ContactCenterServiceException e) {
            String errorMessage = e.getMessage();
            System.debug(LoggingLevel.ERROR, errorMessage);
        }
    }

    public static void validadePayload(OpenMediaInteractionPayload payload)
    {
        if (payload == null || payload.caseId == null)
        { 
            throw new IllegalArgumentException('payload não pode ser nulo.'); 
        }
    }

    public static void validadeCreatedStatusCode(Integer statusCode)
    {
        if (statusCode != 201)
        { 
            throw new ContactCenterServiceException('Status Code diferente de 201.');
        } 
    }
}