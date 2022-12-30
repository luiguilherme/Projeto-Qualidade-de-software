({
    searchHelper : function(component,event,getInputkeyWord) {
        var action = component.get("c.fetchLookUpValues");
        action.setParams({
            'searchfield': component.get('v.searchfield'),
            'searchKeyWord': getInputkeyWord,
            'objectName' : component.get('v.objectAPIName'),
            'fields' : JSON.stringify(component.get("v.listOffields")),
            'tipoRegistro' : component.get('v.tipoRegistro'),
			'conditions' : ((component.get('v.conditions') == null) ? null : JSON.stringify(component.get('v.conditions'))),
            'addWhereKey' : component.get('v.addWhereKey'),
            'addWhereValue' : component.get('v.addWhereValue'),
            'addWhereIsBoolean': component.get('v.addWhereIsBoolean'),
            'addWhereIn' : component.get('v.addWhereIn'),
            'isAvantAppTheme' : component.get('v.isAvantAppTheme')
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                //this.dump(storeResponse);
                if (storeResponse.length == 0)
                    component.set("v.Message", 'No Result Found...');
                else
                    component.set("v.Message", '');
                
                component.set("v.listOfSearchRecords", storeResponse);
            }
        });
        
        $A.enqueueAction(action);
    },
    dump : function (obj) {
        var out = '';
        for (var i in obj) {
            out += i + ": " + obj[i] + "\n";
        }
        
        alert(out);
    },  
})