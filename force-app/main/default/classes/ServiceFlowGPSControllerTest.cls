@isTest
class ServiceFlowGPSControllerTest {
    @testSetup
    static void setup() {
        insert new Webservice__c(
            Name = 'ServiceFlowDiagnosticCallout',
            Endpoint__c = 'http://test:7001/gps/crm/api/v3/diagnostic/',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2',
            HasAuthToken__c = true,
            Headers__c = 'sistemaOrigem:LEGADO'
        );
        
        insert new Webservice__c(
            Name = 'ServiceFlowFormCallout',
            Endpoint__c = 'http://test:7001/gps/crm/api/v3/protocol',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2',
            HasAuthToken__c = true,
            Headers__c = 'sistemaOrigem:LEGADO'
        );

        insert new Webservice__c(
            Name = 'ServiceFlowProtocolCallout',
            Endpoint__c = 'http://test:7001/gps/crm/api/v3/protocol',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2',
            HasAuthToken__c = true,
            Headers__c = 'sistemaOrigem:LEGADO'
        );

        Account acct = DataFactory.createPersonAccount();
        insert acct;        

        Account billingAcct = DataFactory.createBillingAccount(acct.Id, 'Fixa');        
        insert billingAcct;
        
        Asset asset = DataFactory.createAsset(acct.id, 'Fixa');
        asset.Instance__c = '12345678';
        insert asset;
        
        insert new CustomerInteractionTopicTree__c(
            Name = 'Teste de Fluxo de Atendimento',
            Active__c = true,
            GPSId__c = '',
            OperatorSegment__c = 'Gold',
            ProductType__c = 'Fixed',
            Instance__c = 'Banda Larga;TV',
			Type__c = 'Palito'            
        );        
        
        Case transferCase = new Case();
        transferCase.AccountId = acct.Id;
        transferCase.Status = 'Closed';
        transferCase.Origin = 'Ura';
        
        insert transferCase;

        Case openCase = new Case();
        openCase.AccountId = acct.Id;
        openCase.Origin = 'Ura';
        
        insert openCase;

    }

    @isTest
    static void getAssetFixedByAccountTest() {
        Test.startTest();
        
        Account acct = [SELECT Id, Name, DocumentNumber__c FROM Account LIMIT 1];
        List<Asset> ltAsset = [SELECT Id, Name FROM Asset WHERE Account.Id = :acct.Id];        
        
        List<Asset> ltAssetReturned = ServiceFlowGPSController.getAssetFixedByAccount(acct.Id);
        
        System.assertEquals(ltAsset[0].Id, ltAssetReturned[0].Id);
        
        Test.stopTest();
    }

    @isTest
    static void getAccountInfoTest() {
        Test.startTest();
        
        Account acct = [SELECT Id, Name, DocumentNumber__c FROM Account LIMIT 1];                
        
        Map<String, Object> mapResult = ServiceFlowGPSController.getAccountInfo(acct.Id);
        
        System.assertNotEquals(null, mapResult.get('account'));
        // System.assertNotEquals(null, mapResult.get('billingAccount'));
        
        Test.stopTest();
    }

    @IsTest
    static void getServiceFlow() {
        Test.startTest();
        
        Map<String, Object> mapResult = ServiceFlowGPSController.getServiceFlow('OrgVivo');

        //System.assertNotEquals(null, mapResult.get('ltServiceQualification'));
        
        Test.stopTest();
    }

    @IsTest
    static void closeCase() {
        // ServiceQualification__c serv = [SELECT Id FROM ServiceQualification__c WHERE GpsId__c != null LIMIT 1];
        Account account = [SELECT Id FROM Account LIMIT 1];
        Case caseParent = [SELECT Id FROM Case LIMIT 1];
        
        Map<String, String> payload = new Map<String, String>();
        payload.put('accountId', account.Id);
        // payload.put('selectedFlow', serv.Id);
        payload.put('selectedAsset', 'selectedAsset');
        payload.put('caseIdUra', caseParent.Id);

        Test.startTest();
        
        Case newCase = ServiceFlowGPSService.getOrCreateCase(payload);
        Map<String, String> payload2 = new Map<String, String>();
        payload2.put('CaseId__c', newCase.Id);
        Boolean caseClosed = ServiceFlowGPSService.closeCase(payload2);

        Case closedCase = [SELECT Id FROM Case LIMIT 1];
        System.assertNotEquals(null, closedCase.Id);
        
        Test.stopTest();
    }

    @isTest
    static void getCanvasParameters() {
        //ServiceQualification__c serv = [SELECT Id FROM ServiceQualification__c WHERE GpsId__c != null LIMIT 1];
        Asset asset = [SELECT Id FROM Asset LIMIT 1];
        Account account = [SELECT Id FROM Account LIMIT 1];
        Case caseObj = [SELECT Id FROM Case WHERE Status != 'Closed' LIMIT 1];
        caseObj.Status = 'Em Atendimento';
        update caseObj;

        Test.startTest();
        CanvasResult canvasParameters = ServiceFlowGPSService.getCanvasParameters(account.Id, null, 'assetInstance', caseObj.Id);
        
        System.assertNotEquals(null, canvasParameters);
        
        Test.stopTest();
    }
    @isTest
    static void getDiagnosticGroup() {
        //ServiceQualification__c serv = [SELECT Id FROM ServiceQualification__c WHERE GpsId__c != null LIMIT 1];
        Asset asset = [SELECT Id FROM Asset LIMIT 1];        

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ServiceFlowDiagnosticCalloutMock());
        Map<String, Object> mapGpsGroup = ServiceFlowGPSController.getActionGPS(null, asset.Id);
        
        System.assertNotEquals(null, mapGpsGroup.get('response'));
        System.assertNotEquals(null, mapGpsGroup.get('ltPreviousGroups'));
        
        Test.stopTest();
    }

    @isTest
    static void getNextGroup() {
        //ServiceQualification__c serv = [SELECT Id FROM ServiceQualification__c WHERE GpsId__c != null LIMIT 1];
        Asset asset = [SELECT Id FROM Asset LIMIT 1];        

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ServiceFlowDiagnosticCalloutMock());
        GPSAction gpsAction = new GPSAction('1234', 'nameInicial', 'statusInicial', 'typeInicial', 'answerInicial', 'noteInicial', 'responseTimeInicial', 'mediaTypeInicial', 'urlInicial', 'linkInicial', 'linkAlias', 'informacoesAdicionaisInicial', 'errorInicial');

        GPSGroup gpsGroup = new GPSGroup();
        gpsGroup.id = '123';
        gpsGroup.token = '1234';
        gpsGroup.nome = 'grupo teste';
        gpsGroup.ltAction = new List<GPSAction>{gpsAction};
        gpsGroup.ltAction.add(gpsAction);


        Test.setMock(HttpCalloutMock.class, new ServiceFlowDiagnosticCalloutMock());
        Map<String, Object> mapGpsGroup = ServiceFlowGPSController.getNextGroup(JSON.serialize(gpsGroup));

        System.assertNotEquals(null, mapGpsGroup.get('response'));
        System.assertNotEquals(null, mapGpsGroup.get('ltPreviousGroups'));
        
        Test.stopTest();
    }

    @isTest
    static void getFormSelecaoInstancia() {
        //ServiceQualification__c serv = [SELECT Id FROM ServiceQualification__c WHERE GpsId__c != null LIMIT 1];
        Asset asset = [SELECT Id FROM Asset LIMIT 1];        


        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new FormSelecaoInstanciaCalloutMock());
        Map<String, Object> mapGpsGroup = new Map<String, Object>();
        mapGpsGroup = ServiceFlowGPSEngine.getForm(mapGpsGroup, 'token', 'formId');

        System.assertNotEquals(null, mapGpsGroup.get('form'));
        
        Test.stopTest();
    }

    
    @isTest
    static void getFormConsultaDisponibilidade() {
        //ServiceQualification__c serv = [SELECT Id FROM ServiceQualification__c WHERE GpsId__c != null LIMIT 1];
        Asset asset = [SELECT Id FROM Asset LIMIT 1];        

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new FormConsultaDisponibilidadeCalloutMock());
        Map<String, Object> mapGpsGroup = new Map<String, Object>();
        mapGpsGroup = ServiceFlowGPSEngine.getForm(mapGpsGroup, 'token', 'formularioVerificarDisponibilidadeFibraMb');

        System.assertNotEquals(null, mapGpsGroup.get('form'));
        
        Test.stopTest();
    }

    @isTest
    static void getFormSmsExtract() {
        //ServiceQualification__c serv = [SELECT Id FROM ServiceQualification__c WHERE GpsId__c != null LIMIT 1];
        Asset asset = [SELECT Id FROM Asset LIMIT 1];        

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new FormEnvioExtratoSmsCalloutMock());
        Map<String, Object> mapGpsGroup = new Map<String, Object>();
        mapGpsGroup = ServiceFlowGPSEngine.getForm(mapGpsGroup, 'token', 'formId');

        System.assertNotEquals(null, mapGpsGroup.get('form'));
        
        Test.stopTest();
    }


    @isTest
    static void sendFormExtract() {
        //ServiceQualification__c serv = [SELECT Id FROM ServiceQualification__c WHERE GpsId__c != null LIMIT 1];
        Account account = [SELECT Id FROM Account LIMIT 1];        
        Case nuCase = [SELECT Id FROM Case LIMIT 1];        
        Asset asset = [SELECT Id, Instance__c FROM Asset LIMIT 1];        
        Map<String, Object> mapForm = new Map<String, Object>();
        mapForm.put('FORM_ADC_ORDERNUM_RESENDEXTRACT', 'Teste');

        GPSAction gpsAction = new GPSAction('1234', 'nameInicial', 'statusInicial', 'typeInicial', 'answerInicial', 'noteInicial', 'responseTimeInicial', 'mediaTypeInicial', 'urlInicial', 'linkInicial', 'linkAlias', 'informacoesAdicionaisInicial', 'errorInicial');

        GPSGroup gpsGroup = new GPSGroup();
        gpsGroup.id = '123';
        gpsGroup.token = '1234';
        gpsGroup.nome = 'grupo teste';
        gpsGroup.ltAction = new List<GPSAction>{gpsAction};
        gpsGroup.ltAction.add(gpsAction);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ServiceFlowFormRotinaCalloutMock());
        mapForm = ServiceFlowGPSController.sendForm(JSON.serialize(mapForm), JSON.serialize(gpsGroup), account.Id, asset.Instance__c, null, nuCase.id);

        Test.stopTest();
    }

    @isTest
    static void sendFormSelecaoInstancia() {
        //ServiceQualification__c serv = [SELECT Id FROM ServiceQualification__c WHERE GpsId__c != null LIMIT 1];
        Account account = [SELECT Id FROM Account LIMIT 1];
        Case nuCase = [SELECT Id FROM Case LIMIT 1];         
        Asset asset = [SELECT Id, Instance__c FROM Asset LIMIT 1];        
        Map<String, Object> mapForm = new Map<String, Object>();
        mapForm.put('SERIAL_INSTANCIA_FORM_ATEND_SEL_INST', 'Teste');

        GPSAction gpsAction = new GPSAction('1234', 'nameInicial', 'statusInicial', 'typeInicial', 'answerInicial', 'noteInicial', 'responseTimeInicial', 'mediaTypeInicial', 'urlInicial', 'linkInicial', 'linkAlias', 'informacoesAdicionaisInicial', 'errorInicial');

        GPSGroup gpsGroup = new GPSGroup();
        gpsGroup.id = '123';
        gpsGroup.token = '1234';
        gpsGroup.nome = 'grupo teste';
        gpsGroup.ltAction = new List<GPSAction>{gpsAction};
        gpsGroup.ltAction.add(gpsAction);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new FormSelecaoInstanciaCalloutMock());
        mapForm = ServiceFlowGPSController.sendForm(JSON.serialize(mapForm), JSON.serialize(gpsGroup), account.Id, asset.Instance__c, null, nuCase.Id);
        System.assertNotEquals(null, mapForm.get('form'));
        
        Test.stopTest();
    }

    @isTest
    static void sendFormSMS() {
        //ServiceQualification__c serv = [SELECT Id FROM ServiceQualification__c WHERE GpsId__c != null LIMIT 1];
        Account account = [SELECT Id FROM Account LIMIT 1];    
        Case nuCase = [SELECT Id FROM Case LIMIT 1];     
        Asset asset = [SELECT Id, Instance__c FROM Asset LIMIT 1];        
        Map<String, Object> mapForm = new Map<String, Object>();
        mapForm.put('FORM_ADC_LINHAS_SMS_INCENTIVO', 'Teste');

        GPSAction gpsAction = new GPSAction('1234', 'nameInicial', 'statusInicial', 'typeInicial', 'answerInicial', 'noteInicial', 'responseTimeInicial', 'mediaTypeInicial', 'urlInicial', 'linkInicial', 'linkAlias', 'informacoesAdicionaisInicial', 'errorInicial');

        GPSGroup gpsGroup = new GPSGroup();
        gpsGroup.id = '123';
        gpsGroup.token = '1234';
        gpsGroup.nome = 'grupo teste';
        gpsGroup.ltAction = new List<GPSAction>{gpsAction};
        gpsGroup.ltAction.add(gpsAction);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new FormEnvioSMSCalloutMock());
        mapForm = ServiceFlowGPSController.sendForm(JSON.serialize(mapForm), JSON.serialize(gpsGroup), account.Id, asset.Instance__c, null, nuCase.id);        
        Test.stopTest();
    }

    @isTest
    static void getProtocol() {
        GPSGroup gpsGroup = new GpsGroup();
        Account account = [SELECT Id FROM Account LIMIT 1];        
        Asset asset = [SELECT Id, Instance__c FROM Asset LIMIT 1];
        Case nuCase = [SELECT Id FROM Case LIMIT 1];         
        
        gpsGroup.token = '1234';
        gpsGroup.ltText = new List<GPSGroup.Campo>();
        gpsGroup.ltNumber = new List<GPSGroup.Campo>();
        gpsGroup.ltCheckbox = new List<GPSGroup.Campo>();
        gpsGroup.ltCombobox = new List<GPSGroup.Campo>();

        GPSGroup.Campo campoText = new GPSGroup.Campo();
        campoText.chave = 'chave';
        campoText.valor = 'valor';
        campoText.tipo = 'TEXT';
        gpsGroup.ltText.add(campoText);

        GPSGroup.Campo campoNumber = new GPSGroup.Campo();
        campoNumber.chave = 'chave';
        campoNumber.valor = '123';
        campoNumber.tipo = 'NUMBER';
        gpsGroup.ltNumber.add(campoNumber);

        GPSGroup.Campo campoCheckbox = new GPSGroup.Campo();
        campoCheckbox.chave = 'chave';
        campoCheckbox.tipo = 'CHECKBOX';
        gpsGroup.ltCheckbox.add(campoCheckbox);

        GPSGroup.Campo campoCombobox = new GPSGroup.Campo();
        campoCheckbox.chave = 'chave';
        campoCheckbox.tipo = 'COMBOBOX';
        campoCheckbox.valor = 'Teste';
        gpsGroup.ltCombobox.add(campoCombobox);        
		
        CustomerInteractionTopicTree__c service = [SELECT Id FROM CustomerInteractionTopicTree__c LIMIT 1];
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ServiceFlowProtocolCalloutMock());

        GPSProtocol gpsProtocol =  ServiceFlowGPSController.getProtocol(account.Id, asset.Instance__c, JSON.serialize(gpsGroup), service.Id, nuCase.Id);
        System.assertNotEquals(null, gpsProtocol);

        Test.stopTest();
    }

    @isTest
    static void sendFormExtractBase64() {
        //ServiceQualification__c serv = [SELECT Id FROM ServiceQualification__c WHERE GpsId__c != null LIMIT 1];
        Account account = [SELECT Id FROM Account LIMIT 1];        
        Asset asset = [SELECT Id, Instance__c FROM Asset LIMIT 1];        
        Map<String, Object> mapForm = new Map<String, Object>();
        mapForm.put('FORM_ADC_ORDERNUM_RESENDEXTRACT', 'Teste');

        GPSAction gpsAction = new GPSAction('1234', 'nameInicial', 'statusInicial', 'typeInicial', 'answerInicial', 'noteInicial', 'responseTimeInicial', 'mediaTypeInicial', 'urlInicial', 'linkInicial', 'linkAlias', 'informacoesAdicionaisInicial', 'errorInicial');

        GPSGroup gpsGroup = new GPSGroup();
        gpsGroup.id = '123';
        gpsGroup.token = '1234';
        gpsGroup.nome = 'grupo teste';
        gpsGroup.ltAction = new List<GPSAction>{gpsAction};
        gpsGroup.ltAction.add(gpsAction);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ServiceFlowFormBase64CalloutMock());
        mapForm = ServiceFlowGPSController.getBase64(JSON.serialize(mapForm), JSON.serialize(gpsGroup), account.Id, asset.Instance__c, null);
        System.assertNotEquals(null, mapForm.get('base64'));
        Test.stopTest();
    }

    @isTest
    static void sendFormAndRecieveError() {
        // ServiceQualification__c serv = [SELECT Id FROM ServiceQualification__c WHERE GpsId__c != null LIMIT 1];
        Account account = [SELECT Id FROM Account LIMIT 1];        
        Asset asset = [SELECT Id, Instance__c FROM Asset LIMIT 1];        
        Map<String, Object> mapForm = new Map<String, Object>();
        mapForm.put('FORM_ADC_ORDERNUM_RESENDEXTRACT', 'Teste');

        GPSAction gpsAction = new GPSAction('1234', 'nameInicial', 'statusInicial', 'typeInicial', 'answerInicial', 'noteInicial', 'responseTimeInicial', 'mediaTypeInicial', 'urlInicial', 'linkInicial', 'linkAlias', 'informacoesAdicionaisInicial', 'errorInicial');

        GPSGroup gpsGroup = new GPSGroup();
        gpsGroup.id = '123';
        gpsGroup.token = '1234';
        gpsGroup.nome = 'grupo teste';
        gpsGroup.ltAction = new List<GPSAction>{gpsAction};
        gpsGroup.ltAction.add(gpsAction);

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ServiceFlowGPSErrorCalloutMock());
        mapForm = ServiceFlowGPSController.getBase64(JSON.serialize(mapForm), JSON.serialize(gpsGroup), account.Id, asset.Instance__c, null);
        System.assertEquals(null, mapForm.get('base64'));
        Test.stopTest();
    }
}