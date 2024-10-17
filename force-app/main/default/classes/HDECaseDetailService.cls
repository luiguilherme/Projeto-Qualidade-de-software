public without sharing class HDECaseDetailService {
    public static void createCaseDetail(List<Case> ltCases) {
        List<CaseDetail__c> ltCaseDetails = new List<CaseDetail__c>();
        
        for (Case caseSource : ltCases) {
            if (caseSource.Origin == 'HDE') {
                ltCaseDetails.add(new CaseDetail__c(
                    Case__c = caseSource.Id
                ));
            }
        }

        if (ltCaseDetails.size() > 0) {
            insert ltCaseDetails;
        }
    }
}