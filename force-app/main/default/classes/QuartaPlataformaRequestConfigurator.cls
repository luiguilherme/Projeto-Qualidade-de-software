/*
* @author Diego Costa @ Deloitte
* @date 06/06/2022
* @description classe QuartaPlataformaRequestConfigurator 
*/
public class QuartaPlataformaRequestConfigurator implements IHttpRequestConfigurator {
	
    //ALTERAR DE ACORDO PARA ATENDER B2C
    public HttpRequest configure(HttpRequest request, Webservice__c wsConfig){
     	request.setHeader('Content-Type',   		'application/json');
        request.setHeader('application',            String.isNotBlank(wsConfig.Application__c) ? wsConfig.Application__c : 'Salesforce');
        request.setHeader('idMessage',              generateUUID());
        request.setHeader('transactionTimestamp',   datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\''));
        request.setHeader('Ocp-Apim-Subscription-Key', wsConfig.SubscriptionKey__c);
        System.debug('Request = ' + request);
		if(!Test.isRunningTest()) request.setClientCertificateName(wsConfig.Certificate__c);

        return request;
	}

	private String generateUUID(){
        Blob b = Crypto.GenerateAESKey(128);
		String tmp = EncodingUtil.ConvertTohex(b);
		String uuid =   tmp.SubString(0, 8)     + '-' +
                        tmp.SubString(8, 12)    + '-' +
                        tmp.SubString(12, 16)   + '-' +
                        tmp.SubString(16, 20)   + '-' +
                        tmp.SubString(20);

        return uuid;
    }
    
}