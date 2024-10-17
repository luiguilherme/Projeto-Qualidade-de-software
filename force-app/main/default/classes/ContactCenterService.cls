public with sharing class ContactCenterService
{   
    public static final String INTEGRATIONTYPE_ALLOCATION = 'AllocationOfAttendants';
    public static final String INTEGRATIONTYPE_ROUTING = 'Routing';

    public static final String SYSTEMID_SALESFORCE_B2B = 'SALESFORCE_B2B';
	public static final String SYSTEMID_SALESFORCE_B2C = 'SALESFORCE_B2C';

	public static final String SYSTEMIDINTERACTION_WHATSAPP = 'WHATSAPP';
	public static final String SYSTEMIDINTERACTION_APP_VIVO = 'APP_VIVO';
	public static final String SYSTEMIDINTERACTION_MVE = 'MVE';
	public static final String SYSTEMIDINTERACTION_EMAIL = 'EMAIL';
	public static final String SYSTEMIDINTERACTION_INSTAGRAM = 'INSTAGRAM';
	public static final String SYSTEMIDINTERACTION_SALESFORCE_B2B = 'SALESFORCE_B2B';
	public static final String SYSTEMIDINTERACTION_SALESFORCE_B2C = 'SALESFORCE_B2C';

	public static final String PRIORITY_CRITICA = 'CRITICA';
	public static final String PRIORITY_ALTA = 'ALTA';
	public static final String PRIORITY_MEDIA = 'MEDIA';
	public static final String PRIORITY_BAIXA = 'BAIXA';
    
	public static final String TEMPERATURE_ALTA = 'Alta';
	public static final String TEMPERATURE_BAIXA = 'Baixa';

    public static final String ACTION_AGENT_STOP = 'agent_stop';
	public static final String ACTION_AGENT_QUEUE = 'agent_queue';
    
    public class Params {
        public String serviceType {get; set;}
        public User userAgent {get; set;}
        public String userORG {get; set;}

        public String action {get; set;}
        public String agent {get; set;}
        public String priority {get; set;}

        public String interactionReason {get; set;}
        public String interactionDetail {get; set;}

        public String productSubType {get; set;}

        public Case caseRecord {get; set;}
        public Account accountRecord {get; set;}
        public Asset assetRecord {get; set;}
    }

    public static OpenMediaInteractionPayload buildOpenMediaInteractionPayLoad(Case caseRec, Account accountRec, Asset assetRec) {
        OpenMediaInteractionPayload payload = new OpenMediaInteractionPayload();
        populateCaseFields(payload, caseRec);
        populateCustomerFields(payload, accountRec);
        populateCustomerInteractionFields(payload, caseRec);
        populateProductFields(payload, accountRec, assetRec);
        populatePolicyApplicationFields(payload, SYSTEMID_SALESFORCE_B2C, SYSTEMIDINTERACTION_APP_VIVO);
        return payload;
    }

    public static OpenMediaInteractionPayload buildOpenMediaInteractionPayLoad(Params params) {
        OpenMediaInteractionPayload payload;

        if (params != null && params.serviceType != null) {
            if (params.serviceType == INTEGRATIONTYPE_ALLOCATION) {
                payload = buildOpenMediaInteractionPayLoad(params.caseRecord, params.accountRecord, params.assetRecord);

            } else if (params.serviceType == INTEGRATIONTYPE_ROUTING) {
                payload = buildOpenMediaInteractionPayLoadForRouting(params);
            }
        }

        return (payload);
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
        payload.customer.customerRank = accountRec.HighTemperature__c ? TEMPERATURE_ALTA : TEMPERATURE_BAIXA;
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

    private static OpenMediaInteractionPayload buildOpenMediaInteractionPayLoadForRouting(Params params) {
        OpenMediaInteractionPayload payloadForRouting = new OpenMediaInteractionPayload();

        payloadForRouting.action = params.action;
        payloadForRouting.agent = params.agent;
        payloadForRouting.caseId = params.caseRecord.Id;
        payloadForRouting.priority = params.priority;

        payloadForRouting.policyApplication = new OpenMediaInteractionPayload.PolicyApplicationWrapper();

        payloadForRouting.policyApplication.systemId = SYSTEMID_SALESFORCE_B2C;
        payloadForRouting.policyApplication.systemIdInteraction = SYSTEMIDINTERACTION_SALESFORCE_B2C;

        payloadForRouting.customerInteraction = new OpenMediaInteractionPayload.CustomerInteractionWrapper();

        payloadForRouting.customerInteraction.interactionReason = params.interactionReason;
        payloadForRouting.customerInteraction.interactionDetail = params.interactionDetail;

        payloadForRouting.product = new OpenMediaInteractionPayload.ProductWrapper();
        
        payloadForRouting.product.productCharacteristic = new OpenMediaInteractionPayload.ProductCharacteristicWrapper();

        payloadForRouting.product.productCharacteristic.subType = params.productSubType;

        payloadForRouting.customer = new OpenMediaInteractionPayload.CustomerWrapper();

        payloadForRouting.customer.customerSegment = (params.accountRecord.vlocity_cmt__CustomerValue__c ?? '');

        return (payloadForRouting);
    }
    
    @future(callout=true)
    public static void createOpenMediaInteraction(String payload) 
    {
        callCreateOpenMediaInteraction(payload);
    }
    
    public static void callCreateOpenMediaInteraction(String payload)
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