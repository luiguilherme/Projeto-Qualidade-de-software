({
    doInit : function(component, event, helper) {
        let serviceTicket = component.get("v.serviceTicket");
        let elapsedTime = "";

        if (serviceTicket.duration) {
            elapsedTime = serviceTicket.duration;

        } else {
            let lsSSMTicketInfo = LightningUtil.getItemLocalStorage("SSMTicketInfo", "TICKET");
            
            if (lsSSMTicketInfo) {
                try {
                    let SSMTicketInfo = JSON.parse(lsSSMTicketInfo);
                                
                    // Calculate started date/time
                    let startTime = ((startTime.includes(" ")) 
                        ? SSMTicketInfo.startTime.split(" ")[1].split(":")
                        : SSMTicketInfo.startTime.split(":")
                    );
                    
                    let startDateTime = new Date();

                    startDateTime.setHours(startTime[0]);
                    startDateTime.setMinutes(startTime[1]);
                    startDateTime.setSeconds(startTime[2]);

                    // Get date/time now
                    let finishDateTime = new Date();

                    // Calculate elapsed time
                    let milliseconds = Math.abs(finishDateTime - startDateTime)
                    let seconds = Math.floor(milliseconds / 1000);
                    let minutes = Math.floor(seconds / 60);
                    let hours = Math.floor(minutes / 60);

                    seconds = (seconds % 60);
                    minutes = (minutes % 60);
                    hours = (hours % 24);

                    elapsedTime = (
                        hours.toString().padStart(2, "0") + ":" + 
                        minutes.toString().padStart(2, "0") + ":" + 
                        seconds.toString().padStart(2, "0")
                    );


                } catch (error) {

                }
            }
        }

        if (elapsedTime) {
            this.notitySSMChronometer(elapsedTime);
        }
    },

    notitySSMChronometer : function(hours) {
        this.notitySSM("SSMChronometer", {type: "setValue", value: hours});
    },

    notitySSM : function(typeSSM, jsonSSM) {
        let eventSSM = $A.get('e.c:BroadcastNotification');

        eventSSM.setParam("type", typeSSM);
        eventSSM.setParam("sobject", null);
        eventSSM.setParam("json", jsonSSM);

        eventSSM.fire();
    },

})
