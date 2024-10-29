global class CustomVIPImplementationInvocable {

    @InvocableMethod(label = 'Integration Procedure')
    global static List<IntegrationProcedureOutput> execute(List<IntegrationProcedureInput> input) {
        Map<String, Object> ipInput = new Map<String, Object>();
        IntegrationProcedureOutput result = new IntegrationProcedureOutput();
        
        ipInput.put('record_id', input[0].recordId);
        ipInput.put('cartId', input[0].cartId);
        ipInput.put('groupCartName', input[0].groupCartName);
        ipInput.put('accountId', input[0].accountId);
        ipInput.put('cartGroupId', input[0].cartGroupId);
        ipInput.put('cartType', input[0].cartType);
        ipInput.put('groupCartId', input[0].groupCartId);
        ipInput.put('targetOfferId', input[0].targetOfferId);
        ipInput.put('userIntent', input[0].userIntent);

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
        @InvocableVariable(label='CartId')
        global String cartId;
        @InvocableVariable(label='GroupCartName')
        global String groupCartName;
        @InvocableVariable(label='AccountId')
        global String accountId;
        @InvocableVariable(label='CartGroupId')
        global String cartGroupId;
        @InvocableVariable(label='CartType')
        global String cartType;
        @InvocableVariable(label='GroupCartId')
        global String groupCartId;
        @InvocableVariable(label='TargetOfferId')
        global String targetOfferId;
        @InvocableVariable(label='UserIntent')
        global String userIntent;
  	}

    global class IntegrationProcedureOutput {
        @InvocableVariable(label = 'Output') 
        global String output;
    }

}