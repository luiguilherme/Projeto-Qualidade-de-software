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
                /*when 'getHistoryStatusSuspension'{
                    System.debug('inputMap' + inputMap);
                    System.debug('outMap' + outMap);
                    System.debug('options' + options);
                    getHistoryStatusSuspension(inputMap, outMap, options);
                }*/
                when 'getLastActiveStatus' {
                    getLastActiveStatus(inputMap, outMap, options); 
                }   
                when 'getStatusBeforePortout' {
                    getStatusBeforePortout(inputMap, outMap, options); 
                }
                when 'getStatusBeforeChangeOwnership' {
                    getStatusBeforeChangeOwnership(inputMap, outMap, options);
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

    public void getStatusBeforePortout(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        String status, portoutStatus;
        List<Object> listStatusHistory = (List<Object>) inputMap.get('statusHistory');            
        
        if (listStatusHistory != null) {
            Integer historySize = listStatusHistory.size();

            for(Integer i=historySize; i>0; i--) {
                Map<String,Object> statusHistory = (Map<String,Object>) listStatusHistory.get(i-1);
                portoutStatus = (String) statusHistory.get('status');

                if (portoutStatus == 'RecemPortado') {
                    statusHistory = (Map<String,Object>) listStatusHistory.get(i-2);
                    if (statusHistory != null) {
                        status = (String) statusHistory.get('status');                    
                    }
                }
            }
        }
        outputMap.put('status', status);
    }   
    
    public void getStatusBeforeChangeOwnership(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        String status, ownwershipStatus;
        boolean apto = false;
        List<Object> listStatusHistory = (List<Object>) inputMap.get('statusHistory');            
        
        if (listStatusHistory != null) {
            Integer historySize = listStatusHistory.size();

            for(Integer i=historySize; i>0; i--) {
                Map<String,Object> statusHistory = (Map<String,Object>) listStatusHistory.get(i-1);
                ownwershipStatus = (String) statusHistory.get('status');

                 if(StatusHistory.get('status') == 'SuspAFraude' && 
                 StatusHistory.get('status') == 'SuspAPedido' &&
                 StatusHistory.get('status') == 'SuspCadastro' &&
                 StatusHistory.get('status') == 'SuspARoubo') {
                    statusHistory = (Map<String,Object>) listStatusHistory.get(i-2);
                    if (statusHistory != null) {
                        status = (String) statusHistory.get('status');                    
                    }
                }
                else{
                    apto = true;
                }
            }
        }

        outputMap.put('status', status);
        outputMap.put('apto', apto);
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

    /*public void getHistoryStatusSuspension(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options){
        List<Object> listStatusHistory = (List<Object>) inputMap.get('statusHistory');
        String StatusSF = (String)inputMap.get('StatusSF');
        String actualStatus, newStatus;  
        
        if (listStatusHistory != null) {

            Map<String,Object> StatusHistory = (Map<String,Object>) listStatusHistory.get(listStatusHistory.size()-1);
   	
        	if (StatusSF == StatusHistory.get('status')){
                    For(integer i = listStatusHistory.size()-2;i >= 0; i--){
                        StatusHistory = (Map<String,Object>) listStatusHistory.get(i);
                        	if(StatusHistory.get('status') == 'SuspAFraude' || 
                               StatusHistory.get('status') == 'SuspAPedido' || 
                               StatusHistory.get('status') == 'SuspARoubo'){ 
                                   if(StatusSF == 'SuspAFraude' && StatusHistory.get('status') != 'SuspAfraude'){
                                      Map<String,Object> validFor = (Map<String,Object>) StatusHistory.get('validFor');
                                       String endDateTimeString = (String) validFor.get('endDateTime'); 
                                       String endDateString = endDateTimeString.substring(0,10);
                                       Date endDateTimeWithoutTime = Date.valueOf(endDateString);
                                       	Date currentDate = Date.today(); 
                                       		if(endDateTimeWithoutTime >= currentDate){ 
                                               newStatus = (String) StatusHistory.get('status');
                                               	break;
                                           } 
                                   }
                                   if(StatusSF == 'SuspARoubo' && StatusHistory.get('status') != 'SuspAfraude' || StatusHistory.get('status') != 'SuspAfraude'){ 
                                      Map<String,Object> validFor = (Map<String,Object>) StatusHistory.get('validFor');
                                       String endDateTimeString = (String) validFor.get('endDateTime'); 
                                       String endDateString = endDateTimeString.substring(0,10);
                                       Date endDateTimeWithoutTime = Date.valueOf(endDateString);
                                       	Date currentDate = Date.today(); 
                                       		if(endDateTimeWithoutTime >= currentDate){ 
                                               newStatus = (String) StatusHistory.get('status');
                                               	break;
                                            } 
                                   }  
                            }
                        	else{newStatus = (String) StatusHistory.get('status');
								break;
                                }
                    }
                }
            else{actualStatus = (String) StatusHistory.get('status');
			 }
        }
        outputMap.put('actualStatus', actualStatus);
        outputMap.put('newStatus', newStatus);
    }*/
    
    public void getLastActiveStatus(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options){
        List<Object> listStatusHistory = (List<Object>) inputMap.get('statusHistory');
        String newStatus;  
        
        if (listStatusHistory != null) {
            Map<String,Object> StatusHistory = (Map<String,Object>) listStatusHistory.get(listStatusHistory.size()-1);
                    For(integer i = listStatusHistory.size()-2;i >= 0; i--){
                        StatusHistory = (Map<String,Object>) listStatusHistory.get(i);
                        	if(StatusHistory.get('status') != 'SuspAFraude' && 
                               StatusHistory.get('status') != 'SuspAPedido' && 
                               StatusHistory.get('status') != 'SuspARoubo')
                               { 
                                newStatus = (String) StatusHistory.get('status');
								break;                                
                               }
                    }
        } 
        
        else {
            newStatus = (String) 'Sem Status declarado';
        }
           
        outputMap.put('newStatus', newStatus);
    }
}