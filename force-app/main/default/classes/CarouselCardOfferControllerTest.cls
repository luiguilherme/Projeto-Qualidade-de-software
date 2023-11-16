@isTest
public class CarouselCardOfferControllerTest {
    private static final Map<String,String> CONST_MAPHEADER = new Map<String,String>{'Content-Type' => 'application/json'};
    private static final String CONST_BODYSUCCESS = '[{"card_type": "next-best-offer","title": "31255032804","container_id": "inlife","card_layout": "list","cards": [{"id": "L3TZN7HC_1_UP_FTTH","title": "UP FTTH","image": {"url": "https://blablabla.com","alt": "DEFAULT SCRIPT"},"description": "UPGRADE DE VELOCIDADE FTTH","accepts_feedback": false,"identifiers": [{"type": "offer_context_key","id": " "}],"source": "1","rank": "2","voucher_code": "279.98","sub_offers": [{"name": "UP FTTH","description": "L3TZN7HC_1_UP_FTTH_BL + TV|BL + TV|AQUIS_DUO_FTTH_300_IPTV_ULTIM_MAI21_C_HA","categories": "P "}, {"name": "UP FTTH","description": "L3TZN7HC_1_UP_FTTH_TV|TV|AQUIS_DUO_FTTH_300_IPTV_ULTIM_MAI21_C_HA|149.99","categories": "D "}, {"name": "UP FTTH","description": "L3TZN7HC_1_UP_FTTH_BL|BL|AQUIS_DUO_FTTH_300_IPTV_ULTIM_MAI21_C_HA|129.99","categories": "D "}]}, {"id": "NUQTGBT6_2_MIGRA_FTTH","title": "MIGRA FTTH","image": {"url": "https://blablabla.com","alt": "DEFAULT SCRIPT"},"description": "MIGRACAO DE TECNOLOGIA FTTH","accepts_feedback": false,"identifiers": [{"type": "offer_context_key","id": " "}],"source": "2","rank": "1"}]}]';
    private static final String CONST_BODYWITHOUTCARD = '[{"card_type": "next-best-offer","title": "31255032804","container_id": "inlife","card_layout": "list","cards": []	}]';
    private static final String CONST_POSTRESPONSE = '{"code": "PERMISSION_DENIED","message": "Authenticated user has no permission to access the requested resource"}';
    private static final String CONST_CARD = '{ "accepts_feedback": false, "description": "UPGRADE DE VELOCIDADE FTTH","id": "L3TZN7HC_1_UP_FTTH","identifiers": [{"id": " ","type": "offer_context_key"}],"image": {"alt": "DEFAULT SCRIPT","url": "https://blablabla.com"},"rank": "1","source": "1","sub_offers": [{"categories": "P ","description": "L3TZN7HC_1_UP_FTTH_BL + TV|BL + TV|AQUIS_DUO_FTTH_300_IPTV_ULTIM_MAI21_C_HA","name": "UP FTTH"}, {"categories": "D ","description": "L3TZN7HC_1_UP_FTTH_TV|TV|AQUIS_DUO_FTTH_300_IPTV_ULTIM_MAI21_C_HA|149.99","name": "UP FTTH"}, {"categories": "D ","description": "L3TZN7HC_1_UP_FTTH_BL|BL|AQUIS_DUO_FTTH_300_IPTV_ULTIM_MAI21_C_HA|129.99","name": "UP FTTH"}],"title": "RPA","voucher_code": "279.98"}';
    private static String webServiceName = 'RtdNbaNboServiceCallout';

    @TestSetup
    static void setup(){         
        Account accObj = DataFactory.createAccount();
        accObj.UserId__c = 'testUserId';
        insert accObj;
        
        insert new Webservice__c(
            Name = 'RtdNbaNboServiceCallout',
            Endpoint__c = 'https://hmlapi.telefonicabigdata.com',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2',
            switchedOn__c=true
        );
            
        insert new NextBestOfferAndAction__c(Name = 'UP FTTH', Reason__c = 'Aceitou outra oferta, Preço - achou caro, Não quis ouvir a oferta	', Type__c = 'UP FTTH');
        insert new NextBestOfferAndAction__c(Name = 'MIGRA FTTH',Reason__c = 'Quer pensar melhor sobre a oferta, Está satisfeito com a velocidade atual, Prefere comprar em outro canal	', Type__c = 'MIGRA FTTH');
        insert new vlocity_cmt__CustomerInteraction__c(vlocity_cmt__AccountId__c = accObj.Id);
    }
    
    private void createUserRunAs()
    {
        // Timestamp UTC-3 para garantir a exclusividade de dados únicos.
        Long timestamp = DateTime.now().addHours(-3).getTime();
        String timestampString = String.valueOf(timestamp);
        Id profileId = [SELECT Id FROM Profile WHERE Name = 'Representante'].Id;
        Id roleId = [SELECT Id FROM UserRole WHERE Name = 'Vivo Prime'].Id;
        
        User user = new User();
        
        user.ProfileId = profileId;
        user.UserRoleId = roleId;
        user.FirstName = 'FirstNameTest';
        user.LastName = 'LastNameTest';
        user.Username = 'userTest0A999' + timestamp + '@sample.com';
        user.CommunityNickname = 'userTest0A999' + timestamp + '@sample.com';
        user.Email='userTest0A999' + timestamp + '@sample.com';
        user.Alias = 'ut' + timestampString.substring(timestampString.length() - 6);
        user.TimeZoneSidKey = 'America/Sao_Paulo';
        user.LocaleSidKey = 'en_US';
        user.LanguageLocaleKey = 'en_US';
        user.EmailEncodingKey = 'ISO-8859-1';
        
        insert user;
    }

    @isTest 
    static void getCardOffersTest (){
        CarouselCardOfferControllerTest userTest = new CarouselCardOfferControllerTest(); 
        userTest.createUserRunAs();
        List<User> lstUserRunAs = [SELECT Id FROM User WHERE UserRole.Name LIKE 'Vivo Prime' AND IsActive = true limit 1];        

        Account accObj = [SELECT Id FROM Account WHERE Name = 'Account Test' LIMIT 1];
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
        GetCardOfferCalloutMock getRequest = new GetCardOfferCalloutMock(200, CONST_BODYSUCCESS, CONST_MAPHEADER);
        CardOfferServiceReturn cardOffer;

        Test.startTest();
        System.runAs(lstUserRunAs[0]){
            Test.setMock(HttpCalloutMock.class, getRequest);        
            cardOffer = CarouselCardOfferController.getCardsOffers(accObj.Id, customerInteraction.Id);
        }
        Test.stopTest();
		
        System.assertEquals('success', cardOffer.msg, 'Trouxe a lista de card offer');
    } 

    @isTest 
    static void getCardOfferWithoutCard(){
        CarouselCardOfferControllerTest userTest = new CarouselCardOfferControllerTest();
        userTest.createUserRunAs();
        List<User> lstUserRunAs = [SELECT Id FROM User WHERE UserRole.Name LIKE 'Vivo Prime' AND IsActive = true limit 1];
                        
        Account accObj = [SELECT Id FROM Account WHERE Name = 'Account Test' LIMIT 1];
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
        GetCardOfferCalloutMock getRequest = new GetCardOfferCalloutMock(200, 
        CONST_BODYWITHOUTCARD,
        CONST_MAPHEADER);
		CardOfferServiceReturn cardOffer;
        Test.startTest();
        System.runAs(lstUserRunAs[0]){
            Test.setMock(HttpCalloutMock.class, getRequest);
             cardOffer = CarouselCardOfferController.getCardsOffers(accObj.Id, customerInteraction.Id); 
        }
       
        Test.stopTest();
		
        System.assertEquals('noCardOffer', cardOffer.msg, 'Fez a consulta com sucesso, mas não trouxe a lista de card');        
    }

    @isTest
    static void getWithoutResponse(){
        
        CarouselCardOfferControllerTest userTest = new CarouselCardOfferControllerTest();
        userTest.createUserRunAs();
        List<User> lstUserRunAs = [SELECT Id FROM User WHERE UserRole.Name LIKE 'Vivo Prime' AND IsActive = true limit 1];
                         
        Account accObj = [SELECT Id FROM Account WHERE Name = 'Account Test' LIMIT 1];
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
        GetCardOfferCalloutMock getRequest = new GetCardOfferCalloutMock(200, 
        '',
        CONST_MAPHEADER);

        CardOfferServiceReturn cardOffer;

        Test.startTest();
        System.runAs(lstUserRunAs[0]){
            Test.setMock(HttpCalloutMock.class, getRequest);
            cardOffer = CarouselCardOfferController.getCardsOffers(accObj.Id, customerInteraction.Id);
        }
        
        Test.stopTest();

        System.assertEquals('noCardOffer', cardOffer.msg, 'Faz a consulta com sucesso, mas não teve retorno no body');
    }
    
    @isTest 
    static void getWithError(){
        CarouselCardOfferControllerTest userTest = new CarouselCardOfferControllerTest();
        userTest.createUserRunAs();
        List<User> lstUserRunAs = [SELECT Id FROM User WHERE UserRole.Name LIKE 'Vivo Prime' AND IsActive = true limit 1];
                         
        Account accObj = [SELECT Id FROM Account WHERE Name = 'Account Test' LIMIT 1];
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
        GetCardOfferCalloutMock getRequest = new GetCardOfferCalloutMock(500, 
        CONST_BODYWITHOUTCARD,
        CONST_MAPHEADER);
        
        CardOfferServiceReturn cardOffer;

        Test.startTest();
        System.runAs(lstUserRunAs[0]){
            Test.setMock(HttpCalloutMock.class, getRequest);
            cardOffer = CarouselCardOfferController.getCardsOffers(accObj.Id, customerInteraction.Id);
        }
        
        Test.stopTest();

        System.assertEquals('error', cardOffer.msg, 'Ocorreu um erro ao realizar a consulta');
    }

    @isTest 
    static void postCardOfferAcceptedTest(){
        Account accObj = [SELECT Id FROM Account WHERE Name = 'Account Test' LIMIT 1];
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
        GetCardOfferCalloutMock postRequest = new GetCardOfferCalloutMock(200, 
        CONST_POSTRESPONSE,
        CONST_MAPHEADER);   

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, postRequest);
        String responseString = CarouselCardOfferController.postCardOffers(customerInteraction.Id, accObj.Id, CONST_CARD, 'ACEITOU', 'ACEITOU');   
        Test.stopTest();

        System.assertEquals('success', responseString, 'Fez a chamada com sucesso aceitando a oferta');
    }

    @isTest 
    static void postCardOfferDeniedTest(){
        Account accObj = [SELECT Id FROM Account WHERE Name = 'Account Test' LIMIT 1];
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
        GetCardOfferCalloutMock postRequest = new GetCardOfferCalloutMock(200, 
        CONST_POSTRESPONSE,
        CONST_MAPHEADER);   

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, postRequest);
        String responseString = CarouselCardOfferController.postCardOffers(customerInteraction.Id, accObj.Id, CONST_CARD, 'RECUSOU', 'Aceitou outra oferta');   
        Test.stopTest();

        System.assertEquals('success', responseString, 'Fez a chamada com sucesso recusando a oferta');
        
    }

    @isTest
    static void getWithoutWebService(){
        Webservice__c wsConfig = Webservice__c.getInstance(webServiceName);
        Account accObj = [SELECT Id FROM Account WHERE Name = 'Account Test' LIMIT 1];
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
        delete wsConfig;
        GetCardOfferCalloutMock getRequest = new GetCardOfferCalloutMock(200, 
        CONST_BODYSUCCESS,
        CONST_MAPHEADER);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, getRequest);
        CardOfferServiceReturn cardOffer = CarouselCardOfferController.getCardsOffers(accObj.Id, customerInteraction.Id); 
        Test.stopTest();

        System.assertEquals('error', cardOffer.msg, 'Ocorreu um erro, pois não tem um web service cadastrado para o endpoint');
    }    
    
    @isTest
    static void postWithError(){
        Account accObj = [SELECT Id FROM Account WHERE Name = 'Account Test' LIMIT 1];
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
        GetCardOfferCalloutMock postRequest = new GetCardOfferCalloutMock(500, 
        CONST_POSTRESPONSE,
        CONST_MAPHEADER);   

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, postRequest);
        String responseString = CarouselCardOfferController.postCardOffers(customerInteraction.Id, accObj.Id, CONST_CARD, 'ACEITOU', 'ACEITOU');   
        Test.stopTest();

        System.assertEquals('error', responseString, 'Ocorreu um erro ao realizar a consulta');
    }

    @isTest
    static void postWithoutWebService(){
        Webservice__c wsConfig = Webservice__c.getInstance(webServiceName);
        delete wsConfig;
        Account accObj = [SELECT Id FROM Account WHERE Name = 'Account Test' LIMIT 1];
        vlocity_cmt__CustomerInteraction__c customerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
        GetCardOfferCalloutMock postRequest = new GetCardOfferCalloutMock(500, 
        CONST_POSTRESPONSE,
        CONST_MAPHEADER);   

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, postRequest);
        String responseString = CarouselCardOfferController.postCardOffers(customerInteraction.Id, accObj.Id, CONST_CARD, 'ACEITOU', 'ACEITOU');   
        Test.stopTest();

        System.assertEquals('error', responseString, 'Ocorreu um erro, pois não tem um web service cadastrado para o endpoint');
    }
    
    @isTest
    static void checkIfAccountHaveUserId(){
        Account accObj = [SELECT Id FROM Account WHERE Name = 'Account Test' LIMIT 1];
       	Test.startTest();
        Boolean haveUserId = CarouselCardOfferController.checkIfAccountHaveUserId(accObj.Id);        
        Test.stopTest();
        
        System.assertEquals(true, haveUserId, 'Account possui UserId');
    }
    
    @isTest
    static void checkIfAccountDontHaveUserId(){
       	Account accObj = [SELECT Id FROM Account WHERE Name = 'Account Test' LIMIT 1];
        accObj.UserId__c = null;
        update accObj;
        
        Test.startTest();
        Boolean haveUserId = CarouselCardOfferController.checkIfAccountHaveUserId(accObj.Id);        
        Test.stopTest();
        
        System.assertEquals(false, haveUserId, 'Account não possui UserId');
    }

    @isTest
    static void setNumberOfOffers(){
        vlocity_cmt__CustomerInteraction__c oldCustomerInteraction = [SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
                
        Test.startTest();
        CarouselCardOfferController.setNumberOfOffers(oldCustomerInteraction.Id, 10);        
        Test.stopTest();

        vlocity_cmt__CustomerInteraction__c updatedCustomerInteraction = [SELECT Id, NumberOfOffers__c FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
        Boolean hasNumberOfOffers = updatedCustomerInteraction.NumberOfOffers__c != null;
        System.assertEquals(true, hasNumberOfOffers, 'Número de ofertas não atualizadas');
    }
}