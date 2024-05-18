public class ImeiSearchAsPdfController {
    
    private final String LineNumber;
    private final String StartDateTime;
    private final String EndDateTime;
    
    Map<String, Object> ipOutput {get; set;}
    private Map<String, String> outPutJSON = new Map<String, String>(); 
    
    private String responseHTTP;
    
    public ImeiSearchAsPdfController() {

        LineNumber = ApexPages.currentPage().getParameters().get('LineNumber');
        StartDateTime = ApexPages.currentPage().getParameters().get('StartDateTime');
        EndDateTime = ApexPages.currentPage().getParameters().get('EndDateTime');
        
        //LineNumber = ApexPages.getParameters().get('LineNumber');
        //StartDateTime = ApexPages.getParameters().get('StartDateTime');
       // EndDateTime = ApexPages.getParameters().get('EndDateTime');
          
        
    }
    
    public void executeStatement() {
        
        String procedureName = 'val_SearchImei';
        Map<String, Object> ipInput = new Map<String, Object> ();
        Map<String, Object> ipOptions = new Map<String, Object> ();

        //ipInput.put('LineNumber', this.LineNumber);
        /*
        ipInput.put('LineNumber', '11915000024');
        ipInput.put('StartDateTime', '01/02/2024');
        ipInput.put('EndDateTime', '15/02/2024');
        System.debug('ipInput: ' + ipInput);
        */
        
        ipInput.put('LineNumber', this.LineNumber);
        ipInput.put('StartDateTime', this.StartDateTime);
        ipInput.put('EndDateTime', this.EndDateTime);
        
        
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
        return LineNumber;
    }

    public Map<String, Object> getIpOutput() {
        return ipOutput;
    }
    
    public String getEndDateTime() {
        return EndDateTime;
    }

    public String getStartDateTime() {
        return StartDateTime;
    }
    
        
    
}