export const OMNIDEF = {"userTimeZone":-180,"userProfile":"System Administrator","userName":"jlopezmartinez@telefonica.b2cva.com","userId":"0055f000003WUzRAAW","userCurrencyCode":"BRL","timeStamp":"2021-10-21T19:24:52.004Z","sOmniScriptId":"a305f000000ZpsJAAS","sobjPL":{},"RPBundle":"","rMap":{},"response":null,"propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"trackingCustomData":{},"timeTracking":false,"stylesheet":{"newportRtl":"","newport":"","lightningRtl":"","lightning":""},"stepChartPlacement":"right","ssm":false,"showInputWidth":false,"seedDataJSON":{},"saveURLPatterns":{},"saveObjectId":"%ContextId%","saveNameTemplate":null,"saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveExpireInDays":null,"saveContentEncoded":false,"rtpSeed":false,"pubsub":false,"persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge"}],"message":{},"lkObjName":null,"knowledgeArticleTypeQueryFieldsMap":{},"hideStepChart":true,"errorMessage":{"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disableUnloadWarn":true,"currencyCode":"","consoleTabTitle":null,"consoleTabLabel":"New","consoleTabIcon":"custom:custom18","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":false,"allowCancel":true},"prefillJSON":"{}","lwcId":"529a966a-e75f-b5e8-81c8-3dc8242748a7","labelMap":{"SelectedMSISDNSuspendConfirmation":"ConfirmationSuspendingSimStep:SelectedMSISDNSuspendConfirmation","SIM":"ConfirmationSuspendingSimStep:SIM","FailureMsg":"ConfirmationSuspendingSimStep:FailureMsg","SuccessMessage":"ConfirmationSuspendingSimStep:SuccessMessage","DisplaySuspendConfirmation":"ConfirmationSuspendingSimStep:DisplaySuspendConfirmation","CancelToSubsConsole":"ReviewSuspendSimStep:CancelToSubsConsole","CancelToConsole":"ReviewSuspendSimStep:CancelToConsole","SelectedMSISDNDetailLWC":"ReviewSuspendSimStep:SelectedMSISDNDetailLWC","SIMLineBreak":"ReviewSuspendSimStep:SIMLineBreak","SuspendSIMConfirmMsg":"ReviewSuspendSimStep:SuspendSIMConfirmMsg","NavigateToSubsConsole":"NavigateToSubsConsole","NavigateToConsole":"NavigateToConsole","ConfirmationSuspendingSimStep":"ConfirmationSuspendingSimStep","SuspendSIMPostProcessWrapperIP":"SuspendSIMPostProcessWrapperIP","UpdateOLIFieldsAbsLayer":"UpdateOLIFieldsAbsLayer","CreateAccountHold":"CreateAccountHold","SuspendSimIP":"SuspendSimIP","SetCurrentDate":"SetCurrentDate","ReviewSuspendSimStep":"ReviewSuspendSimStep"},"labelKeyMap":{},"errorMsg":"","error":"OK","dMap":{},"depSOPL":{},"depCusPL":{},"cusPL":{},"children":[{"type":"Step","propSetMap":{"validationRequired":true,"showPersistentComponent":[false,false],"show":{"group":{"rules":[{"field":"UserType","data":"Agent","condition":"="},{"field":"UserType","data":"Customer","condition":"="}],"operator":"OR"}},"saveMessage":"Are you sure you want to save it for later?","saveLabel":"","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","previousWidth":2,"previousLabel":"Previous","nextWidth":4,"nextLabel":"Yes, suspend SIM","label":"Confirm Suspend SIM","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"disOnTplt":false,"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","allowSaveForLater":false,"HTMLTemplateId":"","uiElements":{"ReviewSuspendSimStep":""},"aggElements":{"SelectedMSISDNDetailLWC":""}},"offSet":0,"name":"ReviewSuspendSimStep","level":0,"indexInParent":0,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Validation","rootIndex":0,"response":null,"propSetMap":{"validateExpression":null,"show":null,"messages":[{"value":true,"type":"Warning","text":"Suspend this SIM?","active":true},{"value":false,"type":"Requirement","text":"","active":false}],"label":null,"hideLabel":true,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"SuspendSIMConfirmMsg","level":1,"JSONPath":"ReviewSuspendSimStep:SuspendSIMConfirmMsg","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bMessaging":true,"lwcId":"lwc00-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Line Break","rootIndex":0,"response":null,"propSetMap":{"show":null,"padding":20,"label":"LineBreak1","disOnTplt":false,"HTMLTemplateId":""},"name":"SIMLineBreak","level":1,"JSONPath":"ReviewSuspendSimStep:SIMLineBreak","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bLineBreak":true,"lwcId":"lwc01-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Custom Lightning Web Component","rootIndex":0,"response":null,"propSetMap":{"show":null,"lwcName":"vlocity_cmt__b2cCmexSIMDetails","label":null,"hide":false,"disOnTplt":false,"customAttributes":[{"source":"%SubscriptionName%","name":"subscription-name"},{"source":"true","name":"change-confirmation"},{"source":"%AssetDetails%","name":"sim-details"}],"controlWidth":12,"conditionType":"Hide if False","bStandalone":false},"name":"SelectedMSISDNDetailLWC","level":1,"JSONPath":"ReviewSuspendSimStep:SelectedMSISDNDetailLWC","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bcustomlightningwebcomponent1":true,"lwcId":"lwc02-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":3,"eleArray":[{"type":"Navigate Action","rootIndex":0,"response":null,"propSetMap":{"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__CustomerInteraction__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%interactionId%","targetFilter":"Recent","show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"CancelToConsole","level":1,"JSONPath":"ReviewSuspendSimStep:CancelToConsole","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc03-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":4,"eleArray":[{"type":"Navigate Action","rootIndex":0,"response":null,"propSetMap":{"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__Subscription__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"<>"}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"CancelToSubsConsole","level":1,"JSONPath":"ReviewSuspendSimStep:CancelToSubsConsole","indexInParent":4,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc04-0"}],"bHasAttachment":false}],"bAccordionOpen":true,"bAccordionActive":true,"bStep":true,"isStep":true,"JSONPath":"ReviewSuspendSimStep","lwcId":"lwc0"},{"type":"Set Values","propSetMap":{"wpm":false,"validationRequired":"None","ssm":false,"showPersistentComponent":[false,false],"show":{"group":{"rules":[{"field":"UserType","data":"Agent","condition":"="},{"field":"UserType","data":"Customer","condition":"="}],"operator":"OR"}},"pubsub":false,"message":{},"label":null,"elementValueMap":{"RequestDate":"=MOMENT(NOW()).add(2,'minute')"},"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SetCurrentDate","level":0,"indexInParent":1,"bHasAttachment":false,"bEmbed":false,"bSetValues":true,"JSONPath":"SetCurrentDate","lwcId":"lwc1"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"svgSprite":"","svgIcon":"","ssm":false,"showPersistentComponent":[false,false],"show":null,"sendJSONPath":"null","sendJSONNode":"VlocityNoRootNode","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":true},"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":null,"integrationProcedureKey":"vpl_Suspend/ResumePostProcess","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{"UserId":"%userId%","SimProductCode":"%SimProductCode%","RootId":"%RootId%","RequestDate":"%RequestDate%","OrderType":"Suspend Lost or Stolen SIM","ContactId":"%ContactId%","AccountId":"%AccountId%"},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SuspendSimIP","level":0,"indexInParent":2,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"SuspendSimIP","lwcId":"lwc2"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"svgSprite":"","svgIcon":"","ssm":false,"showPersistentComponent":[false,false],"show":null,"sendJSONPath":"null","sendJSONNode":"VlocityNoRootNode","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":null,"integrationProcedureKey":"vpl_CreateAccountHold","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{"Subscription":"%UpdateContextId%","RequestDate":"%RequestDate%","OrderId":"%orderId%","HoldType":"Customer Initiated","HoldReason":"SIM Lost or Stolen","Asset":"%AssetId%","Account":"%AccountId%"},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"CreateAccountHold","level":0,"indexInParent":3,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"CreateAccountHold","lwcId":"lwc3"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"svgSprite":"","svgIcon":"","ssm":false,"showPersistentComponent":[false,false],"show":{"group":{"rules":[{"field":"orderId","data":null,"condition":"<>"}],"operator":"AND"}},"sendJSONPath":"null","sendJSONNode":"VLocityNoRootNode","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":null,"integrationProcedureKey":"vpl_UpdateOLIFields","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{"orderId":"%orderId%","SubAction":"Suspend SIM","ProvisioningStatus":"Suspended","FlowName":"%AbsLayerFlowName%","Action":"Suspend"},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"UpdateOLIFieldsAbsLayer","level":0,"indexInParent":4,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"UpdateOLIFieldsAbsLayer","lwcId":"lwc4"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"svgSprite":"","svgIcon":"","ssm":false,"showPersistentComponent":[false,false],"show":{"group":{"rules":[{"field":"orderId","data":null,"condition":"<>"}],"operator":"AND"}},"sendJSONPath":"null","sendJSONNode":"VLocityNoRootNode","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":null,"integrationProcedureKey":"vpl_SuspendSIMPostProcessWrapperIP","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{"subscriptionId":"%UpdateContextId%","outcome":"Successful","orderId":"%orderId%","interactionTopicId":"%interactionTopicId%","assetId":"%AssetId%","MSISDN":"%MSISDN%","ICCID":"%ICCID%","ContextId":"%UpdateContextId%"},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SuspendSIMPostProcessWrapperIP","level":0,"indexInParent":5,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"SuspendSIMPostProcessWrapperIP","lwcId":"lwc5"},{"type":"Step","propSetMap":{"validationRequired":true,"showPersistentComponent":[false,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","previousWidth":0,"previousLabel":"Previous","nextWidth":3,"nextLabel":"Back to Home","label":"Manage Lost or Stolen Device or SIM","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"disOnTplt":false,"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"","allowSaveForLater":false,"HTMLTemplateId":"","uiElements":{"ConfirmationSuspendingSimStep":""},"aggElements":{"SelectedMSISDNSuspendConfirmation":""}},"offSet":0,"name":"ConfirmationSuspendingSimStep","level":0,"indexInParent":6,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Validation","rootIndex":6,"response":null,"propSetMap":{"validateExpression":null,"show":{"group":{"rules":[{"field":"EmailResponse:success","data":"false","condition":"="}],"operator":"AND"}},"messages":[{"value":true,"type":"Success","text":"Request to suspend %SubscriptionName% (%MSISDN%) SIM with ICCID %ICCID% has been sent.","active":true},{"value":false,"type":"Requirement","text":"","active":false}],"label":null,"hideLabel":true,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"DisplaySuspendConfirmation","level":1,"JSONPath":"ConfirmationSuspendingSimStep:DisplaySuspendConfirmation","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bMessaging":true,"lwcId":"lwc60-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Validation","rootIndex":6,"response":null,"propSetMap":{"validateExpression":null,"show":{"group":{"rules":[{"field":"EmailResponse:EmailResponse:Success","data":"true","condition":"="}],"operator":"AND"}},"messages":[{"value":true,"type":"Success","text":"Request to suspend %SubscriptionName%(%MSISDN%) SIM with ICCID %ICCID% has been sent. We've emailed you a confirmation.","active":true},{"value":false,"type":"Requirement","text":"","active":false}],"label":null,"hideLabel":true,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"SuccessMessage","level":1,"JSONPath":"ConfirmationSuspendingSimStep:SuccessMessage","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bMessaging":true,"lwcId":"lwc61-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Validation","rootIndex":6,"response":null,"propSetMap":{"validateExpression":null,"show":{"group":{"rules":[{"field":"EmailResponse:success","data":"false","condition":"="}],"operator":"AND"}},"messages":[{"value":true,"type":"Warning","text":"%EmailResponse:result:failureMsg%","active":true},{"value":false,"type":"Requirement","text":"","active":false}],"label":null,"hideLabel":true,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"FailureMsg","level":1,"JSONPath":"ConfirmationSuspendingSimStep:FailureMsg","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bMessaging":true,"lwcId":"lwc62-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":3,"eleArray":[{"type":"Text Block","rootIndex":6,"response":null,"propSetMap":{"textKey":"","text":"<p style=\"color: #000000; font-size: 22px; font-weight: 600; padding: 14px 0;\"><strong>SIM</strong></p>","show":null,"label":null,"disOnTplt":false,"dataJSON":false,"controlWidth":12,"HTMLTemplateId":""},"name":"SIM","level":1,"JSONPath":"ConfirmationSuspendingSimStep:SIM","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bTextBlock":true,"lwcId":"lwc63-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":4,"eleArray":[{"type":"Custom Lightning Web Component","rootIndex":6,"response":null,"propSetMap":{"show":null,"lwcName":"vlocity_cmt__b2cCmexSIMDetails","label":null,"hide":false,"disOnTplt":false,"customAttributes":[{"source":"%SubscriptionName%","name":"subscription-name"},{"source":"true","name":"change-confirmation"},{"source":"%AssetDetails%","name":"sim-details"}],"controlWidth":12,"conditionType":"Hide if False","bStandalone":false},"name":"SelectedMSISDNSuspendConfirmation","level":1,"JSONPath":"ConfirmationSuspendingSimStep:SelectedMSISDNSuspendConfirmation","indexInParent":4,"index":0,"children":[],"bHasAttachment":false,"bcustomlightningwebcomponent2":true,"lwcId":"lwc64-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"ConfirmationSuspendingSimStep","lwcId":"lwc6"},{"type":"Navigate Action","propSetMap":{"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"brand","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__CustomerInteraction__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%interactionId%","targetFilter":"Recent","show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"label":null,"iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"NavigateToConsole","level":0,"indexInParent":7,"bHasAttachment":false,"bEmbed":false,"bNavigate":true,"JSONPath":"NavigateToConsole","lwcId":"lwc7"},{"type":"Navigate Action","propSetMap":{"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"brand","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__Subscription__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"<>"}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"label":null,"iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"NavigateToSubsConsole","level":0,"indexInParent":8,"bHasAttachment":false,"bEmbed":false,"bNavigate":true,"JSONPath":"NavigateToSubsConsole","lwcId":"lwc8"}],"bReusable":true,"bpVersion":2,"bpType":"vpl","bpSubType":"SuspendSIM","bpLang":"English","bHasAttachment":false,"lwcVarMap":{"SubscriptionName":null,"AssetDetails":null}};