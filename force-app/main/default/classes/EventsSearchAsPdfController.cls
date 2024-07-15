public class EventsSearchAsPdfController {
    
    private final String networkNumber;
    private final String startDateTime;
    private final String endDateTime;
    private final String eventType;
    private final String inOperation;
    private final String completeError;
    private final String currentPage;
    
    Map<String, Object> ipOutput {get; set;}
    private Map<String, String> outPutJSON = new Map<String, String>(); 
    
    private String responseHTTP;

    public EventsSearchAsPdfController() {

        networkNumber = ApexPages.currentPage().getParameters().get('networkNumber');
        startDateTime = ApexPages.currentPage().getParameters().get('startDateTime');
        endDateTime = ApexPages.currentPage().getParameters().get('endDateTime');
        eventType = ApexPages.currentPage().getParameters().get('eventType');
        completeError = ApexPages.currentPage().getParameters().get('completeError');
        currentPage = ApexPages.currentPage().getParameters().get('currentPage');
        
    }
    
    public void executeStatement() {
        
        String procedureName = 'val_HistoriesDetailsData';
        Map<String, Object> ipInput = new Map<String, Object> ();
        Map<String, Object> ipOptions = new Map<String, Object> ();

        ipInput.put('networkNumber', networkNumber);
        ipInput.put('startDateTime', startDateTime);
        ipInput.put('endDateTime', endDateTime);
        ipInput.put('eventType', eventType);
        ipInput.put('completeError', completeError);
        ipInput.put('currentPage', currentPage);
		
        System.debug('ipInput: ' + ipInput);
        
        ipOutput = (Map<String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(procedureName, ipInput, ipOptions);
        System.debug('ipOutput Puro: ' + ipOutput);
        
        for(String key : ipOutput.keySet()) {
            outPutJSON.put(key, JSON.serialize(ipOutput.get(key)));
        }
        
        System.debug('AFTER LOOP');
        
         for(String key : ipOutput.keySet()) {
            System.debug(key);
            System.debug(outPutJSON.get(key));
        }
        
        System.debug('IP Output: ' + ipOutput);
    }
    
    
    public String getnetworkNumber() {
        return networkNumber;
    }

    public String getStartDateTime() {
        return startDateTime;
    }
    
    public String getEndDateTime() {
        return endDateTime;
    }
    
    public String getEventType() {
        return eventType;
    }
    
    public String getCompleteError() {
        return completeError;
    }
    
    public String getCurrentPage() {
        return currentPage;
    }
    
    public Map<String, Object> getIpOutput() {
        return ipOutput;
    }
}