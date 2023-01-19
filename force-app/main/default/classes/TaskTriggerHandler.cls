public with sharing class TaskTriggerHandler {
    
    public static void PreventDeletionHDE(List<Task> lstTask, String profileId){

        for(Task task : lstTask){
            if(task.IsHDE__c == true){

                Profile currentProfile = ProfileDAO.getById(profileId);   

                if(currentProfile.Name != 'Administrador do sistema' && currentProfile.Name != 'System Administrator'
                && currentProfile.Name != 'Administracao' && currentProfile.Name != 'IntegracaoB2C'){

                    task.addError('Você não tem permissão para excluir a tarefa');
                }                
            }
        }
    }
}