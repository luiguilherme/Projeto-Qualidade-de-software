global class CustomVIPImplementationInvocableFuture {
    
    @InvocableMethod(label = 'Integration Procedure Assync')
    global static void execute(List<IntegrationProcedureInput> input) {
        executeIPAsync(input[0].procedureName, input[0].recordId);
    }

    @future(callout=true)
    global static void executeIPAsync(String procedureName, String recordId) {
        Map<String, Object> ipInput = new Map<String, Object>();
        ipInput.put('record_id', recordId);

        vlocity_cmt.IntegrationProcedureService.runIntegrationService(procedureName, ipInput, new Map<String, Object>());
    }
    
    global class IntegrationProcedureInput {
    	@InvocableVariable(label = 'Id')
    	global String recordId;
        @InvocableVariable(label = 'Integration Procedure' description = 'type_subType' required = true)
    	global String procedureName;
  	}

}