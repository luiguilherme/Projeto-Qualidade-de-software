({
    
    handleComponentEvent : function(component, event, helper) {
        var selectedTypeFromEvent = event.getParam("type");
       
        if(selectedTypeFromEvent === 'SELECT_ACCOUNT'){
            component.set("v.selectedStep", "step2");
        }
        if(selectedTypeFromEvent === 'ADDRESS_CHECK'){
            component.set("v.selectedStep", "step3");
        }  
        if(selectedTypeFromEvent === 'ADDRESS_VALIDATE'){
            component.set("v.selectedStep", "step4");
        }
        if(selectedTypeFromEvent === 'ADDRESS_VALIDATE_ERROR'){
            component.set("v.selectedStep", "step4");
        }
        if(selectedTypeFromEvent === 'ADDRESS_CLEAR'){
            component.set("v.selectedStep", "step1");
        }
        if(selectedTypeFromEvent === 'RETURN_TO_VALIDATE'){
            component.set("v.selectedStep", "step3");
        }
    },
    recordUpdated : function(component, event, helper) {
        let searchComp = component.find("searchComp")
        searchComp.doInit();
    }

})