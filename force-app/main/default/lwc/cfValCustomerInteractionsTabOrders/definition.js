let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":false,"name":""},"type":"IntegrationProcedures","value":{"dsDelay":"","inputMap":{"recordId":"{recordId}"},"ipMethod":"val_GetUserPermission","jsonMap":"{\"recordId\":\"{recordId}\"}","resultVar":"","vlocityAsync":false}},"enableLwc":true,"events":[{"actionList":[{"card":"{card}","draggable":false,"isOpen":true,"key":"1645554098277-zdyecvrt1","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"tabActive","fieldValue":"{action.tabname}"}],"id":"flex-action-1645554101840","type":"cardAction"}}],"channelname":"updatetab","displayLabel":"updatetab:tabselected","element":"action","eventLabel":"pubsub","eventname":"tabselected","eventtype":"pubsub","key":"event-0","recordIndex":"0"}],"isFlex":true,"lwc":{"DeveloperName":"cfValCustomerInteractionsTabOrders_2_FelipeSilveira","Id":"0Rb76000000DEa5CAG","ManageableState":"unmanaged","MasterLabel":"cfValCustomerInteractionsTabOrders_2_FelipeSilveira","NamespacePrefix":"c"},"selectableMode":"Multi","states":[{"actions":[],"childCards":["valCustomerOrders"],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-0","name":"FlexCard","property":{"cardName":"valCustomerOrders","cardNode":"","isChildCardTrackingEnabled":false,"parentAttribute":{"AccountId":"{AccountId}","CustomerInteractionNumber":"{InteractionNumber}","InteractionId":"{ContextId}"},"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"UserPermission.TabOrdersPrepaid","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Orders","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-card slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small slds-m-bottom_x-small ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n         ","text":{"align":"","color":""}}},{"actions":[],"blankCardState":false,"childCards":["valMessageAlert"],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-0","name":"FlexCard","property":{"cardName":"valMessageAlert","cardNode":"","isChildCardTrackingEnabled":false,"parentAttribute":{"ErrorMessage":"Sem permissão"},"recordId":"{recordId}","selectedState":"WarningCustomAttribute"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"UserPermission.TabOrdersPrepaid","hasMergeField":false,"id":"state-new-condition-15","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"documents":[],"fields":[],"isSmartAction":false,"name":"No Permission","omniscripts":[],"smartAction":{},"styleObject":{"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small","container":{"class":"slds-card"},"margin":[{"size":"x-small","type":"bottom"}],"padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12"}}],"theme":"slds","title":"valCustomerInteractionsTabOrders","Id":"a5W760000007XUoEAM","vlocity_cmt__GlobalKey__c":"valCustomerInteractionsTabOrders/FelipeSilveira/2/1695148124082","vlocity_cmt__IsChildCard__c":false};
  export default definition