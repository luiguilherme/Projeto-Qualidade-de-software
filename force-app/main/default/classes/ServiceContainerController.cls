public class ServiceContainerController {

    @AuraEnabled
    public static Map<String, Boolean> haveAccessToFlow(Id userId){
        try {
            return ServiceQualificationService.haveAccessToFlow(userId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    @AuraEnabled
    public static List<Asset> getAssetsByAccount(Id accountId) {
        try {
            return ServiceQualificationService.getAssetsByAccount(accountId);
        }   catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<FromToMapping__mdt> getServiceTreeIdentifier(String userRole) {   
        return ServiceQualificationService.getServiceTreeIdentifier(userRole);
    }

    @AuraEnabled
    public static User getUserById(Id userId) {
        return ServiceQualificationService.getUserById(userId);
    }
    
    @AuraEnabled
    public static void createCase(String accountId, String caseIdUra){
        try {
            ServiceFlowGPSService.createCase(accountId, caseIdUra);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static CanvasResult getCanvasData(String recordId, String serviceFlowId, String assetInstance, String caseId){
        try {
            return ServiceFlowGPSService.getCanvasParameters(recordId, serviceFlowId, assetInstance, caseId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Case getOrCreateCase(Map<String, String> payload) {
        try {
            return ServiceFlowGPSService.getOrCreateCase(payload);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Case getCaseById(String caseId) {
        try {
            return CaseDAO.getCasebyId(caseId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Map<String, Object> getMobileServiceQualifications(String serviceTree) {
        try {
            return ServiceQualificationService.getServiceFlow('Mobile', serviceTree);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}