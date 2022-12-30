({
    doInitLookup : function(component){
        var account = component.get('v.selectedRecord');
        if(account){
            component.set('v.searchKeyWord', account.Name);
            
            var forclose = component.find("lookup-pill");
            $A.util.addClass(forclose, 'slds-show');
            $A.util.removeClass(forclose, 'slds-hide');
            
            var forclose = component.find("searchRes");
            $A.util.addClass(forclose, 'slds-is-close');
            $A.util.removeClass(forclose, 'slds-is-open');
            
            var lookUpTarget = component.find("lookupField");
            $A.util.addClass(lookUpTarget, 'slds-hide');
            $A.util.removeClass(lookUpTarget, 'slds-show');
            
            // Geimison
            var iconSearch = component.find("iconSearch");
            $A.util.removeClass(iconSearch, 'slds-show');
            $A.util.addClass(iconSearch, 'slds-hide');
        
        }
    },
    
    onfocus : function(component,event,helper){
        //Geimison
        var forOpen = component.find("searchRes");
        $A.util.addClass(forOpen, 'slds-is-open');
        $A.util.removeClass(forOpen, 'slds-is-close');
        // Get Default 5 Records order by LastViewedDate DESC  
        var getInputkeyWord = '';
        helper.searchHelper(component,event,getInputkeyWord);
    },
	
    lostFocus : function(component, event, helper){
        window.setTimeout(function (){
            var forOpen = component.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-close');
            $A.util.removeClass(forOpen, 'slds-is-open');
        }, 200 );
        
    },
    
    keyPressController : function(component, event, helper) {
        // get the search Input keyword   
        var getInputkeyWord = component.get("v.searchKeyWord");
        // check if getInputKeyWord size id more then 0 then open the lookup result List and 
        // call the helper 
        // else close the lookup result List part.
        var min = (component.get('v.tamanhoMin') != '')? Number(component.get('v.tamanhoMin')) : 8;
        if( getInputkeyWord.length >= min ){           
            var forOpen = component.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchHelper(component,event,getInputkeyWord);
        }
        else{              
            component.set("v.listOfSearchRecords", null ); 
            var forclose = component.find("searchRes");
            $A.util.addClass(forclose, 'slds-is-close');
            $A.util.removeClass(forclose, 'slds-is-open');
        }
    },
    
    // function for clear the Record Selaction 
    clear :function(component,event,heplper){
        
        var pillTarget = component.find("lookup-pill");
        var lookUpTarget = component.find("lookupField"); 
        
        $A.util.addClass(pillTarget, 'slds-hide');
        $A.util.removeClass(pillTarget, 'slds-show');
        
        $A.util.addClass(lookUpTarget, 'slds-show');
        $A.util.removeClass(lookUpTarget, 'slds-hide');
        
        component.set("v.searchKeyWord",null);
        component.set("v.listOfSearchRecords", null );
        component.set("v.selectedRecord", {} );
        
        // Geimison
        var iconSearch = component.find("iconSearch");
        $A.util.removeClass(iconSearch, 'slds-hide');
        $A.util.addClass(iconSearch, 'slds-show');
    },
    
    // This function call when the end User Select any record from the result list.   
    handleComponentEvent : function(component, event, helper) {
        // get the selected Account record from the COMPONETN event

        var selectedAccountGetFromEvent = event.getParam("sobject");
        var selectedTypeFromEvent = event.getParam("sobject");

        if(selectedTypeFromEvent === 'SELECTED_RECORD'){
            component.set("v.selectedRecord" , selectedAccountGetFromEvent);
            
            var forclose = component.find("lookup-pill");
            $A.util.addClass(forclose, 'slds-show');
            $A.util.removeClass(forclose, 'slds-hide');
            
            var forclose = component.find("searchRes");
            $A.util.addClass(forclose, 'slds-is-close');
            $A.util.removeClass(forclose, 'slds-is-open');
            
            var lookUpTarget = component.find("lookupField");
            $A.util.addClass(lookUpTarget, 'slds-hide');
            $A.util.removeClass(lookUpTarget, 'slds-show');
            
            // Geimison
            var iconSearch = component.find("iconSearch");
            $A.util.addClass(iconSearch, 'slds-hide');
            $A.util.removeClass(iconSearch, 'slds-show');
            
        }
    },
    
    // automatically call when the component is done waiting for a response to a server request.  
    hideSpinner : function (component, event, helper) {
        var spinner = component.find('spinner');
        var evt = spinner.get("e.toggle");
        evt.setParams({ isVisible : false });
        evt.fire();    
    },
    
    // automatically call when the component is waiting for a response to a server request.
    showSpinner : function (component, event, helper) {
        var spinner = component.find('spinner');
        var evt = spinner.get("e.toggle");
        evt.setParams({ isVisible : true });
        evt.fire();    
    }
})