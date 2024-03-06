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

            return !PermissionSetAssigmentDAO.getCurrentPSA(Userinfo.getUserId(), 'TokenSMS').isEmpty();

        } catch (Exception e) {
            return false;
        }
    }

    public static Map<String, Object> getPhoneNumbers(String accId){
        Map<String, Object> phoneNumbers = new Map<String, Object>();

        List<String> ltPhoneNumbers;
        String phoneNumber = 'Não possui linha válida';

        List<Asset> lstAsset = AssetDAO.getPidAssetMobileByAccount(accId);

        if (!lstAsset.isEmpty()){
            final String posPago = 'Pós-Pago';
            final String controle = 'Controle';
            final String prePago = 'Pré-Pago';

            Map<String, List<String>> mapPhoneProductsMoreThan120 = new Map<String, List<String>>();

            mapPhoneProductsMoreThan120.put(posPago, new List<String>());
            mapPhoneProductsMoreThan120.put(controle, new List<String>());
            mapPhoneProductsMoreThan120.put(prePago, new List<String>());

            Map<String, List<String>> mapPhoneProductsLessThan120 = new Map<String, List<String>>();

            mapPhoneProductsLessThan120.put(posPago, new List<String>());
            mapPhoneProductsLessThan120.put(controle, new List<String>());
            mapPhoneProductsLessThan120.put(prePago, new List<String>());

            for (Asset asset : lstAsset){
                String phoneType = asset.ProductType__c;
                if (asset.StartDate__c != null && phoneType == posPago || phoneType == controle || phoneType == prePago){
                    if (asset.StartDate__c < System.now().addDays(-120)){
                        mapPhoneProductsMoreThan120.get(phoneType).add(asset.Name);
                    }
                    if (asset.StartDate__c >= System.now().addDays(-120)){
                        mapPhoneProductsLessThan120.get(phoneType).add(asset.Name);
                    }
                }
            }

            ltPhoneNumbers = new List<String>();

            if (!mapPhoneProductsMoreThan120.isEmpty()) {

                if (!mapPhoneProductsMoreThan120.get(posPago).isEmpty()){
                    ltPhoneNumbers.addAll(mapPhoneProductsMoreThan120.get(posPago));
                }
    
                if (!mapPhoneProductsMoreThan120.get(controle).isEmpty()){
                    ltPhoneNumbers.addAll(mapPhoneProductsMoreThan120.get(controle));
                }
    
                if (!mapPhoneProductsMoreThan120.get(prePago).isEmpty() && ltPhoneNumbers.isEmpty() && mapPhoneProductsLessThan120.get(posPago).isEmpty() && mapPhoneProductsLessThan120.get(controle).isEmpty()){
                    ltPhoneNumbers.addAll(mapPhoneProductsMoreThan120.get(prePago));
                }
                
            }
             
            if (!mapPhoneProductsLessThan120.isEmpty() && ltPhoneNumbers.isEmpty()) {

                if (!mapPhoneProductsLessThan120.get(posPago).isEmpty()){
                    ltPhoneNumbers.add(mapPhoneProductsLessThan120.get(posPago)[0]);
                }

                if (!mapPhoneProductsLessThan120.get(controle).isEmpty() && ltPhoneNumbers.isEmpty()){
                    ltPhoneNumbers.add(mapPhoneProductsLessThan120.get(controle)[0]);
                }

                if (!mapPhoneProductsLessThan120.get(prePago).isEmpty() && ltPhoneNumbers.isEmpty()){
                    ltPhoneNumbers.add(mapPhoneProductsLessThan120.get(prePago)[0]);
                }
            }             
            
            if (!ltPhoneNumbers.isEmpty()) {
                phoneNumbers.put('phones', ltPhoneNumbers);
                phoneNumbers.put('phone', ltPhoneNumbers[0]);
                return phoneNumbers;
            } 
        }
        
		phoneNumbers.put('phones', ltPhoneNumbers);
        phoneNumbers.put('phone', phoneNumber);
        return phoneNumbers;
    }

    public class CustomerIntWrapper {
        public String correlation_id {get;set;}
        public String msisdn {get;set;}
        public String message_code {get;set;}
    }
}