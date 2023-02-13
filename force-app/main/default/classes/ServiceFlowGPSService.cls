/*
*
*   Description: Classe responsável pelos serviços disponíveis para o Fluxo de Atendimento do GPS
*
*   Author: Geimison Oliveira
*   Date:   15/06/2021
*
*/
public with sharing class ServiceFlowGPSService {
    /*
    * Retorno:
    *   Key | Tipo | Descrição
    *   'firstLevel'    | List<ItemTreeTO>    | Lista com todos o Fluxo ativos para o primeiro nível de tipificação
    *   'secondLevel'   | List<ItemTreeTO>    | Lista com todos o Fluxo ativos para o segundo nível de tipificação
    *   'thirdLevel'    | List<ItemTreeTO>    | Lista com todos o Fluxo ativos para o terceiro nível de tipificação
    *   'fourthLevel'   | List<ItemTreeTO>    | Lista com todos o Fluxo ativos para o quarto nível de tipificação
    */ 
    public static Map<String, Object> getServiceFlow(String pageReference) {
        return ServiceFlowGPSEngine.getServiceFlow(pageReference);
    }

    public static Map<String, Object> getActionGPS(String serviceFlowId, String assetInstance) {
        return ServiceFlowGPSEngine.getActionGPS(serviceFlowId, assetInstance);
    }

    public static Map<String, Object> getNextGroup(String currentGroup) {
        return ServiceFlowGPSEngine.getNextGroup(currentGroup);
    }

    public static Map<String, Object> sendForm(String jsonMapForm, String currentGroup, String accountId, String assetInstance, Id serviceFlowId, String parentCaseId) {
        return ServiceFlowGPSEngine.sendForm(jsonMapForm, currentGroup, accountId, assetInstance, serviceFlowId, parentCaseId);
    }

    public static GPSProtocol getProtocol(String accountId, String assetInstance, String currentGroup, String serviceFlowId, String parentCaseId) {
        return ServiceFlowGPSEngine.getProtocol(accountId, assetInstance, currentGroup, serviceFlowId,parentCaseId);
    }

    public static List<Asset> getAssetFixedByAccount(Id accountId) {
        return ServiceFlowGPSEngine.getAssetFixedByAccount(accountId);
    }

    public static Map<String, Object> getAccountInfo(Id accountId) {
        return ServiceFlowGPSEngine.getAccountInfo(accountId);
    }
    
    public static void createCase(String accountId, String caseIdUra) {
        ServiceFlowGPSEngine.createCase(accountId, caseIdUra);
    }

    public static Map<String, Object> getBase64(String jsonMapForm, String currentGroup, String accountId, String assetInstance, Id serviceFlowId) {
        return ServiceFlowGPSEngine.getBase64(jsonMapForm, currentGroup, accountId, assetInstance, serviceFlowId);
    }

    public static Boolean closeCase(Map<String, String> payload) {
        return ServiceFlowGPSEngine.closeCase(payload);
    }

    public static CanvasResult getCanvasParameters (String recordId, String serviceFlowId, String assetInstance, String caseId){
        return ServiceFlowGPSEngine.getCanvasParameters(recordId, serviceFlowId, assetInstance, caseId);
    }

    public static Map<String, Object> getURLToRedirect(String recordId){
        return ServiceFlowGPSEngine.getURLToRedirect(recordId);
    }

    public static Case getOrCreateCase(Map<String, String> payload) {
        return ServiceFlowGPSEngine.getOrCreateCase(payload);
    }

}