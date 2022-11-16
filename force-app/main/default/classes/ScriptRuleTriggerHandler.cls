public with sharing class ScriptRuleTriggerHandler {
    
    public static void validateDeleteScriptRule(){
        if(Trigger.isAfter || !Trigger.isDelete){ return;}
        
        string customLabel = System.Label.ScriptRuleDelete;
        
        Set<Id> setIdScript = new Set<Id>();
        Set<Id> setIdScriptActive = new Set<Id>();
        
        for(ScriptRule__c forscriptRule : (List<ScriptRule__c>) Trigger.old){
            setIdScript.add(forscriptRule.Script__c);
     	}

        if(setIdScript.isEmpty()){ return;}
        List<Script__c> listScript = [SELECT Id, Status__c FROM Script__c WHERE Id =: setIdScript];

        for(Script__c forScript : listScript){
        	if(forScript.Status__c == 'Active'){
				setIdScriptActive.add(forScript.Id);
            }
        }
        
        if(setIdScriptActive.isEmpty()){ return;}
        for(ScriptRule__c forscriptRuleError : (List<ScriptRule__c>) Trigger.old){
		   		forscriptRuleError.addError(customLabel);
        }
     }       
}