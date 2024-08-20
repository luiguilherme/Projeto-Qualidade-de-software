let definition =
      {"dataSource":{"type":"Custom","value":{"dsDelay":"","body":"{}","resultVar":""},"orderBy":{"name":"","isReverse":""},"contextVariables":[]},"dynamicCanvasWidth":{"type":"desktop"},"enableLwc":true,"isFlex":true,"lwc":{"DeveloperName":"cfValPrePaidAssetDetailsButtons_ExtratosButton_3_Telefonica","Id":"0Rb7600000052PJCAY","MasterLabel":"cfValPrePaidAssetDetailsButtons_ExtratosButton_3_Telefonica","NamespacePrefix":"c","ManageableState":"unmanaged"},"osSupport":true,"states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"name":"Action","element":"action","size":{"isResponsive":false,"default":"12"},"stateIndex":0,"class":"slds-col ","property":{"label":"Extratos","iconName":"utility:description","record":"{record}","card":"{card}","stateObj":"{record}","actionList":[{"key":"1708112752053-n1qz2mc5y","label":"event","draggable":true,"isOpen":true,"card":"{card}","stateAction":{"message":"Extratos","id":"flex-action-1717678859575","type":"Event","subType":"PubSub","eventName":"valPrePaidAssetDetailsButtons_ChannelNameButtons"},"actionIndex":0,"isTrackingDisabled":false}],"showSpinner":"true","iconOnly":false,"flyoutDetails":{},"iconSize":"small","iconColor":"#792BA4","data-conditions":{"id":"state-condition-object","isParent":true,"group":[]},"styles":{"label":{"color":"#792BA4","fontSize":"12px"}}},"type":"element","styleObject":{"sizeClass":"slds-size_12-of-12 ","padding":[{"type":"left","size":"small","label":"left:small"},{"type":"top","size":"small","label":"top:small"}],"margin":[],"background":{"color":"","image":"","size":"","repeat":"","position":""},"size":{"isResponsive":false,"default":"12"},"container":{"class":""},"border":{"type":["border_top","border_right","border_bottom","border_left"],"width":"1","color":"#cccccc","radius":"5px","style":""},"elementStyleProperties":{"iconSize":"small","iconColor":"#792BA4","styles":{"label":{"color":"#792BA4","fontSize":"12px"}}},"text":{"align":"left","color":""},"inlineStyle":"height: 55px;","class":"slds-text-align_left slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-left_small slds-p-top_small ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     height: 55px;","customClass":""},"elementLabel":"Action-0","styleObjects":[{"key":0,"conditions":"default","styleObject":{"sizeClass":"slds-size_12-of-12 ","padding":[{"type":"left","size":"small","label":"left:small"},{"type":"top","size":"small","label":"top:small"}],"margin":[],"background":{"color":"","image":"","size":"","repeat":"","position":""},"size":{"isResponsive":false,"default":"12"},"container":{"class":""},"border":{"type":["border_top","border_right","border_bottom","border_left"],"width":"1","color":"#cccccc","radius":"5px","style":""},"elementStyleProperties":{"iconSize":"small","iconColor":"#792BA4","styles":{"label":{"color":"#792BA4","fontSize":"12px"}}},"text":{"align":"left","color":""},"inlineStyle":"height: 55px;","class":"slds-text-align_left slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-left_small slds-p-top_small ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     height: 55px;","customClass":""},"label":"Default","name":"Default","conditionString":"","draggable":false}]}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valPrePaidAssetDetailsButtons_ExtratosButton","globalCSS":false,"events":[{"eventname":"Extratos","channelname":"valPrePaidAssetDetailsButtons_ChannelNameButtons","element":"action","eventtype":"pubsub","recordIndex":"0","actionList":[{"key":"1717503886502-1ki4xpbcw","label":"CheckBiometric","draggable":true,"isOpen":true,"card":"{card}","stateAction":{"id":"flex-action-1718032182254","type":"DataAction","displayName":"Action","vlocityIcon":"standard-default","targetType":"Web Page","openUrlIn":"Current Window","Web Page":{"targetName":"/apex"},"message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_ValidateAllJourneys\",\"vlocityAsync\":false,\"inputMap\":{\"CheckBiometric\":\"true\",\"PreSetValues\":\"true\",\"AssetId\":\"{Parent.AssetId}\",\"AccountId\":\"{Parent.AccountId}\",\"interactionId\":\"{Parent.InteractionId}\",\"serviceType\":\"502\"},\"jsonMap\":\"{\\\"recordId\\\":\\\"{recordId}\\\",\\\"Parent.AssetId\\\":\\\"{Parent.AssetId}\\\",\\\"Parent.AccountId\\\":\\\"{Parent.AccountId}\\\",\\\"Parent.InteractionId\\\":\\\"{Parent.InteractionId}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"recordId\",\"val\":\"02i76000009Pdg3AAC\",\"id\":4},{\"name\":\"Parent.AssetId\",\"val\":\"\",\"id\":12},{\"name\":\"Parent.AccountId\",\"val\":\"\",\"id\":13},{\"name\":\"Parent.InteractionId\",\"val\":\"\",\"id\":14}]}"},"actionIndex":0},{"key":"1717504137241-bk2nmoa75","label":"valToast","draggable":true,"isOpen":true,"card":"{card}","stateAction":{"id":"flex-action-1718032266019","type":"Event","displayName":"Action","vlocityIcon":"standard-default","openUrlIn":"Current Window","subType":"PubSub","eventName":"valToast","message":"showToast","hasExtraParams":true,"extraParams":{"variant":"{variant}","message":"{message}"},"actionConditions":{"id":"state-condition-object","isParent":true,"group":[{"id":"state-new-condition-0","field":"blockJourney","operator":"==","value":"true","type":"custom","hasMergeField":false}]}},"actionIndex":1},{"key":"1717504229738-ms8x9yom7","label":"palitagem Manual","draggable":true,"isOpen":true,"card":"{card}","stateAction":{"id":"flex-action-1718032483740","type":"OmniScript","displayName":"Action","vlocityIcon":"standard-default","openUrlIn":"Current Window","layoutType":"lightning","omniType":{"Name":"val/AddRelationShipTopic/English","Id":"a3076000000AsWyAAK","isLwcOs":true},"isLwcOS":true,"tabLabel":"Palitar","tabIcon":"standard:cancel_checkout","hasExtraParams":true,"extraParams":{"c__SourceCalled":"SalesJourney","c__AssetId":"{Parent.AssetId}","c__InteractionNumber":"{Parent.InteractionNumber}","c__lineNumber":"{Products.LineNumber}","c__CustomerInteractionId":"{Parent.InteractionId}","c__AccountId":"{Parent.AccountId}"},"actionConditions":{"id":"state-condition-object","isParent":true,"group":[{"id":"state-new-condition-7","field":"palitagem","operator":"==","value":"true","type":"custom","hasMergeField":false}]}},"actionIndex":2,"contextId":"\\{Parent.InteractionId}"},{"key":"1717504674821-nlshooaf1","label":"Action","draggable":false,"isOpen":true,"card":"{card}","stateAction":{"id":"flex-action-1718032626320","type":"OmniScript","displayName":"Action","vlocityIcon":"standard-default","openUrlIn":"New Tab/Window","layoutType":"lightning","omniType":{"Name":"val/SelectOptionExtractPage/English","Id":"a3076000000EislAAC","isLwcOs":true},"isLwcOS":true,"tabLabel":"Extratos da linha","tabIcon":"utility:description","hasExtraParams":true,"extraParams":{"c__subscriptionId":"{Parent.SubscriptionId}","c__lineNumber":"{Products.LineNumber}","c__interactionId":"{Parent.InteractionId}"},"actionConditions":{"id":"state-condition-object","isParent":true,"group":[{"id":"state-new-condition-14","field":"blockJourney","operator":"==","value":"false","type":"custom","hasMergeField":false}]}},"actionIndex":3,"contextId":"\\{Parent.AssetId}"}],"showSpinner":"true","key":"event-0","displayLabel":"valPrePaidAssetDetailsButtons_ChannelNameButtons:Extratos","eventLabel":"pubsub"}],"multilanguageSupport":true,"sessionVars":[{"name":"AssetId","isApi":true,"val":""}],"Id":"a5W76000000ChrGEAS","vlocity_cmt__GlobalKey__c":"valPrePaidAssetDetailsButtons_ExtratosButton/Telefonica/3/1703857329164","vlocity_cmt__IsChildCard__c":true};
  export default definition