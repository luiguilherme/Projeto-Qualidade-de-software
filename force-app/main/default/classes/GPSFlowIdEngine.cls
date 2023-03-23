public with sharing class GPSFlowIdEngine {
    private static final String WEBSERVICE_NAME = 'GPSServiceFlowSearchCallout';

    /*
     * getGPSFlow()
     * Consome a API para obter os fluxos do GPS e retornar a lista
     * desses fluxos
     */
    public static Map<String, Object> getGPSFlow(Id flowId) {
        Map<String, Object> mapResponse = new Map<String,Object>();
        List<ItemTreeTO> ltTreeTO = new List<ItemTreeTO>();
        List<CustomerInteractionTopicTree__c> ltCustomerInteractionTopicTree = new List<CustomerInteractionTopicTree__c>();
        
        try {
            ltCustomerInteractionTopicTree = CustomerInteractionTopicTreeDAO.getEndFlowCustomerInteractionTopicTreeById(flowId);
            if(ltCustomerInteractionTopicTree.isEmpty()){
                mapResponse.put('error', Label.ServiceFlowEndFlowValidationMessage);
                return mapResponse;
            }
            
            mapResponse = GPSFlowIdCallout.execute(mapResponse, ltCustomerInteractionTopicTree[0].Instance__c);
            if(mapResponse.get('success') != null){
                GPSFlowIdTO gpsResponse = (GPSFlowIdTO) mapResponse.get('success');

                for(GPSFlowIdTO.Tipificacao tipificacao : gpsResponse.tipificacoes.tipificacao){
                    ItemTreeTO itemTree; 
                    itemTree = new ItemTreeTO(String.valueOf(tipificacao.id), tipificacao.hierarquia);
                    ltTreeTO.add(itemTree);
                }
                mapResponse.put('success', ltTreeTO);
            }

        } catch (Exception e) {
            mapResponse.put('error', e.getMessage());
        }
        return mapResponse;
    }
    
    /*
     * updateGPSFlowId()
     * Realiza atualização do id do fluxo em CustomerInteractionTopicTree
     */
    public static void updateGPSFlowId(String recordId, String flowId, String gpsFlow) {
		CustomerInteractionTopicTree__c customerInteractionTopicTree = new CustomerInteractionTopicTree__c();
        
        customerInteractionTopicTree.Id = recordId;
        customerInteractionTopicTree.GPSId__c = flowId;
        customerInteractionTopicTree.GPSFlow__c = GpsFlow;
        
        update customerInteractionTopicTree;
    }
}