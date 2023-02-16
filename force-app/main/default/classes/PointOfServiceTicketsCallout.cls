public with sharing class PointOfServiceTicketsCallout {
    private static final Boolean API_INTEGRATION = true;

    private static final String WEBSERVICE_NAME = 'PointOfServiceTicketsCallout';
    private static final Integer CODE_HTTP_SUCCESS = 200;
    
    private static final String ERROR_DOMAIN_GSS = 'GSS';
    private static final String ERROR_POINTOFSERVICE = 'PointOfService';
    private static final String[] ERROR_CODES_GSS = new String[] {'1','15','52','53','54','98','99'};
    private static final String ERROR_POINTOFSERVICE_TICKET = '404';

    private static final Integer ERROR_WEBSERVICE_NOTFOUND = 600;
    private static final Integer ERROR_INVALID_WEBSERVICE_CONFIGURATION = 604;
    private static final Integer ERROR_TICKETS_LIST_EMPTY = 625;

    public static Map<String,Object> execute() {
        Map<String, Object> mapResult = new Map<String, Object>();
        
        WebService__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);

        if (wsConfig == null || !wsConfig.switchedOn__c) {
            if (wsConfig == null) {
                mapResult.put('error', ERROR_WEBSERVICE_NOTFOUND);

            } else {
                mapResult.put('error', ERROR_INVALID_WEBSERVICE_CONFIGURATION);
            }
            
        } else {
            User attendant = UserDAO.getById(UserInfo.getUserId());

            wsConfig.Endpoint__c = wsConfig.Endpoint__c
                .replace('{pointOfServiceId}', attendant.StoreCode__c);

            wsConfig.Headers__c = ('sub:' + attendant.Login__c);

            if (API_INTEGRATION) {
                HttpClient client = new HttpClient();
                HttpResponse response = client.get(wsConfig);

                if (response.getStatusCode() == CODE_HTTP_SUCCESS) {
                    mapResult.put('success', response.getBody());

                } else {
                    String jsonError = response.getBody();
                    String errorMessage = '';

                    try {
                        if (!String.isBlank(jsonError)) {
                            StoreServiceManagerResponse.IntegrationError integrationError = (StoreServiceManagerResponse.IntegrationError)
                                JSON.deserialize(jsonError, StoreServiceManagerResponse.IntegrationError.class);
        
                            if (integrationError != null && integrationError.errors != null && integrationError.errors.size() > 0) {
                                if (integrationError.errors[0].domain != null) {
                                    if (integrationError.errors[0].domain.equals(ERROR_DOMAIN_GSS)) {  
                                        if (ERROR_CODES_GSS.contains(integrationError.errors[0].reason)) {
                                            errorMessage = integrationError.errors[0].reason;
                                            
                                        } else {
                                            errorMessage = integrationError.errors[0].message.toLowerCase().capitalize();
                                        }
                                        
                                    } else if (integrationError.errors[0].domain.equals(ERROR_POINTOFSERVICE)) {
                                        if (integrationError.errors[0].reason.equals(ERROR_POINTOFSERVICE_TICKET)) {
                                            errorMessage = String.valueOf(ERROR_TICKETS_LIST_EMPTY);
                                        }
                                    }
                                }
                            }
                        }

                    } catch (Exception e) {
                        errorMessage = '';
                    }

                    if (!String.isBlank(errorMessage)) {
                        if (errorMessage.equals(String.valueOf(ERROR_TICKETS_LIST_EMPTY))) {
                        	mapResult.put('error', ERROR_TICKETS_LIST_EMPTY);

                        } else if (ERROR_CODES_GSS.contains(errorMessage)) {
                            mapResult.put('error', Integer.valueOf(errorMessage));

                        } else {
                        	mapResult.put('error', errorMessage);
                        }
                        
                    } else {
                        mapResult.put('error', response.getStatusCode());
                    }
                }

            } else {
                String response = (
                    '[{"id":"A229","customer":{"name":"Maria da Silva","segment":{"id":"01","name":"Cliente V"},' +
                    '"individualIdentification":{"nationalIdentilyCardNr":"12345678901","documentType":"CPF"}},' +
                    '"duration":{"amount":"2022-06-02 00:05:50"},"geographicArea":{"code":"11"},' +
                    '"network":{"networkNumber":"988887654"},"interaction":{"name":"Ajuste de Plano"}},' +
                    '{"id":"A230","customer":{"name":"Márcio Las","segment":{"id":"01","name":"Purpura"},' +
                    '"individualIdentification":{"nationalIdentilyCardNr":"22233344405","documentType":"CPF"}},' +
                    '"duration":{"amount":"2022-06-02 00:03:16"},"geographicArea":{"code":"11"},' +
                    '"network":{"networkNumber":"999773256"},"interaction":{"name":"Consultoria Tecnológica"}}]'
                );

                mapResult.put('success', response);
            }
        }
 
        return (mapResult);
    }

    public static Map<String,Object> execute(String scheduleTime, String cellPhone) {
        Map<String, Object> mapResult = new Map<String, Object>();
        
        WebService__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);

        if (wsConfig == null || !wsConfig.switchedOn__c) {
            if (wsConfig == null) {
                mapResult.put('error', ERROR_WEBSERVICE_NOTFOUND);

            } else {
                mapResult.put('error', ERROR_INVALID_WEBSERVICE_CONFIGURATION);
            }
            
        } else {
            User attendant = UserDAO.getById(UserInfo.getUserId());

            StoreServiceManagerResponse.Ticket request = 
                StoreServiceManagerRequest.getGenerateTicketRequest(attendant.Login__c, scheduleTime, cellPhone);

            wsConfig.Endpoint__c = wsConfig.Endpoint__c
                .replace('{pointOfServiceId}', attendant.StoreCode__c);

            wsConfig.Headers__c = ('sub:' + attendant.Login__c);

            if (API_INTEGRATION) {
                HttpClient client = new HttpClient();
                HttpResponse response = client.post(wsConfig, JSON.serialize(request, true));

                if (response.getStatusCode() == CODE_HTTP_SUCCESS) {
                    mapResult.put('success', response.getBody());

                } else {
                    String jsonError = response.getBody();
                    String errorMessage = '';

                    try {
                        if (!String.isBlank(jsonError)) {
                            StoreServiceManagerResponse.IntegrationError integrationError = (StoreServiceManagerResponse.IntegrationError)
                                JSON.deserialize(jsonError, StoreServiceManagerResponse.IntegrationError.class);
        
                            if (integrationError != null && integrationError.errors != null && integrationError.errors.size() > 0) {
                                if (integrationError.errors[0].domain != null) {
                                    if (integrationError.errors[0].domain.equals(ERROR_DOMAIN_GSS)) {  
                                        if (ERROR_CODES_GSS.contains(integrationError.errors[0].reason)) {
                                            errorMessage = integrationError.errors[0].reason;
                                            
                                        } else {
                                            errorMessage = integrationError.errors[0].message.toLowerCase().capitalize();
                                        }
                                    }
                                }
                            }
                        }

                    } catch (Exception e) {
                        errorMessage = '';
                    }

                    if (!String.isBlank(errorMessage)) {
                        if (ERROR_CODES_GSS.contains(errorMessage)) {
                            mapResult.put('error', Integer.valueOf(errorMessage));

                        } else {
                            mapResult.put('error', errorMessage);
                        }                   
  
                    } else {
                        mapResult.put('error', response.getStatusCode());
                    }
                }

            } else {
                String response = '{\"id\": \"C0004\"}';

                mapResult.put('success', response);
            }
        }
 
        return (mapResult);
    }
}
