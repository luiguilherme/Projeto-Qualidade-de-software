public without sharing class OrderHybrisResponse { 
    
    public String status{get;set;}
    public String userId{get;set;}
    public String crmPurchaseOrderNumber{get;set;}
    public String vendorId{get;set;}
    public String orderCode{get;set;}
    public list<products> products{get;set;}
    
    public class products{
        public Decimal price{get;set;}
        public String productDescription{get;set;}
        public String productCode{get;set;}
    }

    public static OrderHybrisResponse parse(String responseBody){
        return (OrderHybrisResponse) JSON.deserialize(responseBody, OrderHybrisResponse.class);
    }
}