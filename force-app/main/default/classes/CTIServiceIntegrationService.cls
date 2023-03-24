public with sharing class CTIServiceIntegrationService {
    public static String createCTICase(String CTICase, String recordTypeCase , String caseId, String note){
        return CTIServiceIntegrationEngine.createCTICase(CTICase, recordTypeCase, caseId, note);
    }

    public static void closeCTITransferCase(String caseId, String protocol) {
        CTIServiceIntegrationEngine.closeCTITransferCase(caseId, protocol); 
    }
}