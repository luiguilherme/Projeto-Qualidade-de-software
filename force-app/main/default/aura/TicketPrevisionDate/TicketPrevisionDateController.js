({
    doInit: function (component, event, helper) {		
        
        if(window.LightningUtil === undefined){
			component.set('v.loadUtil', true);
		}else{   
            helper.getPrevisionDate(component, event, helper);
        }   
    }
})