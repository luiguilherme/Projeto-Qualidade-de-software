public with sharing class OrderIssuedManagement {
    public static void checkOrderError(Map<Id, OrderIssued__c> mOldOrders, List<OrderIssued__c> lNewOrders){
        
        Boolean isUpdated = (mOldOrders != null);
        //System.debug(mOldOrders);
        //System.debug(lNewOrders);

        for ( OrderIssued__c order : lNewOrders) {

            OrderIssued__c checkOrderUpdated = new OrderIssued__c();
            if(isUpdated){                
                checkOrderUpdated = mOldOrders.get(order.id);

                if(checkOrderUpdated == null || (checkOrderUpdated.Status__c == order.Status__c && checkOrderUpdated.StatusCode__c == order.StatusCode__c) ){
                    //System.debug('Não há nada para ser alterado.');
                    break;
                } else {
                    setOrderStatus(order);
                }
            } else {
                setOrderStatus(order);
            }
            order.StatusCode__c = null;
        }   
    }
    
    public static void setOrderStatus(OrderIssued__c order) {
        
        String pickListValue = '';
        Schema.DescribeFieldResult field = OrderIssued__c.order.Status__c.getDescribe();
        for (Schema.PicklistEntry f : field.getPicklistValues()){
            if(f.getValue() == order.Status__c){
                //System.debug('entrei aqui order.Status__c >>' + order.Status__c);
                pickListValue = f.getLabel();
                break;
            }
        }
        //System.debug('PICKLIST >>' + pickListValue);

        //System.debug('antes do teste '+order.StatusCode__c);

        if(order.StatusCode__c == 'ERROR'){
            //System.debug('entrei statuscode = error');
            if (order.OrderStatus__C == null || !order.Status__c.toLowerCase().contains('erro')) {
                //System.debug('n tinha palavra erro');
                order.OrderStatus__c = pickListValue + ' com erro';
            }else {
                //System.debug('tinha palavra erro');
                order.OrderStatus__c = pickListValue;
            }
        } else {
            //System.debug('entrou sucesso');
            order.OrderStatus__c = pickListValue;
        }
    }  
}