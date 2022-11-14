@isTest
public class ScriptNotificationTriggerHandlerTest {

    @testSetup 
    static void setup(){
        Script__c script = DataFactory.createAutomaticScript();
        insert script;

        ScriptRule__c scriptRule = DataFactory.createScriptRule(script.Id, 1, 'S');
        insert scriptRule;

   }
    
    @isTest
    public static void validateUpdateOfScriptRecordTest(){
        
        string customLabel = System.Label.LogicScriptValidation;
        
        List<Script__c> lscript = [SELECT Id FROM Script__c LIMIT 1];
        
        system.debug('lscript' + lscript);
        
        List<ScriptRule__c> lscriptRule = [SELECT Id FROM ScriptRule__c LIMIT 1];
        
        system.debug('lscriptRule' + lscriptRule);
        
        Script__c updateScript = new Script__c(
        	Id = lscript[0].Id,
        	Logic__c = '1',
            Status__c = 'Active'
            );
        update updateScript;
        
         Script__c updateScript1 = new Script__c(
        	Id = lscript[0].Id,
        	Logic__c = '',
            Status__c = 'Active'
            );
        
        try
           {
             update updateScript1;  
           }
           catch(Exception e) 
           {    
           System.Assert(e.getMessage().contains(customLabel));
           }
   
    }
    
    @isTest
    public static void getDeveloperNameByRecordId(){
        
        List<Script__c> lscript = [SELECT Id FROM Script__c LIMIT 1];
        
        String ScriptId = lscript[0].Id;
        
       List<ScriptRule__c> lscriptRule = [SELECT Id FROM ScriptRule__c LIMIT 1];
        
       ScriptRule__c updateScriptRule = new ScriptRule__c(
            Id = lscriptRule[0].Id,
        	ObjectAPI__c = 'AccountTest'
            );
       
        String objectAPI = updateScriptRule.ObjectAPI__c;
        
        Test.startTest(); 
        ScriptNotificationTriggerHandler.getDeveloperNameByRecordId(ScriptId, objectAPI);
       	Test.stopTest();
    }
    
    @isTest
    public static void validateScriptTypeActiveUniqueTest(){
        string customLabel = System.Label.ScriptTypeActiveUnique;
        
        Script__c script = DataFactory.createScriptFlow();
        script.Status__c = 'Active';
        insert script;
        
        Script__c script2 = DataFactory.createScriptFlow();
        script2.Status__c = 'Active';
        
        Test.startTest(); 
        try
           {
             insert script2;
           }
           catch(Exception e) 
           {    
           System.Assert(e.getMessage().contains(customLabel));
           }
        
        

	}

}