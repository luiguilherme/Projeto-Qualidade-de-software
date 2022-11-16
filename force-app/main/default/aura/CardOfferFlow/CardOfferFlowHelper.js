({
    openFlow : function (component, event, helper)
    {
        let action = component.get('c.getOffer');

        action.setParams({
            'aOfferId' : component.get('v.offerId')
        });

        action.setCallback(this, function(response)
        {
            let state = response.getState();
            if (state === 'SUCCESS')
            {
                let offer = response.getReturnValue();

                component.set('v.offerFlow', offer);

                var flow = component.find('flowData');
                let inputVariables = [{ name : "GetOfferId", type : "SObject", value: component.get('v.offerFlow') }];
                flow.startFlow('ScriptAltaMobileSemRPA', inputVariables);
            }
            else
            {
                var errors = response.getError();
                if (errors)
                {
                    if (errors[0] && errors[0].message)
                    {
                        this.showToast('error', '', errors[0].message, '');
                    }
                }
                else { this.showToast('error', '' ,'Erro desconhecido', ''); }
            }
        });
        $A.enqueueAction(action);
    },

    closeModal : function (component, event, helper)
    {
        component.set('v.isToOpenScript', false);
    },

    showToast : function (aType, aTitle, aMessage, aMode)
    {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams
        ({
            "type" : aType,
            "title" : aTitle,
            "message" : aMessage,
            "mode" : aMode
        });
        toastEvent.fire();
    }

})