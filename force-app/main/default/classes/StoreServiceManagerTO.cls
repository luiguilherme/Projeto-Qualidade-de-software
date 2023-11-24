/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 17/03/2022
    @description - Class "TO" for StoreServiceManager
    ---------------------------------------------------
*/
public with sharing class StoreServiceManagerTO {
    public class ItemPicklistValue {
        @AuraEnabled
        public String label {get; set;}

        @AuraEnabled
        public String value {get; set;}

        @AuraEnabled
        public String name {get; set;}

        @AuraEnabled
        public String instruction {get; set;}
    }

    public class ServiceTicket {
        @AuraEnabled
        public String id {get; set;}

        @AuraEnabled
        public String createdDateTime {get; set;}

        @AuraEnabled
        public String type {get; set;}

        @AuraEnabled
        public String view {get; set;}

        @AuraEnabled
        public String store {get; set;}

        @AuraEnabled
        public String workPositionId {get; set;}

        @AuraEnabled
        public Boolean displayAlert {get; set;}
        
        @AuraEnabled
		public String ticketId {get; set;}

        @AuraEnabled
        public String externalId {get; set;}

        @AuraEnabled
        public Boolean customerSpecialNeeds {get; set;}        

        @AuraEnabled
        public Integer customerPriority {get; set;}
        
        @AuraEnabled
        public String customerInteractionId {get; set;}

		@AuraEnabled
		public String customerId {get; set;}
		
		@AuraEnabled
		public String customerName {get; set;}
		
		@AuraEnabled
		public String customerAlias {get; set;}

        @AuraEnabled
        public String customerDocument {get; set;}

        @AuraEnabled
        public String geographicAreaCode {get; set;}

        @AuraEnabled
        public String networkNumber {get; set;}

        @AuraEnabled
        public String customerCellPhone {get; set;}

        @AuraEnabled
        public String segmentation {get; set;}

        @AuraEnabled
        public String segmentationName {get; set;}

        @AuraEnabled
        public String activity {get; set;}

        @AuraEnabled
        public String protocol {get; set;}

        @AuraEnabled
        public String waitTime {get; set;}

        @AuraEnabled
        public String status {get; set;}

        @AuraEnabled
        public String userLogin {get; set;}

        @AuraEnabled
        public String startTime {get; set;}

        @AuraEnabled
        public String finalTime {get; set;}

        @AuraEnabled
        public String duration {get; set;}

        @AuraEnabled
        public String service {get; set;}
    
        @AuraEnabled
        public String serviceName {get; set;}

        @AuraEnabled
        public Integer activityPriority {get; set;}

        @AuraEnabled
        public String category {get; set;}
        
        @AuraEnabled
        public String categoryName {get; set;}

        @AuraEnabled
        public String mainDocumentType {get; set;}

        @AuraEnabled
        public String mainDocumentTypeName {get; set;}

        @AuraEnabled
        public String documentNumber {get; set;}

        @AuraEnabled
        public String giveUpReason {get; set;}
        
        @AuraEnabled
        public String activities {get; set;}

        @AuraEnabled
        public String notes {get; set;}
    }

    public class PositionInformationStatus {
        @AuraEnabled
        public String workPositionId {get; set;}

        @AuraEnabled
        public String statusPosition {get; set;}
	}
    
    public class AttendanceInformationStatus {
        @AuraEnabled
        public String pauseReasonId {get; set;}

        @AuraEnabled
        public String statusAttendance {get; set;}

        @AuraEnabled
        public String ticketId {get; set;}
        
        @AuraEnabled
        public String segmentationId {get; set;}

        @AuraEnabled
        public String segmentationName {get; set;}
    
        @AuraEnabled
        public String waitTime {get; set;}

        @AuraEnabled
        public String duration {get; set;}
        
        @AuraEnabled
        public String customerCellPhone {get; set;}
        
        @AuraEnabled
        public String serviceName {get; set;}

        @AuraEnabled
        public String type {get; set;}
        
        @AuraEnabled
        public String startTime {get; set;}

        @AuraEnabled
        public String customerName {get; set;}

        @AuraEnabled
        public String customerDocument {get; set;}
    }
}
