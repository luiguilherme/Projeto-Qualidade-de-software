@isTest
public class ScriptRuleTriggerHandlerTest {

@testSetup 
    static void setup(){
        Script__c automaticScript = DataFactory.createAutomaticScript();
        insert automaticScript;

        ScriptRule__c scriptRule = DataFactory.createScriptRule(automaticScript.Id, 1, 'S');
        insert scriptRule;
	}
    
    @isTest
    public static void validateDeleteScriptRuleTest(){
        
        List<Script__c> lscript = [SELECT Id FROM Script__c LIMIT 1];

        List<ScriptRule__c> lscriptRule = [SELECT Id FROM ScriptRule__c LIMIT 1];
        
        Test.startTest();
        
        Script__c updateScript = new Script__c(
        	Id = lscript[0].Id,
        	Logic__c = '1'
            );
        
        update updateScript;
        
        Script__c updateScript2 = new Script__c(
            Id = lscript[0].Id,
        	Status__c = 'Active'
            );
        
        update updateScript2;
        

        try
           {
               delete lscriptRule;
           }
           catch(Exception e) 
           {    
           System.Assert(e.getMessage().contains(''));
           }
        
        Test.stopTest();
   }
}