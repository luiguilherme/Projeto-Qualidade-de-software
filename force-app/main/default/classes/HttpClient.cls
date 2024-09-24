public class HttpClient {
    public ICredentialsProvider credentials {get; set;}
    public Map<String,String> headerMap {get; set;}

    public HttpResponse get(String serviceName) {
        return callout(serviceName, null, 'GET');
    }

    public HttpResponse get(WebService__c wsConfig) {
        return callout(wsConfig, null, 'GET', null);
    }

    public HttpResponse get(WebService__c wsConfig, String endpoint) {
        return callout(wsConfig, '', 'GET', endpoint, null);
    }

    public HttpResponse get(WebService__c wsConfig, String endpoint, Id customerInteractionId) {
        return callout(wsConfig, '', 'GET', endpoint, customerInteractionId);
    }

    public HttpResponse post(String serviceName, String payload) {
        return callout(serviceName, payload, 'POST');
    }

    public HttpResponse post(WebService__c wsConfig, String payload) {
        return callout(wsConfig, payload, 'POST', null);
    }

    public HttpResponse post(WebService__c wsConfig, String payload, Id customerInteractionId) {
        return callout(wsConfig, payload, 'POST', customerInteractionId);
    }

    public HttpResponse patch(String serviceName, String payload) {
        return callout(serviceName, payload, 'PATCH');
    }

    public HttpResponse patch(WebService__c wsConfig, String payload) {
        return callout(wsConfig, payload, 'PATCH', null);
    }

    public HttpResponse put(String serviceName, String payload) {
        return callout(serviceName, payload, 'PUT');
    }

    public HttpResponse put(WebService__c wsConfig, String payload) {
        return callout(wsConfig, payload, 'PUT', null);
    }

    private HttpResponse callout(String serviceName, String payload, String method) {
        WebService__c wsConfig = Webservice__c.getInstance(serviceName);
        return callout(wsConfig, payload, method, null);
    }
    
    private HttpResponse callout(WebService__c wsConfig, String payload, String method, Id customerInteractionId) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(wsConfig.Endpoint__c); //callout:{NamedCredentialDomain}/{resource}
        request.setMethod(method);

        if(wsConfig.Timeout__c != null){
            request.setTimeout(Integer.valueOf(wsConfig.Timeout__c));
        }


        setRequestHeaders(wsConfig, request);
        
        if(new String[]{'POST', 'PATCH', 'PUT'}.contains( method )){
            request.setBody(payload);
        }

        if(wsConfig.user__c == null || wsConfig.user__c == '' ){
            IHttpRequestConfigurator requestConfigurator = RequestConfiguratorFactory.getConfigurator(wsConfig);
            request = requestConfigurator.configure(request, wsConfig);
        }

        ServiceTransaction serviceTransaction = instantiateServiceTransaction(request, wsConfig, wsConfig.Endpoint__c, method, customerInteractionId);

        HttpResponse response = new HttpResponse();
        response = http.send(request);
        
        serviceTransaction.setResponse(response.getBody());
        serviceTransaction.setStatusCode(String.valueOf(response.getStatusCode()));  

        if (response.getStatusCode()/100 == 2) {
            String result = response.getBody();
			serviceTransaction.complete();

        } else {
            serviceTransaction.setResponse(response.toString());
            serviceTransaction.fail();
        }

        if(wsConfig.CommitTransactionsList__c){
            serviceTransaction.addToList();
        } else {
            serviceTransaction.commitSync();
        }

        return response;
    }

    private HttpResponse callout(WebService__c wsConfig, String payload, String method, String endpoint, Id customerInteractionId) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setEndpoint(endpoint);
        request.setMethod(method);

        if (wsConfig.Timeout__c != null) {
            request.setTimeout(Integer.valueOf(wsConfig.Timeout__c));
        }

        IHttpRequestConfigurator requestConfigurator;

        try {
            requestConfigurator = RequestConfiguratorFactory.getConfigurator(wsConfig);
        
            request = requestConfigurator.configure(request, wsConfig);

        } catch (Exception e) {
            registerHttpClientError(e, wsConfig, endpoint, method, request);

            throw new AuraHandledException(e.getMessage());
        }

        setRequestHeaders(wsConfig, request);

        ServiceTransaction serviceTransaction = instantiateServiceTransaction(request, wsConfig, endpoint, method, customerInteractionId);

        HttpResponse response = new HttpResponse();

        response = http.send(request);
        
        serviceTransaction.setResponse(response.getBody());
        serviceTransaction.setStatusCode(String.valueOf(response.getStatusCode()));  

        if ((response.getStatusCode() / 100) == 2) {
            serviceTransaction.complete();

        } else {
            serviceTransaction.fail();
        }

        if (wsConfig.CommitTransactionsList__c) {
            serviceTransaction.addToList();
       
        } else {
            serviceTransaction.commitSync();
        }

        return (response);
    }

    public static void setRequestHeaders(Webservice__c wsConfig, HttpRequest request) {
        if(wsConfig.Headers__c != null){
            List<String> ltHeader = new List<String>();
        
            if(wsConfig.Headers__c.contains(';')){
                ltHeader = wsConfig.Headers__c.split(';');
            }else if(String.isNotBlank(wsConfig.Headers__c)){
                ltHeader.add(wsConfig.Headers__c);
            }
            
            for(String header : ltHeader){
                if(header.contains(':')){
                    List<String> ltSplitedHeader = header.split(':');
                    request.setHeader(ltSplitedHeader[0], ltSplitedHeader[1]);
                }
            }
        }
    }

    private ServiceTransaction instantiateServiceTransaction(HttpRequest request, WebService__c wsConfig, String endpoint, String method, String customerInteractionId) {
        ServiceTransaction st = ServiceTransaction.getInstance();
        
        st.create(ServiceTransactionOperations.getServiceHistory);

        if(customerInteractionId != null){
            st.serviceTransaction.CustomerInteractionId__c = customerInteractionId;
        }
        
        st.serviceTransaction.Endpoint__c = endpoint;
        st.serviceTransaction.Method__c = method;
        st.serviceTransaction.Name = (wsConfig.Name + ' - ' + st.serviceTransaction.Operation__c + ' - ' + datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss'));
        st.serviceTransaction.Http_Header__c = ('Authorization: ' + request.getHeader('Authorization') + ', Ocp-Apim-Subscription-Key: ' + request.getHeader('Ocp-Apim-Subscription-Key'));
        
        st.setRequest(request.getBody());

        return (st);
    }

    private void registerHttpClientError(Exception error, WebService__c wsConfig, String endpoint, String method, HttpRequest request) {
        ServiceTransaction serviceTransaction = instantiateServiceTransaction(request, wsConfig, endpoint, method, null);

        serviceTransaction.setStatusCode('999');
        serviceTransaction.setResponse(('HttpClient error: ' + error.getMessage() + ', stack trace: ' + error.getStackTraceString()).left(131072));
        serviceTransaction.fail();

        if (wsConfig.CommitTransactionsList__c) {
            serviceTransaction.addToList();

        } else {
            serviceTransaction.commitSync();
        }
    }
}