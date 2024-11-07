let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":"","name":""},"type":"Custom","value":{"body":"{\n\t\"Id\": \"\", \n\t\"ProductType\": \"\", \n\t\"SelectedFunction\": \"\", \n\t\"ServiceTree\": \"\", \n\t\"additionalSettingsType\": \"\"\n}","dsDelay":"","resultVar":""}},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1710968732068-hjpl8c1zs","label":"ActionHideAdditionalSettings","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"Id","fieldValue":"''"},{"fieldName":"ProductType","fieldValue":"''"},{"fieldName":"SelectedFunction","fieldValue":"''"},{"fieldName":"ServiceTree","fieldValue":"''"},{"fieldName":"additionalSettingsType","fieldValue":"''"}],"id":"flex-action-1711054615580","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valtopicstreeitem","displayLabel":"valtopicstreeitem:clearselection","element":"action","eventLabel":"pubsub","eventname":"clearselection","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1710774027991-bkgm9hg7f","label":"ActionUpdateAdditionalSettingsActiveTab","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"additionalSettingsType","fieldValue":"{action.tabName}"}],"id":"flex-action-1711054630218","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"TopicsTreeAdditionalSettingsChannel","displayLabel":"TopicsTreeAdditionalSettingsChannel:updateselectedtab","element":"action","eventLabel":"pubsub","eventname":"updateselectedtab","eventtype":"pubsub","key":"event-1","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1710782335009-883jpp8xx","label":"ActionShowAdditionalSettings","stateAction":{"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"Id","fieldValue":"{action.Id}"},{"fieldName":"ProductType","fieldValue":"{action.ProductType}"},{"fieldName":"SelectedFunction","fieldValue":"{action.SelectedFunction}"},{"fieldName":"ServiceTree","fieldValue":"{action.ServiceTree}"},{"fieldName":"additionalSettingsType","fieldValue":"FollowUpCase"}],"id":"flex-action-1712843967783","openUrlIn":"Current Window","subType":"PubSub","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"TopicsTreeAdditionalSettingsChannel","displayLabel":"TopicsTreeAdditionalSettingsChannel:selectedtopic","element":"action","eventLabel":"pubsub","eventname":"selectedtopic","eventtype":"pubsub","key":"event-2","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1711026120312-0d0m5lscq","label":"ActionHideAdditionalSettings","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"Id","fieldValue":"''"},{"fieldName":"ProductType","fieldValue":"''"},{"fieldName":"SelectedFunction","fieldValue":"''"},{"fieldName":"ServiceTree","fieldValue":"''"},{"fieldName":"additionalSettingsType","fieldValue":"''"}],"id":"flex-action-1711054727971","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valtopicstreeconfigparms","displayLabel":"valtopicstreeconfigparms:clearselection","element":"action","eventLabel":"pubsub","eventname":"clearselection","eventtype":"pubsub","key":"event-3","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1711031207588-ahnz92rc3","label":"ActionHideAdditionalSettings","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"Id","fieldValue":"''"},{"fieldName":"ProductType","fieldValue":"''"},{"fieldName":"SelectedFunction","fieldValue":"''"},{"fieldName":"ServiceTree","fieldValue":"''"},{"fieldName":"additionalSettingsType","fieldValue":"''"}],"id":"flex-action-1711054754250","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"TopicsTreeAdditionalSettingsChannel","displayLabel":"TopicsTreeAdditionalSettingsChannel:clearselection","element":"action","eventLabel":"pubsub","eventname":"clearselection","eventtype":"pubsub","key":"event-4","recordIndex":"0","showSpinner":"false"}],"isFlex":true,"lwc":{"DeveloperName":"cfValTopicsTreeAdditionalSettingsList_1_TelefonicaBrasil_MarcioLas","Id":"0Rb6t000001cVEPCA2","ManageableState":"unmanaged","MasterLabel":"cfValTopicsTreeAdditionalSettingsList_1_TelefonicaBrasil_MarcioLas","NamespacePrefix":"c"},"multilanguageSupport":true,"requiredPermission":"","selectableMode":"Multi","states":[{"actions":[],"blankCardState":false,"childCards":["valTopicsTreeAdditionalSettingsHeader","valTopicsTreeAdditionalSettingsTabsValues","valTopicsTreeAdditionalSettingsList"],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"AdditionalSettingsHeader","name":"FlexCard","property":{"cardName":"valTopicsTreeAdditionalSettingsHeader","cardNode":"","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"STActive"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"childCardPreview","elementLabel":"AdditionalSettingsTabs","name":"FlexCard","property":{"cardName":"valTopicsTreeAdditionalSettingsTabsValues","cardNode":"{record}","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"STActive"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"childCardPreview","elementLabel":"valTopicsTreeAdditionalSettingsList","name":"FlexCard","property":{"cardName":"valTopicsTreeAdditionalSettingsList","cardNode":"","isChildCardTrackingEnabled":true,"parentAttribute":{"IdTopicTree":"{Id}","tabActivated":"{additionalSettingsType}"},"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element","userUpdatedElementLabel":true}]}},"conditions":{"group":[{"field":"additionalSettingsType","hasMergeField":false,"id":"state-new-condition-20","operator":"==","type":"custom","value":"FollowUpCase"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"ActiveFollowUpCase","omniscripts":[],"smartAction":{},"styleObject":{"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small","container":{"class":"slds-card"},"margin":[{"size":"x-small","type":"bottom"}],"padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12"}},{"actions":[],"blankCardState":false,"childCards":["valTopicsTreeAdditionalSettingsHeader","valTopicsTreeAdditionalSettingsTabsValues","valTopicsTreeAdditionalSettingsList"],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"AdditionalSettingsHeader","name":"FlexCard","property":{"cardName":"valTopicsTreeAdditionalSettingsHeader","cardNode":"{record}","data-conditions":{"group":[{"field":"Id","hasMergeField":false,"id":"state-new-condition-2","operator":"!=","type":"custom","value":"REC0"}],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"STActive"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"childCardPreview","elementLabel":"AdditionalSettingsTabs","name":"FlexCard","property":{"cardName":"valTopicsTreeAdditionalSettingsTabsValues","cardNode":"{record}","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"STActive"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"childCardPreview","elementLabel":"valTopicsTreeAdditionalSettingsList","name":"FlexCard","property":{"cardName":"valTopicsTreeAdditionalSettingsList","cardNode":"","isChildCardTrackingEnabled":true,"parentAttribute":{"IdTopicTree":"{Id}","tabActivated":"{additionalSettingsType}"},"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element","userUpdatedElementLabel":true}]}},"conditions":{"group":[{"field":"additionalSettingsType","hasMergeField":false,"id":"state-new-condition-11","operator":"==","type":"custom","value":"TreatmentCase"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"ActiveTreatmentCase","omniscripts":[],"smartAction":{},"styleObject":{"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small","container":{"class":"slds-card"},"margin":[{"size":"x-small","type":"bottom"}],"padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12"}},{"actions":[],"blankCardState":true,"childCards":[],"components":{"layer-0":{"children":[]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"documents":[],"fields":[],"isSmartAction":false,"name":"Blank","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valTopicsTreeAdditionalSettings","Id":"a5W8M000000GuHvUAK","vlocity_cmt__GlobalKey__c":"valTopicsTreeAdditionalSettings/TelefonicaBrasil_MarcioLas/1/1721151675783","vlocity_cmt__IsChildCard__c":false};
  export default definition