({
	// Your renderer method overrides go here
    afterRender: function (component, helper) {
        this.superAfterRender();
        // interact with the DOM here
        var account = component.get('v.selectedRecord');
        if(account.Id != null){
            var iconSearch = component.find("iconSearch");
            $A.util.removeClass(iconSearch, 'slds-show');
            $A.util.addClass(iconSearch, 'slds-hide');
            
        }
    }
})