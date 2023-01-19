trigger TaskTrigger on Task (before delete) {

    if(Trigger.isBefore){

        if(Trigger.isDelete){
            TaskTriggerHandler.PreventDeletionHDE(Trigger.old, UserInfo.getProfileId());
        }

    }

}