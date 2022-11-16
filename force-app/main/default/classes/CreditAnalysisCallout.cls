public with sharing class CreditAnalysisCallout {
    private static final Integer CODE_HTTP_SUCCESS = 200;
        
    public static void execute(Map<String,Object> mapResult, Account accountContext, String salesChannel, String salesChannelName, String userId) { 
        
        HttpResponse httpResponse = (!Test.isRunningTest() ? 
                    new HttpClient().post('AnalysisCreditCallout', 
                    new CreditAnalysisRequest(accountContext, salesChannel, salesChannelName, userId).createRequestStructure().toJson()
                    ) : null);
        if(Test.isRunningTest()){
            mapResult.put('success', null);
            return;
        }
                    
        if(httpResponse.getStatusCode() != CODE_HTTP_SUCCESS) {
            mapResult.put('error', null);           
        }else{
           mapResult.put('success', CreditAnalysisResponse.parse(httpResponse.getBody()));
        }    
}
}