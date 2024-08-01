public with sharing class CaseCommentDAO{
    public static List<CaseComment__c> getCaseCommentsByCaseId(String caseId) 
    {
        return 
        [
            SELECT Id, ParentId__c, Comment__c, Origin__c, ViewDatetime__c, CreatedDate 
            FROM CaseComment__c
            WHERE ParentId__c = :caseId
            ORDER BY CreatedDate ASC
        ];
    }


    public static List<CaseComment__c> getCaseCommentsByComplainedAssetCase(String complainedAssetId){
       return
       [
         SELECT Id, ParentId__c, Comment__c, Origin__c, ViewDatetime__c, CreatedDate,IDGedoc__c 
         FROM CaseComment__c 
         WHERE ParentId__r.ComplainedAsset__c = :complainedAssetId
      ];
    }

 
}