({
    doInit : function(component, event, helper) {
        component.set('v.columnsAddress', [
            {label: 'Logradouro', fieldName: 'streetName', type: 'text'},
            {label: 'CEP', fieldName: 'postcode', type: 'text'},
            {label: 'Bairro', fieldName: 'locality', type: 'text'},
            {label: 'Cidade', fieldName: 'city', type: 'text'},
            {label: 'Estado', fieldName: 'stateOrProvince', type: 'text'},
            {label: 'Número', fieldName: 'streetNrFirst', type: 'text'}
        ]);

        helper.fetchAddressComplementPicklist(component);
        helper.fetchAddressSpecialCities(component);
        helper.fetchAddressBlockLotCities(component);
    },

    getSelectedAddressRow : function(component, event, helper) {
        var selectedRows = event.getParam('selectedRows');        
        var selectedAddress = component.find('addressDataTable').getSelectedRows();

        if(selectedAddress.length > 0){

            var streetNameSelected = selectedAddress != undefined && (selectedAddress[0].streetName == null || selectedAddress[0].streetName == undefined)? null : 'Nenhum';
    
            if(selectedAddress[0].streetName == undefined || selectedAddress[0].streetName == null){
                component.set('v.freeText', true);
            } else{
                component.set('v.freeText', false);
            }
            
            component.set('v.selectedAddress', selectedAddress);
            component.set('v.showForm', true)
            component.set('v.streetNameSelected', streetNameSelected);  
            
            // Cities validation
            var specialCities = component.get('v.addressSpecialCities');
            if(specialCities.includes(`${selectedAddress[0].city}-${selectedAddress[0].stateOrProvince}`)){
                component.set('v.isSpecialCity', true);
                component.set('v.selectedAddress[0].streetNrFirst', '');
                component.set('v.isRequired', false);
                component.set('v.isComplementDisabled', true);
                component.set('v.isBtnDisabled', false);
                component.set('v.JSONResponse.brazilianUrbanPropertyAddress.streetNrFirst', '');
            } else {
                component.set('v.isSpecialCity', false);
                component.set('v.isComplementDisabled', false);

            }
           
            var isBlockLotCity = component.get('v.addressBlockLotCities');
            if(isBlockLotCity.includes(`${selectedAddress[0].city}-${selectedAddress[0].stateOrProvince}`)){
                component.set('v.isBlockLotCity', true);
            } else {
                component.set('v.isBlockLotCity', false);
            }

            helper.isBtnDisabledCheck(component);
        }
    },

    isBtnDisabledCheck : function(component, event, helper){
        helper.isBtnDisabledCheck(component);
    },

    btnController : function(component, event, helper){
        helper.formValidation(component);
    },

    handleComponentEvent : function(component, event, helper) {
        var selectedTypeFromEvent = event.getParam("type");
        if(selectedTypeFromEvent === 'SELECT_ACCOUNT'){
            component.set('v.isLoading', true);

            var JSONFromEvent = event.getParam("json");
            component.set('v.JSONResponse', JSONFromEvent);
            var isReadOnlyObj = {
                postCodeReadOnly : JSONFromEvent.brazilianUrbanPropertyAddress.postcode != undefined && JSONFromEvent.brazilianUrbanPropertyAddress.postcode != null ? true : false,
                localityReadOnly : JSONFromEvent.brazilianUrbanPropertyAddress.locality != undefined && JSONFromEvent.brazilianUrbanPropertyAddress.locality != null ? true : false,
                cityReadOnly : JSONFromEvent.brazilianUrbanPropertyAddress.city != undefined && JSONFromEvent.brazilianUrbanPropertyAddress.city != null ? true : false,
                stateReadOnly : JSONFromEvent.brazilianUrbanPropertyAddress.stateOrProvince != undefined && JSONFromEvent.brazilianUrbanPropertyAddress.stateOrProvince != null ? true : false,
                streetNameReadOnly : JSONFromEvent.brazilianUrbanPropertyAddress.streetName  != undefined && JSONFromEvent.brazilianUrbanPropertyAddress.streetName != null ? true : false,
                streetNrFirstReadOnly : JSONFromEvent.brazilianUrbanPropertyAddress.streetNrFirst != undefined && JSONFromEvent.brazilianUrbanPropertyAddress.streetNrFirst != null ? true : false
            };
            component.set('v.isReadOnly', isReadOnlyObj);

            var ltRecords = [];
            ltRecords.push({
                id: JSONFromEvent.brazilianUrbanPropertyAddress.id,
                streetNrFirst: JSONFromEvent.brazilianUrbanPropertyAddress.streetNrFirst,
                streetName: JSONFromEvent.brazilianUrbanPropertyAddress.streetName,
                postcode: JSONFromEvent.brazilianUrbanPropertyAddress.postcode,
                locality: JSONFromEvent.brazilianUrbanPropertyAddress.locality,
                city: JSONFromEvent.brazilianUrbanPropertyAddress.city,
                stateOrProvince: JSONFromEvent.brazilianUrbanPropertyAddress.stateOrProvince
            });
            component.set('v.data', ltRecords);
            component.set('v.isLoading', false);

        }
        if(selectedTypeFromEvent === 'ADDRESS_CLEAR'){
            component.set('v.data', []); 
            component.set('v.selectedAddress', []);
            component.set('v.streetNameSelected', 'Nenhum');
            component.set('v.showForm', false);
            component.set('v.isComplementDisabled', false);
            component.set('v.Complement1', '')
            component.set('v.ComplementType1', '');
            component.set('v.Complement2', '')
            component.set('v.ComplementType2', '');
            component.set('v.Complement3', '')
            component.set('v.ComplementType3', '');
            component.set('v.isBtnDisabled', true);
            component.set('v.freeText', false);
        }
    },

    onChangeType1Controller : function(component, event, helper){
        helper.onChangeType1(component);
        helper.isBtnDisabledCheck(component);
    },

    onChangeType2Controller : function(component, event, helper){
        helper.onChangeType2(component);
        helper.isBtnDisabledCheck(component);
    },

    onChangeType3Controller : function(component, event, helper){
        helper.onChangeType3(component);
        helper.isBtnDisabledCheck(component);
    },

    isBlankCheckComplement1 : function(component, event, helper){
        let complement = component.get('v.Complement1');
        if(complement == ''){
            helper.onChangeType1(component);
        } else {
            helper.isBtnDisabledCheck(component);
        }
    },

    isBlankCheckComplement2 : function(component, event, helper){
        let complement = component.get('v.Complement2');
        if(complement == ''){
            helper.onChangeType2(component);
        } else {
            helper.isBtnDisabledCheck(component);
        }
    },

})