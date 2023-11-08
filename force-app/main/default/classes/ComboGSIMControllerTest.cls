@isTest
public class ComboGSIMControllerTest {
    
    @isTest
    static void invokeMethodErrorTest(){
        Map<String, Object> inputMap = new Map<String, String>();
        Map<String, Object> outputMap = new Map<String, String>();
        Map<String, Object> optionMap = new Map<String, String>();
        
        inputMap.put('Payload', null);
        
		Test.startTest();
        ComboGSIMController combo = new ComboGSIMController();
        Boolean result = combo.invokeMethod('transformPayload', inputMap, outputMap, null);
		Test.stopTest();
        
        System.assertEquals(false, result);
    }
    
    @isTest
    static void comboGSIMControllerTest(){
        Map<String, Object> inputMap = new Map<String, String>();
		Map<String, Object> outputMap = new Map<String, String>();
		Map<String, Object> optionMap = new Map<String, String>();
        
		String payload = '{"mixRecharge":"0","sms":"","description":"text","activeNgin":"text","effectiveEndDate":"02/05/2050","effectiveStartDate":"11/01/2022","cod":"x","name":"text","promotion":null}';
        
        Test.startTest();
		Map<String, String> mapPayload = (Map<String, String>) JSON.deserialize(payload, Map<String, String>.class);
        ComboGSIMController.ComboItem comboItem = new ComboGSIMController.ComboItem(mapPayload);
        Test.stopTest();
        
        System.assertEquals(9, comboItem.resourceCharacteristic.size());
        
        for (ComboGSIMController.Item item : comboItem.resourceCharacteristic) {
            System.assert(item.value != null);
        }
    }

}