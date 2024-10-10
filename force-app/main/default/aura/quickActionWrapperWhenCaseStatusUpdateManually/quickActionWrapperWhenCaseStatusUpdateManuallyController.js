({
    handleInit : function(component) {
        var caseId = component.get('v.recordId');

        var sendEmailNotificationAction = component.get('c.sendEmailNotificationWhenCaseStatusUpdatedManually');
        sendEmailNotificationAction.setParam('caseId', caseId);
        sendEmailNotificationAction.setCallback(this, function(response) {
            console.log('response', response);
            var notifications = [...component.get('v.notifications')];            
            var state = response.getState();
            if (state == 'SUCCESS') {
                var responseEmailNotification = response.getReturnValue();
                var emailNotification; 
                if (responseEmailNotification == 'SUCCESS') {
                    emailNotification = {
                        message: 'Email enviado.',
                        theme: 'slds-notify slds-notify_toast slds-theme_success',
                        variant: 'success',
                        icon: 'utility:success'
                    };
                    notifications.push(emailNotification);
                }   
            } else if (state == 'ERROR') {
                var errors = response.getError();
                errors.forEach(error => {
                    console.log('ERROR', error.message);
                    emailNotification = {
                        message: 'Erro no envio do Email: ' + error.message,
                        theme: 'slds-notify slds-notify_toast slds-theme_error',
                        variant: 'error',
                        icon: 'utility:error'
                    };
                    notifications.push(emailNotification);
                });  
            }
            component.set('v.notifications', notifications);
        });

        var sendCallOutNotificationAction = component.get('c.sendCallOutNotificationWhenCaseIsManuallyUpdated');
        sendCallOutNotificationAction.setParam('caseId', caseId);
        sendCallOutNotificationAction.setCallback(this, function(response) {
            var notifications = [...component.get('v.notifications')];
            var state = response.getState();
            var callOutNotification;
            if (state == 'SUCCESS') {
                var responseCallOutNotification = response.getReturnValue();
                if (responseCallOutNotification == 'SUCCESS') {
                    callOutNotification = {
                        message: 'CallOut enviado.',
                        theme: 'slds-notify slds-notify_toast slds-theme_success',
                        variant: 'success',
                        icon: 'utility:success'
                    };
                    notifications.push(callOutNotification);
                }   
            } else if (state == 'ERROR') {
                var errors = response.getError();
                errors.forEach(error => {
                    console.log('ERROR', error.message);
                    callOutNotification = {
                        message: 'Erro no envio do CallOut: ' + error.message,
                        theme: 'slds-notify slds-notify_toast slds-theme_error',
                        variant: 'error',
                        icon: 'utility:error'
                    };
                    notifications.push(callOutNotification);
                });  
            }
            component.set('v.notifications', notifications);

        });

        var sendPushSmsNotificationAction = component.get('c.sendPushSmsNotificationWhenCaseIsManuallyUpdated');
        sendPushSmsNotificationAction.setParam('caseId', caseId);
        sendPushSmsNotificationAction.setCallback(this, function(response) {
            var notifications = [...component.get('v.notifications')];
            var state = response.getState();
            var pushSmsNotification; 
            if (state == 'SUCCESS') {
                var responsepushSmsNotification = response.getReturnValue();
                if (responsepushSmsNotification == 'SUCCESS') {
                    pushSmsNotification = {
                        message: 'Push/SMS enviado.',
                        theme: 'slds-notify slds-notify_toast slds-theme_success',
                        variant: 'success',
                        icon: 'utility:success'
                    };
                    notifications.push(pushSmsNotification);
                }   
            } else if (state == 'ERROR') {
                var errors = response.getError();
                errors.forEach(error => {
                    console.log('ERROR', error.message);
                    pushSmsNotification = {
                        message: 'Erro no envio do Push/SMS: ' + error.message,
                        theme: 'slds-notify slds-notify_toast slds-theme_error',
                        variant: 'error',
                        icon: 'utility:error'
                    };
                    notifications.push(pushSmsNotification);
                });  
            }
            component.set('v.notifications', notifications);

        })

        component.set('v.isLoading', true);
        $A.enqueueAction(sendEmailNotificationAction);
        $A.enqueueAction(sendCallOutNotificationAction); 
        $A.enqueueAction(sendPushSmsNotificationAction);   
        component.set('v.isLoading', false);
    }
})
