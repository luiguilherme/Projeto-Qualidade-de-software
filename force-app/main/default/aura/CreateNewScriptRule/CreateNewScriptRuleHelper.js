({
    getAllObjectDetailsHelper: function(component, event){
        var action = component.get("c.getAllObjectsDetails");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                if(response.getReturnValue() == ''){ 
                    this.showToast(component, event, 'Error','','error');
                    this.closeModalHelper(component, event);
                }else{
                    var lListResponse = JSON.parse(response.getReturnValue());
                    this.filterObjectsDetails(component, event, lListResponse);
                    this.getValuesPicklist(component, event);
                }
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },

    filterObjectsDetails:function(component, event, lstAllObjectsDetails){
        var lListObjects = [];
        for(var intContador=0; intContador< lstAllObjectsDetails.length; intContador++){
            var objObjectAndLabel = new Object;
            objObjectAndLabel.name = lstAllObjectsDetails[intContador].strObjectLabel;
            objObjectAndLabel.apiName = lstAllObjectsDetails[intContador].strObjectAPI;
            var mapFieldLabelsAndAPIs = lstAllObjectsDetails[intContador].mapFieldsAndLabels;
            var lstFieldsAndAPIs = [];
            for(var key in mapFieldLabelsAndAPIs){
                var objFieldAndAPI = new Object();
                objFieldAndAPI.fieldAPI = key;
                objFieldAndAPI.fieldLabel = mapFieldLabelsAndAPIs[key];
                lstFieldsAndAPIs.push(objFieldAndAPI);
            }
            objObjectAndLabel.labelAndFieldAPI = lstFieldsAndAPIs;
            lListObjects.push(objObjectAndLabel);
        }
        component.set("v.lstObjects", lListObjects);
    },

    getValuesPicklist:function(component, event){
        var action = component.get("c.getValuePicklist");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var lMapResponse = JSON.parse(response.getReturnValue());
                var lLstPicklistFilter = JSON.parse(lMapResponse['filter']);
                var lLstPicklistOperator = JSON.parse(lMapResponse['operator']);
                this.setListNumberRulesValid(component,event);
                this.setValuePicklist(component, event, lLstPicklistFilter, 'lstFilterRecords');
                this.setValuePicklist(component, event, lLstPicklistOperator, 'lstOperadores');
                
                component.set('v.mapInfoFields' , JSON.parse(lMapResponse['infoFields']));
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },

    setListNumberRulesValid:function(component, event){
        var action = component.get("c.getListNumberRulesActualScript");
        action.setParams({
            'idScript' : component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                this.createNewScriptRule(component, event, response.getReturnValue(), "", true);
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },

    createNewScriptRule:function(component, event, lstNumberRule, intIndex, blnFirstScriptRule){
        var lIntContador = 1;
        
        for(var lCont=0; lCont < lstNumberRule.length ; lCont++){
            if(lstNumberRule.indexOf(lIntContador) != -1){ lIntContador++; continue; }
            break;
        }
        
        lstNumberRule.push(lIntContador);
        component.set('v.lstScriptRulesExisting', lstNumberRule);
        var lLstScriptRules = JSON.parse(JSON.stringify(component.get('v.lstScriptRule')));
        var objScriptRule = new Object();
        objScriptRule.numberRule = JSON.stringify(lIntContador);
        objScriptRule.objectAPI = "";
        objScriptRule.fieldScriptAPI = "";
        objScriptRule.operatorScript = "";
        objScriptRule.fieldType = "text";
        objScriptRule.valueToCompare = "";
        objScriptRule.filterScript = "";
        objScriptRule.lstCampos = [];
        objScriptRule.lstPicklist = [];
        objScriptRule.isValid = false;
        lLstScriptRules.push(objScriptRule);
        component.set("v.lstScriptRule", lLstScriptRules);
        if(!blnFirstScriptRule){ this.setIsValid(component, event, intIndex); }
    },

    setValuePicklist:function(component, event, lstPicklist, strAttribute){
        var lLstValuesPickList = [];
        
        for(var key in lstPicklist){
            var strPickListField = new Object();
            strPickListField.picklistValueAPI = lstPicklist[key].strAPIPicklistValue;
            strPickListField.picklistValueLabel = lstPicklist[key].strLabelPicklistValue;
            lLstValuesPickList.push(strPickListField);
        }
        
        var strAttributeToList = 'v.'+strAttribute;
        component.set(strAttributeToList, lLstValuesPickList);
    },
    
    getSpecificsFieldsHelper:function(component, event, lstObjects, strValueObject, intIndex){
        this.resetObjectScriptRule(component, event, intIndex);
        var lstScriptRule = component.get("v.lstScriptRule");
        var lstFieldsSpecifics = [];

        for(var obj in lstObjects){
            if(lstObjects[obj].apiName != strValueObject){ continue; }
            lstFieldsSpecifics = lstObjects[obj].labelAndFieldAPI;
            break;
        }

        var lstScriptRule = component.get("v.lstScriptRule");
        lstScriptRule[intIndex].lstCampos = lstFieldsSpecifics;
        component.set("v.lstScriptRule", lstScriptRule);
        this.setIsValid(component, event, intIndex);
    },

    saveRecordsHelper:function(component, event, lstScriptRules){
        
        var action = component.get("c.saveScriptRules");
        lstScriptRules = JSON.parse(JSON.stringify(lstScriptRules));
        action.setParams({
            'lstScriptRules': lstScriptRules,
            'idScript' : component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var lBlnResponse = response.getReturnValue();
                var lStrTitle = (lBlnResponse)? $A.get("$Label.c.ScriptRuleCreateWithSuccessTitle") : $A.get("$Label.c.ScriptRuleCreateWithErrorTitle");
                var lStrMessage = (lBlnResponse)? $A.get("$Label.c.ScriptRuleCreateWithSuccessDescription") : $A.get("$Label.c.ScriptRuleCreateWithErrorDescription");
                var lStrType = (lBlnResponse)? 'success' : 'error';
                this.showToast(component, event, lStrTitle, lStrMessage, lStrType);
                if(lBlnResponse){
                    this.redirectRecordPage(component, event);
                }
                
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },

    redirectRecordPage:function(component, event){
        $A.get('e.force:refreshView').fire();
        this.closeModalHelper(component,event);
    },

    closeModalHelper:function(component,event){
        var lCloseModal = $A.get("e.force:closeQuickAction");
        lCloseModal.fire();
    },

    showToast : function(component, event, strTitle, strMessage, strType) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": strTitle,
            "message": strMessage,
            "type" : strType
        });
        toastEvent.fire();
    },

    resetObjectScriptRule:function(component, event, intIndex){
        var lLstScriptRules = JSON.parse(JSON.stringify(component.get('v.lstScriptRule')));
        var objScriptRule = lLstScriptRules[intIndex];
        objScriptRule.fieldScriptAPI = "";
        objScriptRule.operatorScript = "";
        objScriptRule.lstCampos = [];
        objScriptRule.lstPicklist = [];
        objScriptRule.valueToCompare = "";
        objScriptRule.filterScript = "";
        objScriptRule.isValid = false;
        for(var iCont in lLstScriptRules){
            if(iCont != intIndex){ continue; }
            lLstScriptRules[iCont] = objScriptRule;
        }
        component.set("v.lstScriptRule", lLstScriptRules);
    },

    resetByFieldScriptRuleHelper:function(component, event, intIndex){
        var lLstScriptRules = JSON.parse(JSON.stringify(component.get('v.lstScriptRule')));
        var objScriptRule = lLstScriptRules[intIndex];
        objScriptRule.operatorScript = "";
        objScriptRule.lstPicklist = [];
        objScriptRule.valueToCompare = "";
        objScriptRule.filterScript = "";
        objScriptRule.isValid = false;
        for(var iCont in lLstScriptRules){
            if(iCont != intIndex){ continue; }
            lLstScriptRules[iCont] = objScriptRule;
        }
        component.set("v.lstScriptRule", lLstScriptRules);
        this.setIsValid(component, event, intIndex);
    },

    setIsValid:function(component, event, intIndex){
        var lLstScriptRules = JSON.parse(JSON.stringify(component.get('v.lstScriptRule')));
        var lScriptRule = lLstScriptRules[intIndex];
        
        if(!lScriptRule.objectAPI || !lScriptRule.fieldScriptAPI || !lScriptRule.operatorScript || 
             (lScriptRule.fieldType != "checkbox" && lScriptRule.operatorScript != "itHas" && lScriptRule.operatorScript != "doesntHave" && !lScriptRule.valueToCompare) || (lScriptRule.objectAPI != "Account" && !lScriptRule.filterScript)){
                 
            lScriptRule.isValid = false;
        }else{
            lScriptRule.isValid = true;
        }
        for(var iCont in lLstScriptRules){
            if(iCont != intIndex){ continue; }
            lLstScriptRules[iCont] = lScriptRule;
        }
        component.set("v.lstScriptRule", lLstScriptRules);
        this.validateAllRulesIsValid(component, event);
    },
    
    validateAllRulesIsValid:function(component, event){
        var lLstScriptRules = JSON.parse(JSON.stringify(component.get('v.lstScriptRule')));
        var lBlnAllIsValid = true;
        for(var iCont in lLstScriptRules){
            if(lLstScriptRules[iCont].isValid){ continue; }
            lBlnAllIsValid = false;
        }
        component.set('v.blnAllScriptRulesIsValid', !lBlnAllIsValid);
    },

    setFieldTypeToValueCompare:function(component, event, intIndex){
        var lLstScriptRules = JSON.parse(JSON.stringify(component.get('v.lstScriptRule')));
        var lMapInfoFields = JSON.parse(JSON.stringify(component.get('v.mapInfoFields')));
        var lStrObjectAPI = lLstScriptRules[intIndex].objectAPI;
        var lStrFieldAPI = lLstScriptRules[intIndex].fieldScriptAPI;
        var lLstInfoFields = lMapInfoFields[lStrObjectAPI];
        for(var iCont in lLstInfoFields){
            if(lLstInfoFields[iCont].strFieldAPI != lStrFieldAPI){ continue; }
            lLstScriptRules[intIndex].fieldType = lLstInfoFields[iCont].strFieldType;
            lLstScriptRules[intIndex].lstPicklist = lLstInfoFields[iCont].mapPicklistValueAndLabel;
            break;
        }
        component.set('v.lstScriptRule', lLstScriptRules);
    }
})