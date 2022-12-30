({
	recordUpdated: function (component, event, helper) {
        if(window.LightningUtil === undefined) {
            component.set('v.loadUtil', true);
        }
        else {
            helper.recordUpdated(component, event, helper);
        }
	},

    changePageNumber: function (component, event, helper) {
        helper.changePageNumber(component, event, helper);
        component.set('v.openDropDown', false);
    },

    showDetail: function (component, event, helper) {
        var hash = event.target.getAttribute('data-hash');
        var ltCard = component.get('v.ltCard');
        let index = helper.getIndexOfCardByHash(ltCard, hash);
        var ltOffer = ltCard[index].sub_offers;
        
        component.set('v.ltOfferToChild',ltOffer );

        let isPhone = component.get('v.isPhone');
        if (isPhone) {
            $A.util.removeClass(component.find('divDetailForPhone'), 'slds-hide');
            $A.util.addClass(component.find('divCarousel'), 'slds-hide');
        } else{
            component.set('v.showModalDetail', true);
        }
    },

    showCardOffers: function (component, event, helper) {
        $A.util.removeClass(component.find('divCarousel'), 'slds-hide');
        $A.util.addClass(component.find('divDetailForPhone'), 'slds-hide');
    },

    showDropDown: function (component, event, helper) {
        var isOpen = component.get('v.openDropDown');
        if (isOpen) {
            component.set('v.openDropDown', false);
        } else{
            component.set('v.openDropDown', true);
        }
    },

    clickAccepted : function (component, event, helper) {
        var hash = event.target.getAttribute('data-indexAccepted');
        var ltCardWithCardForDisabled = helper.setDisabledCard(component, hash);
        var ltCard = component.get('v.ltCard');
        let index = helper.getIndexOfCardByHash(ltCard, hash);
        var cardToSend = ltCard[index];
        helper.sendCardOffer(component, cardToSend, 'ACEITOU', 'ACEITOU');
        component.set('v.openDropDown', false);   
        component.set('v.ltCard', ltCardWithCardForDisabled);
    },

    clickNotAccepted : function (component, event, helper) {
        var hash = event.target.getAttribute('data-index');
        var item = event.target.getAttribute('data-item');
        var ltCardWithCardForDisabled = helper.setDisabledCard(component, hash);
        var ltCard = component.get('v.ltCard');
        let index = helper.getIndexOfCardByHash(ltCard, hash);
        var cardToSend = ltCard[index];
        helper.sendCardOffer(component, cardToSend, 'RECUSOU', item);
        component.set('v.openDropDown', false);  
        component.set('v.ltCard', ltCardWithCardForDisabled);
    },

    goToBookIntegrado : function (component, event, helper) {
        var urlEvent = $A.get('e.force:navigateToURL');
        urlEvent.setParams({
          'url': '/lightning/n/IntegratedBookTab'
        });
        urlEvent.fire();
    },

    onShowComponent: function(component, event, helper){
        var type = event.getParam('type');

        if(type != 'unlockedUserId'){
            return;
        }
        
        component.set('v.dontHaveResponse', false);
        helper.getCardOffer(component, event, helper);
    },

    recordLoadError: function(component, event, helper) {
        console.log("recordLoadError");
    }
})