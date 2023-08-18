let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":"","name":""},"type":"Custom","value":{"body":"[{ \"remarkup__c\":\"\"}]","dsDelay":"","resultVar":""}},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1687214917822-xnrzn6q0p","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"Session.SelectedRelationshipTopicId","fieldValue":"{action.Id}"},{"fieldName":"Session.SelectedRelationshipFolderName","fieldValue":"{action.Name}"},{"fieldName":"Session.SelectedRelationshipProductType","fieldValue":"{action.ProductType}"},{"fieldName":"Session.SelectedRelationshipServiceTree","fieldValue":"{action.ServiceTree}"},{"fieldName":"Session.SelectedRelationshipAssetId","fieldValue":"{action.AssetId}"},{"fieldName":"Session.SelectedRelationshipOtherProduct","fieldValue":"{action.OtherProduct}"}],"id":"flex-action-1687264778945","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valAddRelationshipTopicModal","displayLabel":"valAddRelationshipTopicModal:Selected","element":"action","eventLabel":"pubsub","eventname":"Selected","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1667927526787-n2jpp5690","label":"Action","stateAction":{"actionConditions":{"group":[],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"setValues","extraParams":{"Session.SelectedRelationshipTopicId":"{action.Id}"},"fieldValues":[{"fieldName":"Session.SelectedRelationshipTopicId","fieldValue":"{action.Id}"},{"fieldName":"Session.SelectedRelationshipFolderName","fieldValue":"{action.Name}"},{"fieldName":"Session.SelectedRelationshipProductType","fieldValue":"{action.ProductType}"},{"fieldName":"Session.SelectedRelationshipServiceTree","fieldValue":"{action.ServiceTree}"},{"fieldName":"Session.SelectedRelationshipAssetId","fieldValue":"{action.AssetId}"},{"fieldName":"Session.SelectedRelationshipOtherProduct","fieldValue":"{action.OtherProduct}"}],"hasExtraParams":true,"id":"flex-action-1672057463178","message":"clearselection","openUrlIn":"Current Window","subType":"PubSub","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valAddRelationshipTopicModal","displayLabel":"valAddRelationshipTopicModal:clearselection","element":"action","eventLabel":"pubsub","eventname":"clearselection","eventtype":"pubsub","key":"event-1","recordIndex":"0","showSpinner":"false"}],"globalCSS":false,"isFlex":true,"lwc":{"DeveloperName":"cfValAddRelationshipTopicModal_3_Deloitte_GuilhermeKaiser","Id":"0Rb760000000LieCAE","ManageableState":"unmanaged","MasterLabel":"cfValAddRelationshipTopicModal_3_Deloitte_GuilhermeKaiser","NamespacePrefix":"c"},"multilanguageSupport":true,"osSupport":true,"selectableMode":"Multi","sessionVars":[{"name":"SelectedRelationshipTopicId","val":""},{"name":"SelectedRelationshipFolderName","val":""},{"name":"SelectedRelationshipProductType","val":""},{"name":"SelectedRelationshipServiceTree","val":""},{"name":"SelectedRelationshipAssetId","val":""},{"name":"SelectedRelationshipOtherProduct","val":""},{"isApi":true,"name":"CustomerInteractionId"},{"isApi":true,"name":"Channel"},{"isApi":true,"name":"OrderId"},{"isApi":true,"name":"AccountId"}],"states":[{"actions":[],"childCards":["valCloseManualProtocolDetails","valTopicsTreeMenu"],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Text-0","name":"Text","property":{"card":"{card}","data-conditions":{"group":[{"field":"Parent.showHeader","hasMergeField":false,"id":"state-new-condition-18","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"mergeField":"%3Cdiv%20class=%22slds-text-align_center%22%3E%3Cspan%20style=%22font-size:%2018pt;%22%3ERegistrar%20Relacionanamento%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":"border_bottom","width":"3"},"class":"slds-border_bottom slds-m-bottom_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-bottom: #cccccc 3px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":"border_bottom","width":"3"},"class":"slds-border_bottom slds-m-bottom_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-bottom: #cccccc 3px solid; \n         ","text":{"align":"","color":""}}}],"type":"text"},{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-2-FlexCard-0","key":"element_element_block_1_0_childCardPreview_0_0","name":"FlexCard","parentElementKey":"element_block_1_0","property":{"cardName":"valCloseManualProtocolDetails","cardNode":"","isChildCardTrackingEnabled":false,"parentAttribute":{"Id":"{Session.CustomerInteractionId}"},"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-1","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"sizeClass":"slds-size_12-of-12"},"type":"block"},{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-1-FlexCard-1","key":"element_element_block_2_0_childCardPreview_0_0","name":"FlexCard","parentElementKey":"element_block_2_0","property":{"cardName":"valTopicsTreeMenu","cardNode":"","isChildCardTrackingEnabled":false,"parentAttribute":{"Active":"Active","AssetId":"{Parent.assetId}","CustomerInteractionId":"{Session.CustomerInteractionId}","HideAddBtn":"true","ProductType":"Pre","SelectedFunction":"RelationshipTopic","ServiceTree":"{Session.Channel}"},"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-3","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-card slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-card slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Text Area-4","name":"Text Area","property":{"card":"{card}","propertyObj":{"customProperties":[],"fieldBinding":"{remarkup__c}","label":"Observação","maxLength":255,"placeholder":"","styles":"{\n        \"label\": {\n            \"width\":\"auto\"\n        }\n      }","value":""},"record":"{record}","type":"textarea"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-right_small slds-m-bottom_xx-small .slds-textarea { resize: none;}","container":{"class":""},"customClass":".slds-textarea { resize: none;}","elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-right_small slds-m-bottom_xx-small .slds-textarea { resize: none;}","container":{"class":""},"customClass":".slds-textarea { resize: none;}","elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"children":[{"children":[],"class":"slds-col ","element":"block","elementLabel":"Block-3-Block-0","key":"element_element_block_4_0_block_0_0","name":"Block","parentElementKey":"element_block_4_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"10","isResponsive":true,"large":"11","medium":"10","small":"10"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"width: 90%;","margin":[],"padding":[],"size":{"default":"10","isResponsive":true,"large":"11","medium":"10","small":"10"},"sizeClass":"slds-large-size_11-of-12 slds-medium-size_10-of-12 slds-small-size_10-of-12 slds-size_10-of-12 ","style":"      \n         width: 90%;","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"width: 90%;","margin":[],"padding":[],"size":{"default":"10","isResponsive":true,"large":"11","medium":"10","small":"10"},"sizeClass":"slds-large-size_11-of-12 slds-medium-size_10-of-12 slds-small-size_10-of-12 slds-size_10-of-12 ","style":"      \n         width: 90%;","text":{"align":"","color":""}}}],"type":"block"},{"children":[{"class":"slds-col ","element":"action","elementLabel":"Block-3-Action-2","key":"element_element_element_block_4_0_block_1_0_action_0_0","name":"Action","parentElementKey":"element_element_block_4_0_block_1_0","property":{"actionList":[{"actionIndex":0,"draggable":true,"isOpen":false,"isTrackingDisabled":true,"key":"1667933698937-ze7usjv38","label":"ActionCreateTopic","stateAction":{"Web Page":{"targetName":"/apex"},"id":"flex-action-1686172863994","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_CreateManualCustomerInteractionTopic\",\"vlocityAsync\":false,\"inputMap\":{\"interactionId\":\"{Session.CustomerInteractionId}\",\"remarkup\":\"{remarkup__c}\",\"userId\":\"{User.userId}\",\"topicId\":\"{Session.SelectedRelationshipTopicId}\",\"ProductType\":\"{Session.SelectedRelationshipProductType}\",\"ServiceTree\":\"{Session.SelectedRelationshipServiceTree}\",\"AssetId\":\"{Session.SelectedRelationshipAssetId}\",\"OtherProduct\":\"{Session.SelectedRelationshipOtherProduct}\",\"OrderId\":\"{Session.OrderId}\",\"interactionTopicId\":\"{interactionTopicId}\"},\"jsonMap\":\"{\\\"Session.SelectedRelationshipTopicId\\\":\\\"{Session.SelectedRelationshipTopicId}\\\",\\\"User.userId\\\":\\\"{User.userId}\\\",\\\"remarkup__c\\\":\\\"{remarkup__c}\\\",\\\"recordId\\\":\\\"{recordId}\\\",\\\"Session.SelectedRelationshipProductType\\\":\\\"{Session.SelectedRelationshipProductType}\\\",\\\"Session.SelectedRelationshipServiceTree\\\":\\\"{Session.SelectedRelationshipServiceTree}\\\",\\\"Session.SelectedRelationshipAssetId\\\":\\\"{Session.SelectedRelationshipAssetId}\\\",\\\"Session.SelectedRelationshipOtherProduct\\\":\\\"{Session.SelectedRelationshipOtherProduct}\\\",\\\"Session.CustomerInteractionId\\\":\\\"{Session.CustomerInteractionId}\\\",\\\"Session.OrderId\\\":\\\"{Session.OrderId}\\\",\\\"interactionTopicId\\\":\\\"{interactionTopicId}\\\"}\",\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"Session.SelectedRelationshipTopicId\",\"val\":\"\",\"id\":20},{\"name\":\"User.userId\",\"val\":\"\",\"id\":8},{\"name\":\"remarkup__c\",\"val\":\"\",\"id\":8},{\"name\":\"recordId\",\"val\":\"\",\"id\":8},{\"name\":\"Session.SelectedRelationshipProductType\",\"val\":\"\",\"id\":31},{\"name\":\"Session.SelectedRelationshipServiceTree\",\"val\":\"\",\"id\":32},{\"name\":\"Session.SelectedRelationshipAssetId\",\"val\":\"\",\"id\":33},{\"name\":\"Session.SelectedRelationshipOtherProduct\",\"val\":\"\",\"id\":16},{\"name\":\"Session.CustomerInteractionId\",\"val\":\"\",\"id\":32},{\"name\":\"Session.OrderId\",\"val\":\"\",\"id\":27},{\"name\":\"interactionTopicId\",\"val\":\"\",\"id\":49}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":false,"key":"1668693542007-ufju3akj1","label":"ActionCreateTopicVivoNet","stateAction":{"Web Page":{"targetName":"/apex"},"actionConditions":{"group":[{"field":"interactionTopicId","hasMergeField":false,"id":"state-new-condition-0","operator":"!=","type":"custom","value":""},{"field":"Session.SelectedRelationshipProductType","hasMergeField":false,"id":"state-new-condition-4","logicalOperator":"&&","operator":"==","type":"custom","value":"Pre"},{"field":"hasErrorGenerateInteractionNumber","hasMergeField":false,"id":"state-new-condition-7","logicalOperator":"&&","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"displayName":"Action","id":"flex-action-1686944553556","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_CallOutProtocolItemVivoNet\",\"vlocityAsync\":false,\"inputMap\":{\"interactionId\":\"{Session.CustomerInteractionId}\",\"topicId\":\"{Session.SelectedRelationshipTopicId}\",\"interactionTopicId\":\"{interactionTopicId}\"},\"jsonMap\":\"{\\\"recordId\\\":\\\"{recordId}\\\",\\\"interactionTopicId\\\":\\\"{interactionTopicId}\\\",\\\"Session.SelectedRelationshipTopicId\\\":\\\"{Session.SelectedRelationshipTopicId}\\\",\\\"Session.CustomerInteractionId\\\":\\\"{Session.CustomerInteractionId}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"recordId\",\"val\":\"\",\"id\":1},{\"name\":\"interactionTopicId\",\"val\":\"\",\"id\":6},{\"name\":\"Session.SelectedRelationshipTopicId\",\"val\":\"\",\"id\":13},{\"name\":\"Session.CustomerInteractionId\",\"val\":\"\",\"id\":6}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}},{"actionIndex":2,"card":"{card}","draggable":true,"isOpen":true,"key":"1668703827712-ca426yh6v","label":"ActionToastTopicCreated","stateAction":{"actionConditions":{"group":[{"field":"idAtendimento","hasMergeField":false,"id":"state-new-condition-12","operator":"!=","type":"custom","value":""},{"field":"interactionTopicId","hasMergeField":false,"id":"state-new-condition-17","logicalOperator":"&&","operator":"!=","type":"custom","value":""},{"field":"hasErrorGenerateInteractionNumber","hasMergeField":false,"id":"state-new-condition-29","logicalOperator":"&&","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valToast","extraParams":{"message":"Palito {Session.SelectedRelationshipFolderName} criado no Salesforce com sucesso","variant":"success"},"hasExtraParams":true,"id":"flex-action-1687266334913","message":"showToast","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":3,"card":"{card}","draggable":true,"isOpen":false,"key":"1668704892424-de3am6vyj","label":"ActionToastTopicVivoNetSuccess","stateAction":{"actionConditions":{"group":[{"field":"Session.SelectedRelationshipProductType","hasMergeField":false,"id":"state-new-condition-17","operator":"==","type":"custom","value":"Pre"},{"field":"idAtendimento","hasMergeField":false,"id":"state-new-condition-24","logicalOperator":"&&","operator":"!=","type":"custom","value":""},{"field":"status","hasMergeField":false,"id":"state-new-condition-31","logicalOperator":"&&","operator":"!=","type":"custom","value":"Created"},{"field":"hasErrorGenerateInteractionNumber","hasMergeField":false,"id":"state-new-condition-33","logicalOperator":"&&","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valToast","extraParams":{"message":"{message}","variant":"success"},"hasExtraParams":true,"id":"flex-action-1686944845878","message":"showToast","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":4,"card":"{card}","draggable":true,"isOpen":false,"key":"1686170351457-84yyeiizf","label":"ActionToastTopicVivoNetError","stateAction":{"actionConditions":{"group":[{"field":"idAtendimento","hasMergeField":false,"id":"state-new-condition-55","operator":"==","type":"custom","value":""},{"field":"hasErrorGenerateInteractionNumber","hasMergeField":false,"id":"state-new-condition-49","logicalOperator":"||","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valToast","extraParams":{"message":"Deu um problema ao tentar realizar o Registro de Relacionamento. Por favor. Tente novamente.","variant":"error"},"hasExtraParams":true,"id":"flex-action-1686944905888","message":"showToast","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":5,"card":"{card}","draggable":true,"isOpen":false,"key":"1669055113426-t2asg1uri","label":"ActionCloseModal","stateAction":{"displayName":"Action","eventName":"close_modalrelationshiptopic","id":"flex-action-1669055120613","message":"close","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":6,"card":"{card}","draggable":true,"isOpen":false,"key":"1683037297852-svcc88ddq","label":"ActionNavigate","stateAction":{"Record":{"targetAction":"view","targetId":"{Session.CustomerInteractionId}","targetName":"vlocity_cmt__CustomerInteraction__c"},"actionConditions":{"group":[{"field":"idAtendimento","hasMergeField":false,"id":"state-new-condition-44","operator":"!=","type":"custom","value":""},{"field":"hasErrorGenerateInteractionNumber","hasMergeField":false,"id":"state-new-condition-7","logicalOperator":"&&","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"displayName":"Action","id":"flex-action-1686946591052","openUrlIn":"Current Window","targetType":"Record","type":"Custom","vlocityIcon":"standard-default"}}],"buttonVariant":"brand","card":"{card}","data-conditions":{"group":[{"field":"Session.SelectedRelationshipTopicId","hasMergeField":false,"id":"state-new-condition-0","operator":"!=","type":"custom","value":""}],"id":"state-condition-object","isParent":true},"displayAsButton":true,"flyoutDetails":{},"hideActionIcon":true,"iconName":"standard-default","label":"Registrar","record":"{record}","showSpinner":"true","stateObj":"{record}"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 "},"type":"element"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-3-Field-3","key":"element_element_element_block_4_0_block_1_0_outputField_1_0","name":"Field","parentElementKey":"element_element_block_4_0_block_1_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"Session.SelectedRelationshipTopicId","hasMergeField":false,"id":"state-new-condition-5","operator":"==","type":"custom","value":""}],"id":"state-condition-object","isParent":true},"label":"Registrar","placeholder":"","record":"{record}","styles":{"label":{"color":"#FFFFFF","fontSize":"13px;","textAlign":"center"}},"type":"text"},"size":{"default":"8","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#CDCDCD","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"3px","style":"","type":"","width":""},"class":"slds-p-around_xx-small moveButtonDisable1","container":{"class":""},"customClass":"moveButtonDisable1","elementStyleProperties":{"styles":{"label":{"color":"#FFFFFF","fontSize":"13px;","textAlign":"center"}}},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"8","isResponsive":false},"sizeClass":"slds-size_8-of-12 ","style":"background-color:#CDCDCD;      \n    border-radius:3px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#CDCDCD","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"3px","style":"","type":"","width":""},"class":"slds-p-around_xx-small moveButtonDisable1","container":{"class":""},"customClass":"moveButtonDisable1","elementStyleProperties":{"styles":{"label":{"color":"#FFFFFF","fontSize":"13px;","textAlign":"center"}}},"inlineStyle":"","margin":[],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"8","isResponsive":false},"sizeClass":"slds-size_8-of-12 ","style":"background-color:#CDCDCD;      \n    border-radius:3px;     ","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-3-Block-1","key":"element_element_block_4_0_block_1_0","name":"Block","parentElementKey":"element_block_4_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"}],"class":"slds-col ","element":"block","elementLabel":"Block-5","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#EEEDED","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#EEEDED;      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#EEEDED","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#EEEDED;      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"customLwc","elementLabel":"Custom LWC-6","name":"Custom LWC","property":{"customlwcname":"valToast"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card addRelationshipTopicModal slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card addRelationshipTopicModal"},"elementStyleProperties":{},"height":"685px;","inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false,"large":"9","medium":"12","small":"12"},"sizeClass":"slds-size_12-of-12 ","style":"      \n     height:685px;;    ","text":{"align":"","color":""}}}],"theme":"slds","title":"valAddRelationshipTopicModal","Name":"valAddRelationshipTopicModal","uniqueKey":"valAddRelationshipTopicModal_undefined_undefined","Id":"a5W760000008Y9sEAE","vlocity_cmt__GlobalKey__c":"valAddRelationshipTopicModal/Deloitte_GuilhermeKaiser/3/1670862304557","vlocity_cmt__IsChildCard__c":true};
  export default definition