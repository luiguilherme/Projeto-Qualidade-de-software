({
    getCoverage : function(component, event, helper) {
        component.set("v.isLoading", true);

        var ltSize = event.getParam("json");
        if(ltSize > 1){
            component.set('v.isDisabled', false);
        }

        var selectedAddress = event.getParam("sobject");
        component.set('v.selectedAddress', selectedAddress);
        
        var action = component.get("c.getAddressCoverage");
        action.setParams({
            "requestJSON": JSON.stringify(selectedAddress.aliasedGeographicAddress)
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var resp = response.getReturnValue();
            component.set("v.isLoading", false);
            if (state === "SUCCESS" && resp.success == true) {
                var responseJSON = JSON.parse(resp.body);
                var objectResponse = {};
                if(responseJSON.physicalResourceAvailability.returnMessage != null && responseJSON.physicalResourceAvailability.returnMessage != undefined){
                    objectResponse.returnMessage = responseJSON.physicalResourceAvailability.returnMessage;
                } else {

                    objectResponse.voiceProtocol = responseJSON.physicalResourceAvailability.brazilianUrbanPropertyAddress.placePhysicalResourceAssoc.physicalLink.voiceProtocol;
                    objectResponse.accessTechnology = responseJSON.physicalResourceAvailability.brazilianUrbanPropertyAddress.placePhysicalResourceAssoc.physicalLink.accessTechnology;
                    objectResponse.cabinetName = responseJSON.physicalResourceAvailability.cabinet.name;
                    objectResponse.cabinetDistance = responseJSON.physicalResourceAvailability.cabinet.distance;
                    
                    if(responseJSON.physicalResourceAvailability.cabinet.technology.length > 0){
                        for(var i = 0; i < responseJSON.physicalResourceAvailability.cabinet.technology.length; i++){
                            if(responseJSON.physicalResourceAvailability.cabinet.technology[i].maxBroadbandSpeed != null){
                                objectResponse.broadbandName = responseJSON.physicalResourceAvailability.cabinet.technology[i].name;
                                objectResponse.maxBroadbandSpeed = responseJSON.physicalResourceAvailability.cabinet.technology[i].maxBroadbandSpeed / 1000;
                                if(responseJSON.physicalResourceAvailability.cabinet.technology[i].available > 0){
                                    objectResponse.available = 'Sim';
                                } else{
                                    objectResponse.available = 'Nao';
                                }
                            }
                            if(responseJSON.physicalResourceAvailability.cabinet.technology[i].tvPlatform != null){
                                objectResponse.tvPlatform = responseJSON.physicalResourceAvailability.cabinet.technology[i].name;
                                // objectResponse.tvPlatform = responseJSON.physicalResourceAvailability.cabinet.technology[i].tvPlatform;
                            }
                        }
                    }
                    objectResponse.accessTechnology =  responseJSON.physicalResourceAvailability.brazilianUrbanPropertyAddress.placePhysicalResourceAssoc.physicalLink.accessTechnology;
                }

            component.set('v.objectResponse', objectResponse);
            component.set('v.errorMessage', '');
            }
            else {
                component.set("v.errorMessage", resp.body);
            }
        });
        $A.enqueueAction(action);                               

    },

    getCoverageError : function (component, event, helper){
        
        var selectedAddress = event.getParam("sobject");
        // var eventname = event.getParam("type");
        var json = event.getParam("json");

        component.set("v.errorMessage", json);
        component.set('v.selectedAddress', selectedAddress);
        component.set("v.isLoading", false);
    }
})