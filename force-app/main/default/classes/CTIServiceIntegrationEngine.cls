public with sharing class CTIServiceIntegrationEngine {
    private static final String QUEUE_NAME = 'CTIIntegrationQueue';

    public static String createCTICase(String CTICase, String recordTypeCase, String caseId, String note){
        Case newCase = new Case();

        try {
            Case existentCase = CaseDAO.getCasebyId(caseId);
            Case genericCase = (Case)JSON.deserialize(CTICase, Case.class);
            List<Group> queue = GroupDAO.getQueueByName(QUEUE_NAME);

            if ((existentCase.Origin == 'Ura' || (existentCase.Origin == 'Tranfer' && existentCase.Status == 'Closed')) && genericCase.Origin != 'CallDropped') {
                newCase = genericCase;
                
                newCase.Origin = 'Transfer';
                newCase.Subject = 'Transferência';
                newCase.Status = 'InTransfer';
                newCase.ParentId = existentCase.Origin == 'Ura' ? caseId : existentCase.ParentId;
                newCase.Description = note;
                newCase.OwnerId = queue[0].id;

                newCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName()
                    .get(recordTypeCase).getrecordTypeId();
                
            } else if (existentCase.Origin == 'Transfer' && genericCase.Origin != 'CallDropped') {
				newCase = existentCase;
				
                newCase.Description = note;
                newCase.OwnerId = queue[0].id;
                newCase.DestinyCell__c = genericCase.DestinyCell__c;
                newCase.OriginCell__c = genericCase.OriginCell__c;

            } else if (genericCase.Origin == 'CallDropped') {
                newCase = genericCase;

                newCase.ParentId = existentCase.Origin == 'Ura' ? caseId : existentCase.ParentId;
                newCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName()
                    .get(recordTypeCase).getrecordTypeId();
                if(existentCase.Origin == 'Transfer') closeCTITransferCase(existentCase.Id, '');
            }
    
            upsert newCase;
            
            if(!String.isEmpty(note)){
                insert new CaseComment(CommentBody = note, ParentId = newCase.Id);
            }
    
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return newCase.Id;
    }
    
    public static void closeCTITransferCase(String caseId, String protocol){
        try {
            Case existentCase = CaseDAO.getCasebyId(caseId);
            
            if(existentCase != null && existentCase.Origin == 'Transfer' && existentCase.Status == 'InTransfer'){
                existentCase.Status = 'Closed';
                existentCase.Protocol__c = protocol;
                
                update existentCase;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}