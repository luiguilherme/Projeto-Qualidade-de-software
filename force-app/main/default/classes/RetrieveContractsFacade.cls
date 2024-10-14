public with sharing class RetrieveContractsFacade {
    public static final String CONST_STRING_WEBSERVICENAME = 'RetrieveContractsCallout';

    public static RetrieveContractsResponse findByFilters(String orderId, String sourceSystem, String contractType) {

        Webservice__c webServiceFiltered = Webservice__c.getInstance(CONST_STRING_WEBSERVICENAME);
        orderId = orderId.replaceAll('[^0-9]', '');

        if (webServiceFiltered == null) {
            NullPointerException customException = new NullPointerException();
            customException.setMessage('Não foi encontrado registro de WebService__c: ' + CONST_STRING_WEBSERVICENAME);
            throw customException;
        }

        webServiceFiltered.Endpoint__c += '?order=' + orderId;
        webServiceFiltered.Endpoint__c += '&sourceSystem=' + sourceSystem;
        webServiceFiltered.Endpoint__c += '&contractType=' + EncodingUtil.urlEncode(contractType, 'UTF-8.');

        HttpClient httpCli = new HttpClient();
        HttpResponse httpResponse = httpCli.get(webServiceFiltered);
        
        if ((httpResponse.getStatusCode() / 100) != 2) {
            if (httpResponse.getBody().contains('Nenhum resultado encontrado.')) {
                return null;
            }

            String errorMessage = 'Endpoint: ' + webServiceFiltered.Endpoint__c;
            errorMessage += '\nStatus Code: ' + httpResponse.getStatusCode();
            errorMessage += '\nMensagem: ' + httpResponse.getBody();

            throw new CalloutException(errorMessage);
        }

        return RetrieveContractsResponse.parse(httpResponse.getBody());
    }
}