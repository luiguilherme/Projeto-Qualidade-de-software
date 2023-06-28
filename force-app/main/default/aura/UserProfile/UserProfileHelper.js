({
	getUserId : function(component, event, helper) {

        var action = component.get('c.getUserId');
        action.setParams({
            "recordId": component.get('v.recordId') 
        });
        
        action.setCallback(component,
            function(response) {
                var state = response.getState();
                var userId = response.getReturnValue();

                if (state === 'SUCCESS' && userId == 'true'){
                    var appEvent = $A.get("e.c:UserProfileEvent");
                    appEvent.setParams({ "type" : "unlockedUserId" });
                    appEvent.fire();
                    console.log('Evento enviado.');
                } 
            }
        );
        $A.enqueueAction(action);

	},

    sendEvent: function(component,nomeEvento,parametros){
        let cmpEvent = component.getEvent(nomeEvento);
        cmpEvent.setParams(parametros);
        cmpEvent.fire()
    },

    sendEventApplication : function(nameEvent,params){
        var appEvent = $A.get("e.c:" + nameEvent);
        appEvent.setParams(params);
        appEvent.fire();
    }

})