public with sharing class GPSFlowIdService {
    /*
     * getGPSFlow()
     * Obtém e retorna a consulta de fluxos do GPS 
     */
    public static Map<String, Object> getGPSFlow(Id flowId) {
        return (GPSFlowIdEngine.getGPSFlow(flowId));
    }

    /*
     * updateGPSFlowId()
     * Envia solicitação de atualização do id do fluxo em CustomerInteractionTopicTree__c
     */
    public static void updateGPSFlowId(String recordId, String flowId, String gpsFlow) {
        GPSFlowIdEngine.updateGPSFlowId(recordId, flowId, gpsFlow);
    }
}