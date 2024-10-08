({
    setUtilityHeigth : function(component, event, helper) {
        let windowSize = window.innerHeight * 0.825;
        let windowSizeText = windowSize.toString();
        console.log(windowSize);
        var utilityAPI = component.find("ChatIAutilitybar");
        utilityAPI.setPanelHeight({heightPX: windowSizeText});
        

        var eventHandler = function(response){
            component.find("chatIA").forceScroll();
        };

        utilityAPI.onUtilityClick({ 
            eventHandler: eventHandler 
        }).then(function(result){
            console.log(result);
        }).catch(function(error){
            console.log(error);
        });
    }
})