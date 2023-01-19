public with sharing class SubscribedProductsTO {
    
    public SubscribedProductsTO(){}

    public String id {get; set;} 
	public String display_name {get; set;} 
	public List<Descriptions> descriptions {get; set;} 
	public String product_type {get; set;} 
	public Connection connection {get; set;}
	public List<String> identifiers {get; set;} 
	public List<String> tags {get; set;} 
	public List<SubProducts> sub_products {get; set;} 
	public String status {get; set;} 
	public String address {get; set;} 
	public String start_date {get; set;} 
	public List<Prices> prices {get; set;} 
	public String subscription_type {get; set;}

    public class Descriptions{
        public String text {get; set;}
    }

    public class SubProducts{
        public String id {get; set;} 
		public String display_name {get; set;} 
		public String status {get; set;} 
		public List<Descriptions> descriptions {get; set;} 
		public String product_type {get; set;} 
		public List<String> identifiers {get; set;} 
		public String address {get; set;} 
		public String start_date {get; set;} 
		public List<String> tags {get; set;} 
		public List<Prices> prices {get; set;} 
		public Connection connection {get; set;}
		public List<SubProducts> sub_products {get;set;} 
    }

    public class Prices{
        public Amount amount {get; set;}
        public String description {get; set;}
        public String recurring_period {get; set;}
        public string type {get; set;}
    }

	public class Connection{
		public String type {get; set;} 
		public string uplink_mbps {get; set;} 
		public String downlink_mbps {get; set;} 
	}	

    public class Amount{
        public String currencys {get; set;}
        public Decimal value {get; set;}
    }

	public class ReturnTO {
		@AuraEnabled
		public String Status { get; set; }
		@AuraEnabled
		public String Message { get; set; }
	}

	public class BillingAccountTO{
		public Id AccountId {get; set;}
		public String RecordTypeName {get; set;}
		public String BillingAccountName {get; set;}
	}

}