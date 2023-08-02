({
    onInit : function(component, event, helper) {
        setTimeout(function() {
            helper.callUtilityBarApi(component);
        }, 500);        
    },   
    onRender: function(component, event, helper) {
            const utilityBarAPI = component.find('utilitybar');
            utilityBarAPI.getEnclosingUtilityId().then((utilityId) => {
            	console.log("utilityId", utilityId);        
            });
            utilityBarAPI.onUtilityClick({
                eventHandler: () => {
                    console.log('onUtilityClick');
                }
            });
    },    
    minimizeUtilityId : function(component, event, helper) {
        var utilityAPI = component.find("utilitybar");
        utilityAPI.minimizeUtility().then(function(utilityId) {
            console.log(utilityId);
        })
        .catch(function(error) {
            console.log(error);
        });
    },        
    disableUtilityPopOut : function(component, event, helper) {
        var utilityAPI = component.find("utilitybar");
        utilityAPI.disableUtilityPopOut({
                disabled: true,
                disabledText: ""
        });        
    }, 
    enableUtilityHighlight : function(component, event, helper) {
        var utilityAPI = component.find("utilitybar");
        utilityAPI.setUtilityHighlighted({highlighted:true});
    }
})