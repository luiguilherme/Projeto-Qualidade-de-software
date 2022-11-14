@isTest
public class HandlerScriptNotificationTest {

    @testSetup 
    static void setup(){
        
        Account account = DataFactory.createAccount();
        insert account;
        
        Account address = new Account(
        Name = 'Test nome',
        ParentId = account.Id,
        ShippingCity = 'São Paulo'
        );
        insert address; 
        
        Script__c manualScript = DataFactory.createManualScript();
        insert manualScript;
        
        ScriptDetail__c scriptLog = DataFactory.createScripDetailLog(manualScript.Id, account.Id);
        insert scriptLog;
        
        Script__c automaticScript = DataFactory.createAutomaticScript();
        insert automaticScript;
        
        ScriptRule__c scriptRule = DataFactory.createScriptRule(automaticScript.Id, 1, 'A');
        insert scriptRule;
        
        ScriptRule__c scriptRule1 = DataFactory.createScriptRule(automaticScript.Id, 2, 'B');
        insert scriptRule1;
        
       }
    
    
    @isTest
    public static void getIdNotificationTest(){
        
        List<String> listParams = new List<String>();
       
        Account account = [SELECT Id FROM Account LIMIT 1];
        
        listParams.add(account.Id + ',' + UserInfo.getUserId());
        
        String manualRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('ManualWarning').getrecordTypeId();
        String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
        List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
      
        Script__c updateScript = new Script__c(
        	Id = automaticScript[0].Id,
        	Logic__c = '(1 AND 2)'
            );
        update updateScript; 
        
        Script__c updateScript1 = new Script__c(
        	Id = automaticScript[0].Id,
        	Status__c = 'Active'
            );
        update updateScript1;
        
        Test.startTest(); 
        HandlerScriptNotification.getIdNotification(listParams);
       	Test.stopTest();
   
    }
    @isTest
    public static void getScriptSpecificsTest(){
        
        String manualRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('ManualWarning').getrecordTypeId();
        
        Account account = [SELECT Id FROM Account LIMIT 1];
                
        Script__c manualScript = new Script__c(
        	Name = 'Script',
        	StartDate__c = system.TODAY(),
            EndDate__c = system.TODAY(),
            Status__c = 'Active',
            Message__c = 'Message',
            Priority__c = 1,
            Recurrent__c = 'No',
            RecordTypeId = manualRecordType
        );
        insert manualScript;
        
        List<Id> listScriptsIds = new List<Id>();
        
        for (ScriptDetail__c forScriptDetail : [SELECT Id FROM ScriptDetail__c WHERE Account__c =: account.Id]){
            listScriptsIds.add(forScriptDetail.Id);
        }

         Test.startTest(); 
        HandlerScriptNotification.getScriptSpecifics(listScriptsIds, account.Id);
       	Test.stopTest(); 
    }

    
    @isTest
    public static void validateFieldAccountTest(){
        
        Account account = [SELECT Id FROM Account LIMIT 1];
         
        String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
        List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
        ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'startsWith',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c'
            );

        insert scriptRule;
        
         Script__c updateScript = new Script__c(
        	Id = automaticScript[0].Id,
        	Logic__c = '(3)'
            );
        update updateScript; 
        
        Script__c updateScript1 = new Script__c(
        	Id = automaticScript[0].Id,
        	Status__c = 'Active'
            );
        update updateScript1;
        
        system.debug('scriptRule' + scriptRule);
        system.debug('account' + account);
        
		Test.startTest();
        HandlerScriptNotification.validateFieldAccount(account, scriptRule);
        Test.stopTest();
    
    }  
    
    @isTest
    public static void validateObjectRelationship(){
        
         Map<String, List<sObject>> mapObjectsRelationship = new Map<String, List<sObject>>();
        
         Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'startsWith',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'none'
            );
        insert scriptRule;
        
        Script__c updateScript = new Script__c(
        	Id = automaticScript[0].Id,
        	Logic__c = '(3)'
            );
        update updateScript; 
        
        Script__c updateScript1 = new Script__c(
        	Id = automaticScript[0].Id,
        	Status__c = 'Active'
            );
        update updateScript1;
        
        List<Account> listAddress = mapObjectsRelationship.put(scriptRule.ObjectAPI__c, [SELECT Id, ShippingCity FROM Account WHERE ParentId =: account.Id]);    

        Test.startTest();
        HandlerScriptNotification.validateObjectRelationship(mapObjectsRelationship, scriptRule);
        Test.stopTest();
    }
    
    @isTest
    public static void validateObjectRelationship1(){
        Map<String, List<sObject>> mapObjectsRelationship = new Map<String, List<sObject>>();
        
         Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'startsWith',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'oneRecord'
            );
        insert scriptRule;
        
        Script__c updateScript = new Script__c(
        	Id = automaticScript[0].Id,
        	Logic__c = '(3)'
            );
        update updateScript; 
        
        Script__c updateScript1 = new Script__c(
        	Id = automaticScript[0].Id,
        	Status__c = 'Active'
            );
        update updateScript1;
        
        List<Account> listAddress = mapObjectsRelationship.put(scriptRule.ObjectAPI__c, [SELECT Id, ShippingCity FROM Account WHERE ParentId =: account.Id]);    

        Test.startTest();
        HandlerScriptNotification.validateObjectRelationship(mapObjectsRelationship, scriptRule);
        Test.stopTest();
    }
    
    @isTest
    public static void validateObjectRelationship2(){
        Map<String, List<sObject>> mapObjectsRelationship = new Map<String, List<sObject>>();
        
         Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'startsWith',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'allRecords'
            );
        insert scriptRule;
        
        Script__c updateScript = new Script__c(
        	Id = automaticScript[0].Id,
        	Logic__c = '(3)'
            );
        update updateScript; 
        
        Script__c updateScript1 = new Script__c(
        	Id = automaticScript[0].Id,
        	Status__c = 'Active'
            );
        update updateScript1;
        
        List<Account> listAddress = mapObjectsRelationship.put(scriptRule.ObjectAPI__c, [SELECT Id, ShippingCity FROM Account WHERE ParentId =: account.Id]);    

        Test.startTest();
        HandlerScriptNotification.validateObjectRelationship(mapObjectsRelationship, scriptRule);
        Test.stopTest();
    }
    
    @isTest
    public static void executeValidateTest(){
        
        Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'startsWith',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'allRecords'
            );
        insert scriptRule;
        
        String field = scriptRule.FieldAPI__c;
        String value = scriptRule.Value__c;
        String operator = scriptRule.Operator__c;
        
         Test.startTest();
        HandlerScriptNotification.executeValidate(field, value, operator);
        Test.stopTest();
        
    }
    
    @isTest
    public static void executeValidateTest1(){
        
        Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'contains',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'allRecords'
            );
        insert scriptRule;
        
        String field = scriptRule.FieldAPI__c;
        String value = scriptRule.Value__c;
        String operator = scriptRule.Operator__c;
        
         Test.startTest();
        HandlerScriptNotification.executeValidate(field, value, operator);
        Test.stopTest();
        
    }
    
    @isTest
    public static void executeValidateTest2(){
        
        Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'doesNotContains',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'allRecords'
            );
        insert scriptRule;
        
        String field = scriptRule.FieldAPI__c;
        String value = scriptRule.Value__c;
        String operator = scriptRule.Operator__c;
        
         Test.startTest();
        HandlerScriptNotification.executeValidate(field, value, operator);
        Test.stopTest();
        
    }
    
    @isTest
    public static void executeValidateTest3(){
        
        Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'equals',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'allRecords'
            );
        insert scriptRule;
        
        String field = scriptRule.FieldAPI__c;
        String value = scriptRule.Value__c;
        String operator = scriptRule.Operator__c;
        
         Test.startTest();
        HandlerScriptNotification.executeValidate(field, value, operator);
        Test.stopTest();
        
    }
    
    @isTest
    public static void executeValidateTest4(){
        
        Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'notEqualsTo',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'allRecords'
            );
        insert scriptRule;
        
        String field = scriptRule.FieldAPI__c;
        String value = scriptRule.Value__c;
        String operator = scriptRule.Operator__c;
        
         Test.startTest();
        HandlerScriptNotification.executeValidate(field, value, operator);
        Test.stopTest();
        
    }
    
     @isTest
    public static void executeValidateTest5(){
        
        Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'greaterOrEqual',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'allRecords'
            );
        insert scriptRule;
        
        String field = scriptRule.FieldAPI__c;
        String value = scriptRule.Value__c;
        String operator = scriptRule.Operator__c;
        
         Test.startTest();
        HandlerScriptNotification.executeValidate(field, value, operator);
        Test.stopTest();
        
    }
    
     @isTest
    public static void executeValidateTest6(){
        
        Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'greaterThan',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'allRecords'
            );
        insert scriptRule;
        
        String field = scriptRule.FieldAPI__c;
        String value = scriptRule.Value__c;
        String operator = scriptRule.Operator__c;
        
         Test.startTest();
        HandlerScriptNotification.executeValidate(field, value, operator);
        Test.stopTest();
        
    }
    
     @isTest
    public static void executeValidateTest7(){
        
        Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'lessOrEqual',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'allRecords'
            );
        insert scriptRule;
        
        String field = scriptRule.FieldAPI__c;
        String value = scriptRule.Value__c;
        String operator = scriptRule.Operator__c;
        
         Test.startTest();
        HandlerScriptNotification.executeValidate(field, value, operator);
        Test.stopTest();
        
    }
    
     @isTest
    public static void executeValidateTest8(){
        
        Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'lessThan',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'allRecords'
            );
        insert scriptRule;
        
        String field = scriptRule.FieldAPI__c;
        String value = scriptRule.Value__c;
        String operator = scriptRule.Operator__c;
        
         Test.startTest();
        HandlerScriptNotification.executeValidate(field, value, operator);
        Test.stopTest();
        
    }
    
     @isTest
    public static void executeValidateTest9(){
        
        Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'itHas',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'allRecords'
            );
        insert scriptRule;
        
        String field = scriptRule.FieldAPI__c;
        String value = scriptRule.Value__c;
        String operator = scriptRule.Operator__c;
        
         Test.startTest();
        HandlerScriptNotification.executeValidate(field, value, operator);
        Test.stopTest();
        
    }
    
    @isTest
    public static void executeValidateTest10(){
        
        Account account = [SELECT Id FROM Account LIMIT 1];
        
         String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();
        
         List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
         ScriptRule__c scriptRule = new ScriptRule__c(
        	Script__c = automaticScript[0].Id,
       		RuleNumber__c = 3,
        	Object__c = 'Endereço',
        	Field__c = 'Cidade',
        	Operator__c = 'doesntHave',
        	Value__c = 'S',
        	ObjectAPI__c = 'Address__c',
        	FieldAPI__c = 'City__c',
            FilterBy__c = 'allRecords'
            );
        insert scriptRule;
        
        String field = scriptRule.FieldAPI__c;
        String value = scriptRule.Value__c;
        String operator = scriptRule.Operator__c;
        
        Test.startTest();
        HandlerScriptNotification.executeValidate(field, value, operator);
        Test.stopTest();
        
    }
    
    @isTest
    public static void createLogOfScript(){
       
        String manualRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('ManualWarning').getrecordTypeId();
        String logRecordType = Schema.SObjectType.ScriptDetail__c.getRecordTypeInfosByDeveloperName().get('WarningLogs').getrecordTypeId();
        
        Account account = [SELECT Id FROM Account LIMIT 1];
        
        List<Script__c> manualScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: manualRecordType LIMIT 1];
        
        ScriptDetail__c scriptDetail = new ScriptDetail__c(
        Script__c = manualScript[0].Id,
        Account__c = account.Id,
        Name = 'Detalhe Script',
        Verbalized__c = False,
        RecordTypeId = logRecordType
		);
        insert scriptDetail;
        
       List<String> listParams = new List<String>();
        
        listParams.add(account.Id + ',' + UserInfo.getUserId());
       
        List<String> listScriptId = new List<String>();
        
        for(Script__c forScript : [SELECT Id FROM Script__c]){
            listScriptId.add(forScript.Id);
        }
        
        
        Test.startTest();
        HandlerScriptNotification.createLogOfScript(listScriptId, account.Id, UserInfo.getUserId());
        Test.stopTest();
        
    }
    
}