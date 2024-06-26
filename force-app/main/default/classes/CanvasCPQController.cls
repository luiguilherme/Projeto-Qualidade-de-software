public with sharing class CanvasCPQController {
    
    @AuraEnabled
    public static CanvasResult getCanvasData(List<String> listRecordId, String tipoOferta){
        CanvasResult result = new CanvasResult();
        if (listRecordId.size() == 0){
            result.canOpenCanvas    = false;
            result.message          = 'Erro';
            return result;
        }

        // Id recordIdValue = Id.valueOf(recordId);

        CanvasService canvasService = new CanvasService(listRecordId[0], listRecordId);
        result.canvasAppName        = canvasService.getConnectedAppName();
        result.parameters           = canvasService.getParameters(tipoOferta);
        result.canOpenCanvas        = true;

        System.debug(result);
        return result;
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