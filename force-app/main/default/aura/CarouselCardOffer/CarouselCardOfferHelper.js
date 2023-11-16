({
    checkIfAccountHaveUserId: function (component, event, helper, callback) {
        LightningUtil.callApex(component,'checkIfAccountHaveUserId', {accountId : component.get('v.record.vlocity_cmt__AccountId__c')}, 
            (returnValue) =>{
                callback(returnValue);
            }, (errorReturn) =>{
                component.set('v.isWaitingForCheckUserId', false);
                this.showCardError(component, 'error');
            }
        ); 
    },
    
    getCardOffer: function (component, event, helper) {
        LightningUtil.callApex(component, 'getCardsOffers', {accountId : component.get('v.record.vlocity_cmt__AccountId__c'), customerInteractionId : component.get('v.recordId')},
            (returnValue) =>{
                if (returnValue!= null && returnValue.msg == 'success') {
                    var iconName = this.setIconTitle(returnValue.cards[0].title);
                    component.set('v.ltCard', returnValue.cards);
                    component.set('v.iconName', iconName);
                    component.set('v.isWaitingForCheckUserId', false);
                    $A.util.removeClass(component.find('divCarousel'), 'slds-hide');
                    
                    let numberOfOffers = returnValue.cards.length;
                    this.setNumberOfOffers(component, numberOfOffers);
                } else {
                    component.set('v.isWaitingForCheckUserId', false);
                    if (returnValue == null || returnValue == undefined
                        || returnValue.msg == null || returnValue.msg == undefined) {
                        component.set('v.returnMsg', '');
                    }else {
                        component.set('v.returnMsg', returnValue.msg);
                    }
                    $A.util.removeClass(component.find('divCarousel'), 'slds-hide');
                    this.showCardError(component, component.get('v.returnMsg'));
                }
            }, (errorReturn) => {
                if (errorReturn) {
                    component.set('v.isWaitingForCheckUserId', false);
                    $A.util.removeClass(component.find('divCarousel'), 'slds-hide');
                    this.showCardError(component, '');
                }
            }
        );
    },

    sendCardOffer: function (component, cardToSend, acceptOrNot, reason) {
        let card = JSON.stringify(cardToSend);
        LightningUtil.callApex(component, 'postCardOffers', {customerInteractionId : component.get('v.recordId'), accountId : component.get('v.record.vlocity_cmt__AccountId__c'), card: card, acceptOrNot:acceptOrNot, reason: reason}, 
            (returnValue) =>{
                if (returnValue == 'success') {
                    LightningUtil.fireNotification(
                        $A.get('$Label.c.CardOfferToastSuccess'),
                        $A.get('$Label.c.CardOfferToastSuccessMsg'),
                        'success',
                        5000
                    );
                }
            }, (errorReturn) => {
                if (errorReturn) {
                    LightningUtil.fireNotification(
                        $A.get('$Label.c.CardOfferToastErrorException'),
                        $A.get('$Label.c.CardOfferToastErrorExceptionMsg'),
                        'error',
                        5000
                    );
                }
            }
        );
    },

    changePageNumber: function (component, event, helper) {
        let target = event.target;
        let selecIndex = target.getAttribute('data-selected-Index');
        let slideInfo = component.get('v.ltCard');
        let iconName;
        if (slideInfo) {
            for (let i = 0; i < slideInfo.length; i++) {
                slideInfo[i].isFocused = false;
            }
            slideInfo[selecIndex].isFocused = true;
            iconName = this.setIconTitle(slideInfo[selecIndex].title);
        }
        component.set('v.ltCard', slideInfo);
        component.set('v.iconName',iconName);
    },

    setIconTitle: function(mainTitle) {
        let aniversaryString = 'nivers';
        if (mainTitle.includes(aniversaryString)) {
            return 'utility:favorite';
        } else {
            return 'utility:cart';
        }
    },

    getIndexOfCardByHash: function (ltCard, cardHash) {
        let idx;
        for (let index = 0; index < ltCard.length; index++) {
            if (ltCard[index].id == cardHash) {
                idx = index;
            }
        }
        return idx;
    },

    setDisabledCard: function (component, cardHash) {
        let ltCard = component.get('v.ltCard');
        let index = this.getIndexOfCardByHash(ltCard, cardHash);
        ltCard[index].isDisabled = true;

        return ltCard;
    },

    showCardError: function (component, msg) {
        let mainTextError;
        let secondTextError;
        switch (msg) {
            case 'noCardOffer':
                mainTextError = $A.get('$Label.c.CardOfferFirstText');
                secondTextError = $A.get('$Label.c.CardOfferSecondText');
                break;

            case 'noUserId' :
                mainTextError = $A.get('$Label.c.CardOfferTitleNoUserId');
                secondTextError = $A.get('$Label.c.CardOfferBodyNoUserId');
                break;

            case 'Read timed out' :
                mainTextError = $A.get('$Label.c.CardOfferTitleTimeOut');
                secondTextError = $A.get('$Label.c.CardOfferBodyTimeOut');
                break;

            case 'withoutFromToMapping':
                mainTextError = $A.get('$Label.c.CardOfferTitleNoUserChannel');
                secondTextError = $A.get('$Label.c.CardOfferBodyNoUserChannel');
                break;

            default:
                mainTextError = $A.get('$Label.c.CardOfferAvailabilityCalloutError');
                secondTextError = $A.get('$Label.c.CardOfferWithoutInstruction');
                break;
        }

        component.set('v.mainTextError', mainTextError);
        component.set('v.secondTextError', secondTextError);
        component.set('v.dontHaveResponse', true);
    },
    recordUpdated: function (component, event, helper) {
        var changeType = event.getParams().changeType;
        if (changeType === "LOADED" || changeType === undefined) {
            // if (window.LightningUtil === undefined) {
            //     component.set('v.loadUtil', true);
            // } else{
                component.set('v.titleOfComponent', $A.get('$Label.c.CardOfferTitleOfComponent'));
                component.set('v.titleWhenHaveError', $A.get('$Label.c.CardOfferWhenHaveErrorTitle'));
                var flow = component.find('flowData');
                var inputVariables = [
                    {
                        name : 'RecordId', type : 'String', value: component.get('v.record.vlocity_cmt__AccountId__c')
                    }];
                flow.startFlow('ScriptFlow', inputVariables);
                helper.checkIfAccountHaveUserId(component, event, helper, (callback) => {
                    if (callback) {
                        helper.getCardOffer(component, event, helper);
                    } else {
                        component.set('v.isWaitingForCheckUserId', false);
                        helper.showCardError(component, 'noUserId');
                    }
                }                
                );

                component.set('v.isPhone', $A.get('$Browser.isPhone'));
                $A.util.toggleClass(component.find('divDetailForPhone'), 'slds-hide');
                $A.util.toggleClass(component.find('dropDownList'), 'slds-hide');
                $A.util.toggleClass(component.find('divCarousel'), 'slds-hide');
            }
        // }
	},

    setNumberOfOffers: function (component, responseNumberOfOffers){
        let hasNumberOfOffers = component.get('v.record.NumberOfOffers__c');

        if($A.util.isUndefinedOrNull(hasNumberOfOffers)){
            LightningUtil.callApex(
                component, 'setNumberOfOffers',
                {
                    customerInteractionId : component.get('v.recordId'),
                    numberOfOffers : responseNumberOfOffers
                },
                (returnValue) =>{
                    console.log('returnValue> ', returnValue);
                    if (returnValue!= null && returnValue == 'success') {
                        console.info('Número do Posicionamento Gravado com Suceso!');
                    }else{
                        console.error('Falha ao atualizar o número do posicionamento!');
                    }
                }
            );
        }else{
            console.info('Número do Posicionamento já exite!');
        }
    }
})