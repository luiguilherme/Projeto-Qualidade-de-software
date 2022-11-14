({
    doInit : function(component, event, helper) {
        var checkRecordId = component.get("v.recordId");
        if( checkRecordId != null || checkRecordId != undefined){
          helper.getAccount(component);
        }
    },

    handleComponentEvent : function(component, event, helper) {
        var selectedTypeFromEvent = event.getParam("type");
        
        if(selectedTypeFromEvent === 'SELECTED_RECORD'){
            var selectedObjectFromEvent = event.getParam("sobject");
            component.set("v.selectedLookUpRecord", selectedObjectFromEvent);
            var childComponent = component.find("accountLookup");
            childComponent.initLookup();
        }

        if(selectedTypeFromEvent === 'ADDRESS_CLEAR'){
            
            var checkRecordId = component.get("v.recordId");
            if( checkRecordId == null || checkRecordId == undefined){
                var lookUp = component.find("accountLookup");
                lookUp.clear();
            } 
            component.set("v.addressSelected", '');
            component.set("v.zipCode", '');
            component.set("v.stNumber", ''); 
            component.set("v.addressId", '');
            component.set("v.selectedStep", "step1");
            component.set("v.hasNumber", false);
            component.set("v.isZipCodeFieldDisabled", false);
            component.set("v.isNumberFieldDisabled", false);
        }
    },

    onChangeAddress : function(component, event, helper){
        var addressId = component.get('v.addressId');
        if(!addressId) {
            component.set('v.addressSelected', null);
            component.set('v.zipCode', '');
            component.set('v.stNumber', '');
            component.set('v.isZipCodeFieldDisabled', false);
            component.set('v.isNumberFieldDisabled', false);
            return
        }
        
        if(addressId === "shipping") {

            let objAddress = {fullAddress: component.get('v.selectedLookUpRecord.ShippingAddress')};
            component.set('v.addressSelected', objAddress);
            component.set('v.zipCode', component.get('v.selectedLookUpRecord.ShippingPostalCode'));
            component.set('v.stNumber', component.get('v.selectedLookUpRecord.ShippingNumber__c'));

        } else if(addressId === "billing") {

            let objAddress = {fullAddress: component.get('v.selectedLookUpRecord.BillingAddress')};
            component.set('v.addressSelected', objAddress);
            component.set('v.zipCode', component.get('v.selectedLookUpRecord.BillingPostalCode'));
            component.set('v.stNumber', component.get('v.selectedLookUpRecord.BillingNumber__c'));

        }
        component.set('v.isZipCodeFieldDisabled', true);
        component.set('v.isNumberFieldDisabled', true);
    },
       
    getAddressCheck : function(component, event, helper) {
        var zipCodeValidation = /^([0-9]{8})/;
        var numbersValidation = /^[0-9]+$/;
        var stNumber = component.get('v.stNumber');
        var zipCode = component.get('v.zipCode');
        var noNumberCheckbox = component.get('v.hasNumber');

        if(stNumber != null){

            if((zipCode.match(zipCodeValidation) && stNumber.match(numbersValidation)) || noNumberCheckbox ) {
                helper.getAccountAddressJS(component);
            } 

        } else {
            if( zipCode.match(zipCodeValidation) || noNumberCheckbox ) {
                helper.getAccountAddressJS(component);
             }
        }
   }, 

    hasNumberCheck : function(component, event, helper){    
        var hasNumber = component.get('v.hasNumber');

        if (hasNumber == true){
            component.set('v.stNumber', 'SN');
            component.set('v.isNumberFieldDisabled', true );
        } else {
            component.set('v.stNumber', '');
            component.set('v.isNumberFieldDisabled', false );
        }
    },
})