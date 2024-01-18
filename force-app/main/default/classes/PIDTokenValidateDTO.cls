public with sharing class PIDTokenValidateDTO {
    @AuraEnabled
    public String accountId {get;set;}
    @AuraEnabled
    public String phone {get;set;}
    @AuraEnabled
    public List<String> phones {get; set;}
    @AuraEnabled
    public Integer attempts {get;set;}
    @AuraEnabled
    public String sendedPhone {get; set;}
    @AuraEnabled
    public Boolean hasAccess {get;set;}
    @AuraEnabled
    public Integer interval {get;set;}
    @AuraEnabled
    public String tokenStatus {get;set;}
    @AuraEnabled
    public Integer tokenSendAttempts {get;set;}
}