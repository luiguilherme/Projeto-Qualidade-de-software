export const OMNIDEF = {"userTimeZone":-180,"userProfile":"System Administrator","userName":"jlopezmartinez@telefonica.b2cva.com","userId":"0055f000003WUzRAAW","userCurrencyCode":"BRL","timeStamp":"2021-10-21T18:27:27.581Z","sOmniScriptId":"a305f000000ZprbAAC","sobjPL":{},"RPBundle":"","rMap":{},"response":null,"propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"trackingCustomData":{},"timeTracking":false,"stylesheet":{"newportRtl":"","newport":"","lightningRtl":"","lightning":""},"stepChartPlacement":"right","ssm":false,"showInputWidth":false,"seedDataJSON":{},"saveURLPatterns":{},"saveObjectId":"%ContextId%","saveNameTemplate":null,"saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveExpireInDays":null,"saveContentEncoded":false,"rtpSeed":false,"pubsub":false,"persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge"}],"message":{},"lkObjName":null,"knowledgeArticleTypeQueryFieldsMap":{},"hideStepChart":true,"errorMessage":{"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disableUnloadWarn":true,"currencyCode":"","consoleTabTitle":null,"consoleTabLabel":"New","consoleTabIcon":"custom:custom18","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":false,"allowCancel":true},"prefillJSON":"{}","lwcId":"e402b4ba-cef2-09dc-5327-d11706b56a7f","labelMap":{"SelectedDeviceConfirmation":"BockDeviceConfirmationMsg:SelectedDeviceConfirmation","Device":"BockDeviceConfirmationMsg:Device","BlockDeviceSuccessMessage":"BockDeviceConfirmationMsg:BlockDeviceSuccessMessage","BlockDeviceSuccessMessageEmail":"BockDeviceConfirmationMsg:BlockDeviceSuccessMessageEmail","CancelToSubsConsole":"ConfirmBlockDevice:CancelToSubsConsole","CancelToConsole":"ConfirmBlockDevice:CancelToConsole","SelectedDeviceLWC":"ConfirmBlockDevice:SelectedDeviceLWC","BlockDeviceBreak":"ConfirmBlockDevice:BlockDeviceBreak","BlockDeviceConfirmMsg":"ConfirmBlockDevice:BlockDeviceConfirmMsg","NavigateToSubsConsole":"NavigateToSubsConsole","NavigateToConsole":"NavigateToConsole","BockDeviceConfirmationMsg":"BockDeviceConfirmationMsg","CreateCaseEmailUpdateInteractionTopicWrapperBarIP":"CreateCaseEmailUpdateInteractionTopicWrapperBarIP","ConfirmBlockDevice":"ConfirmBlockDevice"},"labelKeyMap":{},"errorMsg":"","error":"OK","dMap":{},"depSOPL":{},"depCusPL":{},"cusPL":{},"children":[{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[false,false],"show":{"group":{"rules":[{"field":"UserType","data":"Agent","condition":"="},{"field":"UserType","data":"Customer","condition":"="}],"operator":"OR"}},"saveMessage":"","saveLabel":"","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":2,"previousLabel":"Previous","nextWidth":4,"nextLabel":"Yes, block device","message":{},"label":"Confirm Block Device","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"disOnTplt":false,"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","allowSaveForLater":false,"HTMLTemplateId":"","uiElements":{"ConfirmBlockDevice":""},"aggElements":{"SelectedDeviceLWC":""}},"offSet":0,"name":"ConfirmBlockDevice","level":0,"indexInParent":0,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Validation","rootIndex":0,"response":null,"propSetMap":{"validateExpression":null,"show":null,"messages":[{"value":true,"type":"Warning","text":"Block this device?","active":true},{"value":false,"type":"Requirement","text":"","active":false}],"label":null,"hideLabel":true,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"BlockDeviceConfirmMsg","level":1,"JSONPath":"ConfirmBlockDevice:BlockDeviceConfirmMsg","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bMessaging":true,"lwcId":"lwc00-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Line Break","rootIndex":0,"response":null,"propSetMap":{"show":null,"padding":20,"label":"LineBreak2","disOnTplt":false,"HTMLTemplateId":""},"name":"BlockDeviceBreak","level":1,"JSONPath":"ConfirmBlockDevice:BlockDeviceBreak","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bLineBreak":true,"lwcId":"lwc01-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Custom Lightning Web Component","rootIndex":0,"response":null,"propSetMap":{"show":null,"lwcName":"vlocity_cmt__b2cCmexDeviceDetails","label":null,"hide":false,"disOnTplt":false,"customAttributes":[{"source":"%SelectedDevice%","name":"device-list"},{"source":"true","name":"change-confirmation"}],"controlWidth":12,"conditionType":"Hide if False","bStandalone":false},"name":"SelectedDeviceLWC","level":1,"JSONPath":"ConfirmBlockDevice:SelectedDeviceLWC","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bcustomlightningwebcomponent1":true,"lwcId":"lwc02-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":3,"eleArray":[{"type":"Navigate Action","rootIndex":0,"response":null,"propSetMap":{"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__CustomerInteraction__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%interactionId%","targetFilter":"Recent","show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"CancelToConsole","level":1,"JSONPath":"ConfirmBlockDevice:CancelToConsole","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc03-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":4,"eleArray":[{"type":"Navigate Action","rootIndex":0,"response":null,"propSetMap":{"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__Subscription__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"<>"}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"CancelToSubsConsole","level":1,"JSONPath":"ConfirmBlockDevice:CancelToSubsConsole","indexInParent":4,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc04-0"}],"bHasAttachment":false}],"bAccordionOpen":true,"bAccordionActive":true,"bStep":true,"isStep":true,"JSONPath":"ConfirmBlockDevice","lwcId":"lwc0"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"svgSprite":"","svgIcon":"","ssm":false,"showPersistentComponent":[null,null],"show":null,"sendJSONPath":"null","sendJSONNode":"VLocityNoRootNode","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":"IntegrationProcedureAction4","integrationProcedureKey":"vpl_CreateCaseEmailUpdateInteractionTopicWrapperBarIP","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{"subscriptionId":"%UpdateContextId%","outcome":"Successful","interactionTopicId":"%interactionTopicId%","Name1":"%SelectedDevice|1:Name%","IMEI1":"%SelectedDevice|1:IMEI%","ContextId":"%UpdateContextId%","CaseSubject":"Bar Device %SelectedDevice|1:IMEI%.","CaseDescription":"Bar Device with IMEI : %SelectedDevice|1:IMEI%","CaseContactId":"%ContactId%","CaseAccountId":"%AccountId%"},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"CreateCaseEmailUpdateInteractionTopicWrapperBarIP","level":0,"indexInParent":1,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"CreateCaseEmailUpdateInteractionTopicWrapperBarIP","lwcId":"lwc1"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[false,false],"show":{"group":{"rules":[{"field":"UserType","data":"Agent","condition":"="},{"field":"UserType","data":"Customer","condition":"="}],"operator":"OR"}},"saveMessage":"Are you sure you want to save it for later?","saveLabel":"","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":0,"previousLabel":"Previous","nextWidth":3,"nextLabel":"Back to home","message":{},"label":"Manage Lost or Stolen Device or SIM","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"disOnTplt":false,"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"","allowSaveForLater":false,"HTMLTemplateId":"","uiElements":{"BockDeviceConfirmationMsg":""},"aggElements":{"SelectedDeviceConfirmation":""}},"offSet":0,"name":"BockDeviceConfirmationMsg","level":0,"indexInParent":2,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Validation","rootIndex":2,"response":null,"propSetMap":{"validateExpression":{"group":{"rules":[{"field":"UserType","data":"Agent","condition":"="},{"field":"UserType","data":"Customer","condition":"="}],"operator":"OR"}},"show":{"group":{"rules":[{"field":"EmailResponse:EmailResponse:Success","data":"true","condition":"="}],"operator":"AND"}},"messages":[{"value":true,"type":"Success","text":"Request to block %SelectedDevice|1:Name% IMEI %SelectedDevice|1:IMEI% has been send.  We've emailed you a confirmation.","active":true},{"value":false,"type":"Requirement","text":"","active":false}],"label":null,"hideLabel":true,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"BlockDeviceSuccessMessageEmail","level":1,"JSONPath":"BockDeviceConfirmationMsg:BlockDeviceSuccessMessageEmail","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bMessaging":true,"lwcId":"lwc20-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Validation","rootIndex":2,"response":null,"propSetMap":{"validateExpression":{"group":{"rules":[{"field":"UserType","data":"Agent","condition":"="},{"field":"UserType","data":"Customer","condition":"="}],"operator":"OR"}},"show":{"group":{"rules":[{"field":"EmailResponse:EmailResponse:Success","data":"true","condition":"<>"}],"operator":"AND"}},"messages":[{"value":true,"type":"Success","text":"Request to block %SelectedDevice|1:Name% IMEI %SelectedDevice|1:IMEI% has been send.","active":true},{"value":false,"type":"Requirement","text":"","active":false}],"label":null,"hideLabel":true,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"BlockDeviceSuccessMessage","level":1,"JSONPath":"BockDeviceConfirmationMsg:BlockDeviceSuccessMessage","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bMessaging":true,"lwcId":"lwc21-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Text Block","rootIndex":2,"response":null,"propSetMap":{"textKey":"","text":"<p style=\"color: #000000; font-size: 22px; font-weight: 600; padding: 14px 0;\"><strong>Device</strong></p>","show":null,"sanitize":false,"label":null,"disOnTplt":false,"dataJSON":false,"controlWidth":12,"HTMLTemplateId":""},"name":"Device","level":1,"JSONPath":"BockDeviceConfirmationMsg:Device","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bTextBlock":true,"lwcId":"lwc22-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":3,"eleArray":[{"type":"Custom Lightning Web Component","rootIndex":2,"response":null,"propSetMap":{"show":null,"lwcName":"vlocity_cmt__b2cCmexDeviceDetails","label":null,"hide":false,"disOnTplt":false,"customAttributes":[{"source":"%SelectedDevice%","name":"device-list"},{"source":"true","name":"change-confirmation"}],"controlWidth":12,"conditionType":"Hide if False","bStandalone":false},"name":"SelectedDeviceConfirmation","level":1,"JSONPath":"BockDeviceConfirmationMsg:SelectedDeviceConfirmation","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bcustomlightningwebcomponent2":true,"lwcId":"lwc23-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"BockDeviceConfirmationMsg","lwcId":"lwc2"},{"type":"Navigate Action","propSetMap":{"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"brand","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__CustomerInteraction__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%interactionId%","targetFilter":"Recent","show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"label":"NavigateAction5","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"NavigateToConsole","level":0,"indexInParent":3,"bHasAttachment":false,"bEmbed":false,"bNavigate":true,"JSONPath":"NavigateToConsole","lwcId":"lwc3"},{"type":"Navigate Action","propSetMap":{"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"brand","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__Subscription__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"<>"}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"label":null,"iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"NavigateToSubsConsole","level":0,"indexInParent":4,"bHasAttachment":false,"bEmbed":false,"bNavigate":true,"JSONPath":"NavigateToSubsConsole","lwcId":"lwc4"}],"bReusable":true,"bpVersion":2,"bpType":"vpl","bpSubType":"BarDevice","bpLang":"English","bHasAttachment":false,"lwcVarMap":{"SelectedDevice":null}};