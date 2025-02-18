public with sharing class CasesTriggerHandler
{
    private List<Case> newCases;
    private Map<Id, Case> oldCases;
    private CasesMyRequestsB2C casesMyRequestsB2C;
    private SenderCaseNotificationService caseNotificationService;

    public CasesTriggerHandler(List<Case> newCases, Map<Id, Case> oldCases)
    {
        this.newCases = newCases != null ? newCases : new List<Case>();
        this.oldCases = oldCases != null ? oldCases : new Map<Id, Case>();
        this.casesMyRequestsB2C = new CasesMyRequestsB2C();
        this.caseNotificationService = new SenderCaseNotificationService();

        this.splitNewCases();
        this.splitOldCases();
    }

    private void splitNewCases()
    {
        for (Case newCase: this.newCases)
        {
            if (this.casesMyRequestsB2C.containsRecordTypeId(newCase.RecordTypeId))
            {
                this.casesMyRequestsB2C.addNewCase(newCase);
            }
        }
    }

    
    private void splitOldCases()
    {
        for (Case oldCase: this.oldCases.values())
        {
            if (this.casesMyRequestsB2C.containsRecordTypeId(oldCase.RecordTypeId))
            {
                this.casesMyRequestsB2C.addOldCase(oldCase);
            }
        }
    }

    public void isBeforeInsert()
    {
        this.casesMyRequestsB2C.validade();
        this.casesMyRequestsB2C.processFieldsBeforeInsert();
    }

    public void isAfterInsert()
    {
        NotificadorMinhasSolicitacoes.handleNotifications(newCases, null);
        this.casesMyRequestsB2C.sendNotificationForCreatedCases();
        this.casesMyRequestsB2C.processFieldsAfterInsert();

        CustomerInteractionTopicService.updateRelatedInteractionTopicWithCaseId(this.newCases);

        HDECaseDetailService.createCaseDetail(this.newCases);
        
        this.caseNotificationService.sendOnInsert(this.newCases);  
    }

    public void isBeforeUpdate() 
    {
        this.casesMyRequestsB2C.processFieldsBeforeUpdate();
        
        HDECasesService.validateNewOwnerSegment(this.newCases);
    }

    public void isAfterUpdate()
    {
        NotificadorMinhasSolicitacoes.handleNotifications(newCases, oldCases);
        this.casesMyRequestsB2C.sendNotificationForCasesWithUpdatedStatus();
        this.casesMyRequestsB2C.requestAllocationOfAttendantsForCasesWithUpdatedStatus();
        this.caseNotificationService.sendOnUpdate(this.newCases, this.oldCases);
        
    }
}