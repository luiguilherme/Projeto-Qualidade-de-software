public class ExtractDetailedAsPdfControllerPrepaid {
    
    private final String lineNumber;
    private final String startDate;
    private final String endDate;
    Map<String, Object> ipOutput {get; set;}
    private Map<String, String> outPutJSON = new Map<String, String>(); 
    
    private String responseHTTP;

    public ExtractDetailedAsPdfControllerPrepaid() {

        lineNumber = ApexPages.currentPage().getParameters().get('LineNumber');
        startDate = ApexPages.currentPage().getParameters().get('startDate');
        endDate = ApexPages.currentPage().getParameters().get('endDate');

    }
    
    public void executeStatement() {
        
        String procedureName = 'val_CalloutConsumptionSummary';
        Map<String, Object> ipInput = new Map<String, Object> ();
        Map<String, Object> ipOptions = new Map<String, Object> ();
        
        ipInput.put('contextNumber', lineNumber);
        ipInput.put('startDate', startDate);
        ipInput.put('endDate', endDate);

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
    
    
    
    public String getLineNumber() {
        return lineNumber;
    }

    public String getStartDate() {
        return startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public Map<String, Object> getIpOutput() {
        return ipOutput;
    }



}