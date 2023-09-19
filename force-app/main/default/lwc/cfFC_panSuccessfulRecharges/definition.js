let definition =
      {"dataSource":{"type":"IntegrationProcedures","value":{"dsDelay":"","ipMethod":"pan_SuccessfulRecharges","vlocityAsync":false,"resultVar":""},"orderBy":{"name":"","isReverse":""},"contextVariables":[]},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1659190322311-rxvq5juz9","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"Session.startDate","fieldValue":"{Session.startDate}"},{"fieldName":"Session.endDate","fieldValue":"{Session.endDate}"},{"fieldName":"Session.inputType","fieldValue":"0"}],"id":"flex-action-1679950584285","ignoreResponse":false,"message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"pan_SuccessfulRecharges\",\"vlocityAsync\":true,\"inputMap\":{\"Session.startDate\":\"{action.startDate}\",\"Session.endDate\":\"{action.endDate}\",\"Session.inputType\":\"0\",\"Session.networkNumber\":\"{action.networkNumber}\",\"Session.viewList\":\"{action.viewList}\"},\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"action.startDate\",\"val\":\"19/02/2022\",\"id\":6},{\"name\":\"action.endDate\",\"val\":\"19/03/2022\",\"id\":7},{\"name\":\"action.viewList\",\"val\":\"true\",\"id\":10},{\"name\":\"action.networkNumber\",\"val\":\"11950956538\",\"id\":10}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}}],"channelname":"FC_panSuccessfulRecharges","displayLabel":"querysuccessfulrecharges","element":"action","eventLabel":"custom event","eventname":"querysuccessfulrecharges","eventtype":"event","key":"event-0","recordIndex":"0","showSpinner":"false"},{"eventname":"aguarde","channelname":"FC_panSuccessfulRecharges","element":"action","eventtype":"pubsub","recordIndex":"0","actionList":[{"key":"1682599532747-ph3nyj19v","label":"ActionAguarde","draggable":false,"isOpen":true,"card":"{card}","stateAction":{"id":"flex-action-1682601555311","type":"cardAction","displayName":"Action","vlocityIcon":"standard-default","openUrlIn":"Current Window","eventName":"setValues","subType":"Custom","hasExtraParams":true,"extraParams":{"viewAguarde":"{viewAguarde}"},"fieldValues":[{"fieldName":"Session.viewAguarde","fieldValue":"{action.viewAguarde}"}]},"actionIndex":0}],"showSpinner":"false","key":"event-1","displayLabel":"FC_panSuccessfulRecharges:aguarde","eventLabel":"pubsub"}],"isFlex":true,"lwc":{"DeveloperName":"cfFC_panSuccessfulRecharges_5_Matheus_Rocha","Id":"0Rb7j000000Dar0CAC","MasterLabel":"cfFC_panSuccessfulRecharges_5_Matheus_Rocha","NamespacePrefix":"c","ManageableState":"unmanaged"},"selectableMode":"Multi","states":[{"actions":[],"childCards":["FC_panSuccessfulRechargesDate","FC_panSuccessfulRecharges_Datatable","panAlertNoRecords","panAlertServiceError"],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-0","name":"FlexCard","property":{"cardName":"FC_panSuccessfulRechargesDate","cardNode":"","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active","parentAttribute":{"contextNumber":"{Parent.contextNumber}"}},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":"border_bottom","width":""},"class":"slds-border_bottom ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-bottom: #cccccc 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":"border_bottom","width":""},"class":"slds-border_bottom ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-bottom: #cccccc 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"element"},{"name":"Text","element":"outputField","size":{"isResponsive":false,"default":"12"},"stateIndex":0,"class":"slds-col ","property":{"record":"{record}","mergeField":"%3Cdiv%20class=%22slds-text-align_center%22%3EAguarde%20alguns%20segundos%20at&eacute;%20o%20processo%20ser%20finalizado...%3C/div%3E","card":"{card}","data-conditions":{"id":"state-condition-object","isParent":true,"group":[{"id":"state-new-condition-0","field":"statusCode","operator":"==","value":"init","type":"custom","hasMergeField":false},{"id":"state-new-condition-7","field":"Session.viewAguarde","operator":"==","value":"true","type":"custom","hasMergeField":false,"logicalOperator":"&&"}]}},"type":"text","styleObject":{"sizeClass":"slds-size_12-of-12"},"elementLabel":"Text-1"},{"children":[{"children":[{"children":[{"children":[],"class":"slds-col ","element":"block","elementLabel":"Block-3-Block-1","key":"element_element_element_element_block_1_0_block_0_0_block_0_0_block_0_0","name":"Block","parentElementKey":"element_element_element_block_1_0_block_0_0_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"11","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"11","isResponsive":false},"sizeClass":"slds-size_11-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"11","isResponsive":false},"sizeClass":"slds-size_11-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Text-4","key":"element_element_element_element_element_block_2_0_block_0_0_block_0_0_block_1_0_outputField_0_0","name":"Text","parentElementKey":"element_element_element_element_block_2_0_block_0_0_block_0_0_block_1_0","property":{"card":"{card}","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"mergeField":"%3Cdiv%20class=%22slds-text-align_right%22%3E%3Cspan%20style=%22color:%20#95a5a6;%22%3E0%7BrecordListSize%7D%20registro(s)%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"text"}],"class":"slds-col ","element":"block","elementLabel":"Block-2","key":"element_element_element_element_block_1_0_block_0_0_block_0_0_block_1_0","name":"Block","parentElementKey":"element_element_element_block_1_0_block_0_0_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-2","key":"element_element_element_element_block_1_0_block_0_0_block_0_0_childCardPreview_2_0","name":"FlexCard","parentElementKey":"element_element_element_block_1_0_block_0_0_block_0_0","property":{"cardName":"FC_panSuccessfulRecharges_Datatable","cardNode":"{record.successfulRecharges}","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-3-Block-0","key":"element_element_element_block_1_0_block_0_0_block_0_0","name":"Block","parentElementKey":"element_element_block_1_0_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"}],"class":"slds-col ","element":"block","elementLabel":"Block-3","key":"element_element_block_1_0_block_0_0","name":"Block","parentElementKey":"element_block_1_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"data-conditions":{"group":[{"field":"recordListSize","hasMergeField":false,"id":"state-new-condition-7","operator":">","type":"custom","value":"0"}],"id":"state-condition-object","isParent":true},"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-horizontal_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"horizontal:xx-small","size":"xx-small","type":"horizontal"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-horizontal_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"horizontal:xx-small","size":"xx-small","type":"horizontal"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-4","key":"element_element_block_1_0_childCardPreview_1_0","name":"FlexCard","parentElementKey":"element_block_1_0","property":{"cardName":"panAlertNoRecords","cardNode":"","data-conditions":{"group":[{"field":"recordListSize","hasMergeField":false,"id":"state-new-condition-11","operator":"==","type":"custom","value":"0"}],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-2","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"data-conditions":{"group":[{"field":"status","hasMergeField":false,"id":"state-new-condition-23","operator":"==","type":"custom","value":"OK"},{"id":"state-new-condition-0","field":"input.viewList","operator":"==","value":"true","type":"custom","hasMergeField":false,"logicalOperator":"&&"}],"id":"state-condition-object","isParent":true},"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-vertical_xxx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"vertical:xxx-small","size":"xxx-small","type":"vertical"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-vertical_xxx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"vertical:xxx-small","size":"xxx-small","type":"vertical"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-3","name":"FlexCard","property":{"cardName":"panAlertServiceError","cardNode":"{record}","data-conditions":{"group":[{"field":"status","hasMergeField":false,"id":"state-new-condition-4","operator":"!=","type":"custom","value":"OK"},{"id":"state-new-condition-0","field":"input.viewList","operator":"==","value":"true","type":"custom","hasMergeField":false,"logicalOperator":"&&"}],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small","container":{"class":"slds-card"},"margin":[{"size":"none","type":"around"}],"padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12"}}],"theme":"slds","title":"FC_panSuccessfulRecharges","Id":"a5W7j000000FW6rEAG","vlocity_cmt__GlobalKey__c":"FC_panSuccessfulRecharges/Matheus_Rocha/5/1689251784818","vlocity_cmt__IsChildCard__c":true};
  export default definition