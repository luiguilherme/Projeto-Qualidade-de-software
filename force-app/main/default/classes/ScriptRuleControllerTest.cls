@isTest
public class ScriptRuleControllerTest {
    
    @testSetup 
    static void setup(){
    	Account account = DataFactory.createAccount();
        insert account;
        
        Script__c automaticScript = DataFactory.createAutomaticScript();
        insert automaticScript;   
        
        ScriptRule__c scriptRule = DataFactory.createScriptRule(automaticScript.Id, 1, 'A');
        insert scriptRule;
    }
    
    @isTest
    public static void getAllObjectsDetails(){
        
        String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();

        Account account = [SELECT Id FROM Account LIMIT 1];
        
        List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
     
        Test.startTest(); 
        ScriptRuleController.getAllObjectsDetails();
       	Test.stopTest();
    }
	
	@isTest
    public static void getValuePicklistTest(){   
        
        String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();

        Account account = [SELECT Id FROM Account LIMIT 1];
        
        List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
        List<ScriptRule__c> scriptRule = [SELECT Id, FilterBy__c, Operator__c FROM ScriptRule__c WHERE Script__c =: automaticScript[0].Id LIMIT 1];
        
        ScriptRule__c scriptRuleToUpdate = new ScriptRule__c(
        	Id = scriptRule[0].Id,
        	FilterBy__c = 'none'   
        );
        update scriptRuleToUpdate;

		Test.startTest(); 
        ScriptRuleController.getValuePicklist();
       	Test.stopTest();        
        
   	}
    
    @isTest
    public static void setValuePicklistInMapTest(){
        
        String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();

        Account account = [SELECT Id FROM Account LIMIT 1];
        
        List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        
        List<ScriptRule__c> scriptRule = [SELECT Id, FilterBy__c, Operator__c FROM ScriptRule__c WHERE Script__c =: automaticScript[0].Id LIMIT 1];
        
        Test.startTest();
        
        ScriptRule__c scriptRuleToUpdate = new ScriptRule__c(
        	Id = scriptRule[0].Id,
        	FilterBy__c = 'none'   
        );
        update scriptRuleToUpdate;
        
        Test.stopTest();  
    
    }
   
    @isTest
    public static void saveScriptRulesTest(){
        
        String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();

        Account account = [SELECT Id FROM Account LIMIT 1];
        
        Script__c automaticScript = new Script__c(        
        Name = 'ScriptTest',
        StartDate__c = system.TODAY(),
        EndDate__c = system.TODAY(),
        Status__c = 'Draft',
        Message__c = 'Message',
        Priority__c = 1,
        Recurrent__c = 'No',
        RecordTypeId = automaticRecordType
        );
        insert automaticScript;
        
        List<Script__c> scriptCreated = [SELECT Id FROM Script__c WHERE RecordTypeId =: automaticRecordType AND Name = 'ScriptTest' LIMIT 1];
        
        Id scriptId = scriptCreated[0].Id;
        
        Test.startTest(); 
        
        ScriptRule__c scriptRule = new ScriptRule__c(
            Script__c = scriptCreated[0].Id,
        	RuleNumber__c = 1,
        	Object__c = 'conta',
        	Field__c = 'Nome',
        	Operator__c = 'startsWith',
        	Value__c = 'S',
        	ObjectAPI__c = 'Account',
       		FieldAPI__c = 'Name',
        	FilterBy__c = 'none'
		);
        
        map<Object, Object> mapScriptRule= new map<Object, Object>();
        
        mapScriptRule.put('numberRule', string.valueOf(scriptRule.RuleNumber__c));
        mapScriptRule.put('operatorScript', string.valueOf(scriptRule.Operator__c));
        mapScriptRule.put('objectAPI', string.valueOf(scriptRule.ObjectAPI__c));
        mapScriptRule.put('fieldScriptAPI', string.valueOf(scriptRule.FieldAPI__c));
        mapScriptRule.put('valueToCompare', string.valueOf(scriptRule.RuleNumber__c));
        mapScriptRule.put('filterScript', string.valueOf(scriptRule.FilterBy__c));
        
        List<map<Object, Object>> listScriptrule = new List<map<Object, Object>>();
        
        listScriptrule.add(mapScriptRule);
        
        ScriptRuleController.saveScriptRules(listScriptrule, scriptId);
       	
        Test.stopTest();

    }
    
    @isTest
    public static void saveScriptRulesTest1(){
        
        String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();

        Account account = [SELECT Id FROM Account LIMIT 1];
        
        Script__c automaticScript = new Script__c(        
        Name = 'ScriptTest',
        StartDate__c = system.TODAY(),
        EndDate__c = system.TODAY(),
        Status__c = 'Draft',
        Message__c = 'Message',
        Priority__c = 1,
        Recurrent__c = 'No',
        RecordTypeId = automaticRecordType
        );
        insert automaticScript;
        
        List<Script__c> scriptCreated = [SELECT Id FROM Script__c WHERE RecordTypeId =: automaticRecordType AND Name = 'ScriptTest' LIMIT 1];
        
        Id scriptId = scriptCreated[0].Id;
        
        List<scriptRule__c> listScriprule = new List<scriptRule__c>();
        
        Test.startTest(); 
        ScriptRuleController.saveScriptRules(listScriprule, scriptId);
       	Test.stopTest();

    }
    
    @isTest
    public static void getListNumberRulesActualScriptTest(){
        
        String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();

        Account account = [SELECT Id FROM Account LIMIT 1];
        
        List<Script__c> automaticScript = [SELECT Id, Name, Message__c, Logic__c, Status__c FROM Script__c WHERE RecordTypeId =: automaticRecordType LIMIT 1];
        Id scriptId = automaticScript[0].Id;
        
        Test.startTest(); 
        ScriptRuleController.getListNumberRulesActualScript(scriptId);
       	Test.stopTest(); 
    }
    
    @isTest
    public static void getListNumberRulesActualScriptTest1(){
        
        String automaticRecordType = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();

        Account account = [SELECT Id FROM Account LIMIT 1];
        
        Id scriptId;
        
        Test.startTest(); 
        ScriptRuleController.getListNumberRulesActualScript(scriptId);
       	Test.stopTest(); 
    }
    
   
    
}