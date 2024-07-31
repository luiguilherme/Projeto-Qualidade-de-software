public with sharing class ContactDAO
{
    public static Contact getBy(String accountDocumentNumber)
    {
        return [
            SELECT Id, Email, ExternalId__c
            FROM Contact
            WHERE ExternalId__c = :accountDocumentNumber
        ];
    }

    public static List<Contact> getBy(Set<String> accountDocumentNumbers)
    {
        return [
            SELECT Id, Email, ExternalId__c
            FROM Contact
            WHERE ExternalId__c IN :accountDocumentNumbers
        ];
    }
}