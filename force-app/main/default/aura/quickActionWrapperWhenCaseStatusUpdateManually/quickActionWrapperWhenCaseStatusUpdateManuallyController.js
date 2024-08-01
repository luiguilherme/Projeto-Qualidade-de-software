({
    handleInit : function(component) {

        var sendEmailNotificationAction = component.get('c.sendEmailNotificationWhenCaseStatusUpdatedManually');
        var caseId = component.get('v.recordId');
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

        component.set('v.isLoading', true);
        $A.enqueueAction(sendEmailNotificationAction);  
        component.set('v.isLoading', false);
    }
})
