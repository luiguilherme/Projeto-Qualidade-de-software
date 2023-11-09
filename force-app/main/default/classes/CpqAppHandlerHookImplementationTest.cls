@isTest private class CpqAppHandlerHookImplementationTest {
    @TestSetup
    static void setup(){
        //Account
        Account acc = new Account();
        acc.Name = 'Conta 1';
        insert acc;

        //Order
        Order order = new Order();
        order.AccountId = acc.Id;
        order.DDD__c = '11';
        order.EffectiveDate = Date.today();
        order.Status = 'Draft';
        insert order;

        //Product
        Product2 product = new Product2();
        product.Name = 'Produto 1';
        product.ProductCode = '0001';
        insert product;

        ProductEligibility__c prodEle = new ProductEligibility__c();
        prodEle.ProductId__c = product.Id;
        prodEle.DDD__c = '11';
        prodEle.Active__c = true;
        insert prodEle;
    }

    @isTest static void getCartsProducts_PostInvokeTest(){
        CpqAppHandlerHookImplementation controller = new CpqAppHandlerHookImplementation();

        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();

        Test.startTest();

        Id orderId = [SELECT Id FROM Order].Id;

        inputMap = new Map<String,Object>();
        inputMap.put('cartId', orderId);
        
        controller.invokeMethod('getCartsProducts.PostInvoke', inputMap, outputMap, options);         

        Test.stopTest();
    }

    @isTest static void getOffersByCatalogCode_PostInvoke(){
        CpqAppHandlerHookImplementation controller = new CpqAppHandlerHookImplementation();

        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();

        Map<String,String> inputValues = new Map<String,String>();
        inputValues.put('DDD' , '11');
        inputMap.put('context', JSON.serialize(inputValues));

        Map<String,String> mapOffer = new Map<String,String>();
        mapOffer.put('ProductCode', '0001');

        List<Object> listOffers = new List<Object>();
        listOffers.add(mapOffer);

        outputMap.put('offers', listOffers);

        Test.startTest();
        controller.invokeMethod('getOffersByCatalogCode.PostInvoke', inputMap, outputMap, options);         
        Test.stopTest();
    }    
}