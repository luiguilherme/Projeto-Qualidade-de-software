global class ParametersDataTO {

    @AuraEnabled
    public String id {get; set;}
    
    @AuraEnabled
    public String key {get;set;}

    @AuraEnabled
    public String type {get;set;}

    @AuraEnabled
    public String value {get;set;}

    @AuraEnabled
    public String text {get; set;}
    
    @AuraEnabled
    public String label {get;set;}

    @AuraEnabled
    public String style {get; set;}

    @AuraEnabled 
    public List<String> ltString {get; set;}

    @AuraEnabled
    public Set<String> setColumns {get; set;}

    @AuraEnabled
    public List<ParametersDataTO> ltCombobox {get;set;}

    @AuraEnabled
    public List<ParametersDataTO> ltSubParameters {get;set;}

    @AuraEnabled
    public List<List<DatatableItemTO>> ltData {get; set;}

    @AuraEnabled
    public List<ParametersDataTO> ltRadioBoxValues {get;set;}
}