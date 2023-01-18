public with sharing class OperationalInformationsCallout {
    private static final Boolean API_INTEGRATION = true;

    private static final String WEBSERVICE_NAME = 'OperationalInformationsCallout';
    private static final Integer CODE_HTTP_SUCCESS = 200;

    private static final String ERROR_DOMAIN_GSS = 'GSS';
    private static final String[] ERROR_CODES_GSS = new String[] {'1','15','52','53','54','98','99'};    
    private static final Integer ERROR_WEBSERVICE_NOTFOUND = 600;    
    private static final Integer ERROR_INVALID_WEBSERVICE_CONFIGURATION = 604;

    public static Map<String,Object> execute() {
        Map<String, Object> mapResult = new Map<String, Object>();

        WebService__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);

        Map<String, Object> mapCheck = checkCallout(wsConfig);

        if (mapCheck.get('success') != null) {
            User attendant = UserDAO.getById(UserInfo.getUserId());

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
                String response = (
                    '{\"attendantPauseOptions\": [{\"id\": \"2\", \"name\": \"Banheiro\"},{\"id\": \"19\", \"name\": \"Almoco\"},{\"id\": \"99\", \"name\": \"Encerrar\", \"description\": \"1\"}],' +
                    '\"businessLines\": [{\"id\": \"1\", \"description\": \"Móvel\", \"name\": \"MOVEL\"}, {\"id\": \"2\", \"description\": \"Fixa\", \"name\": \"FIXA\"}],' +
                    '\"quittingReasons\": [{\"id\": \"QR1\", \"description\": \"Retornará em outro horário / dia\"}, {\"id\": \"QR2\", \"description\": \"Cliente desistiu da compra\"}],'+
                    '\"interactions\": [{\"id\": \"705\", \"name\": \"Alteração Cadastral - TV\", \"businessLine\": {\"name\": \"TV\"}},'+
                    '{\"id\": \"728\", \"name\": \"Cancelamento - Fixa\", \"businessLine\": {\"name\": \"FIXA\"}}]}'
                    );

                mapResult.put('success', response);
            }

            if (mapResult.get('success') != null) {
                Decimal expirationHours = (
                    (wsConfig.Validate__c == null || wsConfig.Validate__c == 0) 
                    ? 24 
                    : wsConfig.Validate__c
                );

                wsConfig.Headers__c = '';
                wsConfig.ExpireIn__c = Date.today().addDays(Integer.valueOf(expirationHours / 24));

                update wsConfig;
            }

        } else {
            for (String key : mapCheck.keySet()) {
                mapResult.put(key, mapCheck.get(key));
            }
        }

        return (mapResult);
    }

    private static Map<String, Object> checkCallout(WebService__c wsConfig) {
        Map<String, Object> mapCheck = new Map<String, Object>();

        if (wsConfig == null || !wsConfig.switchedOn__c) {
            if (wsConfig == null) {
                mapCheck.put('error', ERROR_WEBSERVICE_NOTFOUND);

            } else {
                mapCheck.put('error', ERROR_INVALID_WEBSERVICE_CONFIGURATION);
            }

        } else {
            if (wsConfig.ExpireIn__c == null || wsConfig.ExpireIn__c < Date.today()) {
                mapCheck.put('success', CODE_HTTP_SUCCESS);

            } else {
                mapCheck.put('uptodate', CODE_HTTP_SUCCESS);
            }
        }

        return (mapCheck);
    }
}