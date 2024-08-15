public with sharing class WorkForceManagementFacade {

    public static final String CONST_STRING_WEBSERVICENAME = 'WorkForceManagementCallout';

    public static WorkOrder findById(String id) {
        
        Webservice__c ws =  Webservice__c.getInstance(CONST_STRING_WEBSERVICENAME);
        ws.Endpoint__c = ws.Endpoint__c.replace('{id}', id);

        HttpClient hClient = new HttpClient();
        HttpResponse response = hClient.get(ws);
        String responseBody = response.getBody();

        try {
            WorkOrder wo = (WorkOrder) JSON.deserialize(responseBody, WorkOrder.class);
            return wo;
        } catch (Exception e) {
            System.debug('Erro ao converter resposta do webservice: ' + e.getMessage());
            return null;
        }

    }

}