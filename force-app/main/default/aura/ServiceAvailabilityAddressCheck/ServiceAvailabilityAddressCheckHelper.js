({
    fetchAddressComplementPicklist : function(component) {
        var action = component.get('c.getAddressPicklistValues');
       
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                var ltOriginalComplement = response.getReturnValue();
                component.set("v.ltAdressComplement", ltOriginalComplement);
                component.set("v.ltAdressComplement1", ltOriginalComplement);
                component.set("v.ltAdressComplement2", ltOriginalComplement);
                component.set("v.ltAdressComplement3", ltOriginalComplement);

            } 
        });
        $A.enqueueAction(action);
    },

    fetchAddressSpecialCities : function(component){
        var action = component.get('c.getAddressSpecialCities');
        var ltSpecialCities;

        action.setCallback(this, function(response){
            var state = response.getState();
    
            if (state === "SUCCESS"){
                ltSpecialCities = response.getReturnValue();
                component.set("v.addressSpecialCities", ltSpecialCities);
            }
        });
        $A.enqueueAction(action);
    },

    fetchAddressBlockLotCities : function(component){
        var action = component.get('c.getAddressBlockLotCities');
        var ltBlockLotCities;

        action.setCallback(this, function(response){
            var state = response.getState();
    
            if (state === "SUCCESS"){
                ltBlockLotCities = response.getReturnValue();
                component.set("v.addressBlockLotCities", ltBlockLotCities);
            }
        });
        $A.enqueueAction(action);
    },
 formValidation : function(component, event, helper){
        this.getValidateAddress(component);
    },

    isBtnDisabledCheck : function(component, event, helper){

        if(component.get('v.isSpecialCity') == true){
            if(component.get('v.selectedAddress[0].streetName') != null || component.get('v.selectedAddress[0].streetName') != '' ){
                component.set('v.isBtnDisabled', false );
            }   
        }else{
            if( component.get('v.selectedAddress[0].streetName') ==  '' || component.get('v.selectedAddress[0].streetName') ==  undefined ||
                component.get('v.selectedAddress[0].streetNrFirst') ==  '' || component.get('v.selectedAddress[0].streetNrFirst') ==  undefined){
                component.set('v.isBtnDisabled', true);
                return;
            }
        } 

        if (component.get('v.ComplementType1') != '' && component.get('v.Complement1') == '' || 
            component.get('v.ComplementType1') == '' && component.get('v.Complement1') != ''){
            component.set('v.isBtnDisabled', true);
            component.set('v.complementInstruction', true);
            return;
            } 

        if (component.get('v.ComplementType2') != '' && component.get('v.Complement2') == '' || 
            component.get('v.ComplementType2') == '' && component.get('v.Complement2') != ''){
            component.set('v.isBtnDisabled', true);
            component.set('v.complementInstruction', true);
            return;
        } 

        if (component.get('v.ComplementType3') != '' && component.get('v.Complement3') == '' || 
            component.get('v.ComplementType3') == '' && component.get('v.Complement3') != ''){
            component.set('v.isBtnDisabled', true);
            component.set('v.complementInstruction', true);
            return;
        }

        component.set('v.isBtnDisabled', false);
        component.set('v.complementInstruction', false);
        }, 


   
    getValidateAddress : function(component, event, helper) {
        // selectedRecord será usado para receber o retorno da api.
        // var selectedRecord = component.get("v.oRecord");
        component.set("v.errorMessage", '');
        
        if(component.get('v.freeText') == true){
            component.set('v.isBtnDisabled', true);
            var selectedAddress = component.get('v.selectedAddress');
            
            var freeText = '';
            freeText += selectedAddress[0].streetNrFirst != undefined && selectedAddress[0].streetNrFirst != '' ? ',' + selectedAddress[0].streetNrFirst : ',';
            freeText += selectedAddress[0].streetType != undefined && selectedAddress[0].streetType != '' ? selectedAddress[0].streetType : '';
            freeText += selectedAddress[0].streetName != undefined && selectedAddress[0].streetName != '' ? selectedAddress[0].streetName + '-' : '';
            freeText += selectedAddress[0].locality != undefined && selectedAddress[0].locality != '' ? ',' + selectedAddress[0].locality : ',';
            freeText += selectedAddress[0].city != undefined && selectedAddress[0].city != '' ? ',' + selectedAddress[0].city : ',';
            freeText += selectedAddress[0].stateOrProvince != undefined && selectedAddress[0].stateOrProvince != '' ? ' - ' +selectedAddress[0].stateOrProvince : '';
            
            var action = component.get("c.getGeographicAddress");
            action.setParams({
                "zipCode" : "",
                "addressNumber": "",
                "freeText": freeText
            });
            action.setCallback(this, function(response) {

                var state = response.getState();
                var resp = response.getReturnValue();
                if (state === "SUCCESS"  && resp.success == true) {
                    var JSONResponse = JSON.parse(resp.body);
                    
                    var ltRecords = [];
                    
                    ltRecords.push({
                        id: JSONResponse.brazilianUrbanPropertyAddress.id,
                        streetNrFirst: JSONResponse.brazilianUrbanPropertyAddress.streetNrFirst != null ? JSONResponse.brazilianUrbanPropertyAddress.streetNrFirst : selectedAddress[0].streetNrFirst,
                        streetName: JSONResponse.brazilianUrbanPropertyAddress.streetName,
                        postcode: JSONResponse.brazilianUrbanPropertyAddress.postcode,
                        locality: JSONResponse.brazilianUrbanPropertyAddress.locality,
                        city: JSONResponse.brazilianUrbanPropertyAddress.city,
                        streetType: JSONResponse.brazilianUrbanPropertyAddress.streetType,
                        stateOrProvince: JSONResponse.brazilianUrbanPropertyAddress.stateOrProvince
                    });

                    component.set('v.data', ltRecords);
                    component.set('v.selectedAddress', []);
                    component.set('v.freeText', false);
                    component.set('v.JSONResponse', JSONResponse);

                    this.isBtnDisabledCheck(component);

                    var streetNameSelected = ltRecords[0].streetName;
                    component.set('v.streetNameSelected', streetNameSelected);

                }
                else {
                    console.log("Failed with state: " + state);
                    component.set("v.errorMessage", resp.body);
                }
            });
            $A.enqueueAction(action);                               
                                
        } else {
            var JSONResponse = component.get('v.JSONResponse');
            var complements = [];
            
            if(component.get('v.Complement1') != '' && component.get('v.ComplementType1')!= ''){
                complements.push(this.createComplement(1,component.get('v.ComplementType1'),component.get('v.Complement1')));  
            }
            if(component.get('v.Complement2') != '' && component.get('v.ComplementType2')!= ''){
                complements.push(this.createComplement(2,component.get('v.ComplementType2'),component.get('v.Complement2')));  
            }
            if(component.get('v.Complement3') != '' && component.get('v.ComplementType3')!= ''){
                complements.push(this.createComplement(3,component.get('v.ComplementType3'),component.get('v.Complement3')));  
            }
            
            JSONResponse.brazilianUrbanPropertyAddress.geographicAddressComplement = complements;
            var selectedAddress = component.get('v.selectedAddress');

            var eventName = component.get('v.EventName');
            var evt = $A.get('e.c:BroadcastNotification');

            evt.setParam('type', eventName);
            evt.setParam('sobject', selectedAddress[0]);
            evt.setParam('json', JSONResponse);
            evt.fire();
        }
    },

    createComplement : function(order, name, value){
        let obj ={
            order : order,
            name : name,
            value : value
        };
       return obj;
    },

    onChangeType1 : function(component){
        var selectedType1 = component.find('ComplementType1').get('v.value');
        component.set('v.ComplementType1', selectedType1);

        
        var ltAdressComplement1 = component.get('v.ltAdressComplement');
        var ltAddressComplement2Filtered = ltAdressComplement1.filter(item  => { return item.Value != selectedType1 });
        var ltAddressComplement3Filtered = ltAdressComplement1.filter(item  => { return item.Value != selectedType1 });

        component.set('v.ltAdressComplement2', ltAddressComplement2Filtered);
        component.set('v.ComplementType2', '');
        component.set('v.Complement2', '');

        component.set('v.ltAdressComplement3', ltAddressComplement3Filtered);
        component.set('v.ComplementType3', '');
        component.set('v.Complement3', '');
    },

    onChangeType2 : function(component){
        var selectedType2 = component.find('ComplementType2').get('v.value');
        component.set('v.ComplementType2', selectedType2);

        var ltAdressComplement2 = component.get('v.ltAdressComplement2');
        var ltAddressComplement3Filtered = ltAdressComplement2.filter(item  => { return item.Value != selectedType2 });

        component.set('v.ltAdressComplement3', ltAddressComplement3Filtered);
        component.set('v.ComplementType3', '');
        component.set('v.Complement3', '');

    },
    
    onChangeType3 : function(component){
        var selectedType3 = component.find('ComplementType3').get('v.value');
        component.set('v.ComplementType3', selectedType3);
    },

})