({
    openModel: function(component, event, helper) {
        // for Display Model,set the 'isOpen' attribute to 'true'
        var setOfferSelected =  component.get('v.setOfferSelected');
        var ltCardProposal = component.get('v.ltCardProposal');
        var selectedOfferAltaId = component.get('v.selectedOfferAltaId');
        var accountId = component.get('v.accountId');
        var haveToValidate = false;

        component.set('v.setOfferSelected', setOfferSelected),
        component.set('v.ltCardProposal', ltCardProposal),
        component.set('v.selectedOfferAltaId', selectedOfferAltaId),
        component.set('v.accountId', accountId);
        if (setOfferSelected !== undefined) {
            if (setOfferSelected.length != 0 && (selectedOfferAltaId == undefined || selectedOfferAltaId.length ==0)) {
                helper.setOffers(component, haveToValidate, event, helper);
        	} 
            else if (setOfferSelected.length == 0) {
            	helper.validateRulesAlta(component, event, helper);
        	} 
            else{
                haveToValidate = true;
                helper.setOffers(component, haveToValidate, event, helper);
            }
        }      
    },
    
    closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the 'isOpen' attribute to 'Fasle'  
        component.set('v.isOpen', false);
    },

    openModal: function(component, event, helper) {
        component.set('v.returnValidate', true);
    },

    closeModal: function(component, event, helper) {
        component.set('v.returnValidate', false);
    },

    openModalClienteRetido: function(component, event, helper) {
        component.set('v.showClienteRetido', true);
    },

    closeModalClienteRetido: function(component, event, helper) {
        component.set('v.showClienteRetido', false);
    },

    notBtnModalClienteRetido: function(component, event, helper) {
        var actionCloseModalClienteRetido = component.get('c.closeModalClienteRetido');
        $A.enqueueAction(actionCloseModalClienteRetido);
        var actionOpenModal = component.get('c.openModal');
        $A.enqueueAction(actionOpenModal);
    },

    trueBtnModalClienteRetido: function(component, event, helper) {
        var haveToValidate = false;
        var actionCloseModalClienteRetido = component.get('c.closeModalClienteRetido');
        $A.enqueueAction(actionCloseModalClienteRetido);
        helper.setOffers(component, haveToValidate, event, helper);
    },

    gotoURL : function (component, event, helper) {
        var urlEvent = $A.get('e.force:navigateToSObject');
        urlEvent.setParams({
          'recordId': component.get('v.recordId'),
          'slideDevName': 'related'
        });
        urlEvent.fire();
    },

    likenClose: function(component, event, helper) {
        // Display alert message on the click on the 'Like and Close' button from Model Footer 
        // and set set the 'isOpen' attribute to 'False for close the model Box.
        alert('thanks for like Us :)');
        component.set('v.isOpen', false);
    },
    copytextmovel: function(component, event, helper) {
        // Create new element
        var el = document.createElement('textarea');
        // Set value (string to be copied)
        el.value = event.getSource().get('v.value');
        // Set non-editable to avoid focus and move outside of view
        el.setAttribute('readonly', '');
        el.style = {position: 'absolute', left: '-9999px'};
        document.body.appendChild(el);
        // Select text inside element
        el.select();
        // Copy text to clipboard
        document.execCommand('copy');
        // Remove temporary element
        document.body.removeChild(el);
        
        
        var orignalLabel = event.getSource().get('v.value');
        event.getSource().set('v.iconName' , 'utility:check');
        event.getSource().set('v.value' , 'copied');
        setTimeout(function(){ 
            event.getSource().set('v.iconName' , 'utility:copy'); 
            event.getSource().set('v.value' , orignalLabel);
        }, 700);
        component.set('v.isOpen', false);
    },
    
    closeShowClientWithoutPermission: function (component, event, helper){
        component.set('v.showClientWithoutPermission', false);
    },
    
    closeShowClientWithoutLimit: function (component, event, helper){
        component.set('v.showClientWithoutLimit', false);
    }
})