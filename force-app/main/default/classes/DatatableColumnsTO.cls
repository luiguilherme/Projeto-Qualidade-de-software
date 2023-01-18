global class DatatableColumnsTO {
    @AuraEnabled
    public String label {get; set;}
    
	@AuraEnabled
    public String fieldName {get; set;}

	@AuraEnabled
	public String type {get; set;}

	@AuraEnabled
	public CellAttributes cellAttributes {get; set;}

	@AuraEnabled
	public TypeAttributes typeAttributes {get; set;}

    @AuraEnabled
	public Disabled disabled {get; set;}

    public class TypeAttributes {
        @AuraEnabled public String label;
        @AuraEnabled public String name;
        @AuraEnabled public Disabled disabled;
    }

    public class Disabled {
        @AuraEnabled public String fieldName;
    }
    public class CellAttributes {
        @AuraEnabled public String classe;
    }


    public DatatableColumnsTO(String columnLabel, String columnFieldName, String columnType) {
        if(columnType == 'BUTTON'){
            type = 'button';
            typeAttributes = new TypeAttributes();
            typeAttributes.label = columnLabel;
            typeAttributes.name = columnFieldName;
            if(columnFieldName == 'ficoudePensar'){
                disabled = new Disabled();
                disabled.fieldName = 'readOnlyButton';
            }
            typeAttributes.disabled = disabled;
            label  = columnLabel;
            fieldName    = columnFieldName;
            
        } else {
            type = columnType;
            label  = columnLabel;
            fieldName    = columnFieldName;
        }
    }
}