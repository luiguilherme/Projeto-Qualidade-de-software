let definition =
      {"dataSource":{"type":"IntegrationProcedures","value":{"dsDelay":"","ipMethod":"val_GetHistoricContact","vlocityAsync":false,"inputMap":{"CurrentPage":"1","RecordId":"{recordId}"},"resultVar":""},"orderBy":{"name":"","isReverse":""},"contextVariables":[]},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1661450111889-6pu64x5c0","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1661450186816","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_GetBillingAccountsByAccId\",\"vlocityAsync\":false,\"inputMap\":{\"recordId\":\"{recordId}\",\"CurrentPage\":\"{PageControl.CurrentPage}\",\"Navigation\":\"next\",\"TotalPages\":\"{PageControl.TotalPages}\"},\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"id\":1,\"name\":\"recordId\",\"val\":\"a1c8D000000FBQOQA4\"},{\"name\":\"PageControl.CurrentPage\",\"val\":\"\",\"id\":3},{\"name\":\"PageControl.TotalPages\",\"val\":\"\",\"id\":6}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}}],"channelname":"updatedatasource","displayLabel":"updatedatasource:nextpage","element":"action","eventLabel":"pubsub","eventname":"nextpage","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"true"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":true,"key":"1661450256087-qxfmd49pn","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1661450316602","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_GetBillingAccountsByAccId\",\"vlocityAsync\":false,\"inputMap\":{\"recordId\":\"{recordId}\",\"CurrentPage\":\"{PageControl.CurrentPage}\",\"Navigation\":\"previous\",\"TotalPages\":\"{PageControl.TotalPages}\"}},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"id\":1,\"name\":\"recordId\",\"val\":\"a1c8D000000FBQOQA4\"},{\"name\":\"PageControl.CurrentPage\",\"val\":\"\",\"id\":4},{\"name\":\"PageControl.TotalPages\",\"val\":\"\",\"id\":7}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}}],"channelname":"updatedatasource","displayLabel":"updatedatasource:previouspage","element":"action","eventLabel":"pubsub","eventname":"previouspage","eventtype":"pubsub","key":"event-1","recordIndex":"0","showSpinner":"true"}],"isFlex":true,"isRepeatable":true,"lwc":{"DeveloperName":"cfValHistoricContact_1_Front360","Id":"0Rb8D000000VX6YSAW","ManageableState":"unmanaged","MasterLabel":"cfValHistoricContact_1_Front360","NamespacePrefix":"c"},"osSupport":true,"selectableMode":"Multi","states":[{"actions":[],"blankCardState":false,"childCards":["valHistoricContactTitle","valHistoricContactData","valDataPagination"],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"BlockData-Text-0","key":"element_element_block_0_0_outputField_0_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","mergeField":"%3Cdiv%3E%3Cspan%20style=%22font-size:%2014pt;%22%3E%3Cstrong%3EHist&oacute;rico%20do%20Cliente%3C/strong%3E%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"text"},{"children":[{"children":[],"class":"slds-col ","element":"block","elementLabel":"BlockData-Block-1-Block-0","key":"element_element_element_block_0_0_block_1_0_block_0_0","name":"Block","parentElementKey":"element_element_block_0_0_block_1_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"}],"class":"slds-col ","element":"block","elementLabel":"BlockData-Block-1","key":"element_element_block_0_0_block_1_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"BlockData-FlexCard-2","key":"element_element_block_0_0_childCardPreview_2_0","name":"FlexCard","parentElementKey":"element_block_0_0","property":{"cardName":"valHistoricContactTitle","cardNode":"","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"},{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"BlockData-Block-5-FlexCard-0","key":"element_element_element_block_0_0_block_3_0_childCardPreview_0_0","name":"FlexCard","parentElementKey":"element_element_block_0_0_block_3_0","property":{"cardName":"valHistoricContactData","cardNode":"{records[0].History}","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"BlockData-Block-3","key":"element_element_block_0_0_block_3_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":"border_bottom","width":"1"},"class":"slds-border_bottom ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-bottom: #cccccc 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":"border_bottom","width":"1"},"class":"slds-border_bottom ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-bottom: #cccccc 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"block"}],"class":"slds-col ","element":"block","elementLabel":"BlockData","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small slds-m-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:x-small","size":"x-small","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small slds-m-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:x-small","size":"x-small","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block","userUpdatedElementLabel":true},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-3","name":"FlexCard","property":{"cardName":"valDataPagination","cardNode":"","isChildCardTrackingEnabled":false,"parentAttribute":{"currentPage":"{PageControl.CurrentPage}","state":"{PageControl.State}","totalPages":"{PageControl.TotalPages}"},"recordId":"{recordId}","selectedState":"SinglePage"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-card slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"box-shadow: 0px 1px 3px #00000029;","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n         box-shadow: 0px 1px 3px #00000029;","text":{"align":"","color":""}}},{"actions":[],"blankCardState":true,"childCards":["valBillingAccountsHeader"],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"BlockData-FlexCard-3","key":"element_element_block_0_1_childCardPreview_0_1","name":"FlexCard","parentElementKey":"element_block_0_1","property":{"cardName":"valBillingAccountsHeader","cardNode":"","isChildCardTrackingEnabled":false,"parentAttribute":{"Title":"Contas Faturamento"},"recordId":"{recordId}","selectedState":"State1"},"size":{"default":12,"isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-bottom_large ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"bottom:large","size":"large","type":"bottom"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-bottom_large ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"bottom:large","size":"large","type":"bottom"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"children":[{"children":[],"class":"slds-col ","element":"block","elementLabel":"BlockData-Block-5-Block-0","key":"element_element_element_block_0_1_block_1_1_block_0_1","name":"Block","parentElementKey":"element_element_block_0_1_block_1_1","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"4","isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"4","isResponsive":false},"sizeClass":"slds-size_4-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"4","isResponsive":false},"sizeClass":"slds-size_4-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"flexImg","elementLabel":"BlockData-Block-5-Image-1","key":"element_element_element_block_0_1_block_1_1_flexImg_1_1","name":"Image","parentElementKey":"element_element_block_0_1_block_1_1","property":{"card":"{card}","extraclass":"slds-align_absolute-center","record":"{record}","size":"","stateImg":{"alternativeText":"Image description","document":{"Id":"06876000000ViE9AAK","attachmentType":"ContentVersion","label":"EmptySpaceImage2_Easy-Resize.com (Version:1)","title":"EmptySpaceImage2_Easy-Resize.com","value":"/sfc/servlet.shepherd/version/download/06876000000ViE9AAK"},"imgsrc":"/resource/EmptyStateOpenRoad"}},"size":{"default":"4","isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-bottom_medium ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"bottom:medium","size":"medium","type":"bottom"}],"size":{"default":"4","isResponsive":false},"sizeClass":"slds-size_4-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-bottom_medium ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"bottom:medium","size":"medium","type":"bottom"}],"size":{"default":"4","isResponsive":false},"sizeClass":"slds-size_4-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"outputField","elementLabel":"BlockData-Block-5-Text-2","key":"element_element_element_block_0_1_block_1_1_outputField_2_1","name":"Text","parentElementKey":"element_element_block_0_1_block_1_1","property":{"card":"{card}","mergeField":"%3Cdiv%20class=%22slds-text-align_center%22%3E%3Cspan%20style=%22font-size:%2014pt;%22%3EN&atilde;o%20existem%20Contas%20Faturamento%20para%20este%20Cliente%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"center","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"center","color":""}}}],"type":"text"}],"class":"slds-col ","element":"block","elementLabel":"Block-0-clone-0-Block-1-clone-0","key":"element_element_block_0_1_block_1_1","name":"Block","parentElementKey":"element_block_0_1","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":"1"},"class":" ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":"1"},"class":" ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"}],"class":"slds-col ","element":"block","elementLabel":"BlockData","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small slds-m-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:x-small","size":"x-small","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small slds-m-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:x-small","size":"x-small","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block","userUpdatedElementLabel":true}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[{"Id":"06876000000ViE9AAK","developerName":"EmptySpaceImage2_Easy-Resize.com","type":"ContentVersion"}],"fields":[],"isSmartAction":false,"name":"NoRecords","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-card slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valHistoricContact","Id":"a5W78000000KzI7EAK","vlocity_cmt__GlobalKey__c":"valHistoricContact/Front360/1/1661453674472","vlocity_cmt__IsChildCard__c":false};
  export default definition