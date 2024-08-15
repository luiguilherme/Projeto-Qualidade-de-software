public class CaseAmdocs {
	
    @AuraEnabled
    @InvocableVariable
    public String id;
    
    @AuraEnabled
    @InvocableVariable
    public String externalSystemTicketId;
    
    @AuraEnabled
    @InvocableVariable
    public DateTime creationDate;
    
    @AuraEnabled
    @InvocableVariable
    public String name;
    
    @AuraEnabled
    @InvocableVariable
    public String problemTypeLevel1;
    
    @AuraEnabled
    @InvocableVariable
    public String problemTypeLevel2;
    
    @AuraEnabled
    @InvocableVariable
    public String problemTypeLevel3;
    
    @AuraEnabled
    @InvocableVariable
    public String protocolNumber;
    
    @AuraEnabled
    @InvocableVariable
    public String severity;
    
    @AuraEnabled
    @InvocableVariable
    public String status;
    
    @AuraEnabled
    @InvocableVariable
    public String noteDetails;
    
    public CaseAmdocs() {
        
    }

    public CaseAmdocs(String id, String externalSystemTicketId, DateTime creationDate, String name,
						String problemTypeLevel1, String problemTypeLevel2, String problemTypeLevel3, String protocolNumber,
						String severity, String status, String noteDetails) {
        this.id = id;
        this.externalSystemTicketId = externalSystemTicketId;
        this.creationDate = creationDate;
        this.name = name;
        this.problemTypeLevel1 = problemTypeLevel1;
        this.problemTypeLevel2 = problemTypeLevel2;
        this.problemTypeLevel3 = problemTypeLevel3;
        this.protocolNumber = protocolNumber;
        this.severity = severity;
        this.status = status;
        this.noteDetails = noteDetails;
    }

}