({
    doInit: function(component,event,helper){
        let lista = component.get("v.ltOffer");

        if (lista == null || lista.length === 0) {component.set('v.cmpAble', false);}else{component.set('v.cmpAble', true);}

    }
})