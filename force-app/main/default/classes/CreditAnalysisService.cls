public without sharing class CreditAnalysisService {
     /*
    * Retorna um map com analise de credito ou possiveis erros do procesos
    *
    * Retorno:
    *   Key | Descrição
    *   'RequiredFields'    | List,String>              | Campos obrigatórios ausentes
    *   'success'           | String                    | Mensagem de sucesso da análise de crédito, quando os campos de account ja foram atualizados
    *   'error'             | String                    | Erros executados no processo
    */ 
    public static Map<String, Object> executeCreditAnalysis(Account accountContext) {
        return CreditAnalysisEngine.executeCreditAnalysis(AccountContext);
    }

    public static Map<String, Object> executeCreditAnalysis(Account accountContext, String usedIn) {
        return CreditAnalysisEngine.executeCreditAnalysis(AccountContext, usedIn);
    }

}