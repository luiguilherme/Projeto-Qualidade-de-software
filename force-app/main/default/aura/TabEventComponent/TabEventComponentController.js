({
    onTabFocused : function(component, event, helper) {
        var focusedTabId = event.getParam('currentTabId');
        var workspaceAPI = component.find("workspace");        
        workspaceAPI.getFocusedTabInfo({
            tabId : focusedTabId
        }).then(function(response) {
            if (response.recordId != component.get('v.oppenedAccount')){
                var evt = $A.get('e.c:TabEventNotification');
                evt.setParam('type', 'closeCanvas' );
                evt.setParam('sobject', component.get('v.oppenedAccount'));
                evt.fire();
            }
        });
    },

    handleComponentEvent : function (component,event, helper) {
        var selectedTypeFromEvent = event.getParam("type");
        var accountId = event.getParam("sobject");

        if (selectedTypeFromEvent == 'updateCurrentAccountId') {
            component.set('v.oppenedAccount ', accountId);
        }
    }
})