public with sharing class PIDTokenValidateEngine {
    private static final String WEB_SERVICE_RTD = 'ServiceAuthorizationPID';
    private static final Integer SUCCESS_CODE = 200;    
    private static final String WAITING_APPROVAL = 'Aguardando validação';    
    private static final String SEND_ERROR = 'Falha no envio';  

    public static Boolean postTokenValidate(Id customerIntId, String phoneNumber) {

        Webservice__c wsConfig = Webservice__c.getInstance(WEB_SERVICE_RTD);
        if (wsConfig == null || !wsConfig.switchedOn__c) {
            return false;
        }

        String payload = buildPayload(customerIntId, phoneNumber);
        HttpClient client = new HttpClient();
        HttpResponse response;

        response = client.post(wsConfig, payload);
        
        ServiceAuthorizationResponse responseParsed = ServiceAuthorizationResponse.parse(response.getBody());
        Boolean successStatus = responseParsed.status == '0';

        if (response.getStatusCode() == SUCCESS_CODE && successStatus) {
            return true;
        } else {
            return false;
        }
    }

    private static String buildPayload(Id customerIntId, String phoneNumber) {
        final String STR_POSPAGO = 'Pós-Pago';
        final String STR_CONTROLE = 'Controle';
        final String STR_PREPAGO = 'Pré'; 
        ServiceAuthorization__mdt pid = ServiceAuthorization__mdt.getInstance('PID');

        CustomerIntWrapper thisCustomerIntWrapper = new CustomerIntWrapper();
        thisCustomerIntWrapper.correlation_id = customerIntId;
        thisCustomerIntWrapper.message_code = pid.Message_Code__c;
        thisCustomerIntWrapper.msisdn = phoneNumber;

        String jsonBody = JSON.serialize(thisCustomerIntWrapper);
        return jsonBody;
    }

    public static void updateTokenStatus(String customerIntId, String tokenStatus) {
        vlocity_cmt__CustomerInteraction__c thisCustomerInt = new vlocity_cmt__CustomerInteraction__c();
        thisCustomerInt.Id = customerIntId;
        thisCustomerInt.TokenStatus__c = tokenStatus;
        updatePalitagem(thisCustomerInt);
        
        update thisCustomerInt;
    }


    public static void updatePalitagem(vlocity_cmt__CustomerInteraction__c thisCustomerInt) {
        String palitagemString = '';

        switch on thisCustomerInt.TokenStatus__c {
            when 'Falha no envio' {
                palitagemString = 'Validação de segurança não realizada - Erro no envio do Token.';
            }
            when 'Cancelado' {
                palitagemString = '';
            }
            when 'Não validado'{
                ServiceAuthorization__mdt pid = ServiceAuthorization__mdt.getInstance('PID');

                if (thisCustomerInt.TokenSendAttempts__c == pid.Attempts__c) {
                    palitagemString = 'Validação de Token Segurança não realizada - Máximo de tentativas excedido.';
                }
                palitagemString = 'Validação de Token Segurança não realizada.';
            }
            when 'Falha na comunicação API'{
                palitagemString = 'Validação de Token de Segurança não realizada - Falha da API - Token.';
            }
        }

        thisCustomerInt.vlocity_cmt__Comments__c =  palitagemString + thisCustomerInt.vlocity_cmt__Comments__c;
    }

    public static Boolean hasAccess() {
        try {
            User currentUser = UserDAO.getById(UserInfo.getUserId());
            List<FromToMapping__mdt> lstFromToMap =  new List<FromToMapping__mdt>();

            if (currentUser.Profile.UserLicense.Name != 'Partner Community') {
                lstFromToMap = FromToMappingDAO.getLstByUserRole(currentUser.UserRole.DeveloperName);
            } else {
                lstFromToMap = FromToMappingDAO.getLstByUserRole(currentUser.PartnerGroup__c);
            }
            
            for (FromToMapping__mdt iFromToMap : lstFromToMap) {
                if (iFromToMap.TokenPID__c) {
                    return true;
                }
            }
            return false;

        } catch (Exception e) {
            return false;
        }
    }

    public static String getPhoneNumber(String accId) {
        List<Asset> lstAsset = AssetDAO.getPidAssetMobileByAccount(accId);

        String posPago = 'Pós-Pago';
        String controle = 'Controle';
        String prepago = 'Pré-Pago'; 

        Map<String,String> mapPhoneProduct = new Map<String,String>();
        String phoneReturn;
        if(!lstAsset.isEmpty()) {
            for(Asset iAsset : lstAsset) {
                if(!mapPhoneProduct.containsKey(posPago) && iAsset.ProductType__c==posPago) {
                    mapPhoneProduct.put(posPago, iAsset.Name);
                } else if(!mapPhoneProduct.containsKey(controle) && iAsset.ProductType__c==controle) {
                    mapPhoneProduct.put(controle, iAsset.Name);
                } else if(!mapPhoneProduct.containsKey(prepago) && iAsset.ProductType__c==prepago) {
                    mapPhoneProduct.put(prepago, iAsset.Name);
                }
            }

            if(mapPhoneProduct.containsKey(posPago)) {
                phoneReturn = mapPhoneProduct.get(posPago);
            } else if(mapPhoneProduct.containsKey(controle)) {
                phoneReturn = mapPhoneProduct.get(controle);
            } else if(mapPhoneProduct.containsKey(prepago)) {
                phoneReturn = mapPhoneProduct.get(prepago);
            }
        } else {
            phoneReturn = 'Não possui linha válida';
        }
        return phoneReturn;
    }
    
    public class CustomerIntWrapper {
        public String correlation_id {get;set;}
        public String msisdn {get;set;}
        public String message_code {get;set;}
    }
}