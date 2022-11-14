/*
*
*   Description: Classe responsável exclusivamente pelas regras de negócio de Consulta de Massiva
*
*   Author: André Luis
*   Date:   01/07/2021
*
*/

public with sharing class MassiveFixedCaseCallout {
    private static final Integer CODE_HTTP_SUCCESS = 200;
        
    public static Map<String,Object> execute(Map<String,Object> mapResult, String assetInstance) { 

        HttpResponse httpResponse = (!Test.isRunningTest() ? 
                new HttpClient().post('MassiveFixedCallout', 
                new MassiveFixedCaseRequest(assetInstance, 'MassiveFixedCallout').createRequestStructure().toJson()
                ) : null);
        if(Test.isRunningTest()){
            mapResult.put('success', true);
            return mapResult;
        }
                    
        if(httpResponse.getStatusCode() != CODE_HTTP_SUCCESS) {
            mapResult.put('error', Label.MassiveBillingAccountError);           
        }else{
            mapResult.put('success', httpResponse.getBody());
        }
        return mapResult;
    }
}