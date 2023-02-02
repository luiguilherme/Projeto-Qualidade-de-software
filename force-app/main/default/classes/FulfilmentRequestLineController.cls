global with sharing class FulfilmentRequestLineController implements vlocity_cmt.VlocityOpenInterface2 {

    global Object invokeMethod(String methodName, Map<String,Object> inputMap,
                                Map<String,Object> outMap, Map<String,Object> options) {
        Boolean success = true;
        String errors = 'OK';
        try{
            switch on methodName {
                when 'setAttribute' {
                    setAttribute(inputMap, outMap, options); 
                }
                when 'getAttribute' {
                    getAttribute(inputMap, outMap, options); 
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

    //Método que define o valor de um atributo de um fulfilment request line
    public void setAttribute(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        String attributeCode = (String) inputMap.get('AttributeCode');
        String attributeValue = (String) inputMap.get('AttributeValue');
        Id fulfilmentRequestLineId = (Id) inputMap.get('FulfilmentRequestLineId');    
        List <String> fulfilmentRequestLineIdList = (List<String>) inputMap.get('FulfilmentRequestLineIdList');    
        Map<String,String> attributeMap = (Map<String,String>) inputMap.get('AttributeMap');

        List<String> itemList = fulfilmentRequestLineId != null ? new List <String> {fulfilmentRequestLineId} : fulfilmentRequestLineIdList;
        //List<String> itemList = new List <String> {fulfilmentRequestLineId}; //Lista com todos os Ids que serão atualizados
        List<vlocity_cmt.XOMOrderItemDomainObject> omItemList = new List<vlocity_cmt.XOMOrderItemDomainObject>();
        vlocity_cmt.XOMOrderItemService xois = (vlocity_cmt.XOMOrderItemService) vlocity_cmt.XOMObjectFactory.getService(vlocity_cmt__FulfilmentRequestLine__c.SObjectType);
        for(String item : itemList){          
            vlocity_cmt.XOMOrderItemDomainObject frl = (vlocity_cmt.XOMOrderItemDomainObject) xois.getObject(Id.valueOf(item));
            
            List<String> attrList = attributeCode != null ? new List <String> {attributeCode} : new List <String> (attributeMap.keySet()); // Código de atributo a ser atualizado
            for (String attr : attrList){
                vlocity_cmt.XOMAttributeValueRT attrValue = frl.getAttributeValue(attr);
                //system.debug('Attribute: ' + attr + '; Attribute Value: ' + attrValue.getValue() + ';');
        
                // O código abaixo atualiza o valor do atributo do fulfilment request line especificado
                if(attrValue != null) {
                    attrValue.setValue(attributeCode != null ? attributeValue : attributeMap.get(attr));
                }
                frl.updateObject();
            }
            omItemList.add(frl);
        }
        vlocity_cmt.XOMObjectFactory.commitObjs();

    }
    
    //Método que retorna o valor de um atributo de um fulfilment request line
    public void getAttribute(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        Id fulfilmentRequestLineId = (Id) inputMap.get('FulfilmentRequestLineId'); 
        List<Object> attrList = (List<Object>) inputMap.get('AttributeCodeList');
        
        vlocity_cmt.XOMAttributeValueRT attrValue;
        List<String> itemList = new List <String> {fulfilmentRequestLineId};
        List<vlocity_cmt.XOMOrderItemDomainObject> omItemList = new List<vlocity_cmt.XOMOrderItemDomainObject>();
        vlocity_cmt.XOMOrderItemService xois = (vlocity_cmt.XOMOrderItemService) vlocity_cmt.XOMObjectFactory.getService(vlocity_cmt__FulfilmentRequestLine__c.SObjectType);
        for(String item : itemList){
            vlocity_cmt.XOMOrderItemDomainObject frl = (vlocity_cmt.XOMOrderItemDomainObject) xois.getObject(Id.valueOf(item));
            
            for(Object attrObj : attrList){
                String attr = (String) attrObj;
                attrValue = frl.getAttributeValue(attr);
                if (attrValue != null) {
                	outputMap.put(attr, attrValue.getValue());
                }
            }
        } 
    }
}