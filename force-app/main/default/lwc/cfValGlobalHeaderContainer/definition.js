let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{},"type":null,"value":{}},"enableLwc":true,"events":[{"actionData":{"card":"{card}","draggable":true,"isOpen":false,"key":"1624262663924-mkfezf2yb","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"Session.pricelistId","fieldValue":"{action.response.records[0].details.records[0].PriceListId__c}"},{"fieldName":"Session.ObjectType","fieldValue":"{action.response.records[0].details.records[0].ObjectType}"},{"fieldName":"Session.cartDetails","fieldValue":"{action.response.records[0].details}"}],"id":"flex-action-1622026494886","type":"cardAction"}},"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1633063808888-77i4u0xzh","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"Session.pricelistId","fieldValue":"{action.response.records[0].details.records[0].PriceListId__c}"},{"fieldName":"Session.ObjectType","fieldValue":"{action.response.records[0].details.records[0].ObjectType}"},{"fieldName":"Session.cartDetails","fieldValue":"{action.response.records[0].details}"},{"fieldName":"Session.isMultisiteFlow","fieldValue":"{action.isMultisiteFlow}"},{"fieldName":"Session.cartId","fieldValue":"{action.response.records[0].details.records[0].Id}"}],"id":"flex-action-1644224876772","type":"cardAction"}}],"channelname":"cpq_{recordId}","displayLabel":"cpq_{recordId}:cpq_cart_updated","element":"action","eventLabel":"pubsub","eventname":"cpq_cart_updated","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"false"},{"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1633063808888-7ugxgmg51","label":"Action","stateAction":{"eventName":"cpq_{recordId}","extraParams":{"cartType":"{action.carttype}","enteredQuantity":"{action.value}","getInputMethod":"prepareUpdateCartItemInput","handleResponseMethod":"processUpdateCartItemResponse","hierarchyPath":"{action.hierarchypath}","input":"{}","ipMethod":"CPQ_UpdateCartItem","itemId":"{action.itemid}","methodName":"updateCartItem","responseEventName":"cpq_updateCartItem_responseEvent","updateType":"quantity"},"hasExtraParams":true,"id":"flex-action-1626014528129","message":"cpq_ui_event","subType":"PubSub","type":"Event"}}],"channelname":"cpqQuantityField_{recordId}","displayLabel":"cpqQuantityField_{recordId}:baseinputvaluechange","element":"action","eventLabel":"pubsub","eventname":"baseinputvaluechange","eventtype":"pubsub","key":"event-1","recordIndex":"0","showSpinner":"false"},{"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1633063808888-1veg4ons6","label":"Action","stateAction":{"eventName":"cpq_{recordId}","extraParams":{"attributeCategoryId":"{action.attributecategoryid}","attributeCheckboxValue":"{action.checked}","attributeId":"{action.attributeid}","attributeValue":"{action.value}","cartType":"{action.carttype}","getInputMethod":"prepareUpdateCartItemInput","handleResponseMethod":"processUpdateCartItemResponse","hierarchyPath":"{action.hierarchypath}","input":"{}","ipMethod":"CPQ_UpdateCartItem","itemId":"{action.itemid}","methodName":"updateCartItem","responseEventName":"cpq_updateCartItem_responseEvent","updateType":"attribute"},"hasExtraParams":true,"id":"flex-action-1626014493778","message":"cpq_ui_event","subType":"PubSub","type":"Event"}}],"channelname":"cpqProductAttributes_{recordId}","displayLabel":"cpqProductAttributes_{recordId}:baseinputvaluechange","element":"action","eventLabel":"pubsub","eventname":"baseinputvaluechange","eventtype":"pubsub","key":"event-2","recordIndex":"0","showSpinner":"false"},{"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1633063808888-mai6deosk","label":"Action","stateAction":{"eventName":"cpq_{recordId}","extraParams":{"cartType":"{action.cartType}","getInputMethod":"prepareDeleteItemFromCartInput","handleResponseMethod":"processDeleteItemFromCartResponse","hierarchyPath":"{action.hierarchyPath}","ipMethod":"CPQ_DeleteItemFromCart","itemId":"{action.itemId}","methodName":"deleteItemFromCart","minQuantity":"{action.minQuantity}","parentObject":"{action.parentObject}"},"hasExtraParams":true,"id":"flex-action-1626014508344","message":"cpq_ui_event","subType":"PubSub","type":"Event"}}],"channelname":"cpq_{recordId}","displayLabel":"cpq_{recordId}:cpq_delete_item","element":"action","eventLabel":"pubsub","eventname":"cpq_delete_item","eventtype":"pubsub","key":"event-3","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1657019365214-palan2bzo","label":"Action","stateAction":{"channelName":"close_configurator_modal","displayName":"Action","flyoutLwc":"c-p-q-cart-configurator-multi-language","flyoutParams":{"ContextId":"{recordId}"},"flyoutType":"OmniScripts","hasExtraParams":true,"id":"flex-action-1657019431885","layoutType":"lightning","openFlyoutIn":"Modal","openUrlIn":"Current Window","osName":"CPQ/cartConfigurator/Multi-Language","type":"Flyout","vlocityIcon":"standard-default"}}],"channelname":"cpq_{recordId}","displayLabel":"cpq_{recordId}:cpq_addtocart_response","element":"action","eventLabel":"pubsub","eventname":"cpq_addtocart_response","eventtype":"pubsub","key":"event-4","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1658151894644-t3myeeai0","label":"Get Async Job status","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"Session.isAsyncProcessCompleted","fieldValue":"{action.response.isAsyncProcessCompleted}"},{"fieldName":"Session.isAsyncProcessesPresent","fieldValue":"{action.response.isAsyncProcessesPresent}"}],"id":"flex-action-1658161386460","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"cpq_{recordId}","displayLabel":"cpq_{recordId}:cpq_update_bulk_async_job_status","element":"action","eventLabel":"pubsub","eventname":"cpq_update_bulk_async_job_status","eventtype":"pubsub","key":"event-5","recordIndex":"0","showSpinner":"false"}],"globalCSS":false,"isFlex":true,"lwc":{"DeveloperName":"cfValGlobalHeaderContainer_1_Telefonica_Deloitte_Otavio","Id":"0Rb760000008yNTCAY","MasterLabel":"cfValGlobalHeaderContainer_1_Telefonica_Deloitte_Otavio","NamespacePrefix":"c","ManageableState":"unmanaged"},"multilanguageSupport":true,"osSupport":true,"selectableMode":"Multi","sessionVars":[{"name":"cartId","val":""},{"name":"pricelistId","val":"null"},{"name":"ObjectType","val":"Order"},{"name":"cartDetails","val":"null"},{"name":"isMultisiteFlow","val":"null"},{"name":"isAsyncProcessesPresent","val":"null"},{"name":"isAsyncProcessCompleted","val":"null"}],"states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[]}},"conditions":{"group":[{"field":"Session.pricelistId","hasMergeField":false,"id":"state-new-condition-4","operator":"!=","type":"custom","value":"null"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valGlobalHeaderContainer","Name":"valGlobalHeaderContainer","uniqueKey":"valGlobalHeaderContainer_undefined_undefined","Id":"a5W760000007XGXEA2","vlocity_cmt__GlobalKey__c":"valGlobalHeaderContainer/Telefonica_Deloitte_Otavio/1/1675432394997","vlocity_cmt__IsChildCard__c":true};
  export default definition