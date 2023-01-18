({
    chronometerCallback: null,

    doInit : function(component, event, helper) {
        let format = component.get("v.format");

        this.chronometerCallback = null;

        if (!format || (format != "00" && format != "00:00:00")) {
            format = "00:00:00";

            component.set("v.format", format);
        }

        if (format == "00:00:00") {
            component.set("v.directionUpOrDown", "Up");
        }

        let directionUpOrDown = component.get("v.directionUpOrDown");
        let display = format;

        if (directionUpOrDown == "Down") {
            let secondsToAction = component.get("v.secondsToAction");

            display = secondsToAction.toString().padStart(2, "0");
        }

        component.set("v.chronometer", new Object({display: display}));
        component.set("v.inicialized", "true");

        if (component.get("v.startAutomatically")) {
            this.startChronometer(component);
        }
    },

    startChronometer: function(component) {
        this.resetChronometerCallback(component);
		this.setChronometerCallback(component);
	},

    stopChronometer: function() {
        if (this.chronometerCallback != null) {
            window.clearTimeout(this.chronometerCallback);

            this.chronometerCallback = null;
        }
	},

    resetChronometerCallback: function(component) {
        let chronometer = component.get("v.chronometer");

		this.stopChronometer();

        let display = component.get("v.format");

        if (display == "00") {
            let directionUpOrDown = component.get("v.directionUpOrDown");
            let value = -1;

            if (directionUpOrDown == "Down") {
                let secondsToAction = component.get("v.secondsToAction");

                value = (secondsToAction + 1);
            }

            display = value.toString().padStart(2, "0");
        }

        chronometer.display = display;

        component.set("v.chronometer", chronometer);
	},

    restartChronometer: function(component) {
        let chronometer = component.get("v.chronometer");

        chronometer.display = component.get("v.format");

        component.set("v.chronometer", chronometer);
	},

    setChronometerCallback: function(component) {
        let allowAction = false;

        if (component.get("v.inicialized")) {
            let format = component.get("v.format");
            let directionUpOrDown = component.get("v.directionUpOrDown");
            let secondsToAction = component.get("v.secondsToAction");
            let chronometer = component.get("v.chronometer");
            let elapsedTime = chronometer.display;
            let display;

            if (format == "00") {
                if (directionUpOrDown == "Down") {
                    elapsedTime--;

                } else {
                    elapsedTime++;
                }

                display = elapsedTime.toString().padStart(2, "0");
                allowAction = true;

            } else if (format == "00:00:00") {
                let initialTime = elapsedTime.split(":");
                let initialDate = new Date();
        
                initialDate.setHours(initialTime[0]);
                initialDate.setMinutes(initialTime[1]);
                initialDate.setSeconds(initialTime[2]);
        
                let finalDate = new Date(initialDate.valueOf() + 1000);
                let tempTime = finalDate.toTimeString().split(" ");
                let finalTime = tempTime[0].split(":");
        
                display = (finalTime[0] + ":" + finalTime[1] + ":" + finalTime[2]);
            }
        
            chronometer.display = display;

            component.set("v.chronometer", chronometer);

            if (allowAction && secondsToAction) {
                if ((directionUpOrDown == "Down" && elapsedTime == 0) ||
                    (directionUpOrDown == "Up" && elapsedTime == secondsToAction)
                ) {
                    this.stopChronometer(component);
                    this.runAction(component);

                    return;
                }
            }

            this.chronometerCallback = setTimeout(
                $A.getCallback(() => this.setChronometerCallback(component)), 
                1000
            );
        }
	},
    
    runAction: function(component) {
        let notificationId = component.get("v.actionNotificationId");

        if (notificationId) {
            let eventSSM = $A.get('e.c:BroadcastNotification');

            eventSSM.setParam("type", notificationId);
            eventSSM.setParam("sobject", null);
            eventSSM.setParam("json", {chronometerAction: notificationId});
    
            eventSSM.fire();
        }
	},

    BroadcastNotificationHandler : function(component, event) {       
        if (event.getParam("type") == "SSMChronometer") {
            event.stopPropagation();

            let jsonSSM = event.getParam("json");

            if (jsonSSM.type == "secondsToAction") {
                component.set("v.secondsToAction", jsonSSM.value);

            } else if (jsonSSM.type == "play") {
                this.startChronometer(component);

            } else if (jsonSSM.type == "stop") {
                this.stopChronometer();

            } else if (jsonSSM.type == "reset") {
                this.resetChronometer(component);

            } else if (jsonSSM.type == "restart") {
                this.restartChronometer(component);
            }
        }
    },

})