let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":false,"name":""},"type":"Custom","value":{"body":"{\"options\": [{\"name\":\"\"}], \"value\": \"\", \"select\": false, \"catalogId\":-1, \"multiselectoptions\": [{\"name\":\"\"}], \"multiProdValue\": \"\", \"selectedProductsForPills\": [] }","dsDelay":"","resultVar":""}},"enableLwc":true,"events":[{"actionData":{"card":"{card}","draggable":true,"isOpen":false,"key":"1623161225732-cecwabftj","label":"Action","stateAction":{"eventName":"cpqutils","extraParams":{"cartId":"{recordId}","catalogId":"{catalogId}","ipMethod":"CPQ_GetCartsProducts","select":"{select}","utilMethod":"productSearch","value":"{action.value}"},"hasExtraParams":true,"id":"flex-action-1622437798877","message":"cpq_ui_event","subType":"PubSub","type":"Event"}},"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1626850465760-roes6a2s5","label":"Action","stateAction":{"eventName":"cpqutils_{recordId}","extraParams":{"cartId":"{recordId}","catalogId":"{catalogId}","ipMethod":"CPQ_GetCartsProducts","select":"{select}","utilMethod":"productSearch","value":"{action.value}"},"hasExtraParams":true,"id":"flex-action-1626780135224","message":"cpq_ui_event","subType":"PubSub","type":"Event"}},{"card":"{card}","draggable":true,"isOpen":false,"key":"1626850465760-q1c52w63z","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"Session.value","fieldValue":"{action.value}"},{"fieldName":"Session.select","fieldValue":"false"}],"id":"flex-action-1626849735781","type":"cardAction"}}],"channelname":"type","displayLabel":"type:basetypeaheadinputchange","element":"action","eventLabel":"pubsub","eventname":"basetypeaheadinputchange","eventtype":"pubsub","key":"event-0","recordIndex":"0"},{"actionData":{"card":"{card}","draggable":true,"isOpen":false,"key":"1623161225732-m58nrudph","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"options","fieldValue":"{action.value}"},{"fieldName":"value","fieldValue":"{action.name}"}],"id":"flex-action-1617890271043","type":"cardAction"}},"actionList":[{"card":"{card}","draggable":false,"isOpen":true,"key":"1626850465760-h76w3g2m9","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"Session.value.length","hasMergeField":false,"id":"state-new-condition-0","operator":">=","type":"custom","value":"3"},{"field":"Session.select","hasMergeField":false,"id":"state-new-condition-3","logicalOperator":"&&","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"eventName":"setValues","fieldValues":[{"fieldName":"Session.options","fieldValue":"{action.value}"}],"id":"flex-action-1626850509030","type":"cardAction"}},{"card":"{card}","draggable":false,"isOpen":true,"key":"1626850465760-rhreyoed2","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"Session.value.length","hasMergeField":false,"id":"state-new-condition-9","operator":"<","type":"custom","value":"3"}],"id":"state-condition-object","isParent":true},"eventName":"setValues","fieldValues":[{"fieldName":"Session.options","fieldValue":"[]"}],"id":"flex-action-1626850490585","type":"cardAction"}}],"channelname":"cpq_{recordId}","displayLabel":"cpq_{recordId}:cpqresponse","element":"action","eventLabel":"pubsub","eventname":"cpqresponse","eventtype":"pubsub","key":"event-1","recordIndex":"0"},{"actionData":{"card":"{card}","draggable":true,"isOpen":false,"key":"1623161225732-qx1bd3e7p","label":"Action","stateAction":{"eventName":"cpqutils","extraParams":{"catalogId":"{catalogId}","ipMethod":"CPQ_GetCartsProducts","type":"select","utilMethod":"productSearch","value":"{action.event.detail.name}"},"hasExtraParams":true,"id":"flex-action-1618257896887","message":"cpq_ui_event","subType":"PubSub","type":"Event"}},"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1626850465760-mm2qz7ls1","label":"Action","stateAction":{"eventName":"cpqutils_{recordId}","extraParams":{"catalogId":"{catalogId}","ipMethod":"CPQ_GetCartsProducts","phase":"{Parent.phase}","type":"select","utilMethod":"productSearch","value":"{action.event.detail.name}"},"hasExtraParams":true,"id":"flex-action-1626806029694","message":"cpq_ui_event","subType":"PubSub","type":"Event"}},{"card":"{card}","draggable":true,"isOpen":false,"key":"1626850465760-8azp431wy","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"Session.value","fieldValue":"{action.event.detail.name}"},{"fieldName":"Session.select","fieldValue":"true"}],"id":"flex-action-1626849788364","type":"cardAction"}}],"channelname":"type","displayLabel":"type:baseinputvaluechange","element":"action","eventLabel":"pubsub","eventname":"baseinputvaluechange","eventtype":"pubsub","key":"event-2","recordIndex":"0"},{"actionData":{"card":"{card}","draggable":true,"isOpen":false,"key":"1623161225732-xob4ag1vw","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"select","fieldValue":"false"},{"fieldName":"value","fieldValue":""}],"id":"flex-action-1617892163621","type":"cardAction"}},"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1626850465760-aydctwh3u","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"select","fieldValue":"false"},{"fieldName":"Session.value","fieldValue":""},{"fieldName":"Session.options","fieldValue":""}],"id":"flex-action-1626804963203","type":"cardAction"}}],"channelname":"cpq_{recordId}","displayLabel":"cpq_{recordId}:apply_filter","element":"action","eventLabel":"pubsub","eventname":"apply_filter","eventtype":"pubsub","key":"event-3","recordIndex":"0"},{"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1626850465760-zkrh8hssj","label":"Action","stateAction":{"eventName":"cpqutils_{recordId}","extraParams":{"cartId":"{recordId}","filterOnlyProducts":"yes","ipMethod":"CPQ_GetCartsProducts","utilMethod":"productSearch","value":"{action.value}"},"hasExtraParams":true,"id":"flex-action-1626162579826","message":"cpq_ui_event","subType":"PubSub","type":"Event"}}],"channelname":"multiselectproductlist","displayLabel":"multiselectproductlist:basetypeaheadinputchange","element":"action","eventLabel":"pubsub","eventname":"basetypeaheadinputchange","eventtype":"pubsub","key":"event-4","recordIndex":"0"},{"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1626850465760-1q4ajs1mg","label":"productlistDataSet","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"multiselectoptions","fieldValue":"{action.value.records}"},{"fieldName":"multiProdValue","fieldValue":"{action.name}"}],"id":"flex-action-1623267781961","type":"cardAction"}}],"channelname":"cpq_{recordId}","displayLabel":"cpq_{recordId}:productlist","element":"action","eventLabel":"pubsub","eventname":"productlist","eventtype":"pubsub","key":"event-5","recordIndex":"0"},{"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1626850465760-1sg6lrkp1","label":"Action","stateAction":{"eventName":"cpqutils_{recordId}","extraParams":{"type":"multiSelect","utilMethod":"productSearch","value":"{action.event.detail}"},"hasExtraParams":true,"id":"flex-action-1625969127375","message":"cpq_ui_event","subType":"PubSub","type":"Event"}}],"channelname":"multiselectproductlist","displayLabel":"multiselectproductlist:baseinputvaluechange","element":"action","eventLabel":"pubsub","eventname":"baseinputvaluechange","eventtype":"pubsub","key":"event-6","recordIndex":"0"},{"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1626850465760-ss8nv149t","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"multiProdValue","fieldValue":""},{"fieldName":"selectedProductsForPills","fieldValue":"{action.products}"}],"id":"flex-action-1623265128931","type":"cardAction"}}],"channelname":"cpq_{recordId}","displayLabel":"cpq_{recordId}:selectedproductsevent","element":"action","eventLabel":"pubsub","eventname":"selectedproductsevent","eventtype":"pubsub","key":"event-7","recordIndex":"0"},{"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1626850465760-ardpyeqt8","label":"Action","stateAction":{"actionConditions":{"group":[],"id":"state-condition-object","isParent":true},"eventName":"setValues","fieldValues":[{"fieldName":"select","fieldValue":"true"},{"fieldName":"catalogId","fieldValue":"{action.Id}"},{"fieldName":"Session.options","fieldValue":"[]"},{"fieldName":"Session.select","fieldValue":"true"}],"id":"flex-action-1626849825369","type":"cardAction"}}],"channelname":"cpq_{recordId}","displayLabel":"cpq_{recordId}:result","element":"action","eventLabel":"pubsub","eventname":"result","eventtype":"pubsub","key":"event-8","recordIndex":"0"},{"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1626850465760-1efa7q4ww","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"select","fieldValue":"false"},{"fieldName":"Session.value","fieldValue":""},{"fieldName":"Session.options","fieldValue":"[]"}],"id":"flex-action-1626845230203","type":"cardAction"}}],"channelname":"cpq_{recordId}","displayLabel":"cpq_{recordId}:cpq_catalog_item_select_browse","element":"action","eventLabel":"pubsub","eventname":"cpq_catalog_item_select_browse","eventtype":"pubsub","key":"event-9","recordIndex":"0"},{"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1626850465760-pijdfv9r2","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"select","fieldValue":"false"},{"fieldName":"Session.options","fieldValue":"[]"},{"fieldName":"Session.value","fieldValue":""}],"id":"flex-action-1626845298074","type":"cardAction"}}],"channelname":"cpq_{recordId}","displayLabel":"cpq_{recordId}:cpq_catalog_item_select_cart","element":"action","eventLabel":"pubsub","eventname":"cpq_catalog_item_select_cart","eventtype":"pubsub","key":"event-10","recordIndex":"0"}],"globalCSS":false,"isFlex":true,"lwc":{"DeveloperName":"cfCpqProductSearch_1_CPQ1","Id":"0Rb5e000002NGeUCAW","ManageableState":"unmanaged","MasterLabel":"cfCpqProductSearch_1_CPQ1","NamespacePrefix":"vlocity_cmt"},"multilanguageSupport":true,"osSupport":true,"selectableMode":"Multi","sessionVars":[{"name":"options","val":""},{"name":"value","val":""},{"name":"select","val":"false"}],"states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"type","name":"Typeahead","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"options","value":"{Session.options}"},{"id":1,"label":"iconNameLeft","value":"utility:search"},{"id":2,"label":"name","value":"type"},{"id":3,"label":"value","value":"{Session.value}"}],"label":" ","name":"type","placeholder":"{Label.CPQSearch}","type":"typeahead","value":"{value}"},"record":"{record}","type":"typeahead"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element","userUpdatedElementLabel":true}]}},"conditions":{"group":[{"field":"Parent.multiProductsSelect","id":"state-new-condition-11","operator":"==","type":"custom","value":"false"},{"field":"Parent.multiProductsSelect","id":"state-new-condition-18","logicalOperator":"||","operator":"==","type":"custom","value":"undefined"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"cpq__product-search-field slds-p-around_x-small ","container":{"class":"cpq__product-search-field"},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}},{"actions":[],"blankCardState":false,"childCards":["cpqPills"],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Typeahead-0","name":"Typeahead","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"options","value":"{multiselectoptions}"},{"id":1,"label":"iconNameLeft","value":"utility:search"},{"id":2,"label":"placeholder","value":""},{"id":3,"label":"name","value":"multiselectproductlist"},{"id":4,"label":"value","value":"{value}"}],"label":" {Label.CPQProduct}","name":"multiselectproductlist","type":"typeahead","value":"{multiProdValue}"},"record":"{record}","type":"typeahead"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-1","name":"FlexCard","property":{"cardName":"cpqPills","cardNode":"{record.selectedProductsForPills}","isChildCardTrackingEnabled":false,"parentAttribute":{"onRemoveChannelName":"cpqutils_{recordId}","onRemoveEventName":"cpq_ui_event","utilMethod":"productSearch"},"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"margin-top","container":{"class":""},"customClass":"margin-top","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"margin-top","container":{"class":""},"customClass":"margin-top","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"element"}]}},"conditions":{"group":[{"field":"Parent.multiProductsSelect","id":"state-new-condition-0","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"documents":[],"fields":[],"isSmartAction":false,"name":"Multi Products select","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"cpq__product-search-field slds-p-around_x-small slds-m-bottom_x-small ","container":{"class":"cpq__product-search-field"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"cpqProductSearch","Id":"a5W7j000000f2rXEAQ","vlocity_cmt__GlobalKey__c":"cpqProductSearch/CPQ1/4/1626780013427"};
  export default definition