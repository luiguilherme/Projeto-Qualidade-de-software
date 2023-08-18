let definition =
      {"dataSource":{"type":"IntegrationProcedures","value":{"dsDelay":"","ipMethod":"val_GetOrderDetails","vlocityAsync":false,"inputMap":{"OrderId":"{recordId}"},"jsonMap":"{\"recordId\":\"{recordId}\"}","resultVar":""},"orderBy":{"name":"","isReverse":""},"contextVariables":[]},"enableLwc":true,"globalCSS":true,"isFlex":true,"lwc":{"DeveloperName":"cfValOrderDetails_3_Deloitte_GiovaniSouza","Id":"0Rb760000000QY5CAM","MasterLabel":"cfValOrderDetails_3_Deloitte_GiovaniSouza","NamespacePrefix":"c","ManageableState":"unmanaged"},"selectableMode":"Multi","states":[{"actions":[],"childCards":["valHeader","valOrderDetailsStatus","valOrderDetailsAccount","valOrderDetailsProducts","valOrderDetailsChannel","valOrderDetailsContact"],"components":{"layer-0":{"children":[{"name":"Text","element":"outputField","size":{"isResponsive":false,"default":"12"},"stateIndex":0,"class":"slds-col ","property":{"record":"{record}","mergeField":"%3Cdiv%3E%7Bvlocity_cmt__CustomerInteraction__c%7D%3C/div%3E%0A%3Cdiv%3E%7BContextId%7D%3C/div%3E%0A%3Cdiv%3E%7Bvlocity_cmt__CustomerInteraction__c%7D%3C/div%3E","card":"{card}"},"type":"text","styleObject":{"sizeClass":"slds-size_12-of-12"},"elementLabel":"Text-0"},{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-0-FlexCard-0","key":"element_element_block_0_0_childCardPreview_0_0","name":"FlexCard","parentElementKey":"element_block_0_0","property":{"cardName":"valHeader","cardNode":"","isChildCardTrackingEnabled":false,"parentAttribute":{"Data":"{OrderNumber}","Title":"Detalhes da Ordem"},"recordId":"{recordId}","selectedState":"HeaderWithData"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-1","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"sizeClass":"slds-size_12-of-12"},"type":"block"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-2","name":"FlexCard","property":{"cardName":"valOrderDetailsStatus","cardNode":"{record.OrderStatus}","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active","parentAttribute":{"OrderId":"{recordId}"}},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-3","name":"FlexCard","property":{"cardName":"valOrderDetailsAccount","cardNode":"{record.Account}","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-4","name":"FlexCard","property":{"cardName":"valOrderDetailsProducts","cardNode":"{record.OrderProducts}","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-5","name":"FlexCard","property":{"cardName":"valOrderDetailsChannel","cardNode":"{record.Channel}","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-6","name":"FlexCard","property":{"cardName":"valOrderDetailsContact","cardNode":"{record.Contact}","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Text Area-7","name":"Text Area","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"disabled","value":"true"}],"fieldBinding":"","label":"Observações","placeholder":"","readOnly":true,"styles":"{\n        \"label\": {\n            \"width\":\"auto\"\n        }\n      }","value":"{Description}"},"record":"{record}","type":"textarea"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-right_small slds-p-around_xx-small slds-m-bottom_xx-small ","container":{"class":""},"customClass":"","elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"},{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-right_small slds-p-around_xx-small slds-m-bottom_xx-small ","container":{"class":""},"customClass":"","elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"},{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small","container":{"class":"slds-card"},"margin":[{"size":"x-small","type":"bottom"}],"padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12"}}],"theme":"slds","title":"valOrderDetails","events":[{"eventname":"fireToast","channelname":"valOrderDetails","element":"action","eventtype":"pubsub","recordIndex":"0","actionList":[{"key":"1683903821592-q76p6cwt8","label":"showToast","draggable":false,"isOpen":true,"card":"{card}","stateAction":{"id":"flex-action-1683903858713","type":"Event","displayName":"Action","vlocityIcon":"standard-default","openUrlIn":"Current Window","eventName":"valToast","subType":"PubSub","message":"showToast"},"actionIndex":0}],"showSpinner":"false","key":"event-0","displayLabel":"valOrderDetails:fireToast","eventLabel":"pubsub"}],"Id":"a5W76000000H9LpEAK","vlocity_cmt__GlobalKey__c":"valOrderDetails/Deloitte_GiovaniSouza/3/1683903613032","vlocity_cmt__IsChildCard__c":false};
  export default definition