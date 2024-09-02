/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-01-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
global with sharing class GetProductUserResponseWrapper {
    
    public ContactRef contactRef { get; set; }
    public AssetPartyRelationshipRef assetPartyRelationshipRef { get; set; }
    public AssetPartyRelationDelete assetPartyRelationDelete { get; set; }
    
    
    global class Response{
        public ContactRef contactRefResponse{ get; set; }
        public AssetPartyRelationshipRef assetPartyRelationshipRefResponse{ get; set; }
        public AssetPartyRelationDelete assetPartyRelationDeleteResponse{ get; set; }
    }
    
    //Request
    public class AssetPartyRelationDelete {
        public String product { get; set; }
        public Boolean isDeleteProduct { get; set; }
    }

    public class AssetPartyRelationshipRef {
        public Boolean approvedByOwner { get; set; }
        public String product { get; set; }
        public String role { get; set; }
        public DateTime createdDate { get; set; }
    }



    public class ContactRef {
        public String userCPF{ get; set; }
        public String firstName{ get; set; }
        public String lastName{ get; set; }
        public String contactEmail{ get; set; }
        public String assistantPhone{ get; set; }
        public String nickName{ get; set; }
        public String motherName{ get; set; }
        public String birthdate{ get; set; }
    }



    public static GetProductUserResponseWrapper parse(String json) {
        return (GetProductUserResponseWrapper) System.JSON.deserialize(json, GetProductUserResponseWrapper.class);
    }
}