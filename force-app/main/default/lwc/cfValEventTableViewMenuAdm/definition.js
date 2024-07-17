let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{},"type":null,"value":{}},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":false,"key":"1709048571173-n6w2zgqdk","label":"Action","stateAction":{"displayName":"Action","eventName":"updatedatasource","id":"flex-action-1709051735744","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_HistoriesDetailsData\",\"vlocityAsync\":false,\"inputMap\":{\"networkNumber\":\"{action.networkNumber}\",\"startDateTime\":\"{action.startDateTime}\",\"endDateTime\":\"{action.endDateTime}\",\"eventType\":\"{action.eventType}\",\"completeError\":\"{action.completeError}\",\"currentPage\":\"{action.pageNumber}\",\"navigationPage\":\"{action.pageSum}\"},\"jsonMap\":\"{\\\"action.networkNumber\\\":\\\"{action.networkNumber}\\\",\\\"action.startDateTime\\\":\\\"{action.startDateTime}\\\",\\\"action.endDateTime\\\":\\\"{action.endDateTime}\\\",\\\"action.eventType\\\":\\\"{action.eventType}\\\",\\\"action.completeError\\\":\\\"{action.completeError}\\\",\\\"action.pageNumber\\\":\\\"{action.pageNumber}\\\",\\\"action.pageSum\\\":\\\"{action.pageSum}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"action.networkNumber\",\"val\":\"\",\"id\":1},{\"name\":\"action.startDateTime\",\"val\":\"\",\"id\":4},{\"name\":\"action.endDateTime\",\"val\":\"\",\"id\":5},{\"name\":\"action.eventType\",\"val\":\"all\",\"id\":8},{\"name\":\"action.completeError\",\"val\":\"All\",\"id\":9},{\"name\":\"action.pageNumber\",\"val\":\"\",\"id\":11},{\"name\":\"action.pageSum\",\"val\":\"\",\"id\":13}]}","openUrlIn":"Current Window","subType":"PubSub","type":"cardAction","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":false,"isOpen":true,"key":"1709055264882-lljbk22f6","label":"viewPrint","stateAction":{"displayName":"Action","eventName":"valEventsSearchAdmMenu","extraParams":{"error":"{code}"},"hasExtraParams":true,"id":"flex-action-1709055423364","message":"viewPrint","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"channelname":"valEventTableViewMenuAdm","displayLabel":"valEventTableViewMenuAdm:updataSource","element":"action","eventLabel":"pubsub","eventname":"updataSource","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"false"}],"isFlex":true,"isRepeatable":true,"lwc":{"DeveloperName":"cfValEventTableViewMenuAdm_2_Valentina","Id":"0Rb7600000057GCCAY","ManageableState":"unmanaged","MasterLabel":"cfValEventTableViewMenuAdm_2_Valentina","NamespacePrefix":"c"},"selectableMode":"Multi","states":[{"blankCardState":true,"components":{"layer-0":{"children":[]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"fields":[],"isSmartAction":false,"name":"EventTableNull","smartAction":{},"styleObject":{"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small","container":{"class":"slds-card"},"margin":[{"size":"x-small","type":"bottom"}],"padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12"}},{"actions":[],"childCards":["valEventHistoriesHeaderMenuAdm","valEventHistoriesDataMenuAdm","valDataPaginationHistories","valMessageAlert"],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-0","key":"element_element_block_0_0_childCardPreview_0_0","name":"FlexCard","parentElementKey":"element_block_0_0","property":{"cardName":"valEventHistoriesHeaderMenuAdm","cardNode":"{record}","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":"","width":"30"},"class":"","container":{"class":""},"elementStyleProperties":{},"height":"47px","inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n     height:47px;    ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":"","width":"30"},"class":"","container":{"class":""},"elementStyleProperties":{},"height":"47px","inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n     height:47px;    ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-1","key":"element_element_block_0_0_childCardPreview_1_0","name":"FlexCard","parentElementKey":"element_block_0_0","property":{"cardName":"valEventHistoriesDataMenuAdm","cardNode":"{record.consumptions}","isChildCardTrackingEnabled":false,"parentAttribute":{"networkNumber":"{parent.networkNumber}"},"recordId":"{recordId}","selectedState":"EventHistDtTab2"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-m-bottom_xxx-small ","container":{"class":""},"elementStyleProperties":{},"height":"","inlineStyle":"","margin":[{"label":"bottom:xxx-small","size":"xxx-small","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-m-bottom_xxx-small ","container":{"class":""},"elementStyleProperties":{},"height":"","inlineStyle":"","margin":[{"label":"bottom:xxx-small","size":"xxx-small","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-2","key":"element_element_block_0_0_childCardPreview_2_0","name":"FlexCard","parentElementKey":"element_block_0_0","property":{"cardName":"valDataPaginationHistories","cardNode":"{record}","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"SinglePage"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-3","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"data-conditions":{"group":[{"field":"code","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"200"}],"id":"state-condition-object","isParent":true},"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-4","name":"FlexCard","property":{"cardName":"valMessageAlert","cardNode":"{record}","data-conditions":{"group":[{"field":"code","hasMergeField":false,"id":"state-new-condition-0","operator":"!=","type":"custom","value":"200"},{"group":[{"field":"code","hasMergeField":false,"id":"state-new-condition-59","operator":"!=","type":"custom","value":""}],"id":"state-new-group-60","logicalOperator":"&&"}],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"parentAttribute":{"ErrorMessage":"{message}"},"recordId":"{recordId}","selectedState":"WarningCustomAttribute"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small slds-m-around_none ","container":{"class":""},"elementStyleProperties":{},"height":"","inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valEventTableViewMenuAdm","Id":"a5W8M000000Gu1MUAS","vlocity_cmt__GlobalKey__c":"valEventTableViewMenuAdm/Valentina/2/1701107348124","vlocity_cmt__IsChildCard__c":true};
  export default definition