public with sharing class TreatmentConsultationPreController {

    @AuraEnabled(cacheable=true) 
    public static String getEnpoint(){
        Webservice__c wsConfig = Webservice__c.getInstance('GpsCanvasConvergente');
        return wsConfig.Endpoint__c;
    }

}