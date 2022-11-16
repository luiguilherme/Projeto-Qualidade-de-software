({
    returnToCarousel : function(component, event, helper) {
        var evt = $A.get('e.c:BroadcastNotification');
        evt.fire();
    }

})