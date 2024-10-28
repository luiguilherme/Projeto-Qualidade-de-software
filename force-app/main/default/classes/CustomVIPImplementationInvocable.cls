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
        ipInput.put('interactionId', input[0].interactionId);
        ipInput.put('assetId', input[0].assetId);
        ipInput.put('orderId', input[0].orderId);
        ipInput.put('origin', input[0].origin);
        ipInput.put('otherProduct', input[0].otherProduct);
        ipInput.put('outcome', input[0].outcome);
        ipInput.put('process', input[0].process);
        ipInput.put('reason', input[0].reason);
        ipInput.put('remarkup', input[0].remarkup);
        ipInput.put('serviceTree', input[0].serviceTree);
        ipInput.put('subscriptionId', input[0].subscriptionId);
        ipInput.put('topicName', input[0].topicName);
        ipInput.put('topicId', input[0].topicId);
        ipInput.put('userId', input[0].userId);

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
        @InvocableVariable(label='InteractionId')
        global String interactionId;
        @InvocableVariable(label='AssetId')
        global String assetId;
        @InvocableVariable(label='OrderId')
        global String orderId;
        @InvocableVariable(label='Origin')
        global String origin;
        @InvocableVariable(label='OtherProduct')
        global String otherProduct;
        @InvocableVariable(label='Outcome')
        global String outcome;
        @InvocableVariable(label='Process')
        global String process;
        @InvocableVariable(label='Reason')
        global String reason;
        @InvocableVariable(label='Remarkup')
        global String remarkup;
        @InvocableVariable(label='ServiceTree')
        global String ServiceTree;
        @InvocableVariable(label='SubscriptionId')
        global String subscriptionId;
        @InvocableVariable(label='TopicName')
        global String topicName;
        @InvocableVariable(label='TopicId')
        global String topicId;
        @InvocableVariable(label='UserId')
        global String userId;
  	}

    global class IntegrationProcedureOutput {
        @InvocableVariable(label = 'Output') 
        global String output;
    }

}