({
    doInit: function (component, event, helper) {
        var item = component.get("v.route");
        var list = item.split(';');
        component.set("v.ltItem", list);
    }
})