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
                ProtocolURA__c,
                CallerDDD__c,
                CallerPhone__c,
                Comment__c,
                AccountId,
               // ServiceQualificationMobile__c,
                Closure__c,
                TransferObservation__c
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

}