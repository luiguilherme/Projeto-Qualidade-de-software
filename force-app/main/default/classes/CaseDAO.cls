public without sharing class CaseDAO {
    public static List<Case> getCaseByParentId(String parentId, String accountId) {
        return  [
            SELECT 
                Id
        FROM 
            Case 
        WHERE 
            ParentId  = :parentId
        AND AccountId = :accountId 
        AND Status    = 'InTransfer'];
    }

    public static Case getCasebyId(String caseId){
        return[
            SELECT
                Id,
                Origin,
                Status,
                Segment__c,
                ServiceRequestId__c,
                ServiceNumber__c,
                ParentId,
                CaseNumber,
                Protocol__c,
                RecordTypeId,
                RecordType.Name,
                ProtocolURA__c,
                CallerDDD__c,
                CallerPhone__c,
                Comment__c,
                AccountId,
               // ServiceQualificationMobile__c,
                Closure__c,
                TransferObservation__c,
                ComplainedAsset__c,
                CustomerInteractionTopicTree__c,
                Product__c,
                Context__c
            FROM
                Case
            WHERE
                Id = :caseId
            LIMIT 1
        ];
    }

    public static List<Case> getOpenCaseFixa(String accountId, String userId){
        Id recordTypeIdCaseFixa = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('FixedServiceQualification').getrecordTypeId();
        DateTime expirationDate = System.now().addMinutes(-30);
        return [
            SELECT 
                Id,
                Origin,
                Status,
                Segment__c,
                ServiceRequestId__c,
                ParentId,
                CaseNumber,
                Protocol__c,
                RecordTypeId,
                ProtocolURA__c,
                CallerDDD__c,
                CallerPhone__c,
                Comment__c,
                AccountId,
               // ServiceQualificationMobile__c,
                Closure__c,
                TransferObservation__c
            FROM CASE 
            WHERE
                Status       = 'Em Atendimento' AND 
                AccountId    = :accountId AND 
                OwnerId      = :userId AND
                RecordTypeId = :recordTypeIdCaseFixa AND
                CreatedDate >= :expirationDate
            ORDER BY 
                CreatedDate 
            DESC
        ];
    }
	//Kaiser - criado método para retornar um caso aberto de gps pre
    public static List<Case> getOpenCasePre(String accountId, String userId){
        Id recordTypeIdCasePre = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('PreDefectAndRepair').getrecordTypeId();
        DateTime expirationDate = System.now().addMinutes(-30);
        return [
            SELECT 
                Id,
                Origin,
                Status,
                Segment__c,
                ServiceNumber__c,
                ParentId,
                CaseNumber,
                Protocol__c,
                RecordTypeId,
                ProtocolURA__c,
                CallerDDD__c,
                CallerPhone__c,
                Comment__c,
                AccountId,
               // ServiceQualificationMobile__c,
                Closure__c,
                TransferObservation__c
            FROM CASE 
            WHERE
                Status       = 'Em Atendimento' AND 
                AccountId    = :accountId AND 
                OwnerId      = :userId AND
                RecordTypeId = :recordTypeIdCasePre AND
                CreatedDate >= :expirationDate
            ORDER BY 
                CreatedDate 
            DESC
        ];
    }    

    public static List<Case> get(Set<Id> recordTypesIds, Set<Id> accountsIds, Set<Id> assetsIds, Set<String> Statuses)
    {
        return [
            SELECT Id, RecordTypeId, AccountId, ComplainedAsset__c
            FROM Case
            WHERE RecordTypeId IN :recordTypesIds
            AND AccountId IN :accountsIds
            AND ComplainedAsset__c IN :assetsIds
            AND Status NOT IN :Statuses
        ];
    }

    public static List<Case> getBy(Set<Id> accountsIds, Set<Id> assetsIds, Set<Id> topicTreeIds, Set<String> statuses)
    {
        return [
            SELECT Id, AccountId, ComplainedAsset__c, CustomerInteractionTopicTree__c
            FROM Case
            WHERE AccountId IN :accountsIds
            AND ComplainedAsset__c IN :assetsIds
            AND CustomerInteractionTopicTree__c IN :topicTreeIds
            AND Status NOT IN :statuses
        ];
    }

    public static List<Case> get(Set<Id> caseIds) {
        return[
            SELECT
                Id,
                Status,
                Protocol__c,
                RecordTypeId,
                RecordType.Name,
                AccountId,
                ComplainedAsset__c,
            	Description,
                ServiceReason__c
            FROM
                Case
            WHERE
                Id IN :caseIds
        ];
    }
    
    public static List<Case> getCasesFromAccId(String AccountId, Integer days) {
        String query = 'SELECT  id,OwnerId,CaseNumber,Status,RecordType.Name,AccountId,CreatedDate,Origin,RecordType.DeveloperName,ServiceDefinitionId__r.DisputeDenied__c,ServiceDefinitionId__r.RootCause__c,ComplainedAsset__r.Name FROM Case WHERE AccountId = :AccountId AND CreatedDate = LAST_N_DAYS:'+ days;
           return Database.query(query);
    }
}