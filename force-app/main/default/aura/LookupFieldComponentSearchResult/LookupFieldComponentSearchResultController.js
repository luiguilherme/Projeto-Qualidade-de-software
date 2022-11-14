({
    selectRecord : function(component, event, helper){
        var selectedRecord = component.get("v.oRecord");
        var eventName = component.get('v.EventName');
        var evt = $A.get('e.c:BroadcastNotification');

        evt.setParam('type', eventName );
        evt.setParam('sobject', selectedRecord);
        evt.fire();
    },
   
   doInit : function(component, event, helper){
   	var obj = component.get('v.oRecord');
   	var campoLabel = component.get('v.campolabel');
   	var arr = Object.keys(obj);
   	for(var i in arr){
   		if(arr[i] == campoLabel){   			
   			component.set('v.labels', obj[arr[i]]);
   		}
   	}
   }
})