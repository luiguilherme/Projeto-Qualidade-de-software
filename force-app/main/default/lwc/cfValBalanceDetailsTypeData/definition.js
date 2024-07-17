let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{},"type":null,"value":{}},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1681312347970-42uvl5zzl","label":"ActionShowDetails","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"showDetails","fieldValue":"{action.active}"}],"id":"flex-action-1681312364694","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valBalanceDetailsTypeData","displayLabel":"valBalanceDetailsTypeData:showDetails","element":"action","eventLabel":"pubsub","eventname":"showDetails","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"false"}],"isFlex":true,"lwc":{"DeveloperName":"cfValBalanceDetailsTypeData_1_TelefonicaBrasilValentina","Id":"0Rb76000000L59aCAC","ManageableState":"unmanaged","MasterLabel":"cfValBalanceDetailsTypeData_1_TelefonicaBrasilValentina","NamespacePrefix":"c"},"selectableMode":"Multi","states":[{"actions":[],"childCards":["valBalanceDescription"],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Block-0-Text-0","key":"element_element_block_0_0_outputField_0_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","mergeField":"%3Cdiv%3E%3Cspan%20style=%22color:%20#000000;%20font-size:%2014pt;%22%3EInternet%20Geral%20Utilizada:%20%3Cstrong%3E%7BbalanceData.consumedBalanceTotal%7D%20%3Cspan%20style=%22font-size:%2012pt;%22%3EGB%3C/span%3E%3C/strong%3E%3Cspan%20style=%22font-size:%2012pt;%22%3E%20de%20%3Cstrong%3E%7BbalanceData.grantedBalanceTotal%7D%20GB%3C/strong%3E%3C/span%3E%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"font-size:16pt;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         font-size:16pt;","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"font-size:16pt;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         font-size:16pt;","text":{"align":"","color":""}}}],"type":"text"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-0-Text-1","key":"element_element_block_0_0_outputField_1_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","mergeField":"%3Cdiv%3E%3Cspan%20style=%22font-size:%208pt;%20color:%20#000000;%22%3E%3Cspan%20style=%22font-size:%2012pt;%22%3EInternet%20Disponivel:%3Cspan%20style=%22font-size:%2010pt;%22%3E%20%3C/span%3E%3C/span%3E%3Cspan%20style=%22font-size:%2010pt;%22%3E%3Cstrong%3E%7BbalanceData.availableBalanceTotal%7D%20GB%3C/strong%3E%20de%20%3Cstrong%3E%7BbalanceData.grantedBalanceTotal%7D%20GB%3C/strong%3E%3C/span%3E%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"text"},{"class":"slds-col ","element":"customLwc","elementLabel":"Block-0-Custom LWC-2","key":"element_element_block_0_0_customLwc_2_0","name":"Custom LWC","parentElementKey":"element_block_0_0","property":{"customlwcname":"balanceDetailsCard","horizontalBarProperties":"{balanceData}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"},{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-0-FlexCard-3","key":"element_element_element_block_0_0_block_4_0_childCardPreview_0_0","name":"FlexCard","property":{"cardName":"valBalanceDescription","cardNode":"{record.balanceData.attributesList}","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-0-Block-4","key":"element_element_block_0_0_block_3_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"sizeClass":"slds-size_12-of-12"},"type":"block"}],"class":"slds-col ","element":"block","elementLabel":"Block-0","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":"","width":"5px"},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"height":"240px","inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n    border-radius:5px; height:240px;    ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":"","width":"5px"},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"height":"240px","inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n    border-radius:5px; height:240px;    ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"action","elementLabel":"Action-2","name":"Action","property":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":true,"key":"1681312136248-7tao0ap1q","label":"EventShowDetails","stateAction":{"displayName":"Action","eventName":"valBalanceDetailsInfo","extraParams":{"active":"VOL"},"hasExtraParams":true,"id":"flex-action-1681763324439","message":"showDetails","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":true,"key":"1681221392363-0gpdofc6m","label":"ActionShowButtonMinus","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"showData","fieldValue":"true"},{"fieldName":"showMessage","fieldValue":"false"},{"fieldName":"showVoz","fieldValue":"false"}],"id":"flex-action-1681763336751","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"card":"{card}","data-conditions":{"group":[{"field":"showData","hasMergeField":false,"id":"state-new-condition-2","operator":"!=","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"flyoutDetails":{},"hideActionIcon":true,"iconName":"standard-default","label":"Ver Detalhes","record":"{record}","showSpinner":"false","stateObj":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"z-index: 1;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n        color:#368cee; z-index: 1;","text":{"align":"center","color":"#368cee"}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"z-index: 1;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n        color:#368cee; z-index: 1;","text":{"align":"center","color":"#368cee"}}}],"type":"element"},{"class":"slds-col ","element":"action","elementLabel":"Action-3","name":"Action","property":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":false,"key":"1681311903617-k9lg8ddue","label":"EventShowDetails","stateAction":{"displayName":"Action","eventName":"valBalanceDetailsInfo","extraParams":{"active":"false"},"hasExtraParams":true,"id":"flex-action-1681312250981","message":"showDetails","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":1,"draggable":false,"isOpen":true,"key":"1681221657375-ke2fphdhp","label":"ActionShowButtonDetails","stateAction":{"Web Page":{"targetName":"/apex"},"eventName":"setValues","fieldValues":[{"fieldName":"showData","fieldValue":"false"},{"fieldName":"showMessage","fieldValue":"true"},{"fieldName":"showVoz","fieldValue":"true"}],"id":"flex-action-1681322330691","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction"}}],"card":"{card}","data-conditions":{"group":[{"field":"showData","hasMergeField":false,"id":"state-new-condition-9","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"flyoutDetails":{},"hideActionIcon":true,"iconName":"standard-default","label":"Ver Menos","record":"{record}","showSpinner":"false","stateObj":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"z-index: 1;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n        color:#368cee; z-index: 1;","text":{"align":"center","color":"#368cee"}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"z-index: 1;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n        color:#368cee; z-index: 1;","text":{"align":"center","color":"#368cee"}}}],"type":"element"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small","container":{"class":"slds-card"},"margin":[{"size":"none","type":"around"}],"padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12"}}],"theme":"slds","title":"valBalanceDetailsTypeData","Name":"valBalanceDetailsTypeData","uniqueKey":"valBalanceDetailsTypeData_undefined_undefined","Id":"a5W78000000L0QkEAK","vlocity_cmt__GlobalKey__c":"valBalanceDetailsTypeData/TelefonicaBrasilValentina/1/1681221970133","vlocity_cmt__IsChildCard__c":true};
  export default definition