public class BulkReplaceFlowParameters {
    
    @InvocableMethod(label='BulkReplace Parameters')
    public static List<Result> bulkReplaceParameters(List<String> jsonInputs) {
        List<Result> results = new List<Result>();

        for(String jsonInput : jsonInputs) {
            Map<String, Object> jsonData = (Map<String, Object>) JSON.deserializeUntyped(jsonInput);
            String cartId = (String) jsonData.get('cartId');
            String groupCartName = (String) jsonData.get('groupCartName');
            String accountId = (String) jsonData.get('accountId');
            String cartGroupId = (String) jsonData.get('cartGroupId');
            String cartType = (String) jsonData.get('cartType');
            String groupCartId = (String) jsonData.get('groupCartId');
            String targetOfferId = (String) jsonData.get('targetOfferId');
            String userIntent = (String) jsonData.get('userIntent');
            
            Result result = new Result();
            result.cartId = cartId;
            result.groupCartName = groupCartName;
            result.accountId = accountId;
            result.cartGroupId = cartGroupId;
            result.cartType = cartType;
            result.groupCartId = groupCartId;
            result.targetOfferId = targetOfferId;
            result.userIntent = userIntent;
            results.add(result);
        }
		System.debug('Resultado: ' + results);
        return results;
    }

    // Inner class to structure the result
    public class Result {
        @InvocableVariable(label='CartId')
        public String cartId;
        @InvocableVariable(label='GroupCartName')
        public String groupCartName;
        @InvocableVariable(label='AccountId')
        public String accountId;
        @InvocableVariable(label='CartGroupId')
        public String cartGroupId;
        @InvocableVariable(label='CartType')
        public String cartType;
        @InvocableVariable(label='GroupCartId')
        public String groupCartId;
        @InvocableVariable(label='TargetOfferId')
        public String targetOfferId;
        @InvocableVariable(label='UserIntent')
        public String userIntent;
    }
}