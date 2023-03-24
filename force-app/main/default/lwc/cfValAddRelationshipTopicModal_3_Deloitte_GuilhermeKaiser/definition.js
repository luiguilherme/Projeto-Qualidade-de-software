let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":"","name":""},"type":"Custom","value":{"body":"[{ \"remarkup__c\":\"\"}]","dsDelay":"","resultVar":""}},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1667925291158-08zth8hs7","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"Session.SelectedRelationshipTopicId","fieldValue":"{action.Id}"},{"fieldName":"Session.SelectedRelationshipFolderName","fieldValue":"{action.Name}"},{"fieldName":"Session.SelectedRelationshipProductType","fieldValue":"{action.ProductType}"},{"fieldName":"Session.SelectedRelationshipServiceTree","fieldValue":"{action.ServiceTree}"},{"fieldName":"Session.SelectedRelationshipAssetId","fieldValue":"{action.AssetId}"},{"fieldName":"Session.SelectedRelationshipOtherProduct","fieldValue":"{action.OtherProduct}"}],"id":"flex-action-1672057409310","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valAddRelationshipTopicModal","displayLabel":"valAddRelationshipTopicModal:Selected","element":"action","eventLabel":"pubsub","eventname":"Selected","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1667927526787-n2jpp5690","label":"Action","stateAction":{"actionConditions":{"group":[],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"setValues","extraParams":{"Session.SelectedRelationshipTopicId":"{action.Id}"},"fieldValues":[{"fieldName":"Session.SelectedRelationshipTopicId","fieldValue":"{action.Id}"},{"fieldName":"Session.SelectedRelationshipFolderName","fieldValue":"{action.Name}"},{"fieldName":"Session.SelectedRelationshipProductType","fieldValue":"{action.ProductType}"},{"fieldName":"Session.SelectedRelationshipServiceTree","fieldValue":"{action.ServiceTree}"},{"fieldName":"Session.SelectedRelationshipAssetId","fieldValue":"{action.AssetId}"},{"fieldName":"Session.SelectedRelationshipOtherProduct","fieldValue":"{action.OtherProduct}"}],"hasExtraParams":true,"id":"flex-action-1672057463178","message":"clearselection","openUrlIn":"Current Window","subType":"PubSub","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valAddRelationshipTopicModal","displayLabel":"valAddRelationshipTopicModal:clearselection","element":"action","eventLabel":"pubsub","eventname":"clearselection","eventtype":"pubsub","key":"event-1","recordIndex":"0","showSpinner":"false"}],"globalCSS":false,"isFlex":true,"lwc":{"DeveloperName":"cfValAddRelationshipTopicModal","Id":"0Rb78000000L2IWCA0","MasterLabel":"cfValAddRelationshipTopicModal","NamespacePrefix":"c","ManageableState":"unmanaged"},"multilanguageSupport":true,"selectableMode":"Multi","sessionVars":[{"name":"SelectedRelationshipTopicId","val":""},{"name":"SelectedRelationshipFolderName","val":""},{"name":"SelectedRelationshipProductType","val":""},{"name":"SelectedRelationshipServiceTree","val":""},{"name":"SelectedRelationshipAssetId","val":""},{"name":"SelectedRelationshipOtherProduct","val":""}],"states":[{"actions":[],"childCards":["valTopicsTreeMenu"],"components":{"layer-0":{"children":[{"children":[],"class":"slds-col ","element":"block","elementLabel":"Block-0","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"sizeClass":"slds-size_12-of-12"},"type":"block"},{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-1-FlexCard-1","key":"element_element_block_1_0_childCardPreview_1_0","name":"FlexCard","parentElementKey":"element_block_1_0","property":{"cardName":"valTopicsTreeMenu","cardNode":"","isChildCardTrackingEnabled":false,"parentAttribute":{"CustomerInteractionId":"{recordId}","HideAddBtn":"true","SelectedFunction":"RelationshipTopic"},"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-1","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-card slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-card slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Text Area-2","name":"Text Area","property":{"card":"{card}","propertyObj":{"customProperties":[],"fieldBinding":"{remarkup__c}","label":"Observação","maxLength":255,"placeholder":"","styles":"{\n        \"label\": {\n            \"width\":\"auto\"\n        }\n      }","value":""},"record":"{record}","type":"textarea"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-right_small slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-right_small slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"children":[{"children":[],"class":"slds-col ","element":"block","elementLabel":"Block-3-Block-0","key":"element_element_block_3_0_block_0_0","name":"Block","parentElementKey":"element_block_3_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"10","isResponsive":true,"large":"11","medium":"10","small":"10"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"10","isResponsive":true,"large":"11","medium":"10","small":"10"},"sizeClass":"slds-large-size_11-of-12  slds-medium-size_10-of-12  slds-small-size_10-of-12  slds-size_10-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"10","isResponsive":true,"large":"11","medium":"10","small":"10"},"sizeClass":"slds-large-size_11-of-12  slds-medium-size_10-of-12  slds-small-size_10-of-12  slds-size_10-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"children":[{"class":"slds-col ","element":"action","elementLabel":"Block-3-Action-2","key":"element_element_element_block_3_0_block_1_0_action_0_0","name":"Action","parentElementKey":"element_element_block_3_0_block_1_0","property":{"actionList":[{"actionIndex":0,"draggable":true,"isOpen":false,"isTrackingDisabled":true,"key":"1667933698937-ze7usjv38","label":"ActionCreateTopic","stateAction":{"Web Page":{"targetName":"/apex"},"id":"flex-action-1671827696281","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_CreateManualCustomerInteractionTopic\",\"vlocityAsync\":false,\"inputMap\":{\"interactionId\":\"{recordId}\",\"remarkup\":\"{remarkup__c}\",\"userId\":\"{User.userId}\",\"topicId\":\"{Session.SelectedRelationshipTopicId}\",\"ProductType\":\"{Session.SelectedRelationshipProductType}\",\"ServiceTree\":\"{Session.SelectedRelationshipServiceTree}\",\"AssetId\":\"{Session.SelectedRelationshipAssetId}\",\"OtherProduct\":\"{Session.SelectedRelationshipOtherProduct}\"}},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"Session.SelectedRelationshipTopicId\",\"val\":\"\",\"id\":20},{\"name\":\"User.userId\",\"val\":\"\",\"id\":8},{\"name\":\"remarkup__c\",\"val\":\"\",\"id\":8},{\"name\":\"recordId\",\"val\":\"\",\"id\":8},{\"name\":\"Session.SelectedRelationshipProductType\",\"val\":\"\",\"id\":31},{\"name\":\"Session.SelectedRelationshipServiceTree\",\"val\":\"\",\"id\":32},{\"name\":\"Session.SelectedRelationshipAssetId\",\"val\":\"\",\"id\":33},{\"name\":\"Session.SelectedRelationshipOtherProduct\",\"val\":\"\",\"id\":16}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":false,"key":"1668693542007-ufju3akj1","label":"ActionCreateTopicVivoNet","stateAction":{"Web Page":{"targetName":"/apex"},"actionConditions":{"group":[{"field":"interactionTopicId","hasMergeField":false,"id":"state-new-condition-0","operator":"!=","type":"custom","value":""},{"field":"Session.SelectedRelationshipProductType","hasMergeField":false,"id":"state-new-condition-4","logicalOperator":"&&","operator":"==","type":"custom","value":"Pre"}],"id":"state-condition-object","isParent":true},"displayName":"Action","id":"flex-action-1671808721578","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_CallOutProtocolItemVivoNet\",\"vlocityAsync\":false,\"inputMap\":{\"interactionId\":\"{recordId}\",\"topicId\":\"{Session.SelectedRelationshipTopicId}\",\"interactionTopicId\":\"{interactionTopicId}\"}},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"recordId\",\"val\":\"\",\"id\":1},{\"name\":\"interactionTopicId\",\"val\":\"\",\"id\":6},{\"name\":\"Session.SelectedRelationshipTopicId\",\"val\":\"\",\"id\":13}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}},{"actionIndex":2,"card":"{card}","draggable":true,"isOpen":false,"key":"1668703827712-ca426yh6v","label":"ActionToastTopicCreated","stateAction":{"actionConditions":{"group":[{"field":"interactionTopicId","hasMergeField":false,"id":"state-new-condition-0","operator":"!=","type":"custom","value":""}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valToast","extraParams":{"message":"Palito {Session.SelectedRelationshipFolderName} criado no Salesforce com sucesso","variant":"success"},"hasExtraParams":true,"id":"flex-action-1669056524418","message":"showToast","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":3,"card":"{card}","draggable":true,"isOpen":false,"key":"1668704892424-de3am6vyj","label":"ActionToastTopicVivoNetError","stateAction":{"actionConditions":{"group":[{"field":"status","hasMergeField":false,"id":"state-new-condition-0","operator":"!=","type":"custom","value":"Created"},{"field":"Session.SelectedRelationshipProductType","hasMergeField":false,"id":"state-new-condition-14","logicalOperator":"&&","operator":"==","type":"custom","value":"Pre"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valToast","extraParams":{"message":"{message}","variant":"error"},"hasExtraParams":true,"id":"flex-action-1671808685626","message":"showToast","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":5,"card":"{card}","draggable":true,"isOpen":false,"key":"1669041865963-ci5e0rmeg","label":"ActionToastTopicVivoNetSuccess","stateAction":{"actionConditions":{"group":[{"field":"status","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"Created"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valToast","extraParams":{"message":"{message}","variant":"success"},"hasExtraParams":true,"id":"flex-action-1669054262556","message":"showToast","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":5,"card":"{card}","draggable":true,"isOpen":false,"key":"1669055113426-t2asg1uri","label":"Action","stateAction":{"displayName":"Action","eventName":"close_modalrelationshiptopic","id":"flex-action-1669055120613","message":"close","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":6,"card":"{card}","draggable":true,"isOpen":true,"key":"1672246035871-5x7992ebw","label":"Action","stateAction":{"displayName":"Action","eventName":"valServiceFlow","id":"flex-action-1672246075638","message":"hidetree","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":7,"card":"{card}","draggable":true,"isOpen":true,"key":"1672246357487-h2ks6kyo9","label":"Action","stateAction":{"displayName":"Action","eventName":"valServiceFlow","id":"flex-action-1672246533292","message":"refresh","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"buttonVariant":"brand","card":"{card}","data-conditions":{"group":[{"field":"Session.SelectedRelationshipTopicId","hasMergeField":false,"id":"state-new-condition-0","operator":"!=","type":"custom","value":""}],"id":"state-condition-object","isParent":true},"displayAsButton":true,"flyoutDetails":{},"hideActionIcon":true,"iconName":"standard-default","label":"Registrar","record":"{record}","showSpinner":"false","stateObj":"{record}"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 "},"type":"element"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-3-Field-3","key":"element_element_element_block_3_0_block_1_0_outputField_1_0","name":"Field","parentElementKey":"element_element_block_3_0_block_1_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"Session.SelectedRelationshipTopicId","hasMergeField":false,"id":"state-new-condition-5","operator":"==","type":"custom","value":""}],"id":"state-condition-object","isParent":true},"label":"Registrar","placeholder":"","record":"{record}","styles":{"label":{"color":"#FFFFFF","fontSize":"13px;","textAlign":"center"}},"type":"text"},"size":{"default":"8","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#CDCDCD","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"3px","style":"","type":"","width":""},"class":"slds-p-around_xx-small moveButtonDisable1","container":{"class":""},"customClass":"moveButtonDisable1","elementStyleProperties":{"styles":{"label":{"color":"#FFFFFF","fontSize":"13px;","textAlign":"center"}}},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"8","isResponsive":false},"sizeClass":"slds-size_8-of-12 ","style":"background-color:#CDCDCD;      \n    border-radius:3px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#CDCDCD","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"3px","style":"","type":"","width":""},"class":"slds-p-around_xx-small moveButtonDisable1","container":{"class":""},"customClass":"moveButtonDisable1","elementStyleProperties":{"styles":{"label":{"color":"#FFFFFF","fontSize":"13px;","textAlign":"center"}}},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"8","isResponsive":false},"sizeClass":"slds-size_8-of-12 ","style":"background-color:#CDCDCD;      \n    border-radius:3px;     ","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-3-Block-1","key":"element_element_block_3_0_block_1_0","name":"Block","parentElementKey":"element_block_3_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"}],"class":"slds-col ","element":"block","elementLabel":"Block-4","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#EEEDED","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#EEEDED;      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#EEEDED","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#EEEDED;      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"customLwc","elementLabel":"Custom LWC-5","name":"Custom LWC","property":{"customlwcname":"valToast"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"},{"children":[{"class":"slds-col ","element":"action","elementLabel":"Block-7-Action-0","key":"element_element_block_5_0_action_0_0","name":"Action","parentElementKey":"element_block_5_0","property":{"actionList":[{"actionIndex":0,"draggable":false,"isOpen":true,"key":"1671592048247-7uiyyotxz","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"eventName":"reload","id":"flex-action-1671592062269","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction"}}],"buttonVariant":"outline-brand","card":"{card}","data-conditions":{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"Fixed"}],"id":"state-condition-object","isParent":true},"displayAsButton":true,"flyoutDetails":{},"hideActionIcon":true,"iconColor":"#FFFFFF","iconName":"standard-default","label":"Reiniciar Fluxo","record":"{record}","showSpinner":"false","stateObj":"{record}"},"size":{"default":"2","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#FFFFFF","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"iconColor":"#FFFFFF"},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"background-color:#FFFFFF;      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#FFFFFF","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"iconColor":"#FFFFFF"},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"background-color:#FFFFFF;      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"children":[],"class":"slds-col ","element":"block","elementLabel":"Block-7-Block-1","key":"element_element_block_5_0_block_1_0","name":"Block","parentElementKey":"element_block_5_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"data-conditions":{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"Fixed"}],"id":"state-condition-object","isParent":true},"label":"Block","record":"{record}"},"size":{"default":"10","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-7-Field-3","key":"element_element_block_5_0_outputField_2_0","name":"Field","parentElementKey":"element_block_5_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"1","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"2"}],"id":"state-condition-object","isParent":true},"fieldName":"","label":"Ligação Caiu","placeholder":"","record":"{record}","styles":{"label":{"color":"#FFFFFF","fontSize":"13px","textAlign":"center"}},"type":"text"},"size":{"default":"2","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#CDCDCD","image":"","position":"","repeat":"","size":""},"border":{"color":"#CDCDCD","radius":"3px","style":"","type":"","width":""},"class":"slds-p-around_xx-small ","container":{"class":""},"customClass":"","elementStyleProperties":{"styles":{"label":{"color":"#FFFFFF","fontSize":"13px","textAlign":"center"}}},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"background-color:#CDCDCD;      \n    border-radius:3px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#CDCDCD","image":"","position":"","repeat":"","size":""},"border":{"color":"#CDCDCD","radius":"3px","style":"","type":"","width":""},"class":"slds-p-around_xx-small ","container":{"class":""},"customClass":"","elementStyleProperties":{"styles":{"label":{"color":"#FFFFFF","fontSize":"13px","textAlign":"center"}}},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"background-color:#CDCDCD;      \n    border-radius:3px;     ","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-7","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 "},"type":"block"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card addRelationshipTopicModal slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card addRelationshipTopicModal"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false,"large":"9","medium":"12","small":"12"},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valAddRelationshipTopicModal","Id":"a5W78000000KzUzEAK","vlocity_cmt__GlobalKey__c":"valAddRelationshipTopicModal/Deloitte_GuilhermeKaiser/3/1670862304557","vlocity_cmt__IsChildCard__c":true};
  export default definition