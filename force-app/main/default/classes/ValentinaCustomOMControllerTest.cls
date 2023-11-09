@isTest private class ValentinaCustomOMControllerTest {
    @TestSetup
    static void setup(){ 
        //Account
        Account account = new Account();
        account.name = 'testAccount';
        insert account;

        //Order
        Order order = new Order();
        order.AccountId = account.Id;
        order.EffectiveDate = Date.today();
        order.Status = 'Draft';
        order.Pricebook2Id = test.getStandardPricebookId();
        insert order;

		//Product2
        Product2 product = new Product2();
        product.Name = 'Produto 1';
        product.ProductCode = '0001';
        insert product;
        
        //PricebookEntry
        PricebookEntry pbe = new PricebookEntry();
        pbe.UnitPrice = 10;
        pbe.Product2Id = product.Id;
        pbe.Pricebook2Id = test.getStandardPricebookId();
        insert pbe;
        
        //OrderItem
        OrderItem orderItem = new OrderItem();
        orderItem.Quantity = 1;
        orderItem.OrderId = order.Id;
        orderItem.PricebookEntryId = pbe.Id;
        orderItem.Product2Id = product.Id;
        orderItem.UnitPrice = 10;
        insert orderItem;

        //Fulfilment Request
        vlocity_cmt__FulfilmentRequest__c fr = new vlocity_cmt__FulfilmentRequest__c();
        fr.vlocity_cmt__OrderId__c = order.Id;
        insert fr;
        
        //Fulfilment RequestLine
        vlocity_cmt__FulfilmentRequestLine__c frl = new vlocity_cmt__FulfilmentRequestLine__c();
        frl.vlocity_cmt__FulfilmentRequestID__c = fr.Id;
        frl.vlocity_cmt__LineNumber__c = frl.Id + '.0001';
        frl.vlocity_cmt__Action__c = 'Add';
        frl.vlocity_cmt__Product2Id__c = product.Id;
        frl.vlocity_cmt__JSONAttribute__c = '{"ATT_CAT_PROVISIONING":[{"$$AttributeDefinitionStart$$":null,"categorycode__c":"ATT_CAT_PROVISIONING","attributeid__c":"a0X76000000D8JIEA0","attributeuniquecode__c":"ATT_DC_PROVISIONING_STATUS","attributedisplayname__c":"Status de Aprovisionamento","id":"","objectid__c":"","objecttype__c":null,"categoryname__c":"Category","valuedatatype__c":"Text","displaysequence__c":null,"attributecategoryid__c":"","attributedisplaysequence__c":null,"hasrule__c":false,"isactive__c":true,"ishidden__c":false,"isnotassetizable__c":false,"isreadonly__c":false,"isquerydriven__c":false,"isconfigurable__c":true,"attributefilterable__c":true,"attributeconfigurable__c":true,"isrequired__c":false,"formatmask__c":null,"valueinnumber__c":null,"querycode__c":null,"querylabel__c":null,"rulemessage__c":null,"uidisplaytype__c":null,"value__c":null,"valuedescription__c":null,"attributeRunTimeInfo":{"dataType":"Text","default":"","value":"Em Espera"},"Name":"Status de Aprovisionamento","Code":"ATT_DC_PROVISIONING_STATUS","Filterable":false,"SegmentValue":"Em Espera","$$AttributeDefinitionEnd$$":null}]}';
        insert frl;

        //Fulfilment Request Line Decomp Relationship
        vlocity_cmt__FulfilmentRequestLineDecompRelationship__c frldr = new vlocity_cmt__FulfilmentRequestLineDecompRelationship__c();
        frldr.vlocity_cmt__SourceOrderItemId__c = orderItem.Id;
        frldr.vlocity_cmt__DestinationFulfilmentRequestLineId__c = frl.Id;
        insert frldr;
    }
    
    @isTest static void repropagateAttributeTest(){
		Object objRetorno;
        ValentinaCustomOMController valentinacontroller = new ValentinaCustomOMController();
        FulfilmentRequestLineController frlcontroller = new FulfilmentRequestLineController();
        
        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();
        
        Map<String,Object> mapAttr = new Map<String,Object>();
                     
        Test.startTest();
        Id fulfilmentRequestLineId = [SELECT Id FROM vlocity_cmt__FulfilmentRequestLine__c].Id;
        Id orderItemId = [SELECT Id FROM OrderItem].Id;
   
		inputMap.put('OrderItemId', orderItemId);
		inputMap.put('AttributeCode', 'ATT_DC_PROVISIONING_STATUS');
		inputMap.put('AttributeValue', 'OK');

        valentinacontroller.invokeMethod('repropagateAttribute', inputMap, outputMap, options); 
        
        List<String> attrList = new List <String> {'ATT_DC_PROVISIONING_STATUS', 'ATTRIBUTO'};
        inputMap = new Map<String,Object>();
        inputMap.put('FulfilmentRequestLineId', fulfilmentRequestLineId);
		inputMap.put('AttributeCodeList', attrList);
        
        frlcontroller.invokeMethod('getAttribute', inputMap, outputMap, options);         

        System.assertEquals('OK', outputMap.get('ATT_DC_PROVISIONING_STATUS'));
        Test.stopTest();
    }

    @isTest static void testGetHistoryStatus(){
        ValentinaCustomOMController controller = new ValentinaCustomOMController();
        
        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();
          
        Map<String,Object> mapHistory1 = new Map<String,Object>();
        mapHistory1.put('status', 'PreAtivo');

        Map<String,Object> mapHistory2 = new Map<String,Object>();
        mapHistory2.put('status', 'Ativo');   
        
        Map<String,Object> mapHistory3 = new Map<String,Object>();
        mapHistory3.put('status', 'SuspAPedido'); 
        
        List<Object> listHistory = new List<Object>();
        listHistory.add(mapHistory1);
        listHistory.add(mapHistory2);
        listHistory.add(mapHistory3);

		inputMap.put('statusHistory', listHistory);      

        Test.startTest();
        
        controller.invokeMethod('getHistoryStatus', inputMap, outputMap, options); 

        System.assertEquals('Ativo', outputMap.get('actualStatus'));
        System.assertEquals('PreAtivo', outputMap.get('lastStatus'));

        Test.stopTest();
    }    
}