global class DatatableItemTO {
    @AuraEnabled
    public String value {get; set;}

    @AuraEnabled
    public String style {get; set;}

    @AuraEnabled
    public String type {get; set;}

    @AuraEnabled
    public String readOnly {get; set;}

    @AuraEnabled
    public String offerName {get; set;}

    @AuraEnabled
    public String offerType {get; set;}

    @AuraEnabled
    public String columnName {get; set;}

    @AuraEnabled
    public Object parameters {get; set;}

    public DatatableItemTO(String textValue, String textStyle) {
        value = textValue;
        style = textStyle;
    }

    public DatatableItemTO(String dataValue, String dataType, String dataColumnName, String dataReadOnly) {
        value = dataValue;
        type = dataType;
        columnName = dataColumnName;
        readOnly = dataReadOnly;
    }
}