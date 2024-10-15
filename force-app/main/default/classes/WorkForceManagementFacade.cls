public with sharing class WorkForceManagementFacade {

    public static final String CONST_STRING_WEBSERVICENAME = 'WorkForceManagementCallout';

    public static WorkOrder findById(String id) {
        
        Webservice__c ws =  Webservice__c.getInstance(CONST_STRING_WEBSERVICENAME);
        ws.Endpoint__c = ws.Endpoint__c.replace('{id}', id);

        HttpClient hClient = new HttpClient();
        HttpResponse response = hClient.get(ws);
        
        if ((response.getStatusCode() / 100) != 2) {
            String errorMessage = 'Endpoint: ' + ws.Endpoint__c;
            errorMessage += '\nStatus Code: ' + response.getStatusCode();
            errorMessage += '\nMensagem: ' + response.getBody();
            throw new CalloutException(errorMessage);
        }
        
        String responseBody = response.getBody();

        System.debug('responseBody: ' + responseBody);

        try {
            WorkOrder wo = (WorkOrder) JSON.deserialize(responseBody, WorkOrder.class);

            System.debug('wo: ' + wo);

            return wo;
        } catch (Exception e) {
            System.debug('Erro ao converter resposta do webservice: ' + e.getMessage());
            return null;
        }

    }

}