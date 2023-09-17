let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":"","name":""},"type":"IntegrationProcedures","value":{"dsDelay":"","inputMap":{"AssetId":"{recordId}","ScheduleType":"E-mail"},"ipMethod":"val_CreateMontlyScheduleData","jsonMap":"{\"recordId\":\"{recordId}\"}","resultVar":"","vlocityAsync":false}},"enableLwc":true,"events":[],"globalCSS":false,"isFlex":true,"lwc":{"DeveloperName":"cfValSubmissionEmail_2_TelefonicaBrasil_Valentina","Id":"0Rb76000000DBcDCAW","ManageableState":"unmanaged","MasterLabel":"cfValSubmissionEmail_2_TelefonicaBrasil_Valentina","NamespacePrefix":"c"},"osSupport":true,"selectableField":"","selectableMode":"Single","selectedCardsLabel":"","states":[{"actions":[],"blankCardState":false,"childCards":[],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Block-0-Text-1","key":"element_element_block_0_0_outputField_1_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"data-preloadConditionalElement":false,"mergeField":"%3Cdiv%3EUtilizar%20o%20e-mail%20informado%20no%20cadastro?%3C/div%3E","record":"{record}"},"size":{"default":"3","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-bottom_medium slds-p-left_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"bottom:medium","size":"medium","type":"bottom"},{"label":"left:small","size":"small","type":"left"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-bottom_medium slds-p-left_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"bottom:medium","size":"medium","type":"bottom"},{"label":"left:small","size":"small","type":"left"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"text"},{"class":"slds-col ","element":"flexRadioInput","elementLabel":"Block-0-Radio-2","key":"element_element_block_0_0_flexRadioInput_2_0","name":"Radio","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"data-preloadConditionalElement":false,"propertyObj":{"action":null,"controlHeight":"100","controlWidth":"100","enabledCaption":"true","fieldBinding":"{AccountEmailFlg}","imageCountInRow":"3","label":"","name":"Block-0-Block-4-Radio-6","options":[{"id":0,"imgId":"","label":"Sim","selected":true,"value":"true"},{"id":1,"imgId":"","label":"Não","selected":false,"value":"false"}],"radioDisplayValue":"radiogroup.horizontal","value":"true"},"record":"{record}","type":"radiogroup.horizontal"},"size":{"default":"9","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-right_x-small","margin":[{"size":"xx-small","type":"bottom"}],"padding":[{"size":"small","type":"right"}],"size":{"default":"9","isResponsive":false},"sizeClass":"slds-size_9-of-12 "},"type":"element"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"input-email","key":"element_element_block_0_0_baseInputElement_3_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"AccountEmailFlg","hasMergeField":false,"id":"state-new-condition-11","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"propertyObj":{"customProperties":[{"id":0,"label":"messageWhenValueMissing","value":"{Label.ValueMissing}"}],"fieldBinding":"{Email}","label":"E-mail","required":true},"record":"{record}","type":"text"},"size":{"default":"5","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-top_x-small slds-p-left_small slds-p-bottom_large slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"top:x-small","size":"x-small","type":"top"},{"label":"left:small","size":"small","type":"left"},{"label":"bottom:large","size":"large","type":"bottom"}],"size":{"default":"5","isResponsive":false},"sizeClass":"slds-size_5-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-top_x-small slds-p-left_small slds-p-bottom_large slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"top:x-small","size":"x-small","type":"top"},{"label":"left:small","size":"small","type":"left"},{"label":"bottom:large","size":"large","type":"bottom"}],"size":{"default":"5","isResponsive":false},"sizeClass":"slds-size_5-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Block-0-Typeahead-4","key":"element_element_block_0_0_baseInputElement_4_0","name":"Typeahead","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"AccountEmailFlg","hasMergeField":false,"id":"state-new-condition-3","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"propertyObj":{"customProperties":[],"disabled":true,"fieldBinding":"{CustomerDetails.AccountEmail}","label":"E-mail","placeholder":"{CustomerDetails.AccountEmail}","required":true,"type":"typeahead"},"record":"{record}","type":"typeahead"},"size":{"default":"5","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-top_x-small slds-p-left_small slds-p-bottom_large slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"top:x-small","size":"x-small","type":"top"},{"label":"left:small","size":"small","type":"left"},{"label":"bottom:large","size":"large","type":"bottom"}],"size":{"default":"5","isResponsive":false},"sizeClass":"slds-size_5-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-top_x-small slds-p-left_small slds-p-bottom_large slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"top:x-small","size":"x-small","type":"top"},{"label":"left:small","size":"small","type":"left"},{"label":"bottom:large","size":"large","type":"bottom"}],"size":{"default":"5","isResponsive":false},"sizeClass":"slds-size_5-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-0","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"sizeClass":"slds-size_12-of-12"},"type":"block"},{"children":[{"children":[],"class":"slds-col ","element":"block","elementLabel":"Block-2-Block-0","key":"element_element_block_1_0_block_0_0","name":"Block","parentElementKey":"element_block_1_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"10","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 "},"type":"block"},{"class":"slds-col ","element":"action","elementLabel":"Block-2-Action-1","key":"element_element_block_1_0_action_1_0","name":"Action","parentElementKey":"element_block_1_0","property":{"actionList":[{"actionIndex":0,"draggable":true,"isOpen":true,"key":"1671672733933-83qkpl8v8","label":"Reload","stateAction":{"eventName":"reload","id":"flex-action-1684245375734","message":"returnPage","openUrlIn":"Current Window","subType":"PubSub","type":"cardAction"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":true,"key":"1684245359943-43hx14lgr","label":"Return","stateAction":{"displayName":"Action","eventName":"valSelectTypeExtract","id":"flex-action-1684245470401","message":"returnPage","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"buttonVariant":"neutral","card":"{card}","displayAsButton":true,"flyoutDetails":{},"hideActionIcon":true,"iconName":"standard-default","label":"Voltar","record":"{record}","showSpinner":"false","stateObj":"{record}"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right slds-p-right_medium ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"right:medium","size":"medium","type":"right"}],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"right","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right slds-p-right_medium ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"right:medium","size":"medium","type":"right"}],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"right","color":""}}}],"type":"element"},{"class":"slds-col ","element":"action","elementLabel":"Block-2-Action-2","key":"element_element_block_1_0_action_2_0","name":"Action","parentElementKey":"element_block_1_0","property":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":false,"key":"1672670021249-n9wjvc7vd","label":"RunSpinner","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"SpinnerSchedule","fieldValue":"true"}],"id":"flex-action-1683135490744","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":false,"key":"1672464899769-zekxfdlpg","label":"SendHttp","stateAction":{"Web Page":{"targetName":"/apex"},"actionConditions":{"group":[],"id":"state-condition-object","isParent":true},"displayName":"Action","id":"flex-action-1691419097200","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_CreateMontlySchedule\",\"vlocityAsync\":false,\"inputMap\":{\"AssetId\":\"{recordId}\",\"Period\":\"Dia 10 ao dia 09\",\"ScheduleType\":\"E-mail\",\"Email\":\"{Email}\",\"AccountEmail\":\"{CustomerDetails.AccountEmail}\",\"AccountEmailFlg\":\"{AccountEmailFlg}\",\"InteractionId\":\"{Parent.InteractionId}\",\"SendExtract\":\"true\",\"endDate\":\"{Parent.endDate}\",\"reportType\":\"2\",\"reason\":\"1\",\"msisdn\":\"{Parent.LineNumber}\",\"initialDate\":\"{Parent.initialDate}\",\"isSimplified\":\"{Parent.ExtractType}\",\"BraileFlg\":\"-\",\"AccountAddressFlg\":\"-\",\"MainNumber\":\"-\",\"ShowAddress\":\"-\"},\"jsonMap\":\"{\\\"recordId\\\":\\\"{recordId}\\\",\\\"Email\\\":\\\"{Email}\\\",\\\"CustomerDetails.AccountEmail\\\":\\\"{CustomerDetails.AccountEmail}\\\",\\\"AccountEmailFlg\\\":\\\"{AccountEmailFlg}\\\",\\\"Parent.InteractionId\\\":\\\"{Parent.InteractionId}\\\",\\\"endDate\\\":\\\"{endDate}\\\",\\\"lineNumber\\\":\\\"{lineNumber}\\\",\\\"LineNumber\\\":\\\"{LineNumber}\\\",\\\"initialDate\\\":\\\"{initialDate}\\\",\\\"ExtractType\\\":\\\"{ExtractType}\\\",\\\"Parent.ExtractType\\\":\\\"{Parent.ExtractType}\\\",\\\"Parent.endDate\\\":\\\"{Parent.endDate}\\\",\\\"Parent.initialDate\\\":\\\"{Parent.initialDate}\\\",\\\"Parent.LineNumber\\\":\\\"{Parent.LineNumber}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"recordId\",\"val\":\"\",\"id\":25},{\"name\":\"Email\",\"val\":\"\",\"id\":26},{\"name\":\"CustomerDetails.AccountEmail\",\"val\":\"\",\"id\":27},{\"name\":\"AccountEmailFlg\",\"val\":\"\",\"id\":28},{\"name\":\"Parent.InteractionId\",\"val\":\"\",\"id\":29},{\"name\":\"endDate\",\"val\":\"\",\"id\":30},{\"name\":\"lineNumber\",\"val\":\"\",\"id\":60},{\"name\":\"LineNumber\",\"val\":\"\",\"id\":52},{\"name\":\"initialDate\",\"val\":\"\",\"id\":27},{\"name\":\"ExtractType\",\"val\":\"\",\"id\":42},{\"name\":\"Parent.ExtractType\",\"val\":\"\",\"id\":36},{\"name\":\"Parent.endDate\",\"val\":\"\",\"id\":54},{\"name\":\"Parent.initialDate\",\"val\":\"\",\"id\":55},{\"name\":\"Parent.LineNumber\",\"val\":\"\",\"id\":36}]}","openUrlIn":"Current Window","responseNode":"","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}},{"actionIndex":2,"card":"{card}","draggable":true,"isOpen":false,"key":"1683726838036-4ygehc6ke","label":"FinalToastValidateResult","stateAction":{"actionConditions":{"group":[{"field":"success","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valCreateSubmissionExtract","extraParams":{"message":"{message}","variant":"error"},"hasExtraParams":true,"id":"flex-action-1683727530036","message":"finalAction","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":3,"card":"{card}","draggable":true,"isOpen":false,"key":"1672500561296-53bgun5qn","label":"FinalToast","stateAction":{"actionConditions":{"group":[{"field":"success","hasMergeField":false,"id":"state-new-condition-140","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valCreateSubmissionExtract","extraParams":{"message":"{messageSubmissionExtract}","variant":"{variantSubmissionExtract}"},"hasExtraParams":true,"id":"flex-action-1683738784473","message":"finalAction","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":4,"card":"{card}","draggable":true,"isOpen":true,"key":"1691515588291-5df35nn3v","label":"DinamicTopicName","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1692628426133","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_GetInteractionTopicNameFromTopicsAuto\",\"vlocityAsync\":false,\"inputMap\":{\"TopicName\":\"{Parent.TopicName}\"},\"jsonMap\":\"{\\\"Parent.TopicName\\\":\\\"{Parent.TopicName}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"Parent.TopicName\",\"val\":\"\",\"id\":2}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}},{"actionIndex":5,"card":"{card}","draggable":false,"isOpen":true,"key":"1683922304794-7w6kpm8t3","label":"RecoveryTopic","stateAction":{"Web Page":{"targetName":"/apex"},"actionConditions":{"group":[{"field":"variantSubmissionExtract","hasMergeField":false,"id":"state-new-condition-3","operator":"==","type":"custom","value":"success"}],"id":"state-condition-object","isParent":true},"displayName":"Action","id":"flex-action-1692628448742","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_CreateCustomerInteractionTopic\",\"vlocityAsync\":false,\"inputMap\":{\"topicName\":\"{topicName}\",\"interactionId\":\"{Parent.InteractionId}\",\"process\":\"{Parent.TopicName}\"},\"jsonMap\":\"{\\\"recordId\\\":\\\"{recordId}\\\",\\\"topicName\\\":\\\"{topicName}\\\",\\\"Parent.InteractionId\\\":\\\"{Parent.InteractionId}\\\",\\\"Parent.TopicName\\\":\\\"{Parent.TopicName}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"recordId\",\"val\":\"02i7600000DrNiPAAV\",\"id\":11},{\"name\":\"topicName\",\"val\":\"\",\"id\":6},{\"name\":\"Parent.InteractionId\",\"val\":\"\",\"id\":9},{\"name\":\"Parent.TopicName\",\"val\":\"\",\"id\":6}]}","openUrlIn":"Current Window","responseNode":"ProtocolResponse","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}},{"actionIndex":6,"card":"{card}","draggable":true,"isOpen":false,"key":"1672482356444-emnmfx7gs","label":"VivoNet","stateAction":{"Web Page":{"targetName":"/apex"},"actionConditions":{"group":[{"field":"variantSubmissionExtract","hasMergeField":false,"id":"state-new-condition-7","operator":"==","type":"custom","value":"success"}],"id":"state-condition-object","isParent":true},"displayName":"Action","id":"flex-action-1691515791079","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_CallOutProtocolItemVivoNet\",\"vlocityAsync\":false,\"inputMap\":{\"interactionTopicId\":\"{ProtocolResponse.interactionTopicId}\",\"topicName\":\"{topicName}\",\"interactionId\":\"{ProtocolResponse.interactionId}\"},\"jsonMap\":\"{\\\"ProtocolResponse.interactionTopicId\\\":\\\"{ProtocolResponse.interactionTopicId}\\\",\\\"ProtocolResponse.interactionId\\\":\\\"{ProtocolResponse.interactionId}\\\",\\\"topicName\\\":\\\"{topicName}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"ProtocolResponse.interactionTopicId\",\"val\":\"\",\"id\":6},{\"name\":\"ProtocolResponse.interactionId\",\"val\":\"\",\"id\":6},{\"name\":\"topicName\",\"val\":\"\",\"id\":6}]}","openUrlIn":"Current Window","responseNode":"responseTopic","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}},{"actionIndex":5,"card":"{card}","draggable":true,"isOpen":false,"key":"1672670327673-2lufu5koo","label":"StopSpinner","stateAction":{"Web Page":{"targetName":"/apex"},"actionConditions":{"group":[],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"SpinnerSchedule","fieldValue":"false"}],"id":"flex-action-1683135510047","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}},{"actionIndex":7,"card":"{card}","contextId":"\\{recordId}","draggable":true,"isOpen":false,"key":"1683744679177-e7gkjpeer","label":"ReturnOmniSelectExtract","stateAction":{"actionConditions":{"group":[{"field":"variantSubmissionExtract","hasMergeField":false,"id":"state-new-condition-4","operator":"==","type":"custom","value":"success"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valSelectOptionExtract","hasExtraParams":false,"id":"flex-action-1684151908771","message":"setContextSearch","openUrlIn":"New Tab/Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":6,"card":"{card}","draggable":true,"isOpen":false,"key":"1672500593884-00oh3dz9e","label":"Reload","stateAction":{"Web Page":{"targetName":"/apex"},"actionConditions":{"group":[{"field":"success","hasMergeField":false,"id":"state-new-condition-9","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"reload","id":"flex-action-1683738737172","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"ariaLabel":"Enviar","buttonVariant":"brand","card":"{card}","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"disabled":"","displayAsButton":true,"flyoutDetails":{},"hideActionIcon":true,"iconName":"standard-default","label":"Enviar","record":"{record}","showSpinner":"false","stateObj":"{record}"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 "},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-1","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":12,"isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12"},"type":"block"}]}},"conditions":{"group":[{"field":"SpinnerSchedule","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"documents":[],"fields":[],"isSmartAction":false,"name":"InsertRecords","omniscripts":[],"smartAction":{},"styleObject":{"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small","container":{"class":"slds-card"},"margin":[{"size":"x-small","type":"bottom"}],"padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12"}},{"actions":[],"blankCardState":false,"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"flexImg","elementLabel":"Image-0","name":"Image","property":{"card":"{card}","extraclass":"slds-align_absolute-center","record":"{record}","size":"","stateImg":{"alternativeText":"Image description","imgsrc":"/resource/vlocity_cmt__WAITGIF"}},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-top_xx-large slds-p-bottom_xx-large ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"top:xx-large","size":"xx-large","type":"top"},{"label":"bottom:xx-large","size":"xx-large","type":"bottom"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-top_xx-large slds-p-bottom_xx-large ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"top:xx-large","size":"xx-large","type":"top"},{"label":"bottom:xx-large","size":"xx-large","type":"bottom"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"}]}},"conditions":{"group":[{"field":"SpinnerSchedule","hasMergeField":false,"id":"state-new-condition-7","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"documents":[],"fields":[],"isSmartAction":false,"name":"Spinner","omniscripts":[],"smartAction":{},"styleObject":{"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small","container":{"class":"slds-card"},"margin":[{"size":"x-small","type":"bottom"}],"padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12"}}],"theme":"slds","title":"valSubmissionEmail","Name":"valSubmissionEmail","uniqueKey":"valSubmissionEmail_undefined_undefined","Id":"a5W78000000L0QGEA0","vlocity_cmt__GlobalKey__c":"valSubmissionEmail/TelefonicaBrasil_Valentina/3/1692628402610","vlocity_cmt__IsChildCard__c":true};
  export default definition