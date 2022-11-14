public with sharing class CreditAnalysisRequest {
    
	// ATRIBUTOS DA CLASSE
	//==================================================================================================================
	private transient Account accountContext;
	private transient String salesChannel, SalesChannelName, userId;
    public PerformAnalysisCreditRequest performAnalysisCreditRequest;
	//==================================================================================================================

	// CONSTRUTORES
	//==================================================================================================================
    public CreditAnalysisRequest(){}

    public CreditAnalysisRequest(Account account, String salesChannel, String salesChannelName, String userId){
		this.accountContext = account;
		this.salesChannel = salesChannel;
		this.SalesChannelName = salesChannelName;
		this.userId = userId;
    }
	//==================================================================================================================


	// CONTRATO
	//==================================================================================================================
    public class OrganizationName {
		public String tradingName;
	}

	public class CustomerOrder {
		public String customerOrderType;
		public String orderType;
		public String statusOrder;
	}

	public class Product {
		public String productStatus;
	}

	public class QuantityOfSubsidiary {
		public Integer parameterQuantity;
	}

	public class SalesChannel {
		public String salesCode;
		public String salesChannel;
		public String salesSector;
		public String salesDepartment;
		public String salesGroup;
		public String SalesChannelName;
		public String salesChannelAbbreviation;
	}

	public class Item {
		public String type;
	}

	public class PolicyApplication {
		public String userId;
	}

	public class OrganizationIdentification {
		public String documentNumber;
		public String documentType;
	}

	public class Items {
		public List<Item> item;
	}

	public class ProductType {
		public Items items;
	}

	public class IndividualIdentification {
		public String nationalIdentilyCardNr;
		public String documentType;
	}

	public class Individual {
		public String legalName;
		public String motherName;
		public String birthDate;
	}

	public class PerformAnalysisCreditRequest {
		public Individual individual;
		public IndividualIdentification individualIdentification;
		public PolicyApplication policyApplication;
		public SalesChannel salesChannel;
		public CustomerOrder customerOrder;
		public List<OrganizationIdentification> organizationIdentification;
		public IndividualIdentification seller;
		public ProductType productType;
	}
	//==================================================================================================================


	// MAPEAMENTO DE VALOREAS NO CONTRATO
	//==================================================================================================================
    public CreditAnalysisRequest createRequestStructure() {
		return  setPerformAnalysisCreditRequest()
                .setIndividual()
                .setindividualIdentification()
                .setPolicyApplication()
                .setSalesChannel()
                .setCustomerOrder()
                .setItemType();
	}

    private CreditAnalysisRequest setPerformAnalysisCreditRequest(){
		this.performAnalysisCreditRequest = new PerformAnalysisCreditRequest();
		return this;
	}

    private CreditAnalysisRequest setIndividual(){
		CreditAnalysisRequest.individual individual = new CreditAnalysisRequest.individual();
		individual.legalName = accountContext.Name;
        individual.motherName = accountContext.vlocity_cmt__PrimaryContactId__r.MotherName__c;
		individual.birthDate = DateTime.newInstance(accountContext.vlocity_cmt__PrimaryContactId__r.Birthdate, Time.newInstance(00,00,00,00)).format('yyyy-MM-dd\'T\'HH:mm:ss.SS');
        this.performAnalysisCreditRequest.individual = individual;
		return this;
	}

    private CreditAnalysisRequest setindividualIdentification(){
		CreditAnalysisRequest.individualIdentification individualId = new CreditAnalysisRequest.individualIdentification();
		individualId.nationalIdentilyCardNr = accountContext.DocumentNumber__c;
        individualId.documentType = '1';
		this.performAnalysisCreditRequest.individualIdentification = individualId;
		return this;
	}

    private CreditAnalysisRequest setPolicyApplication(){
		CreditAnalysisRequest.policyApplication policy = new CreditAnalysisRequest.policyApplication();
		policy.userId = this.userId;
		this.performAnalysisCreditRequest.policyApplication = policy;
		return this;
	}

    private CreditAnalysisRequest setSalesChannel(){
		CreditAnalysisRequest.salesChannel salesChannel = new CreditAnalysisRequest.salesChannel();
        salesChannel.SalesChannelName = this.SalesChannelName;
		salesChannel.salesChannel = this.salesChannel; 
		this.performAnalysisCreditRequest.salesChannel = salesChannel;
		return this;
	}

    private CreditAnalysisRequest setCustomerOrder(){
		CreditAnalysisRequest.customerOrder customerOrder = new CreditAnalysisRequest.customerOrder();
		customerOrder.orderType = 'PR';
		this.performAnalysisCreditRequest.customerOrder = customerOrder;
		return this;
	}

    private CreditAnalysisRequest setItemType(){
		CreditAnalysisRequest.productType productType = new CreditAnalysisRequest.productType();
        CreditAnalysisRequest.Item item = new CreditAnalysisRequest.Item();
        item.type = 'WS';
        productType.items = new CreditAnalysisRequest.Items();
		productType.items.item = new List<CreditAnalysisRequest.Item>{item};
		this.performAnalysisCreditRequest.productType = productType;
		return this;
	}
	//==================================================================================================================

	// CAST DE ENTRADA E SAIDA
	//==================================================================================================================
	public static CreditAnalysisRequest parse(String json) {
		return (CreditAnalysisRequest) System.JSON.deserialize(json, CreditAnalysisRequest.class);
	}

    public String toJson() {		
		return JSON.serialize(this, true);
	}
	//==================================================================================================================
}