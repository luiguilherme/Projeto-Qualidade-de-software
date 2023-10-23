public with sharing class TaskTriggerHandler {
    
    public static void PreventDeletionHDE(List<Task> lstTask, String profileId){

        for(Task task : lstTask){
            if(task.IsHDE__c == true){

                Profile currentProfile = ProfileDAO.getById(profileId);   

                if(currentProfile.Name != 'Administrador do sistema' && currentProfile.Name != 'System Administrator'
                && currentProfile.Name != 'AdministracaoSistema' && currentProfile.Name != 'IntegracaoSistema'){

                    task.addError('Você não tem permissão para excluir a tarefa');
                }                
            }
        }
    }
    
    Public static void ValidateCreateHDETask (List <Task> ListaHDETask) {
        
    	Set<Id> SetCaseId = new Set<Id>();
        
    	For (Task HDETask: ListaHDETask) {
            String whatId = HDETask.whatId ;
            if( (HDETask.IsHDE__c == True || HDETask.Subject == 'Tentativa de contato') && HDETask.whatID != Null && whatId.startsWith('500') ) {
               SetCaseId.add(HDETask.WhatId);
            }   
        }
        
		List<Case> caseList = [SELECT id, OwnerId FROM Case 
                               WHERE IsHDE__c = True AND id IN: SetCaseId ] ;
        
        Map <Id,Id> mapOwnerCaseId = new Map <Id,Id> () ;
        
        for ( Case caseHDE: caseList) {
            mapOwnerCaseId.put(caseHDE.Id,caseHDE.OwnerId);     
        }
        
        for ( Task HDETask: ListaHDETask){
            system.debug('TryTaskCreatedby ' +Userinfo.getuserId());
            system.debug('CaseOwnerId ' +mapOwnerCaseId.get(HDETask.whatId));
            if (Userinfo.getuserId() != mapOwnerCaseId.get(HDETask.whatId) ) {
                HDETask.AddError ('Somente o proprietário do Caso pode criar a Tarefa.');
            }
                 
           
        }
            
	}
}