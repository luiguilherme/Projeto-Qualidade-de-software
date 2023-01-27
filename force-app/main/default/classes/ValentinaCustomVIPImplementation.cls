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
            Decimal errorCode = (Decimal) ipOutputMap.get('errorCode');            
            
            // For debugging, store the Request in the Orchestration Item SObject
            item.StatusCode__c = errorCode;
            
            if (ipOutputMap.get('request') != null) {
            	item.vlocity_cmt__Request__c = JSON.serialize(ipOutputMap.get('request'));                
            }

            if (ipOutputMap.get('response') != null) {
            	item.vlocity_cmt__Response__c = JSON.serialize(ipOutputMap.get('response'));                
            }

            update item;

            If(errorCode > 299 || errorCode == null)  {
                throw new vlocity_cmt__.XOMOrchestrationInterfaces.SystemInterfaceRecoverableException((string)ipOutputMap.get('error'));
            }            
        }  
    }
    
    /**
     * This method is called at the end of the batch
     * 
     * @param url   base URL for the batch
     * @param path  path for the batch
     */
    global override void endBatch(String url, String path) {}   
 }