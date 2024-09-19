public with sharing class ServiceRequestsHandler {
    public class ServicoDTO {
      public String motivo { get; set; }
      public String nrSolicitacaoServico { get; set; }
      public String status { get; set; }
      public Boolean owner { get; set; }
  }
  @future(callout=true)
  public static void processServiceRequests(List<String> requests) {
      List<ServiceRequest__c> serviceRequestsToProcess = [select id,name,Status__c,ownerid,ServiceReason__c,VivoMaestro_ID__c from ServiceRequest__c where id in:requests];
     Group queue = [SELECT Id FROM Group WHERE Type = 'Queue' AND Name = 'Backoffice Atendimento' LIMIT 1];

      WebService__c wsConfig = WebService__c.getInstance('CamundaTicketInformation');  

      if (wsConfig == null) {
          System.debug('WebService__c instance is null');
          return;  
      }

   system.debug(wsConfig);

      HttpClient httpClient = new HttpClient();

      for (ServiceRequest__c req : serviceRequestsToProcess) {

          //String  payload = JSON.serialize(req);
          ServicoDTO servico = new ServicoDTO();
          servico.motivo = req.ServiceReason__c;
          servico.nrSolicitacaoServico = req.Name;
          servico.status = req.Status__c;
          if(queue.id == req.ownerid){
                servico.owner = false;
          }else{
               servico.owner = true;
          }

          String requestJson = JSON.serialize(servico);
          wsConfig.Endpoint__c=wsConfig.Endpoint__c + '/api/tratativa-ticket/'+ req.VivoMaestro_ID__c+'/status';


          // Envia a solicitação usando o HttpClient
          HttpResponse response = httpClient.put(wsConfig, requestJson);

          // Log de resposta para depuração
          System.debug('Resposta da API: ' + response.getBody());

          // Verifique o status da resposta
          if (response.getStatusCode() != 200) {
              // Adicionar tratamento de erro, se necessário
              System.debug('Erro ao chamar a API. Código de status: ' + response.getStatusCode());
          }
      }
  }
}