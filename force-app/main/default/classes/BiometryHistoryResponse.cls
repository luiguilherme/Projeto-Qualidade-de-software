global without sharing class BiometryHistoryResponse {
    
    @AuraEnabled
    @InvocableVariable
	public BusinessInteraction businessInteraction;
    @AuraEnabled
    @InvocableVariable
	public List<Items> items;

	public class BusinessInteraction {
        @AuraEnabled
    	@InvocableVariable
        public String status;
        @AuraEnabled
    	@InvocableVariable
		public String resultCode;
        @AuraEnabled
    	@InvocableVariable
		public String resultMessage;
	}

	public class Items {
        @AuraEnabled
    	@InvocableVariable        
		public NationalIdentityCardIdentification nationalIdentityCardIdentification;
        @AuraEnabled
    	@InvocableVariable        
		public Protocol protocol;
        @AuraEnabled
    	@InvocableVariable        
		public TimePeriod timePeriod;
        @AuraEnabled
    	@InvocableVariable        
		public String adabasId;
        @AuraEnabled
    	@InvocableVariable       
		public Protocol channel;
        @AuraEnabled
    	@InvocableVariable        
		public String motorStatus;
	}

	public class NationalIdentityCardIdentification {
        @AuraEnabled
    	@InvocableVariable		
        public String cardNr;
	}

	public class Protocol {
        @AuraEnabled
    	@InvocableVariable		
        public String id;
	}

	public class TimePeriod {
        @AuraEnabled
    	@InvocableVariable		
        public String biometryDateTime;
	}

	public static BiometryHistoryResponse parse(String json) {
		return (BiometryHistoryResponse) System.JSON.deserialize(json, BiometryHistoryResponse.class);
	}
}