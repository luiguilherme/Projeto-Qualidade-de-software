@isTest
private class BalanceLineControllerTest {
    
    @isTest
    static void testInvokeMethodGetSmallStepValue() {
        
        Map<String, Object> inputMap1 = new Map<String, Object>();
        inputMap1.put('steps', new List<PartialRenewalSteps__c>());
        Map<String, Object> outputMap1 = new Map<String, Object>();

        BalanceLineController controller1 = new BalanceLineController();
        Boolean success1 = controller1.invokeMethod('getSmallStepValue', inputMap1, outputMap1, new Map<String, Object>());

        System.assertEquals(true, success1);
        
    }
    
    @isTest
    static void testInvokeMethodParseTextAmountToNumber() {
        
        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('textAmount', 'R$90.25');

        Map<String, Object> outputMap = new Map<String, Object>();

        BalanceLineController controller = new BalanceLineController();
        Boolean success = controller.invokeMethod('parseTextAmountToNumber', inputMap, outputMap, new Map<String, Object>());

        System.assertEquals(true, success);
        
    }
    
    @isTest
    static void testInvokeMethodCatch() {
        
        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('textAmount', 'teste');

        Map<String, Object> outputMap = new Map<String, Object>();

        BalanceLineController controller = new BalanceLineController();
        Boolean success = controller.invokeMethod('parseTextAmountToNumber', inputMap, outputMap, new Map<String, Object>());

        System.assertEquals(false, success);
        
    }
    
    @isTest static void testGetSmallStepValue() {
        
        List<PartialRenewalSteps__c> steps = new List<PartialRenewalSteps__c>{
            new PartialRenewalSteps__c(Price__c = 'R$100.00'),
            new PartialRenewalSteps__c(Price__c = 'R$50.00'),
            new PartialRenewalSteps__c(Price__c = 'R$75.00')
        };
        
        Map<String, Object> inputMap = new Map<String, Object>{
            'steps' => steps
        };
        
        Map<String, Object> outputMap = new Map<String, Object>();
        
        BalanceLineController controller = new BalanceLineController();
        controller.getSmallStepValue(inputMap, outputMap);
        
        Decimal expectedResult = 50.00;
        Decimal actualResult = (Decimal) outputMap.get('result');
        
        System.assertEquals(expectedResult, actualResult);
        
    }
    
    @isTest static void testParseTextAmountToNumber() {
        
        Map<String, Object> inputMap = new Map<String, Object>{
            'textAmount' => 'R$123.45'
        };
        
        Map<String, Object> outputMap = new Map<String, Object>();
        
        BalanceLineController controller = new BalanceLineController();
        controller.parseTextAmountToNumber(inputMap, outputMap);
        
        Decimal expectedResult = 123.45;
        Decimal actualResult = (Decimal) outputMap.get('result');
        
        System.assertEquals(expectedResult, actualResult);
        
    }
    
    @isTest static void testParseTextToNumber() {
        
        BalanceLineController controller = new BalanceLineController();
        Decimal actualResult = controller.parseTextToNumber('R$789.12');
        Decimal expectedResult = 789.12;
        
        System.assertEquals(expectedResult, actualResult);
        
    }
    
}