@isTest
public with sharing class DisputeFixedCreateCaseHelperTest {
    
    @isTest
    public static void givenInputsWhenRegexThenShouldReturnAppropriateResponse() {

        Map<String, Object> inputWithLetters = new Map<String, Object>();
        inputWithLetters.put('instanceProduct', 'CTA123456789');
        
        Map<String, Object> inputWithNumbers = new Map<String, Object>();
        inputWithNumbers.put('instanceProduct', '123456789');

        Test.startTest();

        String responseWithLetters = DisputeFixedCreateCaseHelper.validateInstaceProduct(inputWithLetters);
        String responseWithNumbers = DisputeFixedCreateCaseHelper.validateInstaceProduct(inputWithNumbers);

        Test.stopTest();

        System.assertEquals('', responseWithLetters);
        System.assertEquals('123456789', responseWithNumbers);

    }

    @isTest
    public static void givenInputsWhenStringTransformThenShouldReturnString() {

        Map<String, Object> input = new Map<String, Object>();
        input.put('value', 123);
        
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        Test.startTest();

        Boolean response = new DisputeFixedCreateCaseHelper().invokeMethod('transformToString', input, output, options);

        Test.stopTest();

        System.assertEquals('123', output.get('result'));
        System.assertEquals(true, response);

    }
}