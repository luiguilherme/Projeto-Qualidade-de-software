({
    doInit : function(component, event, helper) {
        component.set('v.columnsAddress', [
            {label: 'Logradouro', fieldName: 'streetName', type: 'text'},
            {label: 'Cidade', fieldName: 'city', type: 'text'},
            {label: 'Estado', fieldName: 'stateOrProvince', type: 'text'},
            {label: 'Número', fieldName: 'streetNrFirst', type: 'text'},
            {label: 'Complemento', fieldName: 'complement', type: 'text'},
            {label: 'Rede', fieldName: 'networkOwner', type: 'text'}
        ]);
    },
   
    getCoverage : function(component, event, helper) {
        helper.getCoverage(component);
    },

    handleComponentEvent : function(component, event, helper) {
        var selectedTypeFromEvent = event.getParam("type");
        if(selectedTypeFromEvent === 'ADDRESS_CHECK'){
            component.set("v.isLoading", true);
            
            var JSONFromEvent = event.getParam("json");
            var objectFromEvent = event.getParam("sobject");
            component.set('v.JSONResponse', JSONFromEvent);
            
            var action = component.get("c.getGeographicAddressValidation");
            var self = this;
            action.setParams({
                "requestJSON": JSON.stringify(JSONFromEvent)
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                var resp = response.getReturnValue();
                component.set("v.isLoading", false);
                if (state === "SUCCESS" && resp.success == true) {
                    var responseJSON = JSON.parse(resp.body);
                    var ltRecords = [];
                    
                    var sameAddress = false;
                    for(var i = 0; i < responseJSON.length; i++){

                        if(responseJSON[i].streetName == objectFromEvent.streetName && responseJSON[i].streetNrFirst == objectFromEvent.streetNrFirst){
                            sameAddress = true;
                        }

                        var streetFullName = '';
                        streetFullName = responseJSON[i].streetType != null ? responseJSON[i].streetType : streetFullName;
                        streetFullName =  responseJSON[i].streetPrefix != null ? streetFullName + ' ' + responseJSON[i].streetPrefix  : streetFullName;
                        streetFullName += ' ' + responseJSON[i].streetName;

                        ltRecords.push({
                            id : responseJSON[i].id,
                            streetNrFirst : responseJSON[i].streetNrFirst,
                            streetName : streetFullName,
                            postcode : responseJSON[i].postcode,
                            locality : responseJSON[i].locality,
                            city : responseJSON[i].city,
                            complement : responseJSON[i].complement,
                            stateOrProvince : responseJSON[i].stateOrProvince,
                            aliasedGeographicAddress : responseJSON[i].aliasedGeographicAddress,
                            networkOwner : responseJSON[i].aliasedGeographicAddress.networkOwner
                        });

                    }

                    if(sameAddress == false){
                        component.set('v.sameAddress', true);
                    } else{
                        component.set('v.sameAddress', false);
                    }

                    if(ltRecords.length == 1){
                        component.set('v.selectedAddress', ltRecords[0]);
                        component.set('v.data', ltRecords);
                        helper.getCoverage(component);
                    } else {
                        component.set('v.data', ltRecords);
                        component.set('v.ltFilteredData', ltRecords);
                    }
                }
                else {
                    component.set('v.errorMessage', resp.body);
                   
                }
            });
            $A.enqueueAction(action);                               
            
        }
        if(selectedTypeFromEvent === 'ADDRESS_CLEAR'){
            component.set('v.data', []); 
            component.set('v.selectedAddress[0]', '');
            component.set('v.ltFilteredData', []);
            component.set('v.JSONResponse', '');
            component.set('v.sameAddress', false);
            component.set('v.errorMessage', '');
            component.set('v.enterSearch', '');
        }   
    },

    getSelectedAddressRow : function(component, event, helper) {
        var selectedAddress = component.find('ValidateDataTable').getSelectedRows();
        if(selectedAddress.length > 0){
        component.set('v.selectedAddress', selectedAddress[0]);
        }
        helper.isBtnDisabled(component, event);
    },

    filterAddresses : function(component, event, helper){
        var valueSearch = component.get("v.enterSearch");
        var ltAllAddresses = component.get("v.data");
        var ltFilteredAddresses = [];
        var streetNrFirst = '';
        var streetName = '';
        var postcode = '';
        var locality = ''; 
        var city = '';
        var complement = '';
        var stateOrProvince = '';
        var networkOwner = '';

        for (var index in ltAllAddresses) {
            streetNrFirst = ltAllAddresses[index].streetNrFirst;
            streetName = ltAllAddresses[index].streetName;
            postcode = ltAllAddresses[index].postcode;
            locality = ltAllAddresses[index].locality;
            city = ltAllAddresses[index].city;
            complement = ltAllAddresses[index].complement;
            stateOrProvince = ltAllAddresses[index].locality;
            networkOwner = ltAllAddresses[index].networkOwner;
            
                if (
                    (streetNrFirst && streetNrFirst.toLowerCase().includes(valueSearch.toLowerCase())) ||
                    (streetName && streetName.toLowerCase().includes(valueSearch.toLowerCase())) || 
                    (postcode && postcode.toLowerCase().includes(valueSearch.toLowerCase())) || 
                    (locality && locality.toLowerCase().includes(valueSearch.toLowerCase())) || 
                    (city && city.toLowerCase().includes(valueSearch.toLowerCase())) || 
                    (complement && complement.toLowerCase().includes(valueSearch.toLowerCase())) || 
                    (stateOrProvince && stateOrProvince.toLowerCase().includes(valueSearch.toLowerCase())) ||
                    (networkOwner && networkOwner.toLowerCase().includes(valueSearch.toLowerCase()))
                    ){
                        ltFilteredAddresses.push(ltAllAddresses[index]);
                    }
        }
        component.set('v.ltFilteredData', ltFilteredAddresses);
    },

    handleFinish : function(component,event,helper){
        var evt = $A.get('e.c:BroadcastNotification');
        evt.setParam('type', 'ADDRESS_CLEAR');
        evt.fire();        
    },

    disableButton : function(component, event, helper){
        component.set('v.isBtnDisabled', true);
    }
})