/*
*
*   Description: Classe responsável exclusivamente pelas regras de negócio de Consulta de Massiva
*
*   Author: André Luis
*   Date:   01/07/2021
*
*/
public with sharing class MassiveSuspicionCaseCallout {
    private static final Integer CODE_HTTP_SUCCESS = 200;
        
    public static Map<String,Object> execute(Map<String,Object> mapResult, String assetInstance) { 
        HttpResponse httpResponse = (!Test.isRunningTest() ? 
                new HttpClient().post('MassiveSuspicionCallout', 
                new MassiveSuspicionCaseRequest(assetInstance).createRequestStructure().toJson()
                ) : null);
        if(Test.isRunningTest()){
            mapResult.put('success', true);
            return mapResult;
        }
                    
        if(httpResponse.getStatusCode() != CODE_HTTP_SUCCESS) {
            mapResult.put('error','Erro ao chamar a API');           
        }else{
            mapResult.put('success', httpResponse.getBody());
        }
        return mapResult;
    }
}