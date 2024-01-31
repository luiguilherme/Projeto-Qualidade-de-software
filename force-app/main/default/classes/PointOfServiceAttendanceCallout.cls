public with sharing class PointOfServiceAttendanceCallout {
    private static final Boolean API_INTEGRATION = true;

    private static final String WEBSERVICE_NAME = 'PointOfServiceAttendanceCallout';
    private static final Integer CODE_HTTP_SUCCESS = 200;
    
    private static final String ERROR_DOMAIN_GSS = 'GSS';
    private static final String[] ERROR_CODES_GSS = new String[] {'1','15','52','53','54','98','99'};
    private static final Integer ERROR_WEBSERVICE_NOTFOUND = 600;
    private static final Integer ERROR_INVALID_WEBSERVICE_CONFIGURATION = 604;

    public static Map<String, Object> execute(StoreServiceManagerTO.ServiceTicket serviceTicket) {
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

            StoreServiceManagerResponse.Attendance request = 
                StoreServiceManagerRequest.getStartAttendanceRequest(serviceTicket);

            wsConfig.Endpoint__c = wsConfig.Endpoint__c
                .replace('{pointOfServiceId}', attendant.StoreCode__c)
                .replace('{attendantId}', attendant.Login__c);

            wsConfig.Headers__c = ('sub:' + attendant.Login__c);

            if (API_INTEGRATION) {
                HttpClient client = new HttpClient();
                HttpResponse response = client.post(wsConfig, JSON.serialize(request, true));

                if (response.getStatusCode() == CODE_HTTP_SUCCESS) {
                    mapResult.put('success', response.getBody());
                    mapResult.put('startTime', (DateTime.now()).format('dd/MM/YYYY HH:mm:ss'));

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
                String response = '{"ticket": {"id": "T98"}, "status": "OPEN"}';

                mapResult.put('success', response);
                mapResult.put('startTime', (DateTime.now()).format('dd/MM/YYYY HH:mm:ss'));
            }
        }

        return (mapResult);
    }
    
    public static Map<String, Object> execute(StoreServiceManagerTO.ServiceTicket serviceTicket, String status) {
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

            StoreServiceManagerResponse.Attendance request = 
                StoreServiceManagerRequest.getEndAttendanceRequest(attendant.Login__c, serviceTicket, status);

            wsConfig.Endpoint__c = wsConfig.Endpoint__c
                .replace('{pointOfServiceId}', attendant.StoreCode__c)
                .replace('{attendantId}', attendant.Login__c);

            wsConfig.Headers__c = ('sub:' + attendant.Login__c);

            if (API_INTEGRATION) {
                HttpClient client = new HttpClient();
                HttpResponse response = client.patch(wsConfig, JSON.serialize(request, true));

                if (response.getStatusCode() == CODE_HTTP_SUCCESS) {
                    mapResult.put('success', response.getStatusCode());

                    if (status.equals('Recall')) {
                        mapResult.put('startTime', (DateTime.now()).format('dd/MM/YYYY HH:mm:ss'));
                    }
                    
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
                mapResult.put('success', CODE_HTTP_SUCCESS);

                if (status.equals('Recall')) {
                    mapResult.put('startTime', (DateTime.now()).format('dd/MM/YYYY HH:mm:ss'));
                }
            }
        }

        return (mapResult);        
    }
}
