public class WorkOrderObject {

    @AuraEnabled
    @InvocableVariable
    public String id;
    @AuraEnabled
    @InvocableVariable
    public String orderProtocol;
    @AuraEnabled
    @InvocableVariable
    public Date orderDate;
    @AuraEnabled
    @InvocableVariable
    public String documentNumber;
    @AuraEnabled
    @InvocableVariable
    public String name;
    @AuraEnabled
    @InvocableVariable
    public String category;
    @AuraEnabled
    @InvocableVariable
    public List<WorkOrderItemObject> items;
}