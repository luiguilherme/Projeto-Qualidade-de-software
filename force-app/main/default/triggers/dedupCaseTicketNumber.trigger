/* -------------------------------------------------------------------------
* Autor....: Guilherme Kaiser - Deloitte
* Projeto..: Vivo - VALENTINA
* Descrição: trigger para não permitir incluir ticket de portabilidade
*            repetido para o recordType Bilhete de Portabilidade.
* Data.....: 19/04/2024
*  -------------------------------------------------------------------------
* Alterações:
*/
trigger dedupCaseTicketNumber on Case (before insert, before update) {
    Id TicketPortabilityRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Bilhete de Portabilidade').getRecordTypeId();
    List<Case> lstCase = new List<Case>();

    if(Trigger.new != null) {
        lstCase = Trigger.new;
    } else if(Trigger.old != null){
        lstCase = Trigger.old;
    }
    
    for (Case myCase : lstCase) {   
    if (myCase.TicketNumber__c != null && myCase.RecordtypeId == TicketPortabilityRecordTypeId) {     
      List<Case> dup = [SELECT Id FROM Case WHERE Id!= :myCase.Id and TicketNumber__c = :myCase.TicketNumber__c and RecordtypeId = :TicketPortabilityRecordTypeId];
      if (dup.size() > 0) {
        myCase.addError('Bilhete de Portabilidade '+ myCase.TicketNumber__c +' já está atribuido em outro Caso.');
      }                             
    }
  }
}