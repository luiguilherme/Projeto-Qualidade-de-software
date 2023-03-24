public without sharing class CTIServiceIntegrationController {
    @AuraEnabled
    public static String createCTICase(String CTICase, String recordTypeCase, String caseId, String note){
       return CTIServiceIntegrationService.createCTICase(CTICase, recordTypeCase, caseId, note);
    }

    @AuraEnabled
    public static void closeCTITransferCase(String caseId, String protocol){
        CTIServiceIntegrationService.closeCTITransferCase(caseId, protocol);
    }
}