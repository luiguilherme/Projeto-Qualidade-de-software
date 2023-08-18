@RestResource(urlMapping='/service/*')
global with sharing class ServiceAuthorization {

    global class ContentResponseSuccess {
        global String id { get; set; }
        global Boolean success { get; set; }
        global Integer statusCode { get; set; }
    }

    @HttpPost
    global static void processRequest(String sObjectName, String recordType, String id) {

        try {
            vlocity_cmt__CustomerInteraction__c customerInteractionToUpdate = CustomerInteractionDAO.getCustomerInteractionById(id);
           
            if(customerInteractionToUpdate.TokenStatus__c == 'Aguardando validação') {
                DateTime dateTimeAtual = DateTime.now();
                String diaMesAno = dateTimeAtual.format('dd/MM/yy');
                system.debug(Datetime.now().format('dd/MM/yy'));
                system.debug(Datetime.now().format('hh:mm'));
                customerInteractionToUpdate.TokenLastDateSend__c = dateTimeAtual;
                customerInteractionToUpdate.TokenStatus__c = 'Validado';
                customerInteractionToUpdate.vlocity_cmt__Comments__c = 'Validação de Token de Segurança realizada em ' + diaMesAno + ' às ' + dateTimeAtual.format('hh') + 'h' + dateTimeAtual.format('mm') + '.'; 
            }

            Database.SaveResult saveResult = Database.update(customerInteractionToUpdate);

            if (saveResult.isSuccess()) {
                RestResponse res = RestContext.response;
                ContentResponseSuccess ContentResponseSuccess = new ContentResponseSuccess();
                ContentResponseSuccess.id = id;
                ContentResponseSuccess.success = true;
                ContentResponseSuccess.statusCode = 200;
                res.responseBody = Blob.valueOf(JSON.serialize(ContentResponseSuccess, true));

            } else {
                RestResponse resp = RestContext.response;
                ContentResponseSuccess lContentResponseErro = new ContentResponseSuccess();
                lContentResponseErro.success = false;
                lContentResponseErro.id = saveResult.getErrors()[0].getMessage();

                lContentResponseErro.statusCode = 500;
                resp.responseBody = Blob.valueOf(JSON.serialize(lContentResponseErro, true));
            }   
        } catch (Exception ex){
            vlocity_cmt__CustomerInteraction__c customerInteractionToUpdate = new vlocity_cmt__CustomerInteraction__c();
            customerInteractionToUpdate.id = id;
            customerInteractionToUpdate.TokenSendAttempts__c --;
            customerInteractionToUpdate.TokenStatus__c = 'Falha na comunicação API';

            update customerInteractionToUpdate;

            RestResponse resp = RestContext.response;
            ContentResponseSuccess lContentResponseErro = new ContentResponseSuccess();
            lContentResponseErro.success = false;
            lContentResponseErro.id =  ex.getMessage();
            lContentResponseErro.statusCode = 500;
            resp.responseBody = Blob.valueOf(JSON.serialize(lContentResponseErro, true));
        }
    }
}