trigger ClusterTrigger on Cluster__c (before insert, before update) {
        if (trigger.isBefore) 
        {
            if (Trigger.isInsert) {
                ClusterMethods.insertCluster(trigger.new);
            }
           	if (Trigger.isUpdate) {
                ClusterMethods.updateCluster(trigger.new);
            }
        }
}