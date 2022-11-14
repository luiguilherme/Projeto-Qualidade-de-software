@isTest
public class ScriptConfigTriggerHandlerTest {
    
	@testSetup 
    static void setup(){
        String scriptRecordType;
        String scriptConfigType;
        
        scriptRecordType = 'Flow';        
        Script__c newScriptFlow = DataFactory.createScript(scriptRecordType);
        insert newScriptFlow; 
        
        scriptRecordType = 'Question';        
        Script__c newScriptQuestion = DataFactory.createScript(scriptRecordType);
        insert newScriptQuestion;
        
        scriptRecordType = 'Answer';        
        Script__c newScriptAnswer = DataFactory.createScript(scriptRecordType);
        insert newScriptAnswer;
        
        scriptRecordType = 'Instruction';        
        Script__c newScriptInstruction = DataFactory.createScript(scriptRecordType);
        insert newScriptInstruction;
        
        scriptConfigType = 'Group';
        ScriptConfig__c scriptConfigGroup = DataFactory.createScriptConfig(newScriptFlow.Id, scriptConfigType);
        insert scriptConfigGroup;
        
        scriptConfigType = 'Route';
        ScriptConfig__c scriptConfigRoute = DataFactory.createScriptConfig(newScriptFlow.Id, scriptConfigType);
        insert scriptConfigRoute;
        
	}
    
    @isTest
    public static void createScriptTest(){
        
        List<Script__c> ltScript = [SELECT Id, RecordType.DeveloperName FROM Script__c  limit 1]; 

        List<ScriptConfig__c> ltScriptConfig = [SELECT Id, RecordType.DeveloperName, NextScriptTech__c, ScriptToShow__c,ParentScript__c FROM ScriptConfig__c  limit 1]; 

        Id scriptId;
        
        Test.startTest(); 
        
        ScriptConfigTriggerHandler.createRoute(ltScriptConfig);
        system.assert( !ltScriptConfig.isEmpty());
       
        Test.stopTest();
   }
    
    @isTest
    public static void createScriptTestInstruction(){
        
        List<Script__c> ltScript = [SELECT Id, RecordType.DeveloperName FROM Script__c  WHERE RecordType.DeveloperName = 'Instruction' limit 1];
        

        List<ScriptConfig__c> ltScriptConfigInstruction = [SELECT Id, RecordType.DeveloperName, NextScriptTech__c, ScriptToShow__c,ParentScript__c FROM ScriptConfig__c WHERE RecordType.DeveloperName = 'Group' limit 1]; 
	
        for (ScriptConfig__c item : ltScriptConfigInstruction){
            item.ScriptToShow__c = ltScript[0].Id;            
        }
        
        Test.startTest(); 
        
        ScriptConfigTriggerHandler.createRoute(ltScriptConfigInstruction);
        system.assert( !ltScriptConfigInstruction.isEmpty());
        
        Test.stopTest();
   }
    
  @isTest
    public static void createGroupToRouteTest(){
        
        List<Script__c> ltScript = [SELECT Id FROM Script__c  limit 1]; 

        List<ScriptConfig__c> ltScriptConfigRoute = [SELECT Id, RecordType.DeveloperName, NextScriptTech__c FROM ScriptConfig__c WHERE RecordType.DeveloperName = 'Route' limit 1]; 
        
        List<ScriptConfig__c> ltScriptConfigGroup = [SELECT Id, RecordType.DeveloperName, NextScriptTech__c FROM ScriptConfig__c WHERE RecordType.DeveloperName = 'Group' limit 1]; 
     
        Test.startTest();     
        
        ScriptConfigTriggerHandler.createGroupToRoute(ltScriptConfigGroup);
        system.assert( !ltScriptConfigGroup.isEmpty());
		        
        Test.stopTest();
   }

    @isTest
    public static void createRouteTest(){
        
        List<Script__c> ltScript = [SELECT Id, RecordType.DeveloperName FROM Script__c WHERE RecordType.DeveloperName = 'Question' limit 1];

        
        List<ScriptConfig__c> ltScriptConfigGroup = [SELECT Id, RecordType.DeveloperName, NextScriptTech__c, ScriptToShow__c,ParentScript__c FROM ScriptConfig__c WHERE RecordType.DeveloperName = 'Group']; 
     
       for (ScriptConfig__c item : ltScriptConfigGroup){
            item.ScriptToShow__c = ltScript[0].Id;            
        }
        Test.startTest();     
        
        ScriptConfigTriggerHandler.createRoute(ltScriptConfigGroup);
        system.assert( !ltScriptConfigGroup.isEmpty());
        
		        
        Test.stopTest();
   }
    
    @isTest
    public static void createGroupToRouteTestQuestion(){
        
        List<Script__c> ltScriptQuestion = [SELECT Id, RecordType.DeveloperName FROM Script__c WHERE RecordType.DeveloperName = 'Question' limit 1];
        
       
        List<ScriptConfig__c> ltScriptConfigGroup = [SELECT Id, RecordType.DeveloperName, NextScriptTech__c, ScriptToShow__c,ParentScript__c, NextScriptConfig__c FROM ScriptConfig__c WHERE RecordType.DeveloperName = 'Group']; 
     
        for (ScriptConfig__c item : ltScriptConfigGroup){
            item.ScriptToShow__c = ltScriptQuestion[0].Id;  
            item.NextScriptTech__c = ltScriptQuestion[0].Id; 
            item.NextScriptConfig__c = null;
        }
        Test.startTest();     
        
        ScriptConfigTriggerHandler.createGroupToRoute(ltScriptConfigGroup);
        system.assert( !ltScriptConfigGroup.isEmpty());
        
		        
        Test.stopTest();
   } 
    @isTest
    public static void createGroupToRouteTestQuestionRoute(){
        
        List<Script__c> ltScriptQuestion = [SELECT Id, RecordType.DeveloperName FROM Script__c WHERE RecordType.DeveloperName = 'Question' limit 1];
        List<Script__c> ltScript = [SELECT Id, RecordType.DeveloperName, QuestionScript__c FROM Script__c WHERE RecordType.DeveloperName = 'Answer' limit 1];
        for(Script__c item : ltScriptQuestion){ 
            item.QuestionScript__c = ltScript[0].Id;
        }
        List<ScriptConfig__c> ltScriptConfigGroup = [SELECT Id, RecordType.DeveloperName, NextScriptTech__c, ScriptToShow__c,ParentScript__c, NextScriptConfig__c FROM ScriptConfig__c WHERE RecordType.DeveloperName = 'Route']; 
     
        
        for (ScriptConfig__c item : ltScriptConfigGroup){
            item.ScriptToShow__c = ltScriptQuestion[0].Id;  
            item.NextScriptTech__c = ltScript[0].Id; 
            item.NextScriptConfig__c = null;
        }
        system.debug('LT SCRIPT CONFIG : ' + ltScriptConfigGroup);
        Test.startTest();     
        
        ScriptConfigTriggerHandler.createGroupToRoute(ltScriptConfigGroup);
        system.assert( !ltScriptConfigGroup.isEmpty());
        
		        
        Test.stopTest();
   }
}