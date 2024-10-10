public with sharing class BiometryHistoryService {
    public static List<BiometryHistoryResponse> findByFilters(String documentNumber, Date biometryDate, String orderId){
        
        if (String.isBlank(documentNumber) && biometryDate == null && String.isBlank(orderId)) {
            throw new IllegalArgumentException('Ao menos um parâmetro deve ser enviado para realizar a consulta da biometria.');
        }
                
        if (String.isNotBlank(orderId)) {
            orderId = orderId.replaceAll('[a-zA-Z]', '');
        }
      
        List<BiometryHistoryResponse> responseList = BiometryHistoryFacade.findByFilters(documentNumber, biometryDate, orderId);
        return responseList;
    }
}