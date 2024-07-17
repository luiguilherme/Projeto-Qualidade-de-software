export const OMNIDEF = {"userTimeZone":-180,"userProfile":"System Administrator","userName":"jlopezmartinez@telefonica.b2cva.com","userId":"0055f000003WUzRAAW","userCurrencyCode":"BRL","timeStamp":"2021-10-21T19:03:10.402Z","sOmniScriptId":"a305f000000ZpqmAAC","sobjPL":{},"RPBundle":"","rMap":{},"response":null,"propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"trackingCustomData":{},"timeTracking":false,"stylesheet":{"newportRtl":"","newport":"","lightningRtl":"","lightning":""},"stepChartPlacement":"right","ssm":false,"showInputWidth":false,"seedDataJSON":{},"saveURLPatterns":{},"saveObjectId":"%ContextId%","saveNameTemplate":null,"saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveExpireInDays":null,"saveContentEncoded":false,"rtpSeed":false,"pubsub":false,"persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge"}],"message":{},"lkObjName":null,"knowledgeArticleTypeQueryFieldsMap":{},"hideStepChart":false,"errorMessage":{"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disableUnloadWarn":true,"currencyCode":"","consoleTabTitle":null,"consoleTabLabel":"New","consoleTabIcon":"custom:custom18","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":false,"allowCancel":true},"prefillJSON":"{}","lwcId":"434fe4bf-5476-4440-b757-96522b901887","labelMap":{"customCancelFailstep":"PaymentFailed:customCancelFailstep","NavigateToSubsConsoleFail":"PaymentFailed:NavigateToSubsConsoleFail","NavigateToConsoleFail":"PaymentFailed:NavigateToConsoleFail","IVRPaymentFailMsg":"PaymentFailed:IVRPaymentFailMsg","customCancel":"AgentPaymentViaIVR:customCancel","NavigateToSubsConsole":"AgentPaymentViaIVR:NavigateToSubsConsole","NavigateToConsoleIntNode":"AgentPaymentViaIVR:NavigateToConsoleIntNode","NavigateToConsole":"AgentPaymentViaIVR:NavigateToConsole","IsInteractionIdAvailable":"AgentPaymentViaIVR:IsInteractionIdAvailable","GenerateOTR":"AgentPaymentViaIVR:GenerateOTR","IVRStatus":"AgentPaymentViaIVR:IVRStatus","PaymentViaIVR":"AgentPaymentViaIVR:PaymentViaIVR","SetOutput":"SetOutput","PaymentFailed":"PaymentFailed","UpdateInteractionTopicinIVR":"UpdateInteractionTopicinIVR","AgentPaymentViaIVR":"AgentPaymentViaIVR","MockCreateReceipt":"MockCreateReceipt"},"labelKeyMap":{},"errorMsg":"","error":"OK","dMap":{},"depSOPL":{},"depCusPL":{},"cusPL":{},"children":[{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"svgSprite":"","svgIcon":"","ssm":false,"showPersistentComponent":[false,false],"show":null,"sendJSONPath":"null","sendJSONNode":"VLocityNoRootNode","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":null,"integrationProcedureKey":"vpl_MockCreateReceipts","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"MockCreateReceipt","level":0,"indexInParent":0,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"MockCreateReceipt","lwcId":"lwc0"},{"type":"Step","propSetMap":{"validationRequired":true,"showPersistentComponent":[false,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","previousWidth":3,"previousLabel":"Previous","nextWidth":3,"nextLabel":"Next","label":"IVR Payment","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"disOnTplt":false,"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":"IVR Payment","cancelMessage":"Are you sure?","cancelLabel":"Cancel","allowSaveForLater":false,"HTMLTemplateId":"","uiElements":{"AgentPaymentViaIVR":"","PaymentViaIVR":""},"aggElements":{"IVRStatus":"","GenerateOTR":"","IsInteractionIdAvailable":"","customCancel":""}},"offSet":0,"name":"AgentPaymentViaIVR","level":0,"indexInParent":1,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Radio","rootIndex":1,"response":null,"propSetMap":{"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"options":[{"value":"Yes","name":"Yes"},{"value":"No","name":"No"}],"optionWidth":100,"optionSource":{"type":"","source":""},"optionHeight":100,"label":"Was the payment successful?","imageCountInRow":3,"horizontalMode":"displayWide","hide":false,"helpText":"","help":false,"enableCaption":true,"disOnTplt":false,"defaultValue":null,"controllingField":{"type":"","source":"","element":""},"controlWidth":12,"conditionType":"Hide if False","accessibleInFutureSteps":true,"HTMLTemplateId":""},"name":"PaymentViaIVR","level":1,"JSONPath":"AgentPaymentViaIVR:PaymentViaIVR","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bRadio":true,"lwcId":"lwc10-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Formula","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"mask":null,"label":null,"inputWidth":12,"hideGroupSep":false,"hide":true,"expression":"IF(%AgentPaymentViaIVR:PaymentViaIVR%=='No', 'Failure', 'Success')","disOnTplt":false,"dateFormat":"MM-dd-yyyy","dataType":"Text","controlWidth":12,"accessibleInFutureSteps":true,"HTMLTemplateId":""},"name":"IVRStatus","level":1,"JSONPath":"AgentPaymentViaIVR:IVRStatus","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bFormula":true,"lwcId":"lwc11-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Formula","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"mask":null,"label":null,"inputWidth":12,"hideGroupSep":false,"hide":true,"expression":"%Channel%+%ReceiptReferenceAutoNo%","disOnTplt":false,"dateFormat":"MM-dd-yyyy","dataType":null,"controlWidth":12,"HTMLTemplateId":""},"name":"GenerateOTR","level":1,"JSONPath":"AgentPaymentViaIVR:GenerateOTR","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bFormula":true,"lwcId":"lwc12-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":3,"eleArray":[{"type":"Formula","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"mask":null,"label":null,"inputWidth":12,"hideGroupSep":false,"hide":true,"expression":"IF(%interactionId% <> NULL , true, false)","disOnTplt":false,"dateFormat":"MM-dd-yyyy","dataType":"Boolean","controlWidth":12,"HTMLTemplateId":""},"name":"IsInteractionIdAvailable","level":1,"JSONPath":"AgentPaymentViaIVR:IsInteractionIdAvailable","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bFormula":true,"lwcId":"lwc13-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":4,"eleArray":[{"type":"Navigate Action","rootIndex":1,"response":null,"propSetMap":{"wpm":false,"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__CustomerInteraction__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%interactionId%","targetFilter":"Recent","ssm":false,"show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"="},{"field":"IsInteractionIdAvailable","data":"true","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"loginAction":"login","label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"NavigateToConsole","level":1,"JSONPath":"AgentPaymentViaIVR:NavigateToConsole","indexInParent":4,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc14-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":5,"eleArray":[{"type":"Navigate Action","rootIndex":1,"response":null,"propSetMap":{"wpm":false,"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__CustomerInteraction__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%InteractionNode:interactionId%","targetFilter":"Recent","ssm":false,"show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"="},{"field":"IsInteractionIdAvailable","data":"false","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"loginAction":"login","label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"NavigateToConsoleIntNode","level":1,"JSONPath":"AgentPaymentViaIVR:NavigateToConsoleIntNode","indexInParent":5,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc15-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":6,"eleArray":[{"type":"Navigate Action","rootIndex":1,"response":null,"propSetMap":{"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__CustomerInteraction__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"<>"},{"field":"AbsLayerFlowName","data":"Explore and Join","condition":"<>"}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"NavigateToSubsConsole","level":1,"JSONPath":"AgentPaymentViaIVR:NavigateToSubsConsole","indexInParent":6,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc16-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":7,"eleArray":[{"type":"Custom Lightning Web Component","rootIndex":1,"response":null,"propSetMap":{"show":{"group":{"rules":[{"field":"AbsLayerFlowName","data":"Explore and Join","condition":"="}],"operator":"AND"}},"lwcName":"vlocity_cmt__b2cCmexBaseButton","label":null,"hide":false,"disOnTplt":false,"customAttributes":[{"source":"true","name":"showcancelbutton"},{"source":"false","name":"iscanceldisabled"},{"source":"Explore&Join","name":"flowname"},{"source":"shop_Page1","name":"shoppageurl"},{"source":"vpl_UpdateInteractionTopics","name":"createinteractionip"}],"controlWidth":12,"conditionType":"Hide if False","bStandalone":false},"name":"customCancel","level":1,"JSONPath":"AgentPaymentViaIVR:customCancel","indexInParent":7,"index":0,"children":[],"bHasAttachment":false,"bcustomlightningwebcomponent1":true,"lwcId":"lwc17-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"AgentPaymentViaIVR","lwcId":"lwc1"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"svgSprite":"","svgIcon":"","ssm":false,"showPersistentComponent":[false,false],"show":{"group":{"rules":[{"field":"AgentPaymentViaIVR:IVRStatus","data":"Failure","condition":"="}],"operator":"AND"}},"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":null,"integrationProcedureKey":"vpl_UpdateInteractionTopics","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{"reason":"Payment","outcome":"Failed","interactionTopicId":"%InteractionNode:interactionTopicId%"},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"UpdateInteractionTopicinIVR","level":0,"indexInParent":2,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"UpdateInteractionTopicinIVR","lwcId":"lwc2"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[false,false],"show":{"group":{"rules":[{"field":"IVRStatus","data":"Failure","condition":"="}],"operator":"AND"}},"saveMessage":"Are you sure you want to save it for later?","saveLabel":"","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":3,"previousLabel":"Previous","nextWidth":3,"nextLabel":"Back to home","message":{},"label":"Confirmation","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"disOnTplt":false,"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","allowSaveForLater":false,"HTMLTemplateId":"","uiElements":{"PaymentFailed":""},"aggElements":{"customCancelFailstep":""}},"offSet":0,"name":"PaymentFailed","level":0,"indexInParent":3,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Text Block","rootIndex":3,"response":null,"propSetMap":{"textKey":"","text":"<p style=\"text-align: center;\"><span style=\"color: #ff0000;\"><strong>Transaction&nbsp;cannot not be completed as payment&nbsp;via IVR has failed.</strong></span></p>","show":{"group":{"rules":[{"field":"IVRStatus","data":"Failure","condition":"="}],"operator":"AND"}},"sanitize":false,"label":null,"disOnTplt":false,"dataJSON":false,"controlWidth":12,"HTMLTemplateId":""},"name":"IVRPaymentFailMsg","level":1,"JSONPath":"PaymentFailed:IVRPaymentFailMsg","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bTextBlock":true,"lwcId":"lwc30-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Navigate Action","rootIndex":3,"response":null,"propSetMap":{"wpm":false,"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__CustomerInteraction__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%interactionId%","targetFilter":"Recent","ssm":false,"show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"loginAction":"login","label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"NavigateToConsoleFail","level":1,"JSONPath":"PaymentFailed:NavigateToConsoleFail","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc31-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Navigate Action","rootIndex":3,"response":null,"propSetMap":{"wpm":false,"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetName":"vlocity_cmt__CustomerInteraction__c","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","ssm":false,"show":{"group":{"rules":[{"field":"ContextName","data":"Account360","condition":"<>"},{"field":"AbsLayerFlowName","data":"Explore and Join","condition":"<>"}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"loginAction":"login","label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"NavigateToSubsConsoleFail","level":1,"JSONPath":"PaymentFailed:NavigateToSubsConsoleFail","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc32-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":3,"eleArray":[{"type":"Custom Lightning Web Component","rootIndex":3,"response":null,"propSetMap":{"show":{"group":{"rules":[{"field":"AbsLayerFlowName","data":"Explore and Join","condition":"="}],"operator":"AND"}},"lwcName":"vlocity_cmt__b2cCmexBaseButton","label":null,"hide":false,"disOnTplt":false,"customAttributes":[{"source":"true","name":"showcancelbutton"},{"source":"false","name":"iscanceldisabled"},{"source":"Explore&Join","name":"flowname"},{"source":"shop_Page1","name":"shoppageurl"},{"source":"vpl_UpdateInteractionTopics","name":"createinteractionip"}],"controlWidth":12,"conditionType":"Hide if False","bStandalone":false},"name":"customCancelFailstep","level":1,"JSONPath":"PaymentFailed:customCancelFailstep","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bcustomlightningwebcomponent2":true,"lwcId":"lwc33-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"PaymentFailed","lwcId":"lwc3"},{"type":"Set Values","propSetMap":{"wpm":false,"ssm":false,"showPersistentComponent":[false,false],"show":null,"pubsub":false,"message":{},"label":null,"elementValueMap":{"PaymentStatusConfirmation":"%AgentPaymentViaIVR:PaymentViaIVR%","IsOrderConfirmed":"=IF(%IVRStatus%==\"Failure\", false,true)","IVRStatus":"%IVRStatus%"},"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SetOutput","level":0,"indexInParent":4,"bHasAttachment":false,"bEmbed":false,"bSetValues":true,"JSONPath":"SetOutput","lwcId":"lwc4"}],"bReusable":true,"bpVersion":2,"bpType":"vpl","bpSubType":"PaymentThroughIVR","bpLang":"English","bHasAttachment":false,"lwcVarMap":{}};