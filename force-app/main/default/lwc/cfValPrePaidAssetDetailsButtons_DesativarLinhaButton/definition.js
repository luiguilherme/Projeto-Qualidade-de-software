let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{},"type":null,"value":{}},"dynamicCanvasWidth":{"type":"desktop"},"enableLwc":true,"events":[{"eventname":"Desprogramar linha","channelname":"valPrePaidAssetDetailsButtons_ChannelNameButtons","element":"action","eventtype":"pubsub","recordIndex":"0","actionList":[{"key":"1717686409442-ahxr6jqek","label":"PortabilityInProgressToast","draggable":true,"isOpen":true,"card":"{card}","stateAction":{"id":"flex-action-1718033559000","type":"Event","displayName":"Action","vlocityIcon":"standard-default","openUrlIn":"Current Window","subType":"PubSub","eventName":"valToast","message":"showToast","hasExtraParams":true,"extraParams":{"message":"{message}","variant":"{variant}"},"actionConditions":{"id":"state-condition-object","isParent":true,"group":[{"id":"state-new-condition-3","field":"showToast","operator":"==","value":"true","type":"custom","hasMergeField":false},{"id":"state-new-condition-2","field":"HaveProvisionalNumber","operator":"==","value":"true","type":"custom","hasMergeField":false,"logicalOperator":"&&"}]}},"actionIndex":0},{"key":"1717686176661-vbz2qhoul","label":"Flyout","draggable":false,"isOpen":true,"card":"{card}","stateAction":{"id":"flex-action-1718033745705","type":"Flyout","displayName":"Action","vlocityIcon":"standard-default","openUrlIn":"Current Window","flyoutType":"OmniScripts","openFlyoutIn":"Modal","channelName":"close_modal","layoutType":"lightning","osName":"val/DeactivateLine/English","flyoutLwc":"val-deactivate-line-english","flyoutContainerClass":"slds-text-align_left","actionConditions":{"id":"state-condition-object","isParent":true,"group":[{"id":"state-new-condition-17","field":"showToast","operator":"==","value":"false","type":"custom","hasMergeField":false},{"id":"state-new-condition-20","field":"HaveProvisionalNumber","operator":"==","value":"false","type":"custom","hasMergeField":false,"logicalOperator":"&&"}]},"hasExtraParams":true,"flyoutParams":{"ContextId":"{Parent.AssetId}","EntryPoint":"ProductDetails","InteractionId":"{Parent.InteractionId}"}},"actionIndex":1}],"showSpinner":"true","key":"event-0","displayLabel":"valPrePaidAssetDetailsButtons_ChannelNameButtons:Desprogramar linha","eventLabel":"pubsub"}],"globalCSS":false,"isFlex":true,"lwc":{"DeveloperName":"cfValPrePaidAssetDetailsButtons_ChangeNumberButton_1_Telefonica","Id":"0Rb76000000515rCAA","ManageableState":"unmanaged","MasterLabel":"cfValPrePaidAssetDetailsButtons_ChangeNumberButton_1_Telefonica","NamespacePrefix":"c"},"multilanguageSupport":true,"osSupport":true,"sessionVars":[{"name":"AssetId","isApi":true,"val":""}],"states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"action","elementLabel":"DeactivateLine","name":"Action","property":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1700164705093-y26bt8hv4","label":"event","stateAction":{"actionConditions":{"group":[],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valPrePaidAssetDetailsButtons_ChannelNameButtons","hasExtraParams":false,"id":"flex-action-1718033214659","message":"Desprogramar linha","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"card":"{card}","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"flyoutChannel":"close_modal","flyoutDetails":{},"iconColor":"#792BA4","iconName":"utility:delete","iconOnly":false,"iconSize":"small","label":"Desprogramar linha","reRenderFlyout":true,"record":"{record}","showSpinner":"true","stateObj":"{record}","styles":{"label":{"fontSize":"12px","color":"#792BA4"}}},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"4px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-text-align_left slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-top_small slds-p-left_small ","container":{"class":""},"customClass":"","elementStyleProperties":{"iconColor":"#792BA4","iconSize":"small","styles":{"label":{"fontSize":"12px","color":"#792BA4"}}},"inlineStyle":"height: 55px;","margin":[],"padding":[{"type":"top","size":"small","label":"top:small"},{"type":"left","size":"small","label":"left:small"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:4px;     height: 55px;","text":{"align":"left","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"4px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-text-align_left slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-top_small slds-p-left_small ","container":{"class":""},"customClass":"","elementStyleProperties":{"iconColor":"#792BA4","iconSize":"small","styles":{"label":{"fontSize":"12px","color":"#792BA4"}}},"inlineStyle":"height: 55px;","margin":[],"padding":[{"type":"top","size":"small","label":"top:small"},{"type":"left","size":"small","label":"left:small"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:4px;     height: 55px;","text":{"align":"left","color":""}}}],"type":"element","userUpdatedElementLabel":true}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valPrePaidAssetDetailsButtons_DesativarLinhaButton","Id":"a5W76000000ChqcEAC","vlocity_cmt__GlobalKey__c":"valPrePaidAssetDetailsButtons_DesativarLinhaButton/Telefonica/2/1703859768678","vlocity_cmt__IsChildCard__c":true};
  export default definition