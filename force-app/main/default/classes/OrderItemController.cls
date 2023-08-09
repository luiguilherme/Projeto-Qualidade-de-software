global with sharing class OrderItemController implements vlocity_cmt.VlocityOpenInterface2  {
    
    global Object invokeMethod(String methodName, Map<String,Object> inputMap,
                                Map<String,Object> outMap, Map<String,Object> options) {
        Boolean success = true;
        String errors = 'OK';
        try{
            switch on methodName {
                /*when 'setAttribute' {
                    setAttribute(inputMap, outMap, options); 
                }
                when 'getAttribute' {
                    getAttribute(inputMap, outMap, options); 
                }*/
                when 'setFieldsForAllItemsInOrder' {
                    setFieldsForAllItemsInOrder(inputMap, outMap, options); 
                }
            }

        } catch(Exception e) {
            errors = e.getMessage();
            success = false;
        }
        outMap.put('success', success);
        outMap.put('error', errors);

        return success;
    }

    /*public void setAttribute(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        Id orderItemId = (Id) inputMap.get('OrderItemId');
        Map<String, Object> attributeMap = (Map<String, Object>) inputMap.get('AttributeMap');

        OrderItem item = [SELECT Id, vlocity_cmt__AttributeSelectedValues__c FROM OrderItem WHERE Id =:orderItemId];
        String jsonString = item.vlocity_cmt__AttributeSelectedValues__c;

        if (jsonString != null) {
			Map<String, Object> mapObject = (Map<String, Object>) JSON.deserializeUntyped(jsonString);
        
            for (String attr : attributeMap.keySet()){
                if (mapObject.containsKey(attr)) {
                    mapObject.put(attr, attributeMap.get(attr));
                }
            }
           
        	item.vlocity_cmt__AttributeSelectedValues__c = JSON.serialize(mapObject);                      
        }

        update item;
    }*/

    //Método que atualiza o valor de campos escolhidos dinâmicamente de todos os OrderItems de uma Order
    public void setFieldsForAllItemsInOrder(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        Id orderId = (Id) inputMap.get('OrderId');
        Map<String,Object> fields = (Map<String,Object>) inputMap.get('fields');

        List<OrderItem> orderItemList = [SELECT Id FROM OrderItem WHERE OrderId =: orderId];

        for (OrderItem oItem : orderItemList) {
            for (String fieldName : fields.keySet()) {
                oItem.put(fieldName, fields.get(fieldName));
            }
        }

        update orderItemList;
    }
}