global class ValentinaCustomVIPImplementation extends vlocity_cmt.DefaultSystemInterface {

    /* Exception class */
    public class IntegrationProcedureUnrecoverableException extends Exception {}
     

    
    global ValentinaCustomVIPImplementation() {
        super();
    }
    /**
     * This method is a part of the ISystemInterface. It is invoked at the start of the batch
     * 
     * @param url   base URL the batch is started for
     * @param path  path this batch is started for
     */
    global override void startBatch(String url, String path) {}
 
    /**
     * Executes a Callout OrchestrationItem
     * 
     * @param url   base URL to send the request to (in this class it is ignored as we'll be calling an Integration Procedure)
     * @param path  path to send the request to (in this class it is interpreted as the Integration Procedure API Key)
     * @param item  OrchestrationItem that needs to be executed
     */
    global override void executeItem(String url, String path, vlocity_cmt__OrchestrationItem__c item) {
        
        Map<String, Object> ipInput   = new Map<String, Object>();
        Map<String, Object> ipOptions = new Map<String, Object>();
        Object ipOutput;

        System.debug(JSON.serializePretty(item));
        
        // Add any extra information to the payload that might be useful and otherwise not available via the DataRaptors configured in the Callout
        ipInput.put('orchestration_item_id', item.Id);
        // Added field to prevent a new search using a data raptor on the IP
        ipInput.put('FRLId', item.vlocity_cmt__FulfilmentRequestLineId__c);

        ipOptions.put('queueableChainable', true);
        
        if (!test.isRunningTest()) {
            ipOutput = vlocity_cmt.IntegrationProcedureService.runIntegrationService(path, ipInput, ipOptions);
        }
  
        processResponse(item, ipInput, ipOutput);
    }
 
    /**
     * This method is called from executeItem to handle the response from the Integration Procedure.
     * By default it does nothing (but some logging), but it could be customized to do something more.
     *
     * @param item      The Orchestration Item
     * @param ipInput   The request sent to the Integration Procedure
     * @param ipOutput  The response from the Integration Procedure (could be a list or map)
     * 
     * 
 
     */
    global virtual void processResponse(vlocity_cmt__OrchestrationItem__c item, Map<String, Object> ipInput, Object ipOutput) {
 		Decimal errorCode;
            
        // Do nothing by default
        System.debug('JOE - IP Output -> ' + JSON.serialize(ipOutput));
        

        Map<String,Object> ipOutputMap = (Map<String,Object>) ipOutput;
 
        if (test.isRunningTest()) {
            ipOutputMap = new Map<String,Object>();
            ipOutputMap.put('request', '');
            ipOutputMap.put('response', '');

            if (item.name == 'NOK') {
                ipOutputMap.put('errorCode', 500);
            }
            else {
                ipOutputMap.put('errorCode', 200);
            }            
        }

        if (ipOutputMap != null) { 
            if (!String.isBlank(String.ValueOf(ipOutputMap.get('errorCode')))) {
                errorCode = (Decimal) ipOutputMap.get('errorCode');           
            }
            
            // For debugging, store the Request in the Orchestration Item SObject
            item.StatusCode__c = errorCode;
            
			if ((ipOutputMap.get('internalIPRequest') != null) && (ipOutputMap.get('request') != null)) {
                item.vlocity_cmt__Request__c = JSON.serialize(ipOutputMap.get('request')) + System.Label.InternalRequest + ' ' + JSON.serialize(ipOutputMap.get('internalIPRequest'));
            } else if (ipOutputMap.get('request') != null) {
            	item.vlocity_cmt__Request__c = JSON.serialize(ipOutputMap.get('request'));                
            }

			if ((ipOutputMap.get('internalIPResponse') != null) && (ipOutputMap.get('response') != null)) {
                item.vlocity_cmt__Response__c = JSON.serialize(ipOutputMap.get('response')) + System.Label.InternalResponse+ ' ' + JSON.serialize(ipOutputMap.get('internalIPResponse'));
            } else if (ipOutputMap.get('response') != null) {
            	item.vlocity_cmt__Response__c = JSON.serialize(ipOutputMap.get('response'));                
            }
		
            update item;
            
            System.debug('ipOutputMap:'+ipOutputMap);
            
            this.checkCriticalError(ipOutputMap, item, errorCode);
            if(errorCode > 299 || errorCode == null)
                throw new vlocity_cmt__.XOMOrchestrationInterfaces.SystemInterfaceRecoverableException((string)ipOutputMap.get('error'));
        }  
    }
    
    /**
     * This method is called at the end of the batch
     * 
     * @param url   base URL for the batch
     * @param path  path for the batch
     */
	global override void endBatch(String url, String path) {}
    
    
    /**
     * This method calls IP CheckRollback to check for critical error 
     * 
     * @param item        The Orchestration Item
     * @param errorCode   The errorcode 
     * @author: Diogo Sousa
     * 
     */
    private boolean checkCriticalError(Map<String,Object> ipOutputMap, vlocity_cmt__OrchestrationItem__c item, Decimal errorCode){
        
        Map<String, Object> ipInput   = new Map<String, Object>();
        Map<String, Object> ipOptions = new Map<String, Object>();

        List<Object> listObjErrors = new List<Object>{new Map<String, Object>{'returnCode' => errorCode}};
        
        ipInput.put('SystemInterfaceId', item.vlocity_cmt__SystemInterfaceId__c);
        ipInput.put('transactionId', item.Id);
        ipInput.put('callbackCode', ipOutputMap.get('errorCode'));
        ipInput.put('returnList', listObjErrors);

        Map<String,Object> ipCheckRollbackOutput;
        if (Test.isRunningTest()) {
            ipCheckRollbackOutput = (Map<String,Object>) JSON.deserializeUntyped('{"isCritical": false}');
        } else {
            ipCheckRollbackOutput = (Map<String,Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService('val_CheckRollback', ipInput, ipOptions);
        }                                   
        
        system.debug('aqui estamos nos. ipOutput: '+JSON.serialize(ipCheckRollbackOutput));
		system.debug('result: '+(Boolean)ipCheckRollbackOutput.get('isCritical'));        
        return (Boolean)ipCheckRollbackOutput.get('isCritical');

    }
 }