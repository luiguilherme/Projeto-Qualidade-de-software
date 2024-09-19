/** 
* @author Ronan Michel
* @company Everis do Brasil 
* @description Trigger do Objeto ParameterSLA__c
*/
trigger ParameterSLATrigger on ParameterSLA__c (after delete, after insert, after update, before delete, before insert, before update){
  TriggerFactory.createHandler(ParameterSLA__c.sObjectType);
   
  //TriggerFactory.createHandlerByRecordType(ParameterSLA__c.sObjectType);
}