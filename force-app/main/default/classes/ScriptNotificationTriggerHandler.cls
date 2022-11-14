/**
	* @authors - Marcos Santos 
	* @company - everis 
	* @date - 27/08/2020
	* @description - Classe handler da ScriptTrigger
	*
	* Changes
	* 21/10/2020 @Marina Hessel B2C7551-287 - Criação método validateScriptTypeActiveUnique 
											  que valida a existência de apenas um fluxo ativo de suporte à vendas
**/

public with sharing class ScriptNotificationTriggerHandler {
    
    public static void validateUpdateOfScriptRecord(){
        if(Trigger.isAfter || !Trigger.isUpdate){ return; }
        string customLabel = System.Label.LogicScriptValidation;
        List<Script__c> lLstScripts = new List<Script__c>();
        for(Script__c iScript : (List<Script__c>) Trigger.new){
            Script__c lOldScript = (Script__c) Trigger.oldMap.get(iScript.Id);
            if(getDeveloperNameByRecordId(iScript.RecordTypeId, 'Script__c') != 'AutomaticWarning' || iScript.Status__c != 'Active'){ continue; }
            lLstScripts.add(iScript);
        }

        if(lLstScripts.isEmpty()){ return;}

        Map<Id, Script__c> mapScriptAndScriptRule = new map<Id, Script__c>([SELECT Id, Logic__c, RecordTypeId, Status__c, (SELECT Id, RuleNumber__c FROM Regras_do_Script__r) FROM Script__c WHERE Id IN : lLstScripts]);

        if(mapScriptAndScriptRule.isEmpty()){ return;}

        for(Script__c objScript : lLstScripts){
            if(!mapScriptAndScriptRule.containsKey(objScript.Id)){ continue; }
            Script__c objScriptWithScriptRule = mapScriptAndScriptRule.get(objScript.Id);
            objScriptWithScriptRule.Logic__c = objScript.Logic__c;
            if(HandlerScriptNotification.validateFieldLogic(objScriptWithScriptRule)){ continue; }
            objScript.addError(customLabel); 
        }
    }

    public static String getDeveloperNameByRecordId(String idRecordId, String strObjeto){
        if(String.isBlank(idRecordId) || String.isBlank(strObjeto)){ return ''; }
        try{ return Schema.getGlobalDescribe().get(strObjeto).getDescribe().getRecordTypeInfosById().get(idRecordId).getDeveloperName();}
        catch(Exception e) { return ''; }
    }
    
    
    public static void validateScriptTypeActiveUnique(List<Script__c> newListScript, Map<Id,Script__c> oldMap){
        if(Trigger.isAfter){ return;}
        
        Set<Id> setIdScript = new Set<Id>();
        
        string customLabel = System.Label.ScriptTypeActiveUnique;
        String recordTypeId = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('Flow').getrecordTypeId();
        
        
        for(Script__c forscript : newListScript){
            if(forscript.Status__c == 'Active' && forscript.Type__c == 'SalesSupport' && forscript.RecordTypeId == recordTypeId){
                if(Trigger.IsInsert){
                	setIdScript.add(forscript.Id); 
            	}
                if(Trigger.IsUpdate){
                   if(forscript.Status__c != oldMap.get(forscript.Id).Status__c || forscript.Type__c != oldMap.get(forscript.Id).Type__c){
                	setIdScript.add(forscript.Id);
            		}
           	 	} 
          	}
        }
            
        if(setIdScript.isEmpty()){ return;}
        
        List<Script__c> listScript = [SELECT Id, Status__c, Type__c 
                                      FROM Script__c 
                                      WHERE Status__c = 'Active' 
                                      AND Type__c = 'SalesSupport'
                                      AND RecordTypeId =: recordTypeId];
         
        if(listScript.isEmpty()){ return;}
        
        for(Script__c forscriptError : (List<Script__c>) Trigger.new){
            forscriptError.addError(customLabel);
        }
    }
}