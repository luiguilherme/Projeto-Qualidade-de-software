global with sharing class ValentinaCustomOMController implements vlocity_cmt.VlocityOpenInterface2 {
    
    global Object invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean success = true;
        String errors = 'OK';
        try{
            switch on methodName {
                when 'repropagateAttribute' {
                    repropagateAttribute(inputMap, outMap, options); 
                }
                when 'getHistoryStatus' {
                    getHistoryStatus(inputMap, outMap, options); 
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
    
    public void repropagateAttribute(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        Id orderItemId = (Id) inputMap.get('OrderItemId');
        String attributeCode = (String) inputMap.get('AttributeCode');
        String attributeValue = (String) inputMap.get('AttributeValue');
        Map<String,String> attributeMap = (Map<String,String>) inputMap.get('AttributeMap');

        List<vlocity_cmt__FulfilmentRequestLineDecompRelationship__c> frlDecompRelList = [SELECT Id, vlocity_cmt__DestinationFulfilmentRequestLineId__c FROM vlocity_cmt__FulfilmentRequestLineDecompRelationship__c WHERE vlocity_cmt__SourceOrderItemId__c = :orderItemId];
        List<Id> frlIdList = new List<Id>();

        for (vlocity_cmt__FulfilmentRequestLineDecompRelationship__c frlDecompRel : frlDecompRelList) {
            frlIdList.add(frlDecompRel.vlocity_cmt__DestinationFulfilmentRequestLineId__c);
        }

        FulfilmentRequestLineController frlController = new FulfilmentRequestLineController();

        Map<String,Object> frlInputMap = new Map<String,Object>();
        Map<String,Object> frlOutputMap  = new Map<String,Object>();

        frlInputMap.put('FulfilmentRequestLineIdList', (List<String>) frlIdList);
        if(attributeCode != null) {
            frlInputMap.put('AttributeCode', attributeCode);
            frlInputMap.put('AttributeValue', attributeValue);
        }
		frlInputMap.put('AttributeMap', attributeMap);

        frlController.invokeMethod('setAttribute', frlInputMap, frlOutputMap, options);
    }

    public void getHistoryStatus(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        String actualStatus, lastStatus;
        List<Object> listStatusHistory = (List<Object>) inputMap.get('statusHistory');
        
        if (listStatusHistory != null) {
            Integer historySize = listStatusHistory.size();

            if (historySize >= 2) {
                Map<String,Object> StatusHistory = (Map<String,Object>) listStatusHistory.get(historySize-2);
                actualStatus = (String) StatusHistory.get('status');

                StatusHistory = (Map<String,Object>) listStatusHistory.get(historySize-3);
                lastStatus = (String) StatusHistory.get('status');            
            }
        }

        outputMap.put('actualStatus', actualStatus);
        outputMap.put('lastStatus', lastStatus);
    }    
}