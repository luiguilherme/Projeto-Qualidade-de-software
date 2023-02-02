@isTest private class FulfilmentRequestLineControllerTest {
    @TestSetup
    static void setup(){ 
        //Fulfilment Request
        vlocity_cmt__FulfilmentRequest__c fr = new vlocity_cmt__FulfilmentRequest__c();
        insert fr;
        
        //Product
        Product2 product = new Product2();
        product.Name = 'Produto 1';
        product.ProductCode = '0001';
        insert product;
        
        //Fulfilment RequestLine
        vlocity_cmt__FulfilmentRequestLine__c frl = new vlocity_cmt__FulfilmentRequestLine__c();
        frl.vlocity_cmt__FulfilmentRequestID__c = fr.Id;
        frl.vlocity_cmt__LineNumber__c = frl.Id + '.0001';
        frl.vlocity_cmt__Action__c = 'Add';
        frl.vlocity_cmt__Product2Id__c = product.Id;
        frl.vlocity_cmt__JSONAttribute__c = '{"ATT_CAT_PROVISIONING":[{"$$AttributeDefinitionStart$$":null,"categorycode__c":"ATT_CAT_PROVISIONING","attributeid__c":"a0X76000000D8JIEA0","attributeuniquecode__c":"ATT_DC_PROVISIONING_STATUS","attributedisplayname__c":"Status de Aprovisionamento","id":"","objectid__c":"","objecttype__c":null,"categoryname__c":"Category","valuedatatype__c":"Text","displaysequence__c":null,"attributecategoryid__c":"","attributedisplaysequence__c":null,"hasrule__c":false,"isactive__c":true,"ishidden__c":false,"isnotassetizable__c":false,"isreadonly__c":false,"isquerydriven__c":false,"isconfigurable__c":true,"attributefilterable__c":true,"attributeconfigurable__c":true,"isrequired__c":false,"formatmask__c":null,"valueinnumber__c":null,"querycode__c":null,"querylabel__c":null,"rulemessage__c":null,"uidisplaytype__c":null,"value__c":null,"valuedescription__c":null,"attributeRunTimeInfo":{"dataType":"Text","default":"","value":"Em Espera"},"Name":"Status de Aprovisionamento","Code":"ATT_DC_PROVISIONING_STATUS","Filterable":false,"SegmentValue":"Em Espera","$$AttributeDefinitionEnd$$":null}]}';
        insert frl;

    }
    
    @isTest static void setAttributeTest(){
		Object objRetorno;
        FulfilmentRequestLineController controller = new FulfilmentRequestLineController();
        
        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();
        
        Map<String,Object> mapAttr = new Map<String,Object>();
                     
        Test.startTest();
        Id fulfilmentRequestLineId = [SELECT Id FROM vlocity_cmt__FulfilmentRequestLine__c].Id;
   
		inputMap.put('FulfilmentRequestLineId', fulfilmentRequestLineId);
		inputMap.put('AttributeCode', 'ATT_DC_PROVISIONING_STATUS');
		inputMap.put('AttributeValue', 'OK');        

        controller.invokeMethod('setAttribute', inputMap, outputMap, options); 
        
        List<String> attrList = new List <String> {'ATT_DC_PROVISIONING_STATUS', 'ATTRIBUTO'};
        inputMap = new Map<String,Object>();
        inputMap.put('FulfilmentRequestLineId', fulfilmentRequestLineId);
		inputMap.put('AttributeCodeList', attrList);
        
        controller.invokeMethod('getAttribute', inputMap, outputMap, options);         

        System.assertEquals('OK', outputMap.get('ATT_DC_PROVISIONING_STATUS'));
        Test.stopTest();
    }
    
    @isTest static void setAttributeListTest(){
		Object objRetorno;
        FulfilmentRequestLineController controller = new FulfilmentRequestLineController();
        
        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();
        
        Map<String,Object> mapAttr = new Map<String,Object>();
                     
        Test.startTest();
        Id fulfilmentRequestLineId = [SELECT Id FROM vlocity_cmt__FulfilmentRequestLine__c].Id;
   
        inputMap.put('FulfilmentRequestLineIdList', new List<String> {fulfilmentRequestLineId});
		inputMap.put('AttributeCode', 'ATT_DC_PROVISIONING_STATUS');
		inputMap.put('AttributeValue', 'OKList');

        controller.invokeMethod('setAttribute', inputMap, outputMap, options); 
        
        List<String> attrList = new List <String> {'ATT_DC_PROVISIONING_STATUS', 'ATTRIBUTO'};
        inputMap = new Map<String,Object>();
        inputMap.put('FulfilmentRequestLineId', fulfilmentRequestLineId);
		inputMap.put('AttributeCodeList', attrList);
        
        controller.invokeMethod('getAttribute', inputMap, outputMap, options);         

        System.assertEquals('OKList', outputMap.get('ATT_DC_PROVISIONING_STATUS'));
        Test.stopTest();
    }

    @isTest static void setAttributeMapTest(){
		Object objRetorno;
        FulfilmentRequestLineController controller = new FulfilmentRequestLineController();
        
        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();
        
        Map<String,String> mapAttr = new Map<String,String>();
        mapAttr.put('ATT_DC_PROVISIONING_STATUS','OKMap');
        mapAttr.put('ATTRIBUTO','ValorGenerico');
                     
        Test.startTest();
        Id fulfilmentRequestLineId = [SELECT Id FROM vlocity_cmt__FulfilmentRequestLine__c].Id;
   
        inputMap.put('FulfilmentRequestLineIdList', new List<String> {fulfilmentRequestLineId});
		inputMap.put('AttributeMap', mapAttr);

        controller.invokeMethod('setAttribute', inputMap, outputMap, options); 
        
        List<String> attrList = new List <String> {'ATT_DC_PROVISIONING_STATUS', 'ATTRIBUTO'};
        inputMap = new Map<String,Object>();
        inputMap.put('FulfilmentRequestLineId', fulfilmentRequestLineId);
		inputMap.put('AttributeCodeList', attrList);
        
        controller.invokeMethod('getAttribute', inputMap, outputMap, options);         

        System.assertEquals('OKMap', outputMap.get('ATT_DC_PROVISIONING_STATUS'));
        Test.stopTest();
    }
}