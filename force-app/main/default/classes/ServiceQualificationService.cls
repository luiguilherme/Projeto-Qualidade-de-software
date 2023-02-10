/*
 *
 *   Description: Classe responsável pelos serviços disponíveis para o Fluxo de Atendimento do GPS
 *
 *   Author: Geimison Oliveira
 *   Date:   15/06/2021
 *
 */
public with sharing class ServiceQualificationService {
    /*
     * Retorno:
     *   Key | Tipo | Descrição
     *   'firstLevel'    | List<ItemTreeTO>    | Lista com todos o Fluxo ativos para o primeiro nível de tipificação
     *   'secondLevel'   | List<ItemTreeTO>    | Lista com todos o Fluxo ativos para o segundo nível de tipificação
     *   'thirdLevel'    | List<ItemTreeTO>    | Lista com todos o Fluxo ativos para o terceiro nível de tipificação
     *   'fourthLevel'   | List<ItemTreeTO>    | Lista com todos o Fluxo ativos para o quarto nível de tipificação
     */ 
    public static Map<String, Object> getServiceFlow(String productType, String serviceTree) {
        return ServiceQualificationEngine.getServiceFlow(productType, serviceTree);
    }
    
    public static List<Asset> getAssetMobileByAccount(Id accountId) {
        return ServiceQualificationEngine.getAssetMobileByAccount(accountId);
    }
    
    public static User getUserById(Id userId) {
        return ServiceQualificationEngine.getUserById(userId);
    }
    
    public static List<FromToMapping__mdt> getServiceTreeIdentifier(String userRole) {
        return ServiceQualificationEngine.getServiceTreeIdentifier(userRole);
    }

    public static Case saveQualificationServiceCase(String qualificationCase, String recordTypeCase, String parentCaseId) {
        return ServiceQualificationEngine.saveQualificationServiceCase(qualificationCase, recordTypeCase, parentCaseId);
    }

    public static Map<String, Boolean> haveAccessToFlow(Id userId) {
        return ServiceQualificationEngine.haveAccessToFlow(userId);
    }

    public static List<Asset> getAssetsByAccount(Id accountId) {
        List<Asset> ltAssetToReturn = new List<Asset>();
        List<Asset> ltAsset = getAssetMobileByAccount(accountId);
        ltAssetToReturn.addAll(ltAsset  == null ? new List<Asset>() : ltAsset);
        ltAsset = ServiceFlowGPSService.getAssetFixedByAccount(accountId);
        ltAssetToReturn.addAll(ltAsset  == null ? new List<Asset>() : ltAsset);
        return ltAssetToReturn;
    }
}