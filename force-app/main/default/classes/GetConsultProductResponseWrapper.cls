global with sharing class GetConsultProductResponseWrapper {
    
    public class ConsultProductUserWrapper {
		public Integer totalSize; 
		public String message; 
		public Integer httpStatusCode; 
		public List<ContactRef> contactRef; 
	}

	public class AssetPartyRelashionShip {
		public String name;
		public String role;
		public Boolean approvedByOwner;
        public DateTime createdDate;
	}

	public class ContactRef {
		public String id;
		public String userCPF;
		public String firstName;
		public String lastName;
		public String contactEmail;
		public String assistantPhone;
		public String otherPhone;
		public String otherEmail;
		public String nickName;
		public String motherName;
		public String birthDate;
		public String email;
		public String mobilePhone;
		public String homePhone;
		public String phone;
		public Integer totalSize;
		public List<AssetPartyRelashionShip> assetPartyRelashionShip;
	}

	
	public static GetConsultProductResponseWrapper parse(String json) {
		return (GetConsultProductResponseWrapper) System.JSON.deserialize(json, GetConsultProductResponseWrapper.class);
	}
}