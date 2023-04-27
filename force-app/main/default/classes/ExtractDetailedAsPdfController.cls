public class ExtractDetailedAsPdfController {
    
    private final String lineNumber;
    private final String conta;
    private final String plano;
    private final String emissao;
    private final String startDate;
    private final String endDate;
    private final String periodo;
    Map<String, Object> ipOutput {get; set;}
    private Map<String, String> outPutJSON = new Map<String, String>(); 
    
    private String responseHTTP;

    public ExtractDetailedAsPdfController() {

        lineNumber = ApexPages.currentPage().getParameters().get('LineNumber');
        conta = ApexPages.currentPage().getParameters().get('conta');
        plano = ApexPages.currentPage().getParameters().get('plano');
        emissao = ApexPages.currentPage().getParameters().get('emissao');
        startDate = ApexPages.currentPage().getParameters().get('startDate');
        endDate = ApexPages.currentPage().getParameters().get('endDate');
        periodo = ApexPages.currentPage().getParameters().get('periodo');

    }
    
    public void executeStatement() {
        String procedureName = 'pan_DetailedExtract';
        Map<String, Object> ipInput = new Map<String, Object> ();
        //Map<String, Object> ipOutput = new Map<String, Object> ();
        Map<String, Object> ipOptions = new Map<String, Object> ();
        
        ipInput.put('contextNumber', lineNumber);
        ipInput.put('startDate', startDate.replace('/', ''));
        ipInput.put('endDate', endDate.replace('/', ''));

        System.debug('ipInput: ' + ipInput);
        
        ipOutput = (Map<String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(procedureName, ipInput, ipOptions);
        System.debug('ipOutput Puro: ' + ipOutput);
                
        for(String key : ipOutput.keySet()) {
            system.debug('Valor retornado: ' + key + ': ' + ipOutput.get(key));
            outPutJSON.put(key, JSON.serialize(ipOutput.get(key)));
            system.debug('Valor serializado: ' + key + ': ' + outPutJSON.get(key));

            if(String.isEmpty(outPutJSON.get(key)) || outPutJSON.get(key)=='[]' || outPutJSON.get(key)=='""')
            {
                ipOutput.remove(key);
                ipOutput.put(key, '-');
                system.debug('Valor reinserido: ' + key + ': ' + ipOutput.get(key));
            }
        }
        
        System.debug('AFTER LOOP');
        
         for(String key : ipOutput.keySet()) {
        	System.debug(key);
        	System.debug(outPutJSON.get(key));
        }
        
        System.debug('IP Output: ' + ipOutput);
        //List<Object> lstCallsDetailInfo = new List<Object>();
        //lstCallsDetailInfo = (List<Object>) ipOutput.get('CALLS_DETAIL');
        //System.debug('lstCallsDetailInfo: ' + lstCallsDetailInfo);        

    }
    
   // public void getHTTP() {
   //     String params = '?networkNumber='+getLineNumber()+'&reason=A+pedido+do+cliente'+'&reportType=1'+'&startDate='+ getStartDate()+'&endDate='+getEndDate();
   //     responseHTTP = HttpDetailedExtract.getDetailedExtractContents('extractDetail', params);
   // }

    /*public static void mapingJson(){
        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(responseHTTP);
        System.debug(m);
    }*/
    
    
    public String getLineNumber() {
        return lineNumber;
    }

    public String getConta() {
        return conta;
    }

    public String getPlano() {
        return plano;
    }

    public String getEmissao() {
        return emissao;
    }

    public String getStartDate() {
        return startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public String getPeriodo() {
        return periodo;
    }

    public Map<String, Object> getIpOutput() {
        return ipOutput;
    }

    /*
    public PageReference urlRedirection() {

        String baseURL = URL.getSalesforceBaseUrl().toExternalForm();
        String PageURL = ApexPages.currentPage().getUrl();
        String wholeURL = baseURL + PageURL;

        string url = URL.getCurrentRequestUrl().toExternalForm();

        String lineNumber = '119998987';
        String conta = 'conta';
        String plano = 'Tarifário TIM';
        String emissao = '19/03/2023';
        String startDate = '12/03/2023';
        String endDate = '19/03/2023';
        String periodo = '12/03/2023 A 19/03/2023';

        System.debug('lineNumber: ' + lineNumber);
        System.debug('conta: ' + conta);
        System.debug('plano: ' + plano);
        System.debug('emissao: ' + emissao);
        System.debug('startDate: ' + startDate);
        System.debug('endDate: ' + endDate);

        String url = 'https://valentinatelefonica--devcontrol.sandbox.lightning.force.com/apex/ExtractDetailedAsPdf?linenumber='+lineNumber + '&conta='+conta + '&plano=' + plano + '&emissao=' + emissao + '&periodo=' + startDate + '+A+' + endDate + '&startDate=' + startDate + '&endDate=' + endDate;
        url='https://valentinatelefonica--devcontrol.sandbox.lightning.force.com/lightning/o/Opportunity/list?filterName=00B5f000009GQfjEAG';
        url = 'http://www.google.ca/';
        system.debug('URL: ' + url);

        PageReference page = new PageReference(url);
        
        page.setRedirect(true);
        return page;
  }
  */

}