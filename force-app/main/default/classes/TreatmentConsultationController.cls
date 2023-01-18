public with sharing class TreatmentConsultationController {

    @AuraEnabled(cacheable=true) 
    public static String getEnpoint(){
        Webservice__c wsConfig = Webservice__c.getInstance('GPSTreatmentConsultation');
        return wsConfig.Endpoint__c;
    }

}