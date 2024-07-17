trigger TaskTrigger on Task (before delete, before insert) {

    if(Trigger.isBefore){

        if(Trigger.isDelete){
            TaskTriggerHandler.PreventDeletionHDE(Trigger.old, UserInfo.getProfileId());
        }

    }
    
    if (Trigger.IsInsert && Trigger.Isbefore){
                TaskTriggerHandler.ValidateCreateHDETask(Trigger.new);     
            }

}