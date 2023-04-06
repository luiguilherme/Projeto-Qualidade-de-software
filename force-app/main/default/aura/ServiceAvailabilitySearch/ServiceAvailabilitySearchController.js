({
    doInit : function(component, event, helper) {
        var checkRecordId = component.get("v.recordId");
        if( checkRecordId != null || checkRecordId != undefined){
          helper.getAccount(component);
          helper.getAddressList(component); 
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
            component.set("v.addressSelected", false);
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
        let addressLst = component.get('v.addressList');
        if(!addressId) {
            component.set('v.addressSelected', false);
            component.set('v.zipCode', '');
            component.set('v.stNumber', '');
            component.set('v.isZipCodeFieldDisabled', false);
            component.set('v.isNumberFieldDisabled', false);
            return
        }else{
            let selected = addressLst[addressId];

            component.set('v.addressSelected', true);
            component.set('v.zipCode', selected.PostalCode);
            component.set('v.stNumber', selected.StreetNumber);
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