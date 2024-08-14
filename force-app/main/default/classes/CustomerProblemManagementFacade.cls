public with sharing class CustomerProblemManagementFacade {

    public static string CONST_STRING_WEBSERVICENAME = 'CustomerProblemManagement';

    public static List<CaseAmdocs> findByCustomerId(String customerId, DateTime startDate, DateTime endDate){

		WebService__c ws = WebService__c.getInstance(CONST_STRING_WEBSERVICENAME);
		System.debug('ws: ' + ws);
		String strStartDate = startDate.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS') + '-03:00';
		String strEndDate = endDate.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS') + '-03:00';
		System.debug('strStartDate: ' + strStartDate);
		System.debug('strEndDate: ' + strEndDate);
		ws.Endpoint__c = ws.Endpoint__c + '/problems?sourceSystem=AMDOCS&reporterExternalId=' + customerId + '&creationStartDate=' + strStartDate + '&creationEndDate=' + strEndDate;
		System.debug('Endpoint__c: ' + ws.Endpoint__c);
        HttpClient hClient = new HttpClient();
        HttpResponse response = hClient.get(ws);
        System.debug('response: ' + response.getBody());
		CustomerProblemManagementResponse result = (CustomerProblemManagementResponse)JSON.deserialize(response.getBody(), CustomerProblemManagementResponse.class);
        
        List<CaseAmdocs> cases = new List<CaseAmdocs>();
        
        if (result != null && result.problems != null && !result.problems.isEmpty()) {
            for (CustomerProblemManagementResponse.Problems problem : result.problems) {               
                if (problem != null) {
                    
                    String noteDetailsAsString = '';
                    if (problem.noteDetails != null && !problem.noteDetails.isEmpty()) {
                        for (CustomerProblemManagementResponse.NoteDetails noteDetais : problem.noteDetails) {
                            noteDetailsAsString = noteDetailsAsString + noteDetais.content + '\n\n';
                        }
                    }
                    
                    cases.add(new CaseAmdocs(
                        problem.problemId,
                        problem.externalSystemTicketId,
                        problem.creationDate,
                        problem.name,
                        problem.problemTypeLevel1,
                        problem.problemTypeLevel2,
                        problem.problemTypeLevel3,
                        problem.protocolNumber,
                        problem.severity,
                        problem.status,
                        noteDetailsAsString
                    ));
                }
            }
        }
        
		return cases;

    }
}