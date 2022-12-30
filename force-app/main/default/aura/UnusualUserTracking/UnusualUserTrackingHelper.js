({
	checkPartnerAccess:function(component, event, helper){
        
        console.log('rafa:1');
        
        var action = component.get("c.checkPartnerAccess");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
            	var msgAcc = response.getReturnValue();
                
                console.log('msgAcc: ' + msgAcc);
                if(msgAcc != ''){
                    var eUrl= $A.get("e.force:navigateToURL");
                    eUrl.setParams({
                    "url": '/secur/logout.jsp' 
                    });
                    eUrl.fire();
                }
            }
        });
        $A.enqueueAction(action);
        
    },
})