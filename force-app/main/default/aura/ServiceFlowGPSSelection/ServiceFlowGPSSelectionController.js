({
    doInit: function (component, event, helper) {
        
        if(window.LightningUtil === undefined){
			component.set('v.loadUtil', true);
		}else{   
            helper.getServiceFlow(component, event, helper);
        }
	},
    handleComponentEvent : function(component, event, helper) {
        var typeEvent = event.getParam('type');

        var workspaceAPI = component.find("workspace");
        workspaceAPI.getTabInfo().then(function(response) {
            var focused = response.focused;
            if(focused){
                if(typeEvent === 'ServiceFlowGPS_ComeBack' || typeEvent === 'ServiceFlowGPS_SelectionFlow'){
                    component.set('v.selectedItemFirstLevel', '');
                    component.set('v.selectedItemSecondLevel', '');
                    component.set('v.ltSecondLevel', []);
                    component.set('v.selectedItemThirdLevel', '');
                    component.set('v.ltThirdLevel', []);
                    component.set('v.selectedItemFourthLevel', '');
                    component.set('v.ltFourthLevel', []);
                    component.set('v.listBreadcrumb', []);
                    component.set('v.selectedFlow', '');
                    component.set('v.breadcrumb', '');
                }
            }
       }).catch(function(error) {
            console.log(error);
        });
    },
    handleSelectFirstLevel: function(component, event, helper){
        event.preventDefault();
        component.set('v.selectedItemFirstLevel', event.getParam('name'));
        component.set('v.selectedItemSecondLevel', '');
        component.set('v.ltSecondLevel', []);
        component.set('v.selectedItemThirdLevel', '');
        component.set('v.ltThirdLevel', []);
        component.set('v.selectedItemFourthLevel', '');
        component.set('v.ltFourthLevel', []);
        helper.listForBreadcrumb(component,0, event.getParam('name'));
        helper.fillNextLevel(component, event, 'v.ltSecondLevel', event.getParam('name'));
    },

    handleSelectSecondLevel: function(component, event, helper){
        event.preventDefault();
        component.set('v.selectedItemSecondLevel', event.getParam('name'));
        component.set('v.selectedItemThirdLevel', '');
        component.set('v.ltThirdLevel', []);
        component.set('v.selectedItemFourthLevel', '');
        component.set('v.ltFourthLevel', []);
        helper.listForBreadcrumb(component,1, event.getParam('name'));
        helper.fillNextLevel(component, event, 'v.ltThirdLevel', event.getParam('name'));
    },

    handleSelectThirdLevel: function(component, event, helper){
        event.preventDefault();
        component.set('v.selectedItemFourthLevel', '');
        component.set('v.ltFourthLevel', []);
        component.set('v.selectedItemThirdLevel', event.getParam('name'));
        helper.listForBreadcrumb(component,2, event.getParam('name'));
        helper.fillNextLevel(component, event, 'v.ltFourthLevel', event.getParam('name'));
    },

    handleSelectFourthLevel: function(component, event, helper){
        event.preventDefault();
        component.set('v.selectedItemFourthLevel', event.getParam('name'));
        helper.listForBreadcrumb(component,3, event.getParam('name'));
        component.set('v.selectedFlow', event.getParam('name'));
        helper.setEvent(component);
    }
})