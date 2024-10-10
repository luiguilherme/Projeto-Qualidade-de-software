public with sharing class BiometryHistoryController {
    public class RetrieveBiometryHistoryFilter{
        @InvocableVariable
        public String documentNumber;
        @InvocableVariable
        public Date biometryDate;
        @InvocableVariable
        public String orderId;
    }

    @InvocableMethod(label='Biometry History Controller' description='Classe utilizada para a busca histórico de biometria do cliente no GEDOC')
    public static List<String> findBiometryHistoryByParams(List<RetrieveBiometryHistoryFilter> filter) {
        List<BiometryHistoryResponse> responseList = BiometryHistoryService.findByFilters(filter[0].documentNumber, filter[0].biometryDate, filter[0].orderId);
		List<String> itensResponse = new List<String>();
        if (responseList != null && !responseList.isEmpty()) {
            for(BiometryHistoryResponse rspLst : responseList){
                if(rspLst.items != null && !rspLst.items.isEmpty()){
                    for(BiometryHistoryResponse.Items rspItns : rspLst.items){
                        if(rspItns.motorStatus != null){
                            itensResponse.add(rspItns.motorStatus);
                       		break;
                        }
                	}
                }
                if(!itensResponse.isEmpty()){
                    break;
                }   
            }
        }
        return itensResponse;
    }
}