global without sharing class DeniedDisputeVerifier implements Callable {
    
    private Boolean isDisputeCase;
    private Boolean isRootCauseCase;
    private Datetime yesterday;

    private Boolean accountHasRootCause;

    public DeniedDisputeVerifier() {
        this.isDisputeCase = false;
        this.isRootCauseCase = false;
        this.yesterday = System.now().addDays(-1);

        this.accountHasRootCause = false;
    }
    
	public Object call(String action, Map<String, Object> args) {

        Map<String, Object> input = (Map<String, Object>)args.get('input');
        Map<String, Object> output = (Map<String, Object>)args.get('output');
        Map<String, Object> options = (Map<String, Object>)args.get('options');

        System.debug(action);
        System.debug(input);
        System.debug(output);
        System.debug(options);
        return invokeMethod(action, input, output, options);
    }
    
    global Object invokeMethod(String methodName, Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options) {
		if (methodName == 'checkCases') {
            try {
                String AccountId = (String) inputs.get('AccountId');
                output.put('result', checkCases(AccountId));
                output.put('error', false);
            } catch (Exception e) {
                System.debug(e.getMessage());
                output.put('error', true);
                output.put('errorMsg', e.getMessage());
                output.put('result', '');
            }
        }
        return output;
    }
    
	private String checkCases(String AccountId) {

        List<Case> lCase = CaseDAO.getCasesFromAccId(AccountId, 60);
        for (Case currentCase : lCase) {
            if(areAllPrivateMembersTrue()){
                break;
            }

            if(!(this.isDisputeCase)) {
                if(checkHasDisputeDeniedWithin24h(currentCase)) {
                    this.isDisputeCase = true;
                }
            }

            if(!(this.isRootCauseCase)) {
                if(isCurrentCaseRootCause(currentCase) && isCurrentCaseDisputeInvoiceCase(currentCase)){ 
                    this.accountHasRootCause = true;
                    System.debug('Account has root cause case');
                }
                if(this.accountHasRootCause) {
                    this.isRootCauseCase = true;
                }
            }
        }

        if(this.isDisputeCase) return 'NEG24H';
        if(this.isRootCauseCase) return 'RAIZ';
        return 'NA';
    }

    private Boolean areAllPrivateMembersTrue() {
        return this.isDisputeCase && this.isRootCauseCase;
    }

    //h19 rules
    private Boolean checkHasDisputeDeniedWithin24h(Case currentCase) {
        return isCurrentCaseCreatedgreaterThanYesterday(currentCase) && isCurrentCaseDisputeInvoiceCase(currentCase) && doesCurrentCaseHasDisputedDeniedServiceDefinition(currentCase);
    }

    @TestVisible
    private Boolean checkHasDisputeRootCause(Case currentCase, Task associatedTask, List<Object> DRgetInstanceFromCart) {
        return null;
    }

    //helpers
    private Boolean isCurrentCaseCreatedgreaterThanYesterday(Case currentCase) {
        if(currentCase.CreatedDate >= this.yesterday) {
            return true;
        }
        return false;
    }
    private Boolean isCurrentCaseDisputeInvoiceCase(Case currentCase) {
        if(currentCase.RecordType.DeveloperName == 'DisputeInvoiceCase') {
            return true;
        }
        return false;
    }
    private Boolean doesCurrentCaseHasDisputedDeniedServiceDefinition(Case currentCase) {
        if(currentCase.ServiceDefinitionId__r.DisputeDenied__c) {
            return true;
        }
        return false;
    }
    private Boolean isCurrentCaseRootCause(Case currentCase) {
        if(currentCase.ServiceDefinitionId__r.RootCause__c) {
            return true;
        }
        return false;
    }

}