({
    getAccount:function(component, event, helper){
        
        var action = component.get("c.getAccountRetentionFixed");
        action.setParams({
            "recordId": component.get('v.recordId')
        });
        action.setCallback(this, function(response){
            var state = response.getState();      
            if (state === "SUCCESS") {
                if(response.getReturnValue().length != 0){
                    component.set('v.ltBillingAccount', response.getReturnValue());
                }else{
                    component.set('v.hasBillingAccount',false);

                    let accBilling = {
                        idBilling: '',
                        name: '',
                        totalPrice: '',        
                        totalAmount: '',        
                        ltAsset: [],
                        ltAssetMovel: [],
                        ltOffer: [],
                        selectedOfferId: '',
                        hasAsset: '',
                        hasMultipleAssets: '',
                        hasOffer: '',
                        offerMessage: '',
                        SpeedList: [],
                        TVPlanList: [],
                        FixedLineList: [],
                        OfferGroupList: [],
                        setCityCategories: [],
                        setCabinet: [],
                        setOfferLevel: [],
                        speedSelected: '',
                        tvPlanSelected: '',
                        fixedLineSelected: '',
                        offerGroupSelected: '',
                        accTechnology: ''
                    };

                    var list = [accBilling];

                    component.set('v.ltBillingAccount',list);
                }

                
            } else {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        ("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
})