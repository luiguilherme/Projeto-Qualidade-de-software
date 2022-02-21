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
        objectList.add('31.326.686/0001-39');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('validateCNPJ', inputs, output, options);
        System.debug(output);
    }        
    
}