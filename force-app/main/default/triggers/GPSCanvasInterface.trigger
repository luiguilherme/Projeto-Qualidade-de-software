trigger GPSCanvasInterface on GPSCanvasInterface__e (after insert) {
	List<Case> lstCases = new List<Case>();
    Case nuCase;
    
    for(GPSCanvasInterface__e event : Trigger.new){
        if(event.CaseId__c != null && event.CaseId__c != ''){
            nuCase = new Case();
            nuCase.Id = event.CaseId__c;  
            nuCase.Payload__c = String.valueOf(JSON.serialize(event));
            lstCases.add(nuCase);
        }
    }

    Update lstCases;

}