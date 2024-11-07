let definition =
      {"dataSource":{"type":"Custom","value":{"dsDelay":"","body":"{}","resultVar":""},"orderBy":{"name":"","isReverse":""},"contextVariables":[]},"dynamicCanvasWidth":{"type":"desktop"},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":false,"key":"1717676858884-6ak1s4b4d","label":"CheckBiometric","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1717702021829","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_ValidateAllJourneys\",\"vlocityAsync\":false,\"inputMap\":{\"serviceType\":\"511\",\"InteractionId\":\"{Parent.InteractionId}\",\"AccountId\":\"{Parent.AccountId}\",\"AssetId\":\"{Parent.AssetId}\",\"Functionality\":\"CancelLine\",\"PreSetValues\":\"true\",\"CheckBiometric\":\"true\",\"ValidatePortability\":\"true\",\"ValidateOrder\":\"true\"},\"jsonMap\":\"{\\\"recordId\\\":\\\"{recordId}\\\",\\\"Parent.InteractionId\\\":\\\"{Parent.InteractionId}\\\",\\\"Parent.AccountId\\\":\\\"{Parent.AccountId}\\\",\\\"Parent.AssetId\\\":\\\"{Parent.AssetId}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"recordId\",\"val\":\"02i76000009Pdg3AAC\",\"id\":4},{\"name\":\"Parent.InteractionId\",\"val\":\"\",\"id\":2},{\"name\":\"Parent.AccountId\",\"val\":\"\",\"id\":4},{\"name\":\"Parent.AssetId\",\"val\":\"\",\"id\":6}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":false,"key":"1717702120807-lomd40su2","label":"valToast","stateAction":{"actionConditions":{"group":[{"field":"blockJourney","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valToast","extraParams":{"message":"{message}","variant":"{variant}"},"hasExtraParams":true,"id":"flex-action-1717702168540","message":"showToast","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":2,"card":"{card}","draggable":false,"isOpen":true,"key":"1717702185542-78h4wbj6p","label":"Flyout","stateAction":{"actionConditions":{"group":[{"field":"blockJourney","hasMergeField":false,"id":"state-new-condition-7","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"channelName":"close_modal","displayName":"Action","flyoutContainerClass":"slds-text-align_left","flyoutLwc":"val-cancel-line-english","flyoutParams":{"ContextId":"{Parent.AssetId}","EntryPoint":"ProductDetails","InteractionId":"{Parent.InteractionId}"},"flyoutType":"OmniScripts","hasExtraParams":true,"id":"flex-action-1717767881265","layoutType":"lightning","openFlyoutIn":"Modal","openUrlIn":"Current Window","osName":"val/CancelLine/English","type":"Flyout","vlocityIcon":"standard-default"}},{"actionIndex":3,"card":"{card}","contextId":"\\{Parent.InteractionId}","draggable":true,"isOpen":false,"key":"1717702283287-vot7tgmh0","label":"PalitagemManual","stateAction":{"actionConditions":{"group":[{"field":"palitagem","hasMergeField":false,"id":"state-new-condition-14","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"displayName":"Action","extraParams":{"c__AccountId":"{Parent.AccountId}","c__AssetId":"{Parent.AssetId}","c__CustomerInteractionId":"{Parent.InteractionId}","c__InteractionNumber":"{Parent.InteractionNumber}","c__SourceCalled":"SalesJourney","c__lineNumber":"{Products.LineNumber}"},"hasExtraParams":true,"id":"flex-action-1717702392416","isLwcOS":true,"layoutType":"lightning","omniType":{"Id":"a3076000000AsWyAAK","Name":"val/AddRelationShipTopic/English","isLwcOs":true},"openUrlIn":"Current Window","tabIcon":"standard:cancel_checkout","tabLabel":"Palitar","type":"OmniScript","vlocityIcon":"standard-default"}}],"channelname":"valPrePaidAssetDetailsButtons_ChannelNameButtons","displayLabel":"valPrePaidAssetDetailsButtons_ChannelNameButtons:Cancelar Linha","element":"action","eventLabel":"pubsub","eventname":"Cancelar Linha","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"true"}],"globalCSS":false,"isFlex":true,"lwc":{"DeveloperName":"cfValPrePaidAssetDetailsButtons_CancelarLinhaButton_5_Telefonica","Id":"0Rb8I000001u51SSAQ","MasterLabel":"cfValPrePaidAssetDetailsButtons_CancelarLinhaButton_5_Telefonica","NamespacePrefix":"c","ManageableState":"unmanaged"},"multilanguageSupport":true,"osSupport":true,"states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"action","elementLabel":"CancelarLinha","name":"Action","property":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1708350605895-whi752vkg","label":"Event","stateAction":{"displayName":"Action","eventName":"valPrePaidAssetDetailsButtons_ChannelNameButtons","id":"flex-action-1717701965330","message":"Cancelar Linha","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"card":"{card}","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"flyoutChannel":"close_modal","flyoutDetails":{},"iconColor":"#792BA4","iconName":"utility:hide_mobile","iconOnly":false,"iconSize":"small","label":"Cancelar Linha","reRenderFlyout":true,"record":"{record}","showSpinner":"true","stateObj":"{record}","styles":{"label":{"color":"#792BA4","fontSize":"12px"}}},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"4px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-text-align_left slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-left_small slds-p-top_small ","container":{"class":""},"customClass":"","elementStyleProperties":{"iconColor":"#792BA4","iconSize":"small","styles":{"label":{"color":"#792BA4","fontSize":"12px"}}},"inlineStyle":"height: 55px;","margin":[],"padding":[{"label":"left:small","size":"small","type":"left"},{"label":"top:small","size":"small","type":"top"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:4px;     height: 55px;","text":{"align":"left","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"4px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-text-align_left slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-left_small slds-p-top_small ","container":{"class":""},"customClass":"","elementStyleProperties":{"iconColor":"#792BA4","iconSize":"small","styles":{"label":{"color":"#792BA4","fontSize":"12px"}}},"inlineStyle":"height: 55px;","margin":[],"padding":[{"label":"left:small","size":"small","type":"left"},{"label":"top:small","size":"small","type":"top"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:4px;     height: 55px;","text":{"align":"left","color":""}}}],"type":"element","userUpdatedElementLabel":true}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valPrePaidAssetDetailsButtons_CancelarLinhaButton","Name":"valPrePaidAssetDetailsButtons_CancelarLinhaButton","uniqueKey":"valPrePaidAssetDetailsButtons_CancelarLinhaButton_undefined_undefined","Id":"a5W8I000000FncfUAC","vlocity_cmt__GlobalKey__c":"valPrePaidAssetDetailsButtons_CancelarLinhaButton/Telefonica/5/1722024120764","vlocity_cmt__IsChildCard__c":true};
  export default definition