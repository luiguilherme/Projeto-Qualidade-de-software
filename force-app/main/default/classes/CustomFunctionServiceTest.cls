/*
* Autor: Giovani de Souza - Deloitte
* Criado em: 05/11/2021
*/
@isTest
public class CustomFunctionServiceTest {
    
    @isTest
    public static void validateEmailFormat(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        objectList.add('test@gmail.com');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('validateEmailFormat', inputs, output, options);
        System.debug(output);
    }
    
    @isTest    
    public static void validateCPF(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        objectList.add('083.591.284-13');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('validateCPF', inputs, output, options);
        System.debug(output);
    }    
    @isTest    
    public static void validateCNPJ(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        objectList.add('12345678901234');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('validateCNPJ', inputs, output, options);
        System.debug(output);
    }   
    @isTest    
    public static void mapKeysValues(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        Map<String, String> obj = new Map<String, String>();
        obj.put('name','nome');
        obj.put('value','valor');
        List<object> objectList = new List<object>();
        objectList.add((Object) obj);
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('mapKeysValues', inputs, output, options);
        System.debug(output);
    }   
    
    @isTest
    public static void testTrim(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        
        List<object> objectList = new List<object>();
        objectList.add('tes te');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('trim', inputs, output, options);
        System.assertEquals('teste', output.get('result'));
    }
    @isTest
    public static void testTranslatePickListValues() {
		Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        objectList.add('Order');
        objectList.add('Status');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('translatePickListValues', inputs, output, options);
        System.debug(output);
    }
    
    @isTest
    public static void replaceString() {
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        objectList.add('(21)99754-2130');
        objectList.add('(');
        objectList.add('');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('replaceString', inputs, output, options);
        System.assertEquals('21)99754-2130', output.get('result'));
    }
}