trigger ServiceRequestTrigger on ServiceRequest__c (after update) {
    List<id> serviceRequestsToProcess = new List<id>();
    RecordType rt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Tsuru' AND SObjectType = 'ServiceRequest__c' LIMIT 1];

    for (ServiceRequest__c sr : Trigger.new) {
        ServiceRequest__c oldRecord = Trigger.oldMap.get(sr.Id);
        if (sr.Status__c != oldRecord.Status__c) { System.debug(sr.RecordTypeId);
            // Verificar se o RecordType é "HandlingInconsistencies"
            if (sr.RecordTypeId== rt.id &&
                (sr.Status__c == 'InProgress' || sr.Status__c == 'Canceled' || sr.Status__c == 'AnalysisComplete')) {
                system.System.debug('entrou');
                serviceRequestsToProcess.add(sr.id);
            }
        }
    }
    
    if (!serviceRequestsToProcess.isEmpty()) {
        ServiceRequestsHandler.processServiceRequests(serviceRequestsToProcess);
    }
}