({
    getServiceFlow : function(component, event, helper) {
        LightningUtil.callApex(component, 'getServiceFlow', { pageReference : component.get('v.pageReference') }, (result) =>{

			if(result){

                result.firstLevel.sort(function(a, b) {
                    var textA = a.label;
                    var textB = b.label;
                    return (textA < textB) ? -1 : (textA > textB) ? 1 : 0;
                });
                result.secondLevel.sort(function(a, b) {
                    var textA = a.label;
                    var textB = b.label;
                    return (textA < textB) ? -1 : (textA > textB) ? 1 : 0;
                });
                result.thirdLevel.sort(function(a, b) {
                    var textA = a.label;
                    var textB = b.label;
                    return (textA < textB) ? -1 : (textA > textB) ? 1 : 0;
                });
                result.fourthLevel.sort(function(a, b) {
                    var textA = a.label;
                    var textB = b.label;
                    return (textA < textB) ? -1 : (textA > textB) ? 1 : 0;
                });

                component.set('v.ltFirstLevel',         result.firstLevel);
                component.set('v.ltSecondLevelFull',    result.secondLevel);
                component.set('v.ltThirdLevelFull',     result.thirdLevel);
                component.set('v.ltFourthLevelFull',    result.fourthLevel);

                this.loadMap(component, result);
			}
		});
    },

    loadMap: function(component, result){
        var breadMap = new Map();
        var serviceQualificationMap = new Map();
        var fullList = [];

        fullList.push.apply(fullList, result.firstLevel);
        fullList.push.apply(fullList, result.secondLevel);
        fullList.push.apply(fullList, result.thirdLevel);
        fullList.push.apply(fullList, result.fourthLevel);

        fullList.forEach(item => {
            breadMap.set(item.name,item.label); 
        });

        result.ltServiceQualification.forEach(item => {
            serviceQualificationMap.set(item.Id ,item.GPSId__c);
        });

        component.set('v.serviceQualificationMap', serviceQualificationMap);
        component.set('v.mapBreadcrumb',breadMap);
    },

    getAssetFixedByAccount: function(component, event, helper) {
        var id = component.get('v.recordId');
		var ltAsset = [];
        var mapAsset = new Map();
    
        LightningUtil.callApex(component, 'getAssetFixedByAccount', { accountId: id }, (result) => {
		
			if(result){
                result.push({Id: '1', Type__c: 'Outro', Instance__c: ' '});
        
                ltAsset = result.map(asset => ({
                    label: asset.Type__c + ': ' + asset.Instance__c,
                        value: asset.Id
                    })
                );
                
                for(let i in result){
                    if(result[i].Id != null){
                        mapAsset.set(result[i].Id, result[i]);
                    }
                }
        
                component.set('v.ltAsset', ltAsset);
                component.set('v.mapAsset', mapAsset);
			}
		});
    },

    fillNextLevel: function(component, event, levelList, parentFlow){
        var serviceQualificationMap = component.get('v.serviceQualificationMap').get(parentFlow);

        if(serviceQualificationMap){
            component.set('v.selectedFlow', parentFlow);
            this.setEvent(component);
        }
        var ltFlow = [];
        var ltFlowFull = component.get(levelList + 'Full');
        var item;

        for(item in ltFlowFull){
            if(ltFlowFull[item].parent == parentFlow){
                ltFlow.push(ltFlowFull[item]);
            }
        }

        component.set(levelList, ltFlow);
    },

    listForBreadcrumb: function(component, index, name){
        var list = component.get('v.listBreadcrumb');    
        var label = component.get('v.mapBreadcrumb').get(name);

        if (list[index]) {
            list[index] = label;
        }else{
            list.push(label);
        }
        component.set('v.listBreadcrumb',list);
    },

    createBreadcrumb: function(component){
        var list = component.get('v.listBreadcrumb');
        var breadcrumb;

        for (let index = 0; index < list.length; index++) {
            breadcrumb = ((index==0)  ? list[index] : breadcrumb +' > '+list[index]);
        }
        component.set('v.breadcrumb',breadcrumb);
    },

    setEvent: function(component, event, helper){
        component.set('v.isLoading', true); 
        this.createBreadcrumb(component);

        var evt = component.getEvent("ServiceContainerEvent");;
        evt.setParam('type', 'ServiceFlowGPS_ExecuteCanvas');
        evt.fire();
    }
})