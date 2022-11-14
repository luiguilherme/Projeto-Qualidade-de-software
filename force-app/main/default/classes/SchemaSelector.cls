public with sharing class SchemaSelector {

    public static Map<String,String> getAllFieldsAndLabelsOfFieldSetMembers(String strObject, String strFieldSetName){
        if(String.isBlank(strObject) || String.isBlank(strFieldSetName)){ return new Map<String,String>(); }
        Map<String,String> lMapWithFieldsAndLabel = new Map<String,String>();
        List<Schema.FieldSetMember> lLstFieldSetMember = SchemaSelector.getFieldSetMembersByFieldSetDeveloperName(strObject, strFieldSetName);
        if(lLstFieldSetMember.isEmpty()){ return new Map<String,String>(); }
        for(Schema.FieldSetMember iFieldSetMember : lLstFieldSetMember){
            String lStrAPI = iFieldSetMember.getFieldPath();
            String lStrLabel = iFieldSetMember.getLabel();
            lMapWithFieldsAndLabel.put(lStrAPI, lStrLabel);
        }
        return lMapWithFieldsAndLabel;
    }

    public static String getObjectLabelByObjectAPI(String strObjectAPI){
        if(String.isBlank(strObjectAPI)){ return ''; }
        try{ return Schema.getGlobalDescribe().get(strObjectAPI).getDescribe().getLabel();}
        catch(Exception e) { return ''; } 
    }

    public static String getFieldLabelByObjectAPIAndFieldAPI(String strObjectAPI, String strFieldAPI){
        if(String.isBlank(strObjectAPI) || String.isBlank(strFieldAPI)){ return ''; }
        try{ return Schema.getGlobalDescribe().get(strObjectAPI).getDescribe().fields.getMap().get(strFieldAPI).getDescribe().getLabel();}
        catch(Exception e) { return ''; } 
    }

    public static List<Schema.PicklistEntry> getPicklistValuesByObjectAndFieldAPI(String strObjectAPI, String strFieldAPI){
        if(String.isBlank(strObjectAPI) || String.isBlank(strFieldAPI)){ return new List<Schema.PicklistEntry>(); }
        try{ return Schema.getGlobalDescribe().get(strObjectAPI).getDescribe().fields.getMap().get(strFieldAPI).getDescribe().getPicklistValues();}
        catch(Exception e) { return new List<Schema.PicklistEntry>(); } 
    }
    
    public static List<Schema.FieldSetMember> getFieldSetMembersByFieldSetDeveloperName(String strObjName, String strFieldSetDeveloperName){
        if (String.isBlank(strObjName) || String.isBlank(strFieldSetDeveloperName)) { return new List<Schema.FieldSetMember>(); }
        try { return Schema.getGlobalDescribe().get(strObjName).getDescribe().FieldSets.getMap().get(strFieldSetDeveloperName).getFields(); }
        catch(Exception e) { return new List<Schema.FieldSetMember>(); }
    }

    public static Id getIdRecordTypeByDeveloperName(String strObjectName, String strDeveloperName){
        if (String.isBlank(strObjectName) || String.isBlank(strDeveloperName)) { return null; }
        try { return Schema.getGlobalDescribe().get(strObjectName).getDescribe().getRecordTypeInfosByDeveloperName().get(strDeveloperName).getRecordTypeId(); }
        catch(Exception e) { return null; }
    }

    public static Schema.DisplayType getFieldTypeByObjectAndFieldAPI(String strObjecAPI, String strFieldAPI){
        if(String.isBlank(strObjecAPI) || String.isBlank(strFieldAPI)){ return null; }
        try{return Schema.getGlobalDescribe().get(strObjecAPI).getDescribe().fields.getMap().get(strFieldAPI).getDescribe().getType(); }
        catch(Exception e) { return null; }
    }


}