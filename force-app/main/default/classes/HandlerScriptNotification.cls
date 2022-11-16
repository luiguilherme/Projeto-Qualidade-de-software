public without sharing class HandlerScriptNotification {
    
    public static String FIELDSET = 'ScriptRuleField';
    public static String RECORDTYPENOTIFICATIONMANUAL = 'ManualWarning';
    public static String RECORDTYPENOTIFICATIONAUTOMATIC = 'AutomaticWarning';
    public static String RECORDTYPELOG = 'WarningLogs';
    private static String EXPRESSIONFORMATTED;
    private static String FINALEXPRESSION;

    
    public class wrapperInfoScriptRuleMetadata{
        public String strObjeto;
        public List<String> lstFieldsOfFieldSet;
        public String strFieldNameRelationship;
        public String strSubQueryOfFieldSet;
    }

    public class wrapperAccountDetails{
        public sObject accActualAccount;
        public Map<String, List<sObject>> mapObjectsAndFieldsRelationship;
    }

    
    @InvocableMethod
    public static List<List<Id>> getIdNotification(List<String> lstIdParams){
    if(lstIdParams == null || lstIdParams.isEmpty()){ return new List<List<Id>>(); }
    List<String> lstIds = lstIdParams[0].split(',');
    String idAccount = lstIds[0];
    String idEmployeer = lstIds[1];
    List<List<Id>> lLstWithListOfScriptsMatchs = new List<List<Id>>();
    List<Id> lstIdNotification = new List<Id>();
    if(String.isBlank(idAccount)){ return new List<List<Id>>(); }
    List<HandlerScriptNotification.wrapperInfoScriptRuleMetadata> lstObjectsRelationship = new List<HandlerScriptNotification.wrapperInfoScriptRuleMetadata>();
    HandlerScriptNotification.wrapperInfoScriptRuleMetadata wrapperMainObject;

    for(ScriptRuleNotification__mdt mdtScriptRule : [SELECT ObjectAPI__c, ChildRelationshipName__c FROM ScriptRuleNotification__mdt]){
        if(String.isBlank(mdtScriptRule.ObjectAPI__c) || (mdtScriptRule.ObjectAPI__c != 'Account' && String.isBlank(mdtScriptRule.ChildRelationshipName__c))){ return new List<List<Id>>(); }
        List<Schema.FieldSetMember> lstFieldsSets = getFieldSetMembersByFieldSetDeveloperName(mdtScriptRule.ObjectAPI__c, HandlerScriptNotification.FIELDSET);
        if(lstFieldsSets == null || lstFieldsSets.isEmpty()){ return new List<List<Id>>(); }
        List<String> lstFieldsRulesScripts = new List<String>();
        String strSubQuery = (mdtScriptRule.ObjectAPI__c != 'Account')? '(SELECT ' : 'SELECT ';
        Integer intUnitField = 1;
        String strChildRelationship = (mdtScriptRule.ObjectAPI__c.contains('__c')) ? mdtScriptRule.ChildRelationshipName__c + '__r' : mdtScriptRule.ChildRelationshipName__c;
        
        for(Schema.FieldSetMember schFieldSetMember : lstFieldsSets){
            if(mdtScriptRule.ObjectAPI__c != 'Account'){
                strSubQuery = (intUnitField != lstFieldsSets.size())? strSubQuery +''+ schFieldSetMember.getFieldPath() + ', ' : strSubQuery +''+ schFieldSetMember.getFieldPath() + ' FROM ' + strChildRelationship + ')';
            }else{
                strSubQuery = (intUnitField != lstFieldsSets.size())? strSubQuery +''+ schFieldSetMember.getFieldPath() + ', ' : strSubQuery +''+ schFieldSetMember.getFieldPath() + ', positionSubQuery FROM ' + mdtScriptRule.ObjectAPI__c + ' WHERE Id = \''+ idAccount +'\'';                
            }
            lstFieldsRulesScripts.add(schFieldSetMember.getFieldPath());
            intUnitField++;
        }

        HandlerScriptNotification.wrapperInfoScriptRuleMetadata wrapperScriptRuleMetadata = new HandlerScriptNotification.wrapperInfoScriptRuleMetadata();
        wrapperScriptRuleMetadata.strObjeto = mdtScriptRule.ObjectAPI__c ;
        wrapperScriptRuleMetadata.lstFieldsOfFieldSet = lstFieldsRulesScripts;
        wrapperScriptRuleMetadata.strFieldNameRelationship = strChildRelationship;
        wrapperScriptRuleMetadata.strSubQueryOfFieldSet = strSubQuery;
        if(mdtScriptRule.ObjectAPI__c == 'Account'){
            wrapperMainObject = wrapperScriptRuleMetadata;
        }else{
            lstObjectsRelationship.add(wrapperScriptRuleMetadata);
        } 
    }

    if(wrapperMainObject == null){ return new List<List<Id>>(); }
    String strResultSubQuery = '';
    if(!lstObjectsRelationship.isEmpty()){ strResultSubQuery = createdSubQuery(lstObjectsRelationship); }
    String strResultQuery = createdMainQuery(wrapperMainObject, strResultSubQuery);
    List<sObject> lstAccount;

    try{
        lstAccount = Database.query(strResultQuery);
    }catch(Exception e){
        System.debug(e);
        return new List<List<Id>>();
    }
    
    if(lstAccount == null || lstAccount.isEmpty()){ return new List<List<Id>>(); }
    List<HandlerScriptNotification.wrapperAccountDetails> lstWrapperAccountDetails = getAccountDetails(lstAccount,lstObjectsRelationship);
    if(lstWrapperAccountDetails == null || lstWrapperAccountDetails.isEmpty()){ return new List<List<Id>>(); }

    Date lDtToday = Date.today();


    List<Script__c> lstScripts = [SELECT Id, Logic__c, (SELECT Id, Object__c, Field__c, Operator__c, RuleNumber__c, Value__c, ObjectAPI__c, FieldAPI__c, FilterBy__c FROM Regras_do_Script__r) FROM Script__c WHERE Status__c =: 'Active'
                                    AND RecordType.DeveloperName =: HandlerScriptNotification.RECORDTYPENOTIFICATIONAUTOMATIC
                                    AND StartDate__c <= : lDtToday
                                    AND EndDate__c >= : lDtToday
                                    AND Logic__c != null];

    if(!lstScripts.isEmpty()){
        for(Script__c objScript : lstScripts){
            List<ScriptRule__c> lstScriptRule = objScript.Regras_do_Script__r;
            String strRuleOfLogic = objScript.Logic__c;
            if(lstScriptRule == null || lstScriptRule.isEmpty() || String.isBlank(strRuleOfLogic) || strRuleOfLogic.countMatches('(') != strRuleOfLogic.countMatches(')')){ continue; }
            List<String> lstNumberRules = getNumberRules(lstScriptRule, strRuleOfLogic);
            if(lstNumberRules == null || lstNumberRules.isEmpty()){ continue; }
            Boolean blnValid = validateNumberInLogic(objScript.Logic__c, lstNumberRules);
            if(!blnValid){ continue; }
            Map<String,Boolean> mapWithAnswer = new Map<String,Boolean>(); 
            Account lMainAccount = (Account) lstWrapperAccountDetails[0].accActualAccount;
            Map<String, List<sObject>> mapActualObject = lstWrapperAccountDetails[0].mapObjectsAndFieldsRelationship;
            Boolean lBlnRuleIsTrue;
    
            for(ScriptRule__c iScriptRule : lstScriptRule){
                lBlnRuleIsTrue = false;
                if(iScriptRule.RuleNumber__c == null){ continue; }
                String lStrRuleNumber = String.valueOf(iScriptRule.RuleNumber__c);
                if(lstNumberRules.indexOf(lStrRuleNumber) == -1){ continue; }
                if(String.isBlank(iScriptRule.ObjectAPI__c) || String.isBlank(iScriptRule.FieldAPI__c) || String.isBlank(iScriptRule.Operator__c) || (iScriptRule.Operator__c != 'itHas' && iScriptRule.Operator__c != 'doesntHave' && String.isBlank(iScriptRule.Value__c))){ mapWithAnswer.put(String.valueOf(iScriptRule.RuleNumber__c), false); continue; }
                if(iScriptRule.ObjectAPI__c == 'Account'){
                    lBlnRuleIsTrue = validateFieldAccount(lMainAccount, iScriptRule);
                }else{
                    if(mapActualObject == null || mapActualObject.isEmpty()){ mapWithAnswer.put(String.valueOf(iScriptRule.RuleNumber__c), false); continue; }
                    lBlnRuleIsTrue = validateObjectRelationship(mapActualObject, iScriptRule);
                }
                mapWithAnswer.put(String.valueOf(iScriptRule.RuleNumber__c), lBlnRuleIsTrue);
            }
            
            if(!formattedExpression(mapWithAnswer, objScript.Logic__c)){ continue; }
            
            lstIdNotification.add(objScript.Id);
        }
    }
    List<Id> lLstIdAllScriptsMatchWithAccount = getScriptSpecifics(lstIdNotification, idAccount);
    createLogOfScript(lLstIdAllScriptsMatchWithAccount, idAccount, idEmployeer);
    lLstWithListOfScriptsMatchs.add(lLstIdAllScriptsMatchWithAccount);
    return lLstWithListOfScriptsMatchs;
   }

    @TestVisible
    private static List<Id> getScriptSpecifics(List<Id> lstScriptAutomaticId, Id idAccount){
    if(idAccount == null){ return lstScriptAutomaticId; }
    Date lDtToday = Date.today();
    List<Script__c> lstScripts = [SELECT Id, (SELECT Id FROM ScriptDetails__r WHERE Account__c =: idAccount) FROM Script__c WHERE Status__c =: 'Active' AND RecordType.DeveloperName =: HandlerScriptNotification.RECORDTYPENOTIFICATIONMANUAL
                                    AND StartDate__c <= : lDtToday
                                    AND EndDate__c >= : lDtToday];
    
    for(Script__c iScriptDetail : lstScripts){
        if(iScriptDetail.ScriptDetails__r.size() < 1){ continue; }
        lstScriptAutomaticId.add(iScriptDetail.Id);
    }
        return lstScriptAutomaticId;
   }

   private static Boolean formattedExpression(Map<String,Boolean> mapWithAnswers, String strScriptLogic){
        if(mapWithAnswers == null || mapWithAnswers.isEmpty() || String.isBlank(strScriptLogic)){ return false; }
        strScriptLogic = strScriptLogic.toUpperCase();
        Set<String> lSetIndex = mapWithAnswers.keySet();
        List<Integer> lLstIndex = new List<Integer>();
        for(String iStrIndex : lSetIndex){ lLstIndex.add(Integer.valueOf(iStrIndex)); }
        if(lLstIndex.isEmpty()){ return false; }
        lLstIndex.sort();
        Integer lIntListSize = lLstIndex.size();
        for(Integer iCont = lIntListSize - 1; iCont > -1 ; iCont--){
            String lTextActual = String.valueOf(lLstIndex[iCont]);
            strScriptLogic = strScriptLogic.replace(lTextActual, String.valueOf(mapWithAnswers.get(lTextActual)));
        }
        EXPRESSIONFORMATTED = strScriptLogic;
        evaluate(EXPRESSIONFORMATTED);
        return evaluateExpression(FINALEXPRESSION);
    }

    private static void evaluate(String strExpression){
        if(String.isBlank(strExpression)){ return; }

        if (!strExpression.contains('(')) {
            FINALEXPRESSION = strExpression;
            return;
          }

        Integer lIntIndexOfOpen = - 1;
        Integer lIntIndexOfClose = - 1;
        String[] lLstCaracter = strExpression.split('');
        for (Integer iContador = 0; iContador < lLstCaracter.size(); iContador++){
            String lStrSingleChar = lLstCaracter[iContador];
            if (lStrSingleChar == '(') {
                lIntIndexOfOpen = iContador;
                continue;
            }

            if (lStrSingleChar == ')') {
                lIntIndexOfClose = iContador;
                break;
            }
        }
        String lStrReplace = strExpression.substring(lIntIndexOfOpen + 1, lIntIndexOfClose);
        strExpression = strExpression.replace('(' + lStrReplace + ')', String.valueOf(evaluateExpression(lStrReplace)));
        evaluate(strExpression);
    }

    private static Boolean evaluateExpression(String strExpression){
        Boolean lResult = false;
        if(String.isBlank(strExpression)){ return lResult; }
        for (String iConj : strExpression.split('OR')){
            Boolean lBoolean = true;
            for (String iSingle : iConj.split('AND')){ 
                lBoolean &= Boolean.valueOf(iSingle.trim()); 
            }
            lResult |= lBoolean;
        }
        return lResult;
    }

    @TestVisible 
    private static Boolean validateFieldAccount(Account accMainAccount, ScriptRule__c objScriptRule){
    Boolean lBlnIsTrue = false;    
    if(accMainAccount == null || objScriptRule == null || String.isBlank(objScriptRule.Operator__c) || String.isBlank(objScriptRule.FieldAPI__c) || !validateExistenceField('Account', FIELDSET, objScriptRule.FieldAPI__c)){ return lBlnIsTrue; }
    String lStrValue = (accMainAccount.get(objScriptRule.FieldAPI__c) == null)? '' : String.valueOf(accMainAccount.get(objScriptRule.FieldAPI__c));
    String lStringValueToCompare = objScriptRule.Value__c;
    lBlnIsTrue = executeValidate(lStrValue, lStringValueToCompare, objScriptRule.Operator__c);
    return lBlnIsTrue;
   }

    @TestVisible
    private static Boolean validateObjectRelationship(Map<String, List<sObject>> mapObjectsRelationship, ScriptRule__c objScriptRule){
    Boolean lBlnIsTrue = false;    
    if(mapObjectsRelationship == null || mapObjectsRelationship.isEmpty() || objScriptRule == null || String.isBlank(objScriptRule.ObjectAPI__c) || String.isBlank(objScriptRule.Operator__c) || String.isBlank(objScriptRule.FieldAPI__c) || String.isBlank(objScriptRule.FilterBy__c) || !validateExistenceField(objScriptRule.ObjectAPI__c, FIELDSET, objScriptRule.FieldAPI__c)){ return lBlnIsTrue; }
    List<sObject> lLstObjectRelationship = mapObjectsRelationship.get(objScriptRule.ObjectAPI__c);
    if(lLstObjectRelationship == null || lLstObjectRelationship.isEmpty()){ return lBlnIsTrue; }
    List<Boolean> lLstWithValidate = new List<Boolean>();
    
    for(sObject iObject : lLstObjectRelationship){
        String lStrValue = (iObject.get(objScriptRule.FieldAPI__c) == null)? '' : String.valueOf(iObject.get(objScriptRule.FieldAPI__c));
        String lStringValueToCompare = objScriptRule.Value__c;
        Boolean isValid = executeValidate(lStrValue, lStringValueToCompare, objScriptRule.Operator__c);
        lLstWithValidate.add(isValid);
    }

    if(lLstWithValidate.isEmpty()){ return false; }

    
    switch on objScriptRule.FilterBy__c {
        when 'none'{
            return lLstWithValidate.indexOf(true) == -1;
        }
        when 'oneRecord'{
            Integer lIntContador = 0;
            for(Boolean iBoolean : lLstWithValidate){
                if(!iBoolean){ continue; }
                lIntContador++;
            }
            return lIntContador >= 1;
        }
        when 'allRecords'{
            return lLstWithValidate.indexOf(false) == -1;
        }
    }
    return false;
   }

   @TestVisible
   private static Boolean executeValidate(String strValueFieldObject, String strValueToCompare, String strOperator){
    if(String.isBlank(strOperator)){ return false;}   
    String regex = '\\' + 'd+' + '\\' + '.' + '\\' + 'd+';
    Boolean lBlnIsDecimal = Pattern.matches(regex, strValueFieldObject);

    switch on strOperator {
        when 'startsWith' {
            return strValueFieldObject.startsWithIgnoreCase(strValueToCompare);
        }	
        when 'contains' {
            return strValueFieldObject.containsIgnoreCase(strValueToCompare);
        }
        when 'doesNotContains' {
            return !strValueFieldObject.containsIgnoreCase(strValueToCompare);
        }
        when 'equals' {
            if ((!strValueFieldObject.isNumeric() && !lBlnIsDecimal) || !strValueToCompare.isNumeric()){ return strValueFieldObject.equalsIgnoreCase(strValueToCompare);  }
            return Double.valueOf(strValueFieldObject) == Double.valueOf(strValueToCompare);
        }
        when 'notEqualsTo' {
            if ((!strValueFieldObject.isNumeric() && !lBlnIsDecimal) || !strValueToCompare.isNumeric()){ return !strValueFieldObject.equalsIgnoreCase(strValueToCompare);  }
            return Double.valueOf(strValueFieldObject) != Double.valueOf(strValueToCompare);
        }
        when 'greaterOrEqual' {
            if ((!strValueFieldObject.isNumeric() && !lBlnIsDecimal) || !strValueToCompare.isNumeric()){ return strValueFieldObject >= strValueToCompare; }
            return Double.valueOf(strValueFieldObject) >= Double.valueOf(strValueToCompare);
        }
        when 'greaterThan' {
            if ((!strValueFieldObject.isNumeric() && !lBlnIsDecimal) || !strValueToCompare.isNumeric()){ return strValueFieldObject > strValueToCompare; }
            return Double.valueOf(strValueFieldObject) > Double.valueOf(strValueToCompare);
        }
        when 'lessOrEqual' {
            if ((!strValueFieldObject.isNumeric() && !lBlnIsDecimal) || !strValueToCompare.isNumeric()){ return strValueFieldObject <= strValueToCompare; }
            return Double.valueOf(strValueFieldObject) <= Double.valueOf(strValueToCompare);
        }
        when 'lessThan' {
            if ((!strValueFieldObject.isNumeric() && !lBlnIsDecimal) || !strValueToCompare.isNumeric()){ return strValueFieldObject < strValueToCompare; }
            return Double.valueOf(strValueFieldObject) < Double.valueOf(strValueToCompare);
        }
        when 'itHas' {
            return !String.isBlank(strValueFieldObject);
        }
        when 'doesntHave' {
            return String.isBlank(strValueFieldObject);
        }
    }
    return false;
   }

   private static Boolean validateExistenceField(String strObject, String strFieldSet, String strFieldAPI){
    Boolean lBlnIsExisting = false;
    if(String.isBlank(strObject) || String.isBlank(strFieldSet) || String.isBlank(strFieldAPI)){ return lBlnIsExisting; }
    List<Schema.FieldSetMember> lLstFieldSetMember = getFieldSetMembersByFieldSetDeveloperName(strObject, strFieldSet);
    if(lLstFieldSetMember.isEmpty()){ return lBlnIsExisting; }
    for(Schema.FieldSetMember iFieldSetMember : lLstFieldSetMember){
        if(!strFieldAPI.equalsIgnoreCase(iFieldSetMember.getFieldPath())){ continue; }
        lBlnIsExisting = true; 
    }
        return lBlnIsExisting;
   }

   private static List<HandlerScriptNotification.wrapperAccountDetails> getAccountDetails(List<sObject> lstAccount, List<HandlerScriptNotification.wrapperInfoScriptRuleMetadata> lstObjectsRelationship){
    if(lstAccount == null || lstAccount.isEmpty()){ return new List<HandlerScriptNotification.wrapperAccountDetails>(); }
    HandlerScriptNotification.wrapperAccountDetails wrapperAccountDetail;
    Map<String, List<sObject>> mapObjectAndFields;
    List<HandlerScriptNotification.wrapperAccountDetails> lstMainObjectAndRelationship = new List<HandlerScriptNotification.wrapperAccountDetails>();
    
    for(sObject acc : lstAccount){
        wrapperAccountDetail = new HandlerScriptNotification.wrapperAccountDetails();
        mapObjectAndFields = new Map<String, List<sObject>>();
        wrapperAccountDetail.accActualAccount = acc;
        
        for(HandlerScriptNotification.wrapperInfoScriptRuleMetadata sObjectsRelationship : lstObjectsRelationship){
            String strChildFieldRelationship = sObjectsRelationship.strFieldNameRelationship;
            if(String.isBlank(strChildFieldRelationship)){return new List<HandlerScriptNotification.wrapperAccountDetails>(); }
            List<sObject> sActualObject = acc.getSObjects(strChildFieldRelationship);
            mapObjectAndFields.put(sObjectsRelationship.strObjeto, sActualObject);
        }

        wrapperAccountDetail.mapObjectsAndFieldsRelationship = mapObjectAndFields;
        lstMainObjectAndRelationship.add(wrapperAccountDetail);
    }
    return lstMainObjectAndRelationship;
   } 

    private static String createdSubQuery(List<HandlerScriptNotification.wrapperInfoScriptRuleMetadata> lstObjectsRelationship){
       if(lstObjectsRelationship == null || lstObjectsRelationship.isEmpty()){ return ''; }
       String strSubQuery = '';
       Integer intContador = 1;
       
       for(HandlerScriptNotification.wrapperInfoScriptRuleMetadata wrapperInfoScriptRule : lstObjectsRelationship){
           strSubQuery = (intContador != lstObjectsRelationship.size())? strSubQuery + '' + wrapperInfoScriptRule.strSubQueryOfFieldSet + ',' : strSubQuery + '' + wrapperInfoScriptRule.strSubQueryOfFieldSet;
           intContador++;
       }
       return strSubQuery;
    }

    private static String createdMainQuery(HandlerScriptNotification.wrapperInfoScriptRuleMetadata wrapperMainObject, String strSubQuery){
        if(wrapperMainObject == null){ return ''; }
        String strMainQuery = wrapperMainObject.strSubQueryOfFieldSet;
        strMainQuery = (String.isBlank(strSubQuery)) ?  strMainQuery.replace(', positionSubQuery', '') : strMainQuery.replace('positionSubQuery', strSubQuery);
        return strMainQuery;
    }

    
    public static Boolean validateFieldLogic(Script__c objScript){
        if(objScript == null || String.isBlank(objScript.Logic__c)){ return false; }
        String strRuleOfLogic = objScript.Logic__c;
        if(strRuleOfLogic.countMatches('(') != strRuleOfLogic.countMatches(')')){ return false; }
        List<ScriptRule__c> lstScriptRules = objScript.Regras_do_Script__r;
        if(lstScriptRules.isEmpty()){ return false; }
        List<String> lstNumberRules = HandlerScriptNotification.getNumberRules(lstScriptRules);
        if(lstNumberRules.isEmpty()){ return false; }
        return HandlerScriptNotification.validateNumberInLogic(objScript.Logic__c, lstNumberRules); 
    }

    
    public static List<String> getNumberRules(List<ScriptRule__c> lstRules){
        List<String> lstNumberRules = new List<String>();
        if(lstRules == null || lstRules.isEmpty()){ return lstNumberRules; }
        for(ScriptRule__c objScriptRule : lstRules){
            if(objScriptRule.RuleNumber__c == null){ return new List<String>(); }
            lstNumberRules.add(String.valueOf(objScriptRule.RuleNumber__c));
        }
        return lstNumberRules;
    }
	
    private static List<String> getNumberRules(List<ScriptRule__c> lstRules, String strLogic){
        List<String> lstNumberRules = new List<String>();
        if(lstRules == null || lstRules.isEmpty() || String.isBlank(strLogic)){ return lstNumberRules; }
        strLogic = strLogic.toUpperCase();
        strLogic = strLogic.remove('AND').remove('OR').remove('(').remove(')');

        for(String iCaracter : strLogic.split(' ')){
            if(String.isBlank(iCaracter)){ continue; }
            Boolean lBlnExist = false;
            for(ScriptRule__c iScriptRule : lstRules){
                if(iScriptRule.RuleNumber__c == null){ continue; }
                String lRuleNumber = String.valueOf(iScriptRule.RuleNumber__c);
                if(!iCaracter.equals(lRuleNumber)){ continue; }
                lBlnExist = true;
                break;
            }
            if(!lBlnExist){ return new List<String>(); }
            lstNumberRules.add(iCaracter);
        }
        return lstNumberRules;
    }

    
    public static Boolean validateNumberInLogic(String strLogic, List<String> lstNumberRule){
        if(String.isBlank(strLogic) || lstNumberRule == null || lstNumberRule.isEmpty()){ return false; }
        Integer intIndicador = 0;
        strLogic = strLogic.toUpperCase();
        strLogic = strLogic.remove('(').remove(')');
        Integer intSizeLstValuesInLogic = strLogic.split(' ').size();
        for(String strCaracter : strLogic.split(' ')){
            intIndicador++;
            if(math.mod(intIndicador, 2) == 0){
                if( (strCaracter == 'AND' || strCaracter == 'OR') && intIndicador != intSizeLstValuesInLogic){ continue; }
                return false;
            }
            else{
                if(lstNumberRule.indexOf(strCaracter) != -1){ continue; }
                return false;
            }
        }
        return true;
    }

    @TestVisible
    private static void createLogOfScript(List<Id> lstIdScript, Id idAccount, Id idEmployeer){

        if(lstIdScript == null || lstIdScript.isEmpty() || idAccount == null){ return; }
        List<Id> lLstIdAux = lstIdScript;
        Map<Id, Script__c> mapScript = new Map<Id, Script__c>([SELECT Id, Name, Message__c FROM Script__c WHERE Id IN: lstIdScript]);
        if(mapScript == null || mapScript.isEmpty()){ return; }
        List<Id> lLstScriptExisting = new List<Id>();
        List<ScriptDetail__c> lLstIdToCreate = new List<ScriptDetail__c>();
        List<ScriptDetail__c> lLstIdToUpdate = new List<ScriptDetail__c>();

        for(ScriptDetail__c iScriptDetail : [SELECT Id, Recurrent__c, Verbalized__c, DisplayScriptFlow__c, Script__c FROM ScriptDetail__c WHERE Account__c =: idAccount AND Script__c IN : lstIdScript]){
            if(lLstScriptExisting.indexOf(iScriptDetail.Script__c) == -1 && (!iScriptDetail.Verbalized__c || (iScriptDetail.Verbalized__c && iScriptDetail.Recurrent__c == 'Yes'))){
                iScriptDetail.DisplayScriptFlow__c = true;
                lLstScriptExisting.add(iScriptDetail.Script__c);
            }else{
                iScriptDetail.DisplayScriptFlow__c = false;
            }
            Id lIdScript = iScriptDetail.Script__c;
            iScriptDetail.Name = mapScript.get(lIdScript).Name;
            iScriptDetail.ScriptMessage__c = mapScript.get(lIdScript).Message__c;
            Integer lIndexToRemove = lLstIdAux.indexOf(iScriptDetail.Script__c);
            if(lIndexToRemove == -1){ lLstIdToUpdate.add(iScriptDetail); continue; }
            Id idRemoved = lLstIdAux.remove(lIndexToRemove);
            lLstIdToUpdate.add(iScriptDetail);
        }

        if(!lLstIdToUpdate.isEmpty()){ 
            try{
                upsert lLstIdToUpdate;
            }catch(Exception e){
                System.debug('The following exception has occurred: ' + e.getMessage());
            }
        }

        for(Id iId : lLstIdAux){
            ScriptDetail__c lScriptDetail = new ScriptDetail__c();
            lScriptDetail.Script__c = iId;
            lScriptDetail.DisplayScriptFlow__c = true;
            lScriptDetail.Account__c = idAccount;
            lScriptDetail.Name = mapScript.get(iId).Name;
            lScriptDetail.ScriptMessage__c = mapScript.get(iId).Message__c;
            lScriptDetail.RecordTypeId = SchemaSelector.getIdRecordTypeByDeveloperName('ScriptDetail__c', RECORDTYPELOG);
            lScriptDetail.Operator__c = idEmployeer;
            lLstIdToCreate.add(lScriptDetail);
        }

        

        if(!lLstIdToCreate.isEmpty()){ 
            try{
                insert lLstIdToCreate; 
            }catch(Exception e){
                System.debug('The following exception has occurred: ' + e.getMessage());
            }
        }
    }

public static List<Schema.FieldSetMember> getFieldSetMembersByFieldSetDeveloperName(String strObjName, String strFieldSetDeveloperName){
    if (String.isBlank(strObjName) || String.isBlank(strFieldSetDeveloperName)) { return new List<Schema.FieldSetMember>(); }
    try { return Schema.getGlobalDescribe().get(strObjName).getDescribe().FieldSets.getMap().get(strFieldSetDeveloperName).getFields(); }
    catch(Exception e) { return new List<Schema.FieldSetMember>(); }
}

    
    
}