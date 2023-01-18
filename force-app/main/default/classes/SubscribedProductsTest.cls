@isTest
public class SubscribedProductsTest {
    
    private static final Map<String,String> CONST_MAPHEADER = new Map<String,String>{'Content-Type' => 'application/json'};
    private static final String CONST_RESPONSE_CONTROLE = '[{"tags":["so:ngn","controle-n"],"descriptions":[{"text":"SMARTVIVO CTRL CARTAO PLUS 1GB"}],"id":"CONTROLN:11995012382","status":"active","product_type":"mobile","identifiers":["+5511995012382"],"start_date":"2021-02-19T15:44:01.000Z","subscription_type":"prepaid","display_name":"Controle Cartão"}]';
    private static final String CONST_RESPONSE_CONTROLE_SVA = '[{"id":"AMDOCS:11960610025","status":"active","display_name":"VIVO CONTROLE 7,5GB - MENSAL","product_type":"mobile","descriptions":[{"text":"VIVO CONTROLE 7,5GB - MENSAL"}],"identifiers":["+5511960610025"],"start_date":"2021-02-12T14:06:41.000Z","tags":["so:amdocs","produto-avulso"],"subscription_type":"control"},{"display_name":"WhatsApp","product_type":"value_added_service","start_date":"2021-02-12T14:06:41.000Z","tags":["whatsapp","ilimitado"],"descriptions":[{"text":"WhatsApp"}],"status":"active","identifiers":["+5511960610025"],"id":"ilimitado:whatsapp:11960610025"},{"display_name":"Waze","product_type":"value_added_service","start_date":"2021-02-12T14:06:41.000Z","tags":["waze","ilimitado"],"descriptions":[{"text":"Waze"}],"status":"active","identifiers":["+5511960610025"],"id":"ilimitado:waze:11960610025"},{"display_name":"Cabify","product_type":"value_added_service","start_date":"2021-02-12T14:06:41.000Z","tags":["cabify","ilimitado"],"descriptions":[{"text":"Cabify"}],"status":"active","identifiers":["+5511960610025"],"id":"ilimitado:cabify:11960610025"},{"display_name":"Easy Taxi","product_type":"value_added_service","start_date":"2021-02-12T14:06:41.000Z","tags":["easytaxi","ilimitado"],"descriptions":[{"text":"Easy Taxi"}],"status":"active","identifiers":["+5511960610025"],"id":"ilimitado:easytaxi:11960610025"},{"display_name":"Moovit","product_type":"value_added_service","start_date":"2021-02-12T14:06:41.000Z","tags":["moovit","ilimitado"],"descriptions":[{"text":"Moovit"}],"status":"active","identifiers":["+5511960610025"],"id":"ilimitado:moovit:11960610025"},{"display_name":"Go Read","product_type":"value_added_service","start_date":"2021-02-12T14:06:41.000Z","tags":["goread","incluso"],"descriptions":[{"text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store"}],"status":"active","identifiers":["+5511960610025"],"id":"incluso:goread:11960610025"},{"display_name":"Babbel","product_type":"value_added_service","start_date":"2021-02-12T14:06:41.000Z","tags":["babbel","incluso"],"descriptions":[{"text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store"}],"status":"active","identifiers":["+5511960610025"],"id":"incluso:babbel:11960610025"},{"display_name":"Skeelo","product_type":"value_added_service","start_date":"2021-02-12T14:06:41.000Z","tags":["skeelo","incluso"],"descriptions":[{"text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store"}],"status":"active","identifiers":["+5511960610025"],"id":"incluso:skeelo:11960610025"},{"display_name":"NBA","product_type":"value_added_service","start_date":"2021-02-12T14:06:41.000Z","tags":["nba","incluso"],"descriptions":[{"text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store"}],"status":"active","identifiers":["+5511960610025"],"id":"incluso:nba:11960610025"},{"display_name":"Vivo Meditação Lite","product_type":"value_added_service","start_date":"2021-02-12T14:06:41.000Z","tags":["vivomeditacaolite","incluso"],"descriptions":[{"text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store"}],"status":"active","identifiers":["+5511960610025"],"id":"incluso:vivomeditacaolite:11960610025"}]';
    private static final String CONST_RESPONSE_BUNDLE = '[{"id":"AMDOCS:11999394227","status":"active","display_name":"Titular Pós MIG 8GB","product_type":"mobile","descriptions":[{"text":"Titular Pós MIG 8GB"}],"identifiers":["+5511999394227"],"start_date":"2021-09-30T22:06:41.000Z","tags":["so:amdocs","produto-avulso"],"subscription_type":"postpaid"},{"display_name":"Go Read","product_type":"value_added_service","start_date":"2021-09-30T22:06:41.000Z","tags":["goread","incluso"],"descriptions":[{"text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store"}],"status":"active","identifiers":["+5511999394227"],"id":"incluso:goread:11999394227"},{"display_name":"NBA","product_type":"value_added_service","start_date":"2021-09-30T22:06:41.000Z","tags":["nba","incluso"],"descriptions":[{"text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store"}],"status":"active","identifiers":["+5511999394227"],"id":"incluso:nba:11999394227"},{"display_name":"Skeelo","product_type":"value_added_service","start_date":"2021-09-30T22:06:41.000Z","tags":["skeelo","incluso"],"descriptions":[{"text":"Seu plano inclui aplicativos com conteúdos exclusivos, é só baixar na Vivo App Store"}],"status":"active","identifiers":["+5511999394227"],"id":"incluso:skeelo:11999394227"},{"id":"SB899981028973","display_name":"Plano Trio","descriptions":[{"text":"Fixo Voz + Vivo Internet + TV"}],"product_type":"bundle","identifiers":["+551148685548","SPO-81GZ5JKVZ-013","TV-SPO-81GZ5JGAP-050"],"tags":["so:siebel"],"sub_products":[{"identifiers":["+551148685548"],"id":"VIVO_VOZ_2:1148685548","display_name":"Fixo Voz","status":"active","product_type":"landline","descriptions":[{"text":"Vivo Fixo Ilimitado Brasil"}],"address":"REPUBLICA DO IRAQUE, 931 - SAO PAULO","start_date":"2021-07-29T09:00:00.000Z","tags":["so:siebel"]},{"identifiers":["SPO-81GZ5JKVZ-013"],"id":"INTERNET_VIVO_2:1148685548","display_name":"Vivo Internet","status":"active","product_type":"internet","connection":{"type":"fiber","uplink_mbps":17.5,"downlink_mbps":35},"descriptions":[{"text":"35 Mbps"}],"address":"REPUBLICA DO IRAQUE, 931 - SAO PAULO","start_date":"2021-07-29T09:00:00.000Z","tags":["so:siebel"]},{"identifiers":["TV-SPO-81GZ5JGAP-050"],"id":"TV_VIVO_2:1148685548","display_name":"TV","status":"active","product_type":"iptv","descriptions":[{"text":"Vivo Play Ultra"}],"address":"REPUBLICA DO IRAQUE, 931 - SAO PAULO","start_date":"2021-07-29T09:00:00.000Z","tags":["so:siebel"]}],"status":"active","address":"REPUBLICA DO IRAQUE, 931 - SAO PAULO","start_date":"2021-07-29T09:00:00.000Z"}]';
    private static final String CONST_RESPONSE_1P = '[{"identifiers":["CTA-81GZOZH2D-013"],"id":"INTERNET_VIVO_2:4130891027","display_name":"Vivo Internet","status":"active","product_type":"internet","connection":{"type":"fiber","uplink_mbps":3,"downlink_mbps":35},"descriptions":[{"text":"35 Mbps"}],"address":"PROF. PEDRO VIRIATO PARIGOT DE SOUZA, 3288 - CURITIBA","start_date":"2021-06-15T09:00:00.000Z","tags":["so:siebel"]}]';

    private static final String CONST_STRING_WEBSERVICENAME = 'FourthPlataformSubscribedProducts'; 

    @testSetup 
    static void setup(){
        Account account = DataFactory.createAccount();
        insert account;


        insert new Webservice__c(
            Name = 'FourthPlataformSubscribedProducts',
            Validate__c = 3600,
            //Endpoint__c  = 'https://api-hml.telefonica.com.br/subscribed-products/v3/users/{user_id}/products',
            Endpoint__c = 'https://hmlapi.telefonicabigdata.com',
            SubscriptionKey__c = 'null',
            switchedOn__c = true,
            Certificate__c = 'SingleSignOn'
        );

        WebServiceTestFactory.start().authOAuthProvider().create();
    }

    @isTest
    private static void validadeUserIdTest(){
        Account accountObj = [SELECT Id FROM Account LIMIT 1];
        Boolean validateReturn;
        
        Test.startTest();
            validateReturn = SubscribedProductsController.validateUserIdInformation(accountObj.Id);
        Test.stopTest();

        System.equals(validateReturn, true);
    }

    @isTest
    private static void callSubscribedControle(){
        Account accountObj = [SELECT Id FROM Account LIMIT 1];
        accountObj.UserId__c = 'xpto-0pt';
        update accountObj;

        SubscribedProductsMock getRequest = new SubscribedProductsMock(200, 
        CONST_RESPONSE_CONTROLE,
        CONST_MAPHEADER);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, getRequest);
            SubscribedProductsTO.ReturnTO integrationResponse = SubscribedProductsController.getSubscribedProducts(accountObj.Id);
        Test.stopTest();

        System.assertEquals(integrationResponse.Status, 'success');
    }

    @isTest
    private static void callSubscribedControleSVA(){
        Account accountObj = [SELECT Id FROM Account LIMIT 1];
        accountObj.UserId__c = 'xpto-0pt';
        update accountObj;

        SubscribedProductsMock getRequest = new SubscribedProductsMock(200, 
        CONST_RESPONSE_CONTROLE_SVA,
        CONST_MAPHEADER);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, getRequest);
            SubscribedProductsTO.ReturnTO integrationResponse = SubscribedProductsController.getSubscribedProducts(accountObj.Id);
        Test.stopTest();

        System.assertEquals(integrationResponse.Status, 'success');
    }

    //Testar a chamada de bundles
    @isTest
    private static void callSubscribedBundle(){
        Account accountObj = [SELECT Id FROM Account LIMIT 1];
        accountObj.UserId__c = 'xpto-0pt';
        update accountObj;

        SubscribedProductsMock getRequest = new SubscribedProductsMock(200, 
        CONST_RESPONSE_BUNDLE,
        CONST_MAPHEADER);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, getRequest);
            SubscribedProductsTO.ReturnTO integrationResponse = SubscribedProductsController.getSubscribedProducts(accountObj.Id);
        Test.stopTest();

        System.assertEquals(integrationResponse.Status, 'success');
    }

    //Testar chamada de 1P
    @isTest
    private static void callSubscribed1P(){
        Account accountObj = [SELECT Id FROM Account LIMIT 1];
        accountObj.UserId__c = 'xpto-0pt';
        update accountObj;

        SubscribedProductsMock getRequest = new SubscribedProductsMock(200, 
        CONST_RESPONSE_1P,
        CONST_MAPHEADER);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, getRequest);
            SubscribedProductsTO.ReturnTO integrationResponse = SubscribedProductsController.getSubscribedProducts(accountObj.Id);
        Test.stopTest();

        System.assertEquals(integrationResponse.Status, 'success');
    }

    //Testar a exclusao de conta de faturamento (substituindo uma criada anteriormente)
}