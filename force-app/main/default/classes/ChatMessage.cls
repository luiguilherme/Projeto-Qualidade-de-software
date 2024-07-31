public with sharing class ChatMessage 
{
    @AuraEnabled public String id;
    @AuraEnabled public String parentId;
    @AuraEnabled public String message;
    @AuraEnabled public Boolean fromCustomer;
    @AuraEnabled public String origin;
}
