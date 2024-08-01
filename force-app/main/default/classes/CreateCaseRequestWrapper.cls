public with sharing class CreateCaseRequestWrapper {
    public class Descriptions {
		public String text;
	}

	public AccountRef accountRef { get; set; }
	public AssetRef assetRef { get; set; }
	public CaseRef caseRef { get; set; }
	public CaseDetailRef caseDetailRef { get; set; }
	public List<FileLinksRef> fileLinksRef { get; set; }

	public class FileLinksRef {
		public String idGedoc { get; set; }
		public String fileDescription { get; set; }
	}

	public class CaseDetailRef {
		public String recordTypeDevName { get; set; }
		public String orderNumber { get; set; }
		public String cep { get; set; }
		public String street { get; set; }
		public String addresNumber { get; set; }
		public Boolean haveAddressNumber { get; set; }
		public Boolean withoutComplement { get; set; }
		public String complement { get; set; }
		public String referencePoint { get; set; }
		public String neighborhood { get; set; }
		public String city { get; set; }
		public String state { get; set; }
		public Boolean modifyBillingAddress { get; set; }
		public String firstDateOption { get; set; }
		public String firstPeriodOption { get; set; }
		public String secondDateOption { get; set; }
		public String secondPeriodOption { get; set; }
	}

	public class Connection {
		public String downlink_mbps { get; set; }
		public String uplink_mbps { get; set; }
		public String type { get; set; }
	}

	public class AssetRef {
		public String externalId { get; set; }
		public Payload payload { get; set; }
	}

	public class CaseRef {
		public String omniChannelStatus { get; set; }
		public String caseId { get; set; }
		public String status { get; set; }
		public String contactPhone { get; set; }
		public String recordTypeDevName { get; set; }
		public String protocol { get; set; }
		public String topicTreeId { get; set; }
		public String origin { get; set; }
		public String createDate { get; set; }
		public String description { get; set; }
		public String serviceReason { get; set; }
	}

	public class AccountRef {
		public String documentNumber { get; set; }
	}

	public class Payload {
		public List<String> identifiers { get; set; }
		public DateTime start_date { get; set; }
		public String subscription_type { get; set; }
		public String product_type { get; set; }
		public String display_name { get; set; }
		public String status { get; set; }
		public String status_description { get; set; }
		public Connection connection { get; set; }
		public List<String> tags { get; set; }
		public List<Descriptions> descriptions { get; set; }
	}

	public class ResponseError {
		public String message { get; set; }
		public String errorCode { get; set; }
	}
}