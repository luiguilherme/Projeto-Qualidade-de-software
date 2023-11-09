/*
* Autor: Giovani de Souza - Deloitte
* Criado em: 05/11/2021
*/
@isTest
public class CustomFunctionServiceTest {
    
    @TestSetup
    static void setup(){ 
        // Árvore de palitagem 
        CustomerInteractionTopicTree__c topicTree = new CustomerInteractionTopicTree__c();
        topicTree.Name = 'Vivo';
        topicTree.Type__c = 'Pasta';
        insert topicTree;

        topicTree = new CustomerInteractionTopicTree__c();
        topicTree.Name = 'Palito 1';
        topicTree.Type__c = 'Palito';
        insert topicTree;

        // Palitagem automatica 
        TopicsAuto__c topicAuto = new TopicsAuto__c();
        topicAuto.TopicId__c = topicTree.Id;
        topicAuto.Process__c = 'Troca de Plano';
        topicAuto.Channel__c = 'Lojas Próprias';
        topicAuto.Status__c = 'Ativo';
        insert topicAuto;

        topicAuto = new TopicsAuto__c();
        topicAuto.TopicId__c = topicTree.Id;
        topicAuto.Process__c = 'Troca de Plano';
        topicAuto.Channel__c = 'Revenda';
        topicAuto.Status__c = 'Ativo';
        insert topicAuto;
    }
    
    @isTest
    public  static void testvalidateCEP(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        objectList.add('16200325');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('validateCEP', inputs, output, options);
        System.debug(output);
    }

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
    public static void validateOnlyTextFormat(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        objectList.add('Nome abc');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('validateOnlyTextFormat', inputs, output, options);
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
    public static void testformatDate(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        objectList.add('03/02/1975');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('formatDate', inputs, output, options);
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
    public static void testgetPickListKeyValues() {
		Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        objectList.add('Order');
        objectList.add('Status');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('getPickListKeyValues', inputs, output, options);
        System.debug(output);
    }  

    @isTest
    public static void testgetPickListLabelValues() {
		Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        objectList.add('Order');
        objectList.add('Status');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('getPickListLabelValues', inputs, output, options);
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

    @isTest
    public static void testReplaceBackslashTopicName() {
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        List<object> objectList = new List<object>();
        objectList.add('Pasta1\\Pasta2');
        inputs.put('arguments',objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('replaceBackslashTopicName', inputs, output, options);
        System.assertEquals('Pasta1' + String.fromCharArray( new integer[] { 92 }) + 'Pasta2', output.get('result'));
    }    

    @isTest
    public static void GetListRange(){
        
        list<Object> testeList = new list<Object> ();
        
        List<Object> accounts = new List<Object>();
        
        for(Integer index = 0; index < 3; index++){
            Account acc = new Account(Name='Account' + index);
            accounts.add(acc);
        }
        
        Map <String, Object> objectsMap =  new Map <String, Object>();
        objectsMap.put('Objects', accounts);
        
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        objectList.add(objectsMap);
        objectList.add(0);
        objectList.add(2);
        inputs.put('arguments', objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('GetListRange', inputs, output, options);
        
        List<Object> accountListResult =  new List<Object>();
        Map<String, Object> accountMapResult = new Map<String, Object>();
        
        accountListResult.add( accounts[0]);
        accountListResult.add( accounts[1]);
        accountMapResult.put('result',accountListResult);
        List<Object> outputResult = (List<Object>) output.get('result');
        
        System.assertEquals(accountListResult, outputResult);
        
    }
    
    @isTest
    public static void convertByteTest(){
        
		Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        objectList.add(104857600);
        objectList.add('B');
        objectList.add('MB');
        inputs.put('arguments', objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('convertByte', inputs, output, options);
        System.assertEquals(100, output.get('result'));
        
    }
    
    @isTest
    public static void getElementApiName(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        List<object> objectList = new List<object>();
        
        Account acct = new Account(Name='Test Account');
        insert acct;
        
        objectList.add(acct.id);
        inputs.put('arguments', objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('getElementApiName', inputs, output, options);
        
        System.assertEquals('Account', output.get('result'));
        
    }
    
    @isTest
    public static void removeValueFromList(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        Map<String,Object> menusMap = new Map<String,Object>();
        List<object> objectList = new List<object>();
        
        List<String> stringList = new List<String>();
        List<String> stringListToCompare = new List<String>(); 
        
        String valueA = 'A';
        String valueB = 'B';
        String valueC = 'C';
        
        stringList.add(valueC);
        stringList.add(valueA);
        stringList.add(valueB);
        stringList.add(valueC);
        
        stringListToCompare.add(valueA);
        stringListToCompare.add(valueB);
        
        menusMap.put('VLOCITY-FORMULA-LIST', stringList);

        objectList.add(menusMap);
        objectList.add(valueC);
        inputs.put('arguments', objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('removeValueFromList', inputs, output, options);
        
        System.assertEquals(output.get('result'), stringListToCompare);
    }

    @isTest
    public static void testgetPathTree(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        CustomerInteractionTopicTree__c topicTree = [SELECT Id FROM CustomerInteractionTopicTree__c WHERE Name = 'Palito 1'];

        List<object> objectList = new List<object>();
        objectList.add(topicTree.Id);

        inputs.put('arguments', objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('getPathTree', inputs, output, options);
        System.debug(output);
    } 

    @isTest
    public static void testgetPath(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        CustomerInteractionTopicTree__c topicTree = [SELECT Id FROM CustomerInteractionTopicTree__c WHERE Name = 'Palito 1'];

        List<object> objectList = new List<object>();
        objectList.add(topicTree.Id);

        inputs.put('arguments', objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('getPath', inputs, output, options);
        System.debug(output);
    }     

    @isTest
    public static void testGetChannelTotal(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        List<object> objectList = new List<object>();
        objectList.add('Troca de Plano');
        objectList.add('Lojas Próprias;Revenda');
        objectList.add(0);

        inputs.put('arguments', objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('getTotalChannels', inputs, output, options);
        System.debug(output);
        System.assertEquals(2, Integer.valueOf(output.get('result')));
    }   
    
    @isTest
    static void testGetLabel() {
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        List<object> objectList = new List<object>();
        objectList.add('ScheduleFound');

        inputs.put('arguments', objectList);
        
        CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('getLabel', inputs, output, options);
        System.debug(output);
        System.assert(output.get('result') != null);
    }
	
	@isTest
    static void testproperCase() {
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

		List<object> objectList = new List<object>();
        objectList.add('CAMILLA');

		inputs.put('arguments', objectList);

		CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('properCase', inputs, output, options);
        System.debug(output);
        System.assert(output.get('result') != null);
    }
	@isTest
    static void testgetUserInCommunity() {
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

		CustomFunctionService c = new CustomFunctionService();
        c.invokeMethod('getUserInCommunity', inputs, output, options);
        System.debug(output);
        System.assert(output.get('result') != null);
    }
}