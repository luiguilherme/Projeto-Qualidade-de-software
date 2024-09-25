public with sharing class CalculateSLAHourForServiceRequests {
    public static void execute(List<ServiceRequest__c> lstNew) {

        List<ServiceRequest__c> lLstCases = new List<ServiceRequest__c> ();
        //Set<String> lStatusCancel = new Set<String> { 'Não Iniciado', 'Aprovado', 'Encerrado', 'Reprovado', 'Cancelado' };
        Set<String> lStatusCancel = new Set<String> { 'NotStarted', 'Canceled' };
        Map<Id, ServiceRequest__c> lMapCaseById = new Map<Id, ServiceRequest__c> ();
        Set<String> lSetRecTypeIds = new Set<String> ();

        for (ServiceRequest__c serviceRequest : lstNew) {
           
            if (String.isBlank(serviceRequest.BusinessHoursId__c) || 
                 lStatusCancel.contains(serviceRequest.Status__c) || 
                 serviceRequest.ClosingDateTime__c != null ||
             (serviceRequest.DueDate__c != null && serviceRequest.ClosingDateTime__c == null)) { continue; }

            lMapCaseById.put(serviceRequest.Id, serviceRequest);
            lSetRecTypeIds.add(serviceRequest.RecordTypeId);
        }
        if (lMapCaseById.isEmpty()) { return; }

        if (!lMapCaseById.isEmpty()) { calculateWorkingTime(lMapCaseById, lSetRecTypeIds); }
    }





    private static void calculateWorkingTime(Map<Id, ServiceRequest__c> aMapCaseById, Set<String> aSetRecTypeIds) {
       
        List<RecordType> lLstRecType = new List<RecordType> ([SELECT Id, DeveloperName FROM RecordType WHERE Id = :aSetRecTypeIds]);
        Map<String, String> lMapRecType = new Map<String, String> ();
        for (RecordType iRecType : lLstRecType) { lMapRecType.put(iRecType.DeveloperName, iRecType.Id); }
system.debug(lMapRecType);
        Map<String, List<parameterSLA__c>> lMapParamSLA = StringBooleanEvaluate.getLstParameterSLA(lMapRecType);  
		system.debug(lMapParamSLA);
        if (lMapParamSLA.isEmpty()) { return; }

        Map<String, Map<String, Integer>> lMapMinutesByIdRegister = StringBooleanEvaluate.executeEvaluate(aMapCaseById.values(), lMapParamSLA);
        system.debug(lMapMinutesByIdRegister);
        if (lMapMinutesByIdRegister.isEmpty()) { return; }
        
        Map<String, Datetime> lMapTargetDateByRegister = new Map<String, Datetime> ();
        Map<String, Datetime> lMapNotificationDateByRegister = new Map<String, Datetime> ();
        Map<String, Id> lMapIdBusinessHourByCase= new Map<String, Id>();

        for (ServiceRequest__c serviceRequest : aMapCaseById.values()) {
            if (!lMapMinutesByIdRegister.containsKey(serviceRequest.Id)) {
                aMapCaseById.remove(serviceRequest.Id);
                continue;
            }
            lMapIdBusinessHourByCase.put(serviceRequest.Id, serviceRequest.BusinessHoursId__c);
            lMapTargetDateByRegister.put(serviceRequest.Id, System.now());
            lMapNotificationDateByRegister.put(serviceRequest.Id, System.now());
        }

        lMapTargetDateByRegister = CalculateWorkingTime.calculateTime(lMapTargetDateByRegister, lMapMinutesByIdRegister,lMapIdBusinessHourByCase, 'TargetDate');
        lMapNotificationDateByRegister = CalculateWorkingTime.calculateTime(lMapNotificationDateByRegister, lMapMinutesByIdRegister,lMapIdBusinessHourByCase, 'NotificationDate');

        if (lMapTargetDateByRegister.isEmpty()) { return; }

        for (ServiceRequest__c serviceRequest : aMapCaseById.values()) {
            Map<String, Integer> iMapSLATimer = lMapMinutesByIdRegister.get(serviceRequest.Id);
            Integer iQtdHourSLA = (iMapSLATimer.containsKey('TargetDate')) ? iMapSLATimer.get('TargetDate') : 0;
             iQtdHourSLA /= 60;

            Datetime iDateTarget = lMapTargetDateByRegister.get(serviceRequest.Id);
            serviceRequest.DueDate__c = iDateTarget;
            serviceRequest.SlaHours__c = iQtdHourSLA;
            serviceRequest.NotificationDate__c = lMapNotificationDateByRegister.get(serviceRequest.Id);
            serviceRequest.OpeningDateTime__c = (iDateTarget != null) ? System.now() : null;
        }
    }
   
}