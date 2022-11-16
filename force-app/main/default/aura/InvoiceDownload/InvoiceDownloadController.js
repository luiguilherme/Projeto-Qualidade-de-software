({
    doInit : function(component, event, helper) {
        console.log('init');
        helper.doInit(component);    
    },
    

    handleComponentEvent : function(component, event, helper) {
        component.set("v.loaded", true);


    }
    
})