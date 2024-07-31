global with sharing class GetCasesRequestWrapper {
    global List<cases> cases;
	global class Cases {
		public String caseId;
		public String omniChannelStatus;
		public String protocol;
		public String recordTypeDevName;
		public String recordTypeName;
		public String contactPhone;
		public String status;
		public String origin;
		public String createDate;
		public String description;
		public TopicTree topicTree;
		public CaseCommentRef caseCommentRef;
		public CaseDetailRef caseDetailRef;
		public AssetRef assetRef;
	}

	global class TopicTree {
		public String id;
		public String name;
	}

	global class returnEmpty{
	}

	global class CaseDetailRef {
		public String recordTypeDevName;
		public String orderNumber;
		public String cep;
		public String street;
		public String addresNumber;
		public Boolean haveAddressNumber;
		public Boolean withoutComplement;
		public String complement;
		public String referencePoint;
		public String neighborhood;
		public String city;
		public String state;
		public Boolean modifyBillingAddress;
		public String firstDateOption;
		public String firstPeriodOption;
		public String secondDateOption;
		public String secondPeriodOption;
		public String scheduledDate;
		public String scheduledPeriod;
	}

	global class CaseCommentRef {
		public Integer totalUnreadComments;
	}

	global class AssetRef {
		public String displayName;
		public String id;
	}
}