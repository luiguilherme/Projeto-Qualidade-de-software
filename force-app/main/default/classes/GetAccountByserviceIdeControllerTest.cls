@isTest 
private class GetAccountByserviceIdeControllerTest {

    @TestSetup
    static void setup(){ 
        Account acc = DataFactory.createConsumerAccount();
        acc.Name = 'AccByService';
        Insert acc;
        
        Account accService = DataFactory.createServiceAccount(acc.Id, acc.id, 'Movel');        
        Insert accService;
        
        Product2 prod = DataFactory.createProductPromotion();
        Insert prod;
        
        Asset assetToInsert = DataFactory.createAsset(acc.Id, 'Movel');
        assetToInsert.Product2Id = prod.Id;
        assetToInsert.Status = 'Active';
        assetToInsert.vlocity_cmt__ServiceIdentifier__c = '11999999999';
        assetToInsert.vlocity_cmt__ServiceAccountId__c = accService.Id;
        Insert assetToInsert;
    }
    
    @isTest 
    static void getAccByServiceIdentifier(){
        GetAccountByserviceIdentifierController controller = new GetAccountByserviceIdentifierController();
        
        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();
                             
        Test.startTest();
		Account acc = [SELECT Id FROM Account WHERE Name = 'AccByService'];
         
		inputMap.put('AccId', acc.Id);    

        controller.invokeMethod('getAccountAssetAddress', inputMap, outputMap, options); 
        Test.stopTest();
        System.assertEquals(true, outputMap.get('result') != null);

    }
}