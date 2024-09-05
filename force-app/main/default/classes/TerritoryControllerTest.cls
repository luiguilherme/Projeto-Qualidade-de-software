@isTest
public class TerritoryControllerTest {
	
    @testSetup
    static void setup(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Representante'];
        User u = new User(Alias = 'Teste', Email='teste@carteira.com',
                          EmailEncodingKey='UTF-8', LastName='Carteira', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id,
                          TimeZoneSidKey='America/Sao_Paulo', UserName='stdteste@teste.com');
        Database.insert(u);
    }
    
    @isTest
    static void testInvokeMethod() {
        
        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('territoryId', 'fakeId');

        Map<String, Object> outputMap = new Map<String, Object>();

        TerritoryController controller = new TerritoryController();
        Boolean success = controller.invokeMethod('getRepresentantesCarteira', inputMap, outputMap, new Map<String, Object>());

        System.assertEquals(true, success);        
    }
    
    @isTest
    static void testInvokeMethodNotExist() {
        
        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('territoryId', 'fakeId');

        Map<String, Object> outputMap = new Map<String, Object>();

        TerritoryController controller = new TerritoryController();
        Boolean success = controller.invokeMethod('getFakeMethod', inputMap, outputMap, new Map<String, Object>());

        System.assertEquals(true, success);        
    }
    
}