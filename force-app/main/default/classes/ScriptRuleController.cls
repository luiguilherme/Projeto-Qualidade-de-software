public without sharing class ScriptRuleController {
    
    public static String FIELDSET = 'ScriptRuleField';
    
    public class ObjectDetail{
        public String strObjectLabel;
        public String strObjectAPI;
        public Map<String,String> mapFieldsAndLabels;
    }

    public class PicklistDetails{
        public String strAPIPicklistValue;
        public String strLabelPicklistValue;
    }


    public class FieldDetails{
        public String strFieldAPI;
        public String strFieldType;
        public List<Object> mapPicklistValueAndLabel;
    }


    public static String setInfosField(){
        Map<String,List<Object>> lMapInfoFields = new Map<String,List<Object>>();
        for(ScriptRuleNotification__mdt iScriptNotification : [SELECT MasterLabel, ObjectAPI__c FROM ScriptRuleNotification__mdt]){
            String lObjectAPI = iScriptNotification.ObjectAPI__c;
            if(String.isBlank(lObjectAPI)){ continue; }
            List<Schema.FieldSetMember> lLstMembers = SchemaSelector.getFieldSetMembersByFieldSetDeveloperName(lObjectAPI,FIELDSET);
            if(lLstMembers.isEmpty()){ continue; }
            List<ScriptRuleController.FieldDetails> lLstFieldDetails = new List<ScriptRuleController.FieldDetails>();
            for(Schema.FieldSetMember iMember : lLstMembers){
                String lStrType = formattedFieldType(lObjectAPI, iMember.getFieldPath());
                if(String.isBlank(lStrType)){ continue; }
                ScriptRuleController.FieldDetails lFieldDetail = new ScriptRuleController.FieldDetails();
                if(lStrType == 'picklist'){
                    List<Schema.PicklistEntry> lLstPicklist = SchemaSelector.getPicklistValuesByObjectAndFieldAPI(lObjectAPI,iMember.getFieldPath());
                    if(lLstPicklist.isEmpty()){ continue; }
                    lFieldDetail.mapPicklistValueAndLabel = setValuePicklistInMap(lLstPicklist);
                }
                lFieldDetail.strFieldAPI = iMember.getFieldPath();
                lFieldDetail.strFieldType = lStrType;
                lLstFieldDetails.add(lFieldDetail);
            }
            lMapInfoFields.put(lObjectAPI, lLstFieldDetails);
        }
        return JSON.serialize(lMapInfoFields);
    }

    private static String formattedFieldType(String strObjectAPI, String strFieldAPI){
        Schema.DisplayType lStrType = SchemaSelector.getFieldTypeByObjectAndFieldAPI(strObjectAPI, strFieldAPI);
        String lStrFieldTypeFormatted = '';
        switch on lStrType {
            when ADDRESS{ System.debug('ADDRESS'); lStrFieldTypeFormatted = 'text'; }
            when STRING{ System.debug('STRING'); lStrFieldTypeFormatted = 'text'; }
            when REFERENCE{ System.debug('REFERENCE'); lStrFieldTypeFormatted = 'text'; }
            when URL { System.debug('URL'); lStrFieldTypeFormatted = 'text'; }
            when TEXTAREA { System.debug('TEXTAREA'); lStrFieldTypeFormatted = 'text'; }
            when TIME { System.debug('TIME'); lStrFieldTypeFormatted = 'text'; }
            when PHONE { System.debug('PHONE');  lStrFieldTypeFormatted = 'text'; }
            when INTEGER { System.debug('INTEGER'); lStrFieldTypeFormatted = 'number'; }
            when LONG { System.debug('LONG'); lStrFieldTypeFormatted = 'number'; }
            when DOUBLE { System.debug('DOUBLE'); lStrFieldTypeFormatted = 'number'; }
            when ID { System.debug('ID'); lStrFieldTypeFormatted = 'text'; }
            when EMAIL { System.debug('EMAIL'); lStrFieldTypeFormatted = 'text'; }
            when ENCRYPTEDSTRING { System.debug('ENCRYPTEDSTRING'); lStrFieldTypeFormatted = 'text'; } 
            when DATE { System.debug('DATE'); lStrFieldTypeFormatted = 'date'; }
            when DATETIME { System.debug('DATETIME');  lStrFieldTypeFormatted = 'date'; }
            when CURRENCY { System.debug('CURRENCY'); lStrFieldTypeFormatted = 'numberCurrency'; }
            when PERCENT { System.debug('PERCENT'); lStrFieldTypeFormatted = 'numberPercent'; }
            when BOOLEAN { System.debug('BOOLEAN'); lStrFieldTypeFormatted = 'checkbox'; }
            when PICKLIST { System.debug('PICKLIST'); lStrFieldTypeFormatted = 'picklist'; }
            when MULTIPICKLIST { System.debug('MULTIPICKLIST'); lStrFieldTypeFormatted = 'picklist'; }
        }
        return lStrFieldTypeFormatted;
    }


    @AuraEnabled
    public static String getAllObjectsDetails(){
        String lIdProfile = UserInfo.getProfileId();
        if(String.isBlank(lIdProfile)){ return ''; }
        String lStrNameProfile = [SELECT Name FROM Profile WHERE Id =: lIdProfile].Name;
        if(String.isBlank(lStrNameProfile)){ return ''; }
        String lStrProfilesAvailable = System.Label.CreateScriptRuleProfiles;
        if(String.isBlank(lStrProfilesAvailable)){ return ''; }
        List<String> lVetProfilesAvailable = lStrProfilesAvailable.split(','); 
        Boolean lBlnProfileIsValid = lVetProfilesAvailable.contains(lStrNameProfile);
        if(!lBlnProfileIsValid){ return ''; }

        List<Object> lListObjectsDetails = new List<Object>();
        for(ScriptRuleNotification__mdt iScriptNotification : [SELECT MasterLabel, ObjectAPI__c FROM ScriptRuleNotification__mdt]){
            ScriptRuleController.ObjectDetail lObjecDetail = new ScriptRuleController.ObjectDetail();
            String lStrObject = iScriptNotification.ObjectAPI__c;
            String lStrObjectLabel = iScriptNotification.MasterLabel;
            lObjecDetail.strObjectAPI = lStrObject;
            lObjecDetail.strObjectLabel = lStrObjectLabel;
            lObjecDetail.mapFieldsAndLabels = SchemaSelector.getAllFieldsAndLabelsOfFieldSetMembers(lStrObject, FIELDSET);
            lListObjectsDetails.add(lObjecDetail);
        }
        return JSON.serialize(lListObjectsDetails);
    }

    @AuraEnabled
    public static String getValuePicklist(){
        List<Schema.PicklistEntry> lLstPicklistEntryOfFilter = SchemaSelector.getPicklistValuesByObjectAndFieldAPI('ScriptRule__c', 'FilterBy__c');
        Map<String,String> mapWithPicklistValues = new Map<String,String>();
        if(lLstPicklistEntryOfFilter.isEmpty()){ return '';}
        mapWithPicklistValues.put('filter', JSON.serialize(setValuePicklistInMap(lLstPicklistEntryOfFilter)));
        List<Schema.PicklistEntry> lLstPicklistEntryOfOperator = SchemaSelector.getPicklistValuesByObjectAndFieldAPI('ScriptRule__c', 'Operator__c');
        if(lLstPicklistEntryOfOperator.isEmpty()){ return '';}
        mapWithPicklistValues.put('operator', JSON.serialize(setValuePicklistInMap(lLstPicklistEntryOfOperator)));
        mapWithPicklistValues.put('infoFields', setInfosField());
        return JSON.serialize(mapWithPicklistValues);
    }
    
    private static List<Object> setValuePicklistInMap(List<Schema.PicklistEntry> lLstPicklistEntry){
        List<ScriptRuleController.PicklistDetails> lLstPickListDetail = new List<ScriptRuleController.PicklistDetails>(); 
        for(Schema.PicklistEntry iPickListEntry : lLstPicklistEntry){
            ScriptRuleController.PicklistDetails lPickListDetail = new ScriptRuleController.PicklistDetails();
            String lStrAPIValue = iPickListEntry.getValue();
            String lStrLabelValue = iPickListEntry.getLabel();
            lPickListDetail.strAPIPicklistValue = lStrAPIValue;
            lPickListDetail.strLabelPicklistValue = lStrLabelValue;
            lLstPickListDetail.add(lPickListDetail);
        }
        return lLstPickListDetail;
    }

    @AuraEnabled
    public static Boolean saveScriptRules(List<Object> lstScriptRules, Id idScript){
        if(lstScriptRules == null || lstScriptRules.isEmpty() || idScript == null){ return false; }
        List<ScriptRule__c> lNewScriptRule = new List<ScriptRule__c>();
        for(Object iObject : lstScriptRules){
            Map<Object,Object> lMapIObject = (Map<Object, Object>) iObject;
            if(lMapIObject == null || lMapIObject.isEmpty()){ return false; }
            ScriptRule__c lScriptRule = new ScriptRule__c();
            String lNumberRule = (String.isBlank((String) lMapIObject.get('numberRule')))? '' : String.valueOf(lMapIObject.get('numberRule'));
            lScriptRule.Operator__c =  (String.isBlank((String) lMapIObject.get('operatorScript')))? '' : String.valueOf(lMapIObject.get('operatorScript'));
            lScriptRule.ObjectAPI__c =  (String.isBlank((String) lMapIObject.get('objectAPI')))? '' : String.valueOf(lMapIObject.get('objectAPI'));
            lScriptRule.FieldAPI__c =  (String.isBlank((String) lMapIObject.get('fieldScriptAPI')))? '' : String.valueOf(lMapIObject.get('fieldScriptAPI'));
            if(String.isEmpty(lNumberRule) || String.isEmpty(lScriptRule.Operator__c) || String.isEmpty(lScriptRule.ObjectAPI__c) || String.isEmpty(lScriptRule.FieldAPI__c) ){ return false; }
            lScriptRule.Value__c = (String.isBlank((String) lMapIObject.get('valueToCompare')) || (lScriptRule.Operator__c == 'itHas' || lScriptRule.Operator__c == 'doesntHave'))? '' : String.valueOf(lMapIObject.get('valueToCompare'));
            lScriptRule.Value__c = (lMapIObject.get('fieldType') == 'date' && !String.isBlank(lScriptRule.Value__c))? lScriptRule.Value__c + ' 00:00:00' : lScriptRule.Value__c;
            lScriptRule.FilterBy__c = (String.isBlank((String) lMapIObject.get('filterScript')))? '' : String.valueOf(lMapIObject.get('filterScript'));
            lScriptRule.RuleNumber__c = Decimal.valueOf(lNumberRule);
            String lStrLabelObject = SchemaSelector.getObjectLabelByObjectAPI(lScriptRule.ObjectAPI__c);
            String lStrLabelField = SchemaSelector.getFieldLabelByObjectAPIAndFieldAPI(lScriptRule.ObjectAPI__c, lScriptRule.FieldAPI__c);
            if(String.isBlank(lStrLabelObject) || String.isBlank(lStrLabelField)){ return false; }
            lScriptRule.Object__c = lStrLabelObject;
            lScriptRule.Field__c = lStrLabelField;
            lScriptRule.Script__c = idScript;
            lNewScriptRule.add(lScriptRule);
        }
        try{
            insert lNewScriptRule;
        }catch(Exception e){
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        
        return true;
    }

    @AuraEnabled
    public static List<Decimal> getListNumberRulesActualScript(Id idScript){
        if(idScript == null) { return new List<Decimal>(); }
        List<Decimal> lListNumberRules = new List<Decimal>();
        for(ScriptRule__c iScripRule : [SELECT RuleNumber__c FROM ScriptRule__c WHERE Script__c =: idScript ORDER BY RuleNumber__c ASC]){
            lListNumberRules.add(iScripRule.RuleNumber__c);
        }
        return lListNumberRules;
    }
}