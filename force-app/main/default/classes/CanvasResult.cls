global class CanvasResult {

    @AuraEnabled
    public Boolean canOpenCanvas;

    @AuraEnabled
    public String message;

    @AuraEnabled
    public String canvasAppName;

    @AuraEnabled
    public Map<String,Object> parameters;
}