export const OMNIDEF = {"userTimeZone":-180,"userProfile":"Administrador do sistema","userName":"80819444@telefonica.b2cva.uat","userId":"00578000000LOJoAAO","userCurrencyCode":"BRL","timeStamp":"2022-02-05T19:43:24.002Z","sOmniScriptId":"a30780000008SnOAAU","sobjPL":{},"RPBundle":"","rMap":{},"response":null,"propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"trackingCustomData":{},"timeTracking":false,"stylesheet":{"newportRtl":"","newport":"","lightningRtl":"","lightning":""},"stepChartPlacement":"right","ssm":false,"showInputWidth":false,"seedDataJSON":{},"saveURLPatterns":{},"saveObjectId":"%ContextId%","saveNameTemplate":null,"saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveExpireInDays":null,"saveContentEncoded":false,"rtpSeed":false,"pubsub":false,"persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge"}],"message":{},"lkObjName":null,"knowledgeArticleTypeQueryFieldsMap":{},"hideStepChart":false,"errorMessage":{"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disableUnloadWarn":true,"currencyCode":"","consoleTabTitle":null,"consoleTabLabel":"New","consoleTabIcon":"custom:custom18","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":false,"allowCancel":true},"prefillJSON":"{}","lwcId":"66a3f075-6df5-806d-d3cd-78f40b5db5b2","labelMap":{"DOBChangeCancelCustomer":"DOBDetails:DOBChangeCancelCustomer","DOBChangeCancelAgent":"DOBDetails:DOBChangeCancelAgent","DOB":"DOBDetails:DOB","ContactBirthdate":"DOBDetails:ContactBirthdate","BirthdateError":"DOBDetails:BirthdateError","VerifyBirthDate":"DOBDetails:VerifyBirthDate","DateOfBirth":"DOBDetails:DateOfBirth","PhoneChangeCancelCustomer":"PhoneDetails:PhoneChangeCancelCustomer","PhoneChangeCancelAgent":"PhoneDetails:PhoneChangeCancelAgent","ContactMobile":"PhoneDetails:ContactMobile","NameChangeCancelCustomer":"NameDetails:NameChangeCancelCustomer","NameChangeCancelAgent":"NameDetails:NameChangeCancelAgent","LastName":"NameDetails:LastName","FirstName":"NameDetails:FirstName","Salutation":"NameDetails:Salutation","UpdateDetailsIP":"UpdateDetailsIP","DOBDetails":"DOBDetails","PhoneDetails":"PhoneDetails","NameDetails":"NameDetails"},"labelKeyMap":{},"errorMsg":"","error":"OK","dMap":{},"depSOPL":{},"depCusPL":{},"cusPL":{},"children":[{"type":"Step","propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"validationRequired":true,"trackingCustomData":{},"timeTracking":false,"ssm":false,"showPersistentComponent":[false,false],"showInputWidth":false,"show":{"group":{"rules":[{"field":"NameChange","data":"true","condition":"="}],"operator":"AND"}},"seedDataJSON":{},"saveURLPatterns":{},"saveObjectId":"%ContextId%","saveMessage":"","saveLabel":"Save for later","saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveContentEncoded":false,"rtpSeed":false,"remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":0,"previousLabel":"Previous","persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge"}],"nextWidth":2,"nextLabel":"Save","message":{},"label":"Editar Nome","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"knowledgeArticleTypeQueryFieldsMap":{},"instructionKey":"","instruction":"","hideStepChart":false,"errorMessage":{"default":null,"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disOnTplt":false,"consoleTabLabel":"New","consoleTabIcon":"custom:custom18","conditionType":"Hide if False","completeMessage":"","completeLabel":"Complete","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","cancelMessage":"Are you sure?","cancelLabel":"Cancel","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":true,"Type__c":{"type":"navigation","label":"Step"},"HTMLTemplateId":"","uiElements":{"NameDetails":"","Salutation":"","FirstName":"","LastName":""},"aggElements":{}},"offSet":0,"name":"NameDetails","level":0,"indexInParent":0,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Select","rootIndex":0,"response":null,"propSetMap":{"showInputWidth":true,"show":{"group":{"rules":[{"field":"NameChange","data":"true","condition":"="}],"operator":"AND"}},"required":true,"repeatClone":false,"repeat":false,"readOnly":false,"options":[{"name":"Mr.","value":"Mr."},{"name":"Ms.","value":"Ms."},{"name":"Mrs.","value":"Mrs."},{"name":"Dr.","value":"Dr."},{"name":"Prof.","value":"Prof."}],"optionSource":{"type":"SObject","source":"Contact.Salutation"},"label":"Titulo","inputWidth":5,"hide":false,"help":false,"disOnTplt":false,"controllingField":{"type":"","source":"","element":""},"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":true},"name":"Salutation","level":1,"JSONPath":"NameDetails:Salutation","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bSelect":true,"lwcId":"lwc00-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Text","rootIndex":0,"response":null,"propSetMap":{"showInputWidth":true,"show":{"group":{"rules":[{"field":"NameChange","data":"true","condition":"="}],"operator":"AND"}},"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Primeiro Nome","inputWidth":6,"hide":false,"helpText":"","help":false,"disOnTplt":false,"debounceValue":0,"controlWidth":7,"conditionType":"Hide if False","accessibleInFutureSteps":true,"HTMLTemplateId":""},"name":"FirstName","level":1,"JSONPath":"NameDetails:FirstName","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc01-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Text","rootIndex":0,"response":null,"propSetMap":{"showInputWidth":true,"show":{"group":{"rules":[{"field":"NameChange","data":"true","condition":"="}],"operator":"AND"}},"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Último Nome","inputWidth":6,"hide":false,"helpText":"","help":false,"disOnTplt":false,"debounceValue":0,"controlWidth":7,"conditionType":"Hide if False","accessibleInFutureSteps":true,"HTMLTemplateId":""},"name":"LastName","level":1,"JSONPath":"NameDetails:LastName","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc02-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":3,"eleArray":[{"type":"Navigate Action","rootIndex":0,"response":null,"propSetMap":{"wpm":false,"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","ssm":false,"show":{"group":{"rules":[{"field":"UserType","data":"Agent","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"loginAction":"login","label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"NameChangeCancelAgent","level":1,"JSONPath":"NameDetails:NameChangeCancelAgent","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc03-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":4,"eleArray":[{"type":"Navigate Action","rootIndex":0,"response":null,"propSetMap":{"wpm":false,"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetUrl":"%baseURL%","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Web Page","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","ssm":false,"show":{"group":{"rules":[{"field":"UserType","data":"Customer","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"loginAction":"login","label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"NameChangeCancelCustomer","level":1,"JSONPath":"NameDetails:NameChangeCancelCustomer","indexInParent":4,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc04-0"}],"bHasAttachment":false}],"bAccordionOpen":true,"bAccordionActive":true,"bStep":true,"isStep":true,"JSONPath":"NameDetails","lwcId":"lwc0"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[false,false],"show":{"group":{"rules":[{"field":"PhoneChange","data":"true","condition":"="}],"operator":"AND"}},"saveMessage":"","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":0,"previousLabel":"Previous","nextWidth":2,"nextLabel":"Save","message":{},"label":"Editar Telefone","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"disOnTplt":false,"conditionType":"Hide if False","completeMessage":"","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","allowSaveForLater":true,"HTMLTemplateId":"","uiElements":{"PhoneDetails":"","ContactMobile":""},"aggElements":{}},"offSet":0,"name":"PhoneDetails","level":0,"indexInParent":1,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Telephone","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"Please enter a valid phone number.","placeholder":"(Phone #)","pattern":"","minLength":9,"maxLength":11,"mask":"(99) 9999-9999","label":"Telefone","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"debounceValue":0,"controlWidth":5,"conditionType":"Hide if False","accessibleInFutureSteps":false,"HTMLTemplateId":""},"name":"ContactMobile","level":1,"JSONPath":"PhoneDetails:ContactMobile","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bTelephone":true,"lwcId":"lwc10-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Navigate Action","rootIndex":1,"response":null,"propSetMap":{"wpm":false,"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","ssm":false,"show":{"group":{"rules":[{"field":"UserType","data":"Agent","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"loginAction":"login","label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"PhoneChangeCancelAgent","level":1,"JSONPath":"PhoneDetails:PhoneChangeCancelAgent","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc11-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Navigate Action","rootIndex":1,"response":null,"propSetMap":{"wpm":false,"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetUrl":"%baseURL%","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Web Page","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","ssm":false,"show":{"group":{"rules":[{"field":"UserType","data":"Customer","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"loginAction":"login","label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"PhoneChangeCancelCustomer","level":1,"JSONPath":"PhoneDetails:PhoneChangeCancelCustomer","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc12-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"PhoneDetails","lwcId":"lwc1"},{"type":"Step","propSetMap":{"wpm":false,"validationRequired":true,"ssm":false,"showPersistentComponent":[false,false],"show":{"group":{"rules":[{"field":"BirthdateChange","data":"true","condition":"="}],"operator":"AND"}},"saveMessage":"","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","pubsub":false,"previousWidth":0,"previousLabel":"Previous","nextWidth":2,"nextLabel":"Save","message":{},"label":"Editar Data de Nascimento","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"disOnTplt":false,"conditionType":"Hide if False","completeMessage":"","completeLabel":"Complete","chartLabel":null,"cancelMessage":"","cancelLabel":"Cancel","allowSaveForLater":true,"HTMLTemplateId":"","uiElements":{"DOBDetails":"","DateOfBirth":""},"aggElements":{"VerifyBirthDate":"","ContactBirthdate":"","DOB":""}},"offSet":0,"name":"DOBDetails","level":0,"indexInParent":2,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Date","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":true,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"modelDateFormat":"M/d/yyyy","minDate":"","maxDate":"","label":"Data de Nascimento","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"dateType":"date","dateFormat":"dd/mm/yyyy","controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":true,"HTMLTemplateId":""},"name":"DateOfBirth","level":1,"JSONPath":"DOBDetails:DateOfBirth","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bDate":true,"lwcId":"lwc20-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Formula","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":true,"show":null,"label":null,"inputWidth":12,"hideGroupSep":false,"hide":true,"expression":"DATEDIFF(TODAY(),%DateOfBirth%) > 0","disOnTplt":false,"dateFormat":"MM-dd-yyyy","dataType":"Boolean","controlWidth":12},"name":"VerifyBirthDate","level":1,"JSONPath":"DOBDetails:VerifyBirthDate","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bFormula":true,"lwcId":"lwc21-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Validation","rootIndex":2,"response":null,"propSetMap":{"validateExpression":{"group":{"rules":[{"field":"VerifyBirthDate","data":"false","condition":"="}],"operator":"AND"}},"showInputWidth":false,"show":{"group":{"rules":[{"field":"VerifyBirthDate","data":"true","condition":"="}],"operator":"AND"}},"messages":[{"value":true,"type":"Success","text":"","active":false},{"value":false,"type":"Requirement","text":"Birthdate should be a past date","active":true}],"label":"Birthdate Error","inputWidth":12,"hideLabel":true,"hideGroupSep":false,"hide":false,"disOnTplt":false,"dateFormat":"MM-dd-yyyy","controlWidth":12,"HTMLTemplateId":""},"name":"BirthdateError","level":1,"JSONPath":"DOBDetails:BirthdateError","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bMessaging":true,"lwcId":"lwc22-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":3,"eleArray":[{"type":"Formula","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":true,"show":null,"mask":null,"label":null,"inputWidth":12,"hideGroupSep":false,"hide":true,"expression":"IF( %DateOfBirth% != null,MOMENT(%DateOfBirth%).format('ll'),MOMENT(%PersonalDetails:BirthDate%).format('ll'))","disOnTplt":false,"dateFormat":"MM-dd-yyyy","dataType":null,"controlWidth":12,"HTMLTemplateId":""},"name":"ContactBirthdate","level":1,"JSONPath":"DOBDetails:ContactBirthdate","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bFormula":true,"lwcId":"lwc23-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":4,"eleArray":[{"type":"Formula","rootIndex":2,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"mask":null,"label":null,"inputWidth":12,"hideGroupSep":false,"hide":true,"expression":"MOMENT(%DateOfBirth%).format()","disOnTplt":false,"dateFormat":"MM-dd-yyyy","dataType":null,"controlWidth":12,"HTMLTemplateId":""},"name":"DOB","level":1,"JSONPath":"DOBDetails:DOB","indexInParent":4,"index":0,"children":[],"bHasAttachment":false,"bFormula":true,"lwcId":"lwc24-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":5,"eleArray":[{"type":"Navigate Action","rootIndex":2,"response":null,"propSetMap":{"wpm":false,"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Record","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","ssm":false,"show":{"group":{"rules":[{"field":"UserType","data":"Agent","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"loginAction":"login","label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"DOBChangeCancelAgent","level":1,"JSONPath":"DOBDetails:DOBChangeCancelAgent","indexInParent":5,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc25-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":6,"eleArray":[{"type":"Navigate Action","rootIndex":2,"response":null,"propSetMap":{"wpm":false,"variantOptions":["brand","outline-brand","neutral","success","destructive","text-destructive","inverse","link"],"variant":"link","validationRequired":"none","targetUrl":"%baseURL%","targetTypeOptions":["Component","Current Page","Knowledge Article","Named Page","Navigation Item","Object","Record","Record Relationship","Web Page","Vlocity OmniScript"],"targetType":"Web Page","targetLWCLayoutOptions":["lightning","newport"],"targetLWCLayout":"lightning","targetId":"%ContextId%","targetFilter":"Recent","ssm":false,"show":{"group":{"rules":[{"field":"UserType","data":"Customer","condition":"="}],"operator":"AND"}},"replaceOptions":[{"value":false,"label":"No"},{"value":true,"label":"Yes"}],"replace":true,"recordActionOptions":["clone","edit","view"],"recordAction":"view","pubsub":false,"objectActionOptions":["home","list","new"],"objectAction":"home","message":{},"loginAction":"login","label":"Cancel","iconVariant":"","iconPositionOptions":["left","right"],"iconPosition":"left","iconName":"","disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"DOBChangeCancelCustomer","level":1,"JSONPath":"DOBDetails:DOBChangeCancelCustomer","indexInParent":6,"index":0,"children":[],"bHasAttachment":false,"bNavigate":true,"lwcId":"lwc26-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"DOBDetails","lwcId":"lwc2"},{"type":"Integration Procedure Action","propSetMap":{"wpm":false,"validationRequired":"Step","useContinuation":false,"svgSprite":"","svgIcon":"","ssm":false,"showPersistentComponent":[false,false],"show":null,"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","remoteTimeout":30000,"remoteOptions":{"useFuture":false,"preTransformBundle":"","postTransformBundle":"","chainable":false},"redirectTemplateUrl":"vlcAcknowledge.html","redirectPreviousWidth":3,"redirectPreviousLabel":"Previous","redirectPageName":"","redirectNextWidth":3,"redirectNextLabel":"Next","pubsub":false,"preTransformBundle":"","postTransformBundle":"","postMessage":"Done","message":{},"label":null,"integrationProcedureKey":"sfi_UpdatePersonalDetails","inProgressMessage":"In Progress","failureNextLabel":"Continue","failureGoBackLabel":"Go Back","failureAbortMessage":"Are you sure?","failureAbortLabel":"Abort","extraPayload":{},"errorMessage":{"default":null,"custom":[]},"enableDefaultAbort":false,"enableActionMessage":false,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"UpdateDetailsIP","level":0,"indexInParent":3,"bHasAttachment":false,"bEmbed":false,"bIntegrationProcedureAction":true,"JSONPath":"UpdateDetailsIP","lwcId":"lwc3"}],"bReusable":true,"bpVersion":2,"bpType":"sfi","bpSubType":"UpdatePersonalDetails","bpLang":"English","bHasAttachment":false,"lwcVarMap":{}};