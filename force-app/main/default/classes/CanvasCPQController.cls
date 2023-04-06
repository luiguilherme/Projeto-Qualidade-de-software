public with sharing class CanvasCPQController {
    
    @AuraEnabled
    public static CanvasResult getCanvasData(String recordId){
        CanvasResult result = new CanvasResult();

        if (String.isBlank(recordId)){
            result.canOpenCanvas    = false;
            result.message          = 'Erro';
            return result;
        }

        Id recordIdValue = Id.valueOf(recordId);

        CanvasService canvasService = new CanvasService(recordIdValue);
        result.canvasAppName        = canvasService.getConnectedAppName();
        result.parameters           = canvasService.getParameters();
        result.canOpenCanvas        = true;

        System.debug(result);
        return result;
    }

    @AuraEnabled
    public static Asset getAssetData(String assetName) {
        try {
            return AssetDAO.getAssetDataByName(assetName);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class CanvasResult {
        @AuraEnabled
        public Boolean canOpenCanvas;

        @AuraEnabled
        public String message;

        @AuraEnabled
        public String canvasAppName;

        @AuraEnabled
        public Map<String,Object> parameters;
    }
}