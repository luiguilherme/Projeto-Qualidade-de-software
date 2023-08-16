public with sharing class AssetMigrationDTO {
    @AuraEnabled
    public Boolean haveAccessToToken {get;set;}
    @AuraEnabled
    public Boolean haveTokenValidated {get;set;}
    @AuraEnabled
    public Boolean userHaveAccess {get;set;}
}