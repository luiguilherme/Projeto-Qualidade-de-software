global class CustomVIPImplementationInvocable {

    @InvocableMethod(label = 'Integration Procedure')
    global static List<IntegrationProcedureOutput> execute(List<IntegrationProcedureInput> input) {
        Map<String, Object> ipInput = new Map<String, Object>();
        IntegrationProcedureOutput result = new IntegrationProcedureOutput();
        
        ipInput.put('record_id', input[0].recordId);

        result.output = JSON.serialize(
            vlocity_cmt.IntegrationProcedureService.runIntegrationService(input[0].procedureName, ipInput, new Map<String, Object>())
        );
        
        System.debug(result.output);

        return new List<IntegrationProcedureOutput>{result};
    }
    
    global class IntegrationProcedureInput {
    	@InvocableVariable(label = 'Id')
    	global String recordId;
        @InvocableVariable(label = 'Integration Procedure' description = 'type_subType' required = true)
    	global String procedureName;
  	}

    global class IntegrationProcedureOutput {
        @InvocableVariable(label = 'Output') 
        global String output;
    }

}