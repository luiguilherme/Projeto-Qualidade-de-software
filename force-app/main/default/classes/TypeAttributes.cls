public with sharing class TypeAttributes {
    @AuraEnabled
    public String iconName { get; set; }
    @AuraEnabled
    public String label { get; set; }
    @AuraEnabled
    public Boolean disable { get; set; }
    @AuraEnabled
    public String value { get; set; }
    @AuraEnabled
    public String variant { get; set; }

    public TypeAttributes(String iconName, String label, Boolean disable, String value, String variant) {
      this.iconName = iconName;
      this.label = label;
      this.disable =disable;
      this.value = value;
      this.variant = variant;
    }
}