public with sharing class OrderItemList {

    @AuraEnabled
    @InvocableVariable
    public String id;
    @AuraEnabled
    @InvocableVariable
    public String serviceId;
    @AuraEnabled
    @InvocableVariable
    public String actionType;
    @AuraEnabled
    @InvocableVariable
    public String status;
    @AuraEnabled
    @InvocableVariable
    public String implActionTypeX9;
    @AuraEnabled
    @InvocableVariable
    public String implOrderTypeX9;
    @AuraEnabled
    @InvocableVariable
    public Date closeDate;
    @AuraEnabled
	@InvocableVariable
	public String workOrderIdX9;
    
}