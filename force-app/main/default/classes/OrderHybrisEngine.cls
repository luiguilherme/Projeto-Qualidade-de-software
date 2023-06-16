public with sharing class OrderHybrisEngine {
    public static Map<String, Object> syncOrderStatusWithHybris(String orderIssuedId) {
        Map<String, Object> mapResult;
        
        OrderIssued__c orderIssuedContext = OrderIssuedDAO.getById(orderIssuedId);

        if(orderIssuedContext == null) {
            mapResult.put('error', 'Não encontrado registro de Order Issued');//TODO: Trocar por Custom Label
            return mapResult;
        }

        mapResult = OrderHybrisCallout.execute(orderIssuedContext.HybrisOrder__c);

        if(mapResult.get('error') != null){
            return mapResult;
        }

        OrderHybrisResponse response = OrderHybrisResponse.parse((String) mapResult.get('response'));

        orderIssuedContext.Status__c = response.status;
        update orderIssuedContext;
        
        mapResult.put('success', 'Atualizado com sucesso!');//TODO: Trocar por Custom Label
        mapResult.put('OrderIssued__c', orderIssuedContext);
        return mapResult;
    }
}