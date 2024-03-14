global class PicklistPopulation implements vlocity_cmt.VlocityOpenInterface {
    public Boolean invokeMethod(String methodName, Map < String, Object > input, Map < String, Object > outMap, Map < String, Object > options) {
        if (methodName.equals('GetAccountComplementType')) {
            GetAccountComplementType(input, outMap, options);
        }
        return true;
    }
    
    public void GetAccountComplementType(Map < String, Object > input, Map < String, Object > outMap, Map < String, Object > options) {
        List < Map < String, String >> UIoptions = new List < Map < String, String >> ();
        
        Schema.DescribeFieldResult fieldResult = Account.BillingComplementType1__c.getDescribe();
        
        // Recupera os valores da picklistGlobal
        List<Schema.PicklistEntry> pickListOptions = fieldResult.getPicklistValues();
        
        for (Schema.PicklistEntry entry : pickListOptions) {
            if (entry.getLabel() != 'Caixa Postal' ){
                Map < String, String > tempMap = new Map < String, String > ();
                
                tempMap.put('name', entry.getLabel());
                tempMap.put('value', entry.getLabel());

                UIoptions.add(tempMap); 
            }
        }
        outMap.put('options', UIoptions);
    }   
}