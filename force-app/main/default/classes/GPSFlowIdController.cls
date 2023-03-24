public with sharing class GPSFlowIdController {
    /*
     * getGPSFlow()
     * Obtém a consulta de fluxos do GPS e a retorna transformando 
     * a estrutura para que atenda o objeto tree do componente
     */
    @AuraEnabled
    public static Map<String, Object> getGPSFlow(Id flowId) {
        return (GPSFlowIdService.getGPSFlow(flowId));
    }

    /*
     * updateGPSFlowId()
     * Envia solicitação de atualização do id do fluxo em CustomerInteractionTopicTree__c
     */
    @AuraEnabled
    public static void updateGPSFlowId(String recordId, String flowId, String gpsFlow) {
        GPSFlowIdService.updateGPSFlowId(recordId, flowId, gpsFlow);
    }
}