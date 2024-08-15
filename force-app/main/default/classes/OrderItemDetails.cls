public with sharing class OrderItemDetails {
    
    @AuraEnabled
    @InvocableVariable
    public String serviceId;
    @AuraEnabled
    @InvocableVariable
    public String itemName;
    @AuraEnabled
    @InvocableVariable
    public String plan;
    @AuraEnabled
    @InvocableVariable
    public String action;
    @AuraEnabled
    @InvocableVariable
    public Datetime creationDate;
    @AuraEnabled
    @InvocableVariable
    public Datetime closedDate;
    @AuraEnabled
    @InvocableVariable
    public String implActionTypeX9;
    @AuraEnabled
    @InvocableVariable
    public List<OrderItemDetails> children; //_children

}