({
    canvasLoad : function(component, event) {
        const recordId = component.get('v.recordId');    
        component.set("v.isloading", true);
        const callbackError = (exceptions) => {
            component.set("v.isloading", false);
            try {
                component.set("v.canOpenCanvas", false);
                var errorMessage = '';
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        errorMessage = errors[0].message;
                    }
                } else {
                    errorMessage = 'Erro ao executar o canvas'
                }
                component.set("v.message", errorMessage);
            } catch (ex) {
                this.showNotification(
                    component,
                    "Erro",
                    "Erro ao realizar a operação. Tente novamente mais tarde.",
                    "error"
                );
            }
        };

        LightningUtil.callApex(
            component,
            'getCanvasData',
            { recordId },
            (result) => {
                component.set("v.isloading", false);
                console.log('CanvasCPQController.onInit - action.callback - returnValue', result);
                   
                component.set("v.canOpenCanvas",    result.canOpenCanvas);
                component.set("v.message",          result.message);
                component.set("v.canvasAppName",    result.canvasAppName);
                component.set("v.canvasParameters", JSON.stringify(result.parameters));
            },
            callbackError
        );

    },

    canvasLoad : function(component, event, phoneNumber) {
        component.set("v.isloading", true);
        const callbackError = (exceptions) => {
            component.set("v.isloading", false);
            try {
                component.set("v.canOpenCanvas", false);
                var errorMessage = '';
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        errorMessage = errors[0].message;
                    }
                } else {
                    errorMessage = 'Erro ao executar o canvas'
                }
                component.set("v.message", errorMessage);
            } catch (ex) {
                this.showNotification(
                    component,
                    "Erro",
                    "Erro ao realizar a operação. Tente novamente mais tarde.",
                    "error"
                );
            }
        };

        let listIdPhoneNumber = [];
        phoneNumber.forEach(item => {
            listIdPhoneNumber.push(item.Id);
        });
  
        LightningUtil.callApex(
            component,
            'getCanvasData',
            { 
                'listRecordId': listIdPhoneNumber,
                'tipoOferta' : phoneNumber[0].tipoOferta 
            },
            (result) => {
                let assetObj = component.get('v.phoneNumber')[0];
                result.parameters.protocoloAtendimento = assetObj.customerInteractionNumber;
                result.parameters.telefoneMigracao = assetObj.Name;
                result.parameters.tipoProduto = assetObj.ProductType__c;
                result.parameters.idInteracao = assetObj.topicId;
                                
                component.set("v.isloading", false);
                console.log('CanvasCPQController.onInit - action.callback - returnValue', result);
                
                component.set("v.canOpenCanvas",    result.canOpenCanvas);
                component.set("v.message",          result.message);
                component.set("v.canvasAppName",    result.canvasAppName);
                component.set("v.canvasParameters", JSON.stringify(result.parameters));
            },
            callbackError
        );
        

    },
    showNotification: function (component, title, message, variant) {
        component.find("notifLib").showToast({
            variant,
            title: `${title} \n`,
            message,
        });
    },

})