public class Orders {

    @AuraEnabled
    @InvocableVariable
    public Date creationDate;
    @AuraEnabled
    @InvocableVariable
    public String referenceNumber;
    @AuraEnabled
    @InvocableVariable
    public String status;
    @AuraEnabled
    @InvocableVariable
    public Decimal finalAmount;
    @AuraEnabled
    @InvocableVariable
    public List<OrderItemList> itens;
     
}