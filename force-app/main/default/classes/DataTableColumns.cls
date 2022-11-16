public with sharing class DataTableColumns {
  @AuraEnabled
  public String label { get; set; }
  @AuraEnabled
  public String fieldName { get; set; }
  @AuraEnabled
  public String type { get; set; }
  @AuraEnabled
  public Boolean hideDefaultActions { get; set; }
  @AuraEnabled
  public Integer fixedWidth { get; set; }
  @AuraEnabled
  public TypeAttributes typeAttributes { get; set; }

  //Create and set three variables label, fieldname and type as required by the lightning:datatable
  public DataTableColumns(String label, String fieldName, String type) {
    this.label = label;
    this.fieldName = fieldName;
    this.type = type;
  }

  public DataTableColumns(String label, String fieldName, String type, Boolean hideDefaultActions) {
    this.label = label;
    this.fieldName = fieldName;
    this.type = type;
    this.hideDefaultActions = hideDefaultActions;
  }

  public DataTableColumns(String label, String fieldName, String type, Boolean hideDefaultActions, Integer fixedWidth, TypeAttributes typeAttributes) {
    this.label = label;
    this.fieldName = fieldName;
    this.type = type;
    this.hideDefaultActions = hideDefaultActions;
    this.fixedWidth = fixedWidth;
    this.typeAttributes = typeAttributes;
  }
}