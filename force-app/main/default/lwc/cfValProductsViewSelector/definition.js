let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":false,"name":""},"type":"Custom","value":{"body":"[\n\t{\n\t\t\"phase\": \"browse\",\n\t\t\"isListViewSelected\": \"true\",\n\t\t\"isTileViewSelected\": \"false\"\n\t}\n]","dsDelay":"","resultVar":""}},"enableLwc":true,"events":[{"actionList":[{"card":"{card}","draggable":true,"isOpen":false,"key":"1641821844374-g6mvob7hb","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"isListViewSelected","fieldValue":"true"},{"fieldName":"isTileViewSelected","fieldValue":"false"}],"id":"flex-action-1641821744718","type":"cardAction"}}],"channelname":"changeview","displayLabel":"changeview:changeviewtolist","element":"action","eventLabel":"pubsub","eventname":"changeviewtolist","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"false"},{"actionList":[{"card":"{card}","draggable":false,"isOpen":true,"key":"1641821844374-a3ndu2m6n","label":"Action","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"isTileViewSelected","fieldValue":"true"},{"fieldName":"isListViewSelected","fieldValue":"false"}],"id":"flex-action-1641821853612","type":"cardAction"}}],"channelname":"changeview","displayLabel":"changeview:changeviewtotile","element":"action","eventLabel":"pubsub","eventname":"changeviewtotile","eventtype":"pubsub","key":"event-1","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":false,"key":"1653076804580-jsazx7f3f","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"Teste","fieldValue":"{action.value}"},{"fieldName":"Teste2","fieldValue":"{action.FilterValueTypeAhead}"}],"id":"flex-action-1653314291919","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"type","displayLabel":"type:baseinputvaluechange","element":"action","eventLabel":"pubsub","eventname":"baseinputvaluechange","eventtype":"pubsub","key":"event-2","recordIndex":"0","showSpinner":"false"}],"isFlex":true,"lwc":{"DeveloperName":"cfValProductsViewSelector_6_GiovaniSouza","Id":"0Rb780000004Uz1CAE","MasterLabel":"cfValProductsViewSelector_6_GiovaniSouza","NamespacePrefix":"c","ManageableState":"unmanaged"},"selectableMode":"Multi","sessionVars":[{"name":"isListViewSelected","val":"true"},{"name":"isTileViewSelected","val":"false"}],"states":[{"actions":[],"blankCardState":false,"childCards":["valCustomerProductsSearch","valCustomerProductsController","valProductTableView","valNavigateShowAll"],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-0-FlexCard-2","key":"element_element_block_0_0_childCardPreview_1_0","name":"FlexCard","parentElementKey":"element_block_0_0","property":{"cardName":"valCustomerProductsSearch","cardNode":"","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"11","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"11","isResponsive":false},"sizeClass":"slds-size_11-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"11","isResponsive":false},"sizeClass":"slds-size_11-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"children":[{"class":"slds-col ","element":"flexToggle","elementLabel":"listViewIcon","key":"element_element_element_block_0_0_block_1_0_flexToggle_0_0","name":"Toggle","property":{"action":{"actionData":{"card":"{card}","stateAction":{"displayName":"Action","eventName":"changeview","id":"flex-action-1641821664807","message":"changeviewtolist","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"},"stateObj":"{record}"},"eventType":"onchange","iconName":"standard-default","label":"Action","name":""},"alternativeText":"Exibição em lista","card":"{card}","checked":"\\{isListViewSelected}","disabled":"false","iconName":"utility:list","label":"Toggle","name":"Toggle","record":"{record}","type":"statefulIcon"},"size":{"default":"6","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"6","isResponsive":false},"sizeClass":"slds-size_6-of-12 ","style":"      \n         ","text":{"align":"right","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"6","isResponsive":false},"sizeClass":"slds-size_6-of-12 ","style":"      \n         ","text":{"align":"right","color":""}}}],"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"flexToggle","elementLabel":"tileViewIcon","key":"element_element_element_block_0_0_block_1_0_flexToggle_1_0","name":"Toggle","parentElementKey":"element_element_block_0_0_block_1_0","property":{"action":{"actionData":{"card":"{card}","stateAction":{"displayName":"Action","eventName":"changeview","id":"flex-action-1641821020866","message":"changeviewtotile","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"},"stateObj":"{record}"},"eventType":"onchange","iconName":"standard-default","label":"Action","name":""},"alternativeText":"Exibição em blocos","card":"{card}","checked":"\\{isTileViewSelected}","disabled":"false","iconName":"utility:tile_card_list","label":"Toggle","name":"Toggle","record":"{record}","type":"statefulIcon"},"size":{"default":"6","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_left ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"6","isResponsive":false},"sizeClass":"slds-size_6-of-12 ","style":"      \n         ","text":{"align":"left","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_left ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"6","isResponsive":false},"sizeClass":"slds-size_6-of-12 ","style":"      \n         ","text":{"align":"left","color":""}}}],"type":"element","userUpdatedElementLabel":true}],"class":"slds-col ","element":"block","elementLabel":"Block-0-Block-1","key":"element_element_block_0_0_block_2_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-m-top_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"padding-left: 10px;","margin":[{"label":"top:small","size":"small","type":"top"}],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         padding-left: 10px;","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-m-top_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"padding-left: 10px;","margin":[{"label":"top:small","size":"small","type":"top"}],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         padding-left: 10px;","text":{"align":"","color":""}}}],"type":"block"},{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-0-FlexCard-4","key":"element_element_element_block_0_0_block_3_0_childCardPreview_0_0","name":"FlexCard","parentElementKey":"element_element_block_0_0_block_3_0","property":{"cardName":"valCustomerProductsController","cardNode":"","data-conditions":{"group":[{"field":"isTileViewSelected","hasMergeField":false,"id":"state-new-condition-7","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false,"large":"5","medium":"5","small":"5"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"customClass":"","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false,"large":"5","medium":"5","small":"5"},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"customClass":"","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false,"large":"5","medium":"5","small":"5"},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-0-Block-3","key":"element_element_block_0_0_block_3_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:small","size":"small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:small","size":"small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-0-Block-5-FlexCard-0","key":"element_element_element_block_0_0_block_4_0_childCardPreview_0_0","name":"FlexCard","parentElementKey":"element_element_block_0_0_block_4_0","property":{"cardName":"valProductTableView","cardNode":"","data-conditions":{"group":[{"field":"isListViewSelected","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-0-Block-5","key":"element_element_block_0_0_block_4_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:small","size":"small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:small","size":"small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"}],"class":"slds-col ","element":"block","elementLabel":"Block-0","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":12,"isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small slds-m-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:x-small","size":"x-small","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small slds-m-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:x-small","size":"x-small","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-1","name":"FlexCard","property":{"cardName":"valNavigateShowAll","cardNode":"","isChildCardTrackingEnabled":false,"parentAttribute":{"TargetObjectName":"Assets"},"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-card slds-border_top slds-border_right slds-border_bottom slds-border_left slds-m-bottom_small ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"box-shadow: 0px 1px 3px #00000029;","margin":[{"label":"bottom:small","size":"small","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n         box-shadow: 0px 1px 3px #00000029;","text":{"align":"","color":""}}}],"theme":"slds","title":"valProductsViewSelector","Id":"a5W78000000HXMVEA4","vlocity_cmt__GlobalKey__c":"valProductsViewSelector/GiovaniSouza/6/1661438023049","vlocity_cmt__IsChildCard__c":true};
  export default definition