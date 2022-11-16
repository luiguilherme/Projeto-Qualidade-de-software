({
    doInit : function(component, event, helper) {
        helper.getAllObjectDetailsHelper(component, event);
    },

    getSpecificsFields:function(component, event, helper){
        var intIndex = event.getSource().get("v.name");
        var lstObjects = component.get("v.lstObjects");
        var strValueObject = event.getSource().get("v.value");
        helper.getSpecificsFieldsHelper(component, event, lstObjects, strValueObject, intIndex);
    },

    resetByFieldScriptRule:function(component, event, helper){
        var intIndex = event.getSource().get("v.name");
        helper.resetByFieldScriptRuleHelper(component, event, intIndex);
        helper.setFieldTypeToValueCompare(component, event, intIndex);
    },

    closeModal:function(component, event, helper){
        helper.closeModalHelper(component, event);
    },

    addNewRule:function(component, event, helper){
        var lLstScriptRuleExisting = JSON.parse(JSON.stringify(component.get("v.lstScriptRulesExisting")));
        var intIndex = event.getSource().get("v.name");
        helper.createNewScriptRule(component, event, lLstScriptRuleExisting, intIndex, false);
    },

    removeNewRule:function(component, event, helper){
        var lstObjScriptRule = JSON.parse(JSON.stringify(component.get("v.lstScriptRule")));
        var intIndex = event.getSource().get("v.name");
        var lScriptRuleToRemove = lstObjScriptRule[intIndex];
        lstObjScriptRule.splice(intIndex,1);
        component.set("v.lstScriptRule",lstObjScriptRule);
        
        var lLstScriptRuleExisting = JSON.parse(JSON.stringify(component.get("v.lstScriptRulesExisting")));
        var lIntIndexToRemoveExisting;
        for(var iCont in lLstScriptRuleExisting){
            if(lLstScriptRuleExisting[iCont] != lScriptRuleToRemove.numberRule){ continue; }
            lIntIndexToRemoveExisting = iCont;
        }
        lLstScriptRuleExisting.splice(JSON.parse(lIntIndexToRemoveExisting), 1);
        component.set("v.lstScriptRulesExisting",lLstScriptRuleExisting);
        helper.validateAllRulesIsValid(component, event);
    },

    saveRecords:function(component, event, helper){
        var lLstScriptRules = component.get('v.lstScriptRule');
        helper.saveRecordsHelper(component, event, lLstScriptRules);
    },

    checkIsValid:function(component, event, helper){
        var intIndex = event.getSource().get("v.name");
        helper.setIsValid(component, event, intIndex);
    }
})