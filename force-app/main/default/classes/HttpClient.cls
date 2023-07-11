public class HttpClient {
    public ICredentialsProvider credentials {get; set;}
    public Map<String,String> headerMap {get; set;}

    public HttpResponse get(String serviceName) {
        return callout(serviceName, null, 'GET');
    }

    public HttpResponse get(WebService__c wsConfig) {
        return callout(wsConfig, null, 'GET');
    }

    public HttpResponse get(WebService__c wsConfig, String endpoint) {
        return callout(wsConfig, '', 'GET', endpoint);
    }

    public HttpResponse post(String serviceName, String payload) {
        return callout(serviceName, payload, 'POST');
    }

    public HttpResponse post(WebService__c wsConfig, String payload) {
        return callout(wsConfig, payload, 'POST');
    }

    public HttpResponse patch(String serviceName, String payload) {
        return callout(serviceName, payload, 'PATCH');
    }

    public HttpResponse patch(WebService__c wsConfig, String payload) {
        return callout(wsConfig, payload, 'PATCH');
    }

    public HttpResponse put(String serviceName, String payload) {
        return callout(serviceName, payload, 'PUT');
    }

    public HttpResponse put(WebService__c wsConfig, String payload) {
        return callout(wsConfig, payload, 'PUT');
    }

    private HttpResponse callout(String serviceName, String payload, String method) {
        WebService__c wsConfig = Webservice__c.getInstance(serviceName);

        return callout(wsConfig, payload, method);
    }
    
    private HttpResponse callout(WebService__c wsConfig, String payload, String method) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setEndpoint(wsConfig.Endpoint__c);
        request.setMethod(method);

        if (wsConfig.Timeout__c != null) {
            request.setTimeout(Integer.valueOf(wsConfig.Timeout__c));
        }

        if (wsConfig.Headers__c != null) {
            List<String> ltHeader = new List<String>();
        
            if (wsConfig.Headers__c.contains(';')) {
                ltHeader = wsConfig.Headers__c.split(';');

            } else if (String.isNotBlank(wsConfig.Headers__c)) {
                ltHeader.add(wsConfig.Headers__c);
            }
            
            for (String header : ltHeader) {
                if (header.contains(':')) {
                    List<String> ltSplitedHeader = header.split(':');
                    
                    request.setHeader(ltSplitedHeader[0], ltSplitedHeader[1]);
                }
            }
        }
        
        if (new String[]{'POST', 'PATCH', 'PUT'}.contains(method)) {
            request.setBody(payload);
        }

        IHttpRequestConfigurator requestConfigurator;

        try {
            requestConfigurator = RequestConfiguratorFactory.getConfigurator(wsConfig);

            request = requestConfigurator.configure(request, wsConfig);

        } catch (Exception e) {
            registerHttpClientError(e, wsConfig, wsConfig.Endpoint__c, method, request);

            throw new AuraHandledException(e.getMessage());
        }

        ServiceTransaction serviceTransaction = instantiateServiceTransaction(request, wsConfig, wsConfig.Endpoint__c, method);

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

    private HttpResponse callout(WebService__c wsConfig, String payload, String method, String endpoint) {
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

        ServiceTransaction serviceTransaction = instantiateServiceTransaction(request, wsConfig, endpoint, method);

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

    private ServiceTransaction instantiateServiceTransaction(HttpRequest request, WebService__c wsConfig, String endpoint, String method) {
        ServiceTransaction st = ServiceTransaction.getInstance();
        
        st.create(ServiceTransactionOperations.getServiceHistory);

        st.serviceTransaction.Endpoint__c = endpoint;
        st.serviceTransaction.Method__c = method;
        st.serviceTransaction.Name = (wsConfig.Name + ' - ' + st.serviceTransaction.Operation__c + ' - ' + datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss'));
        st.serviceTransaction.Http_Header__c = ('Authorization: ' + request.getHeader('Authorization') + ', Ocp-Apim-Subscription-Key: ' + request.getHeader('Ocp-Apim-Subscription-Key'));
        
        st.setRequest(request.getBody());

        return (st);
    }

    private void registerHttpClientError(Exception error, WebService__c wsConfig, String endpoint, String method, HttpRequest request) {
        ServiceTransaction serviceTransaction = instantiateServiceTransaction(request, wsConfig, endpoint, method);

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
