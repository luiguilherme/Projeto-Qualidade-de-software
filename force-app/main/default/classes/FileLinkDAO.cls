public inherited sharing class FileLinkDAO
{
    public static FileLink__c getById(String recordId)
    {
        return [
            SELECT Id, IDGedoc__c
            FROM FileLink__c
            WHERE Id = :recordId
        ];
    }

    public static List<FileLink__c> getBy(String caseId)
    {
        return [
            SELECT Id, FileDescription__c, IDGedoc__c
            FROM FileLink__c
            WHERE Case__c = :caseId
            ORDER BY CreatedDate ASC
        ];
    }
}