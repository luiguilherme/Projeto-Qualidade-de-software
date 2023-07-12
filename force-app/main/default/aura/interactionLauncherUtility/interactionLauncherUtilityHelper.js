({
    callUtilityBarApi : function(component) {
        const utilityBarAPI = component.find("utilitybar");
        utilityBarAPI.getEnclosingUtilityId().then(function (utilityId) {
            console.log("utilityId", utilityId);
        });

        var a = component.get('c.disableUtilityPopOut');
        $A.enqueueAction(a);

        utilityBarAPI.onUtilityClick({
            eventHandler: function () {
                console.log("onUtilityClick");
            }
        });        
    }    
})