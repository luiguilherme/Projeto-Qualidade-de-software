let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{},"type":null,"value":{}},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1680283760090-0aa7vo9ce","label":"Action","stateAction":{"displayName":"Action","elementId":"ABACAXI","extraParams":{"BLABLA":"    \"approverUser\": {       \"approverSelected\": {         \"Id\": \"00576000000YlgcAAC\",         \"UserRole\": {           \"attributes\": {             \"type\": \"UserRole\",             \"url\": \"/services/data/v57.0/sobjects/UserRole/00E76000000JJtsEAG\"           },           \"Name\": \"Lojas Proprias Gerente Geral\",           \"Id\": \"00E76000000JJtsEAG\"         },         \"UserRoleId\": \"00E76000000JJtsEAG\",         \"Email\": \"emicai@deloitte.com\",         \"Name\": \"Erick Micai\",         \"uniqueKey\": \"REC1\",         \"_flex\": {           \"uniqueKey\": \"REC1\"         },         \"IsApprover\": true       }     }"},"hasExtraParams":true,"id":"flex-action-1680283860500","openUrlIn":"Current Window","type":"updateOmniScript","vlocityIcon":"standard-default"}}],"channelname":"omniscript_action","displayLabel":"omniscript_action:data","element":"action","eventLabel":"pubsub","eventname":"data","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"false"}],"isFlex":true,"listenToWidthResize":false,"lwc":{"DeveloperName":"cfValChildApproverListJourney_2_GuilhermeKaiser","Id":"0Rb76000000HGZYCA4","ManageableState":"unmanaged","MasterLabel":"cfValChildApproverListJourney_2_GuilhermeKaiser","NamespacePrefix":"c"},"osSupport":true,"selectableField":"IsApprover","selectableMode":"Single","selectedCardsLabel":"","states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"children":[{"children":[{"class":"slds-col ","element":"action","elementLabel":"Block-1-Action-0","key":"element_element_element_block_0_0_block_0_0_action_0_0","name":"Action","parentElementKey":"element_element_block_0_0_block_0_0","property":{"actionList":[{"actionIndex":1,"card":"{card}","draggable":false,"isOpen":true,"key":"1665535106002-62kf8z5ul","label":"Action","stateAction":{"displayName":"Action","eventName":"selectcards","id":"flex-action-1665536704910","openUrlIn":"Current Window","type":"cardAction","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":true,"key":"1665667797173-3did3gp8t","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"IsApprover","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"displayName":"Action","elementId":"approverUser","extraParams":{"approverSelected":"{record}"},"hasExtraParams":true,"id":"flex-action-1680293036182","openUrlIn":"Current Window","type":"updateOmniScript","vlocityIcon":"standard-default"}},{"actionIndex":2,"card":"{card}","draggable":false,"isOpen":true,"key":"1680204056398-tgu1qlbbq","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"IsApprover","hasMergeField":false,"id":"state-new-condition-7","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"displayName":"Action","elementId":"approverUser","extraParams":{"approverSelected":"null"},"hasExtraParams":true,"id":"flex-action-1680293081766","openUrlIn":"Current Window","type":"updateOmniScript","vlocityIcon":"standard-default"}}],"card":"{card}","displayAsButton":false,"flyoutDetails":{},"hideActionIcon":false,"iconName":"standard-default","iconOnly":false,"label":" ","record":"{record}","showSpinner":"false","stateObj":"{record}"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{},"height":"22px","inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n     height:22px;    ","text":{"align":"center","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{},"height":"22px","inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n     height:22px;    ","text":{"align":"center","color":""}}}],"type":"element"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-1-Field-1","key":"element_element_element_block_0_0_block_0_0_outputField_1_0","name":"Field","parentElementKey":"element_element_block_0_0_block_0_0","property":{"card":"{card}","label":"{Name}","placeholder":"","record":"{record}","type":"text"},"size":{"default":"3","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-1-Field-2","key":"element_element_element_block_0_0_block_0_0_outputField_2_0","name":"Field","parentElementKey":"element_element_block_0_0_block_0_0","property":{"card":"{card}","label":"{Email}","placeholder":"","record":"{record}","type":"text"},"size":{"default":"3","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-left_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:xx-small","size":"xx-small","type":"left"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-left_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:xx-small","size":"xx-small","type":"left"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-1-Field-3","key":"element_element_element_block_0_0_block_0_0_outputField_3_0","name":"Field","parentElementKey":"element_element_block_0_0_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"1","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"2"}],"id":"state-condition-object","isParent":true},"label":"{UserRole.Name}","placeholder":"","record":"{record}","type":"text"},"size":{"default":"4","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-left_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:x-small","size":"x-small","type":"left"}],"size":{"default":"4","isResponsive":false},"sizeClass":"slds-size_4-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-left_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:x-small","size":"x-small","type":"left"}],"size":{"default":"4","isResponsive":false},"sizeClass":"slds-size_4-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-4","key":"element_element_block_0_0_block_0_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":"border_bottom","width":"1px"},"class":"slds-border_bottom slds-p-around_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-bottom: #cccccc 1pxpx solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":"border_bottom","width":"1px"},"class":"slds-border_bottom slds-p-around_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-bottom: #cccccc 1pxpx solid; \n         ","text":{"align":"","color":""}}}],"type":"block"}],"class":"slds-col ","element":"block","elementLabel":"Block-1","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#F0F0F0","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#F0F0F0;      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#F0F0F0","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#F0F0F0;      \n         ","text":{"align":"","color":""}}}],"type":"block"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valChildApproverListJourney","Name":"valChildApproverListJourney","uniqueKey":"valChildApproverListJourney_undefined_undefined","Id":"a5W760000007WsaEAE","vlocity_cmt__GlobalKey__c":"valChildApproverListJourney/Guilherme Kaiser/2/1686602477757","vlocity_cmt__IsChildCard__c":true};
  export default definition