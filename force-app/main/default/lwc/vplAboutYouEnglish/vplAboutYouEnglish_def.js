export const OMNIDEF = {"userTimeZone":-180,"userProfile":"System Administrator","userName":"jlopezmartinez@telefonica.b2cva.com","userId":"0055f000003WUzRAAW","userCurrencyCode":"BRL","timeStamp":"2021-10-21T18:23:49.334Z","sOmniScriptId":"a305f000000ZplDAAS","sobjPL":{},"RPBundle":"","rMap":{},"response":null,"propSetMap":{"wpm":false,"visualforcePagesAvailableInPreview":{},"trackingCustomData":{},"timeTracking":false,"stylesheet":{"newportRtl":"","newport":"","lightningRtl":"","lightning":""},"stepChartPlacement":"right","ssm":false,"showInputWidth":false,"seedDataJSON":{},"saveURLPatterns":{},"saveObjectId":"%OrderId%","saveNameTemplate":"Join","saveForLaterRedirectTemplateUrl":"vlcSaveForLaterAcknowledge.html","saveForLaterRedirectPageName":"sflRedirect","saveExpireInDays":null,"saveContentEncoded":false,"rtpSeed":false,"pubsub":false,"persistentComponent":[{"sendJSONPath":"","sendJSONNode":"","responseJSONPath":"","responseJSONNode":"","render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"vlcProductConfig.html","modalController":"ModalProductCtrl"},"label":"","itemsKey":"cartItems","id":"vlcCart"},{"render":false,"remoteTimeout":30000,"remoteOptions":{"preTransformBundle":"","postTransformBundle":""},"remoteMethod":"","remoteClass":"","preTransformBundle":"","postTransformBundle":"","modalConfigurationSetting":{"modalSize":"lg","modalHTMLTemplateId":"","modalController":""},"label":"","itemsKey":"knowledgeItems","id":"vlcKnowledge"}],"message":{},"lkObjName":null,"knowledgeArticleTypeQueryFieldsMap":{},"hideStepChart":false,"errorMessage":{"custom":[]},"enableKnowledge":false,"elementTypeToHTMLTemplateMapping":{},"disableUnloadWarn":true,"currencyCode":"","consoleTabTitle":null,"consoleTabLabel":"New","consoleTabIcon":"custom:custom18","cancelType":"SObject","cancelSource":"%ContextId%","cancelRedirectTemplateUrl":"vlcCancelled.html","cancelRedirectPageName":"OmniScriptCancelled","bLK":false,"autoSaveOnStepNext":false,"autoFocus":false,"allowSaveForLater":false,"allowCancel":true},"prefillJSON":"{}","lwcId":"b5001e34-5867-9079-088a-4edc7ddcbfa3","labelMap":{"NextOrRedirectLWC":"AboutYou:NextOrRedirectLWC","CancelShop":"AboutYou:CancelShop","Phone":"AboutYou:Phone","LineBreakForLastName":"AboutYou:LineBreakForLastName","LastName":"AboutYou:LastName","LineBreakforfirstName":"AboutYou:LineBreakforfirstName","FirstName":"AboutYou:FirstName","LineBreakTitle":"AboutYou:LineBreakTitle","Title":"AboutYou:Title","AccountCreatedMessage":"AboutYou:AccountCreatedMessage","AboutYou":"AboutYou","SetValuesPrepopulateAboutYouInfo":"SetValuesPrepopulateAboutYouInfo"},"labelKeyMap":{},"errorMsg":"","error":"OK","dMap":{},"depSOPL":{},"depCusPL":{},"cusPL":{},"children":[{"type":"Set Values","propSetMap":{"wpm":false,"ssm":false,"showPersistentComponent":[false,false],"show":null,"pubsub":false,"message":{},"label":null,"elementValueMap":{"ExistingDetails":{"JoinUserId":"%JoinUserId%","IndividualId":"%IndividualId%","CurrentUserId":"%NewUserId%","CurrentUserContactId":"%GuestContactId%","CurrentUserAccountId":"%GuestAccountId%"}},"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":"","aggElements":{}},"offSet":0,"name":"SetValuesPrepopulateAboutYouInfo","level":0,"indexInParent":0,"bHasAttachment":false,"bEmbed":false,"bSetValues":true,"JSONPath":"SetValuesPrepopulateAboutYouInfo","lwcId":"lwc0"},{"type":"Step","propSetMap":{"validationRequired":true,"showPersistentComponent":[false,false],"show":null,"saveMessage":"Are you sure you want to save it for later?","saveLabel":"Save for later","remoteTimeout":30000,"remoteOptions":{},"remoteMethod":"","remoteClass":"","previousWidth":0,"previousLabel":"Previous","nextWidth":0,"nextLabel":"Next","label":"Personal Details","knowledgeOptions":{"typeFilter":"","remoteTimeout":30000,"publishStatus":"Online","language":"English","keyword":"","dataCategoryCriteria":""},"instructionKey":"","instruction":"","errorMessage":{"default":null,"custom":[]},"disOnTplt":false,"conditionType":"Hide if False","completeMessage":"Are you sure you want to complete the script?","completeLabel":"Complete","chartLabel":null,"cancelMessage":"Are you sure?","cancelLabel":"Cancel","allowSaveForLater":true,"HTMLTemplateId":"","uiElements":{"AboutYou":"","Title":"","FirstName":"","LastName":"","Phone":""},"aggElements":{"CancelShop":"","NextOrRedirectLWC":""}},"offSet":0,"name":"AboutYou","level":0,"indexInParent":1,"bHasAttachment":false,"bEmbed":false,"response":null,"inheritShowProp":null,"children":[{"response":null,"level":1,"indexInParent":0,"eleArray":[{"type":"Validation","rootIndex":1,"response":null,"propSetMap":{"validateExpression":null,"show":{"group":{"rules":[{"field":"GuestAccountId","data":null,"condition":"<>"}],"operator":"AND"}},"messages":[{"value":true,"type":"Success","text":"Your account has been created.","active":true},{"value":false,"type":"Requirement","text":"","active":false}],"label":null,"hideLabel":true,"disOnTplt":false,"controlWidth":12,"HTMLTemplateId":""},"name":"AccountCreatedMessage","level":1,"JSONPath":"AboutYou:AccountCreatedMessage","indexInParent":0,"index":0,"children":[],"bHasAttachment":false,"bMessaging":true,"lwcId":"lwc10-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":1,"eleArray":[{"type":"Select","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"options":[{"name":"Mr.","value":"Mr."},{"name":"Ms.","value":"Ms."},{"name":"Mrs.","value":"Mrs."},{"name":"Dr.","value":"Dr."},{"name":"Prof.","value":"Prof."}],"optionSource":{"type":"SObject","source":"Contact.Salutation"},"label":"Title","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"controllingField":{"type":"","source":"","element":""},"controlWidth":3,"conditionType":"Hide if False","accessibleInFutureSteps":true,"HTMLTemplateId":""},"name":"Title","level":1,"JSONPath":"AboutYou:Title","indexInParent":1,"index":0,"children":[],"bHasAttachment":false,"bSelect":true,"lwcId":"lwc11-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":2,"eleArray":[{"type":"Line Break","rootIndex":1,"response":null,"propSetMap":{"show":null,"padding":0,"label":"LineBreak1","disOnTplt":false,"HTMLTemplateId":""},"name":"LineBreakTitle","level":1,"JSONPath":"AboutYou:LineBreakTitle","indexInParent":2,"index":0,"children":[],"bHasAttachment":false,"bLineBreak":true,"lwcId":"lwc12-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":3,"eleArray":[{"type":"Text","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"First name","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":"","debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":true,"HTMLTemplateId":""},"name":"FirstName","level":1,"JSONPath":"AboutYou:FirstName","indexInParent":3,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc13-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":4,"eleArray":[{"type":"Line Break","rootIndex":1,"response":null,"propSetMap":{"show":null,"padding":0,"label":"LineBreak2","disOnTplt":false,"HTMLTemplateId":""},"name":"LineBreakforfirstName","level":1,"JSONPath":"AboutYou:LineBreakforfirstName","indexInParent":4,"index":0,"children":[],"bHasAttachment":false,"bLineBreak":true,"lwcId":"lwc14-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":5,"eleArray":[{"type":"Text","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":true,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"","pattern":"","minLength":0,"maxLength":255,"mask":"","label":"Last name","inputWidth":12,"hide":false,"helpText":"","help":false,"disOnTplt":false,"defaultValue":null,"debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":true,"HTMLTemplateId":""},"name":"LastName","level":1,"JSONPath":"AboutYou:LastName","indexInParent":5,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc15-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":6,"eleArray":[{"type":"Line Break","rootIndex":1,"response":null,"propSetMap":{"show":null,"padding":0,"label":"LineBreak3","disOnTplt":false,"HTMLTemplateId":""},"name":"LineBreakForLastName","level":1,"JSONPath":"AboutYou:LineBreakForLastName","indexInParent":6,"index":0,"children":[],"bHasAttachment":false,"bLineBreak":true,"lwcId":"lwc16-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":7,"eleArray":[{"type":"Text","rootIndex":1,"response":null,"propSetMap":{"showInputWidth":false,"show":null,"required":false,"repeatLimit":null,"repeatClone":false,"repeat":false,"readOnly":false,"ptrnErrText":"Enter valid number (9-11 digits)","pattern":"[0-9]{9,11}","minLength":0,"maxLength":255,"mask":"(999) 999-9999","label":"Alternative phone number","inputWidth":12,"hide":false,"helpText":"We will contact you on this number if there is a problem with your delivery .","help":true,"disOnTplt":false,"defaultValue":null,"debounceValue":0,"controlWidth":6,"conditionType":"Hide if False","accessibleInFutureSteps":true,"HTMLTemplateId":""},"name":"Phone","level":1,"JSONPath":"AboutYou:Phone","indexInParent":7,"index":0,"children":[],"bHasAttachment":false,"bText":true,"lwcId":"lwc17-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":8,"eleArray":[{"type":"Custom Lightning Web Component","rootIndex":1,"response":null,"propSetMap":{"show":null,"lwcName":"vlocity_cmt__b2cCmexBaseButton","label":null,"hide":false,"disOnTplt":false,"customAttributes":[{"source":"{}","name":"interactiontopicid"},{"source":"true","name":"showcancelbutton"},{"source":"false","name":"iscanceldisabled"},{"source":"Explore&Join","name":"flowname"},{"source":"shop_Page1","name":"shoppageurl"},{"source":"vpl_UpdateInteractionTopics","name":"createinteractionip"}],"controlWidth":12,"conditionType":"Hide if False","bStandalone":false},"name":"CancelShop","level":1,"JSONPath":"AboutYou:CancelShop","indexInParent":8,"index":0,"children":[],"bHasAttachment":false,"bcustomlightningwebcomponent1":true,"lwcId":"lwc18-0"}],"bHasAttachment":false},{"response":null,"level":1,"indexInParent":9,"eleArray":[{"type":"Custom Lightning Web Component","rootIndex":1,"response":null,"propSetMap":{"show":null,"lwcName":"vlocity_cmt__b2cCmexUpdateAndRedirect","label":null,"hide":false,"disOnTplt":false,"customAttributes":[{"source":"vpl_AboutYouPostProcessIP","name":"vipname"},{"source":"%IsReview%","name":"isreview"},{"source":"ReviewDetails","name":"reviewstep"},{"source":"%AboutYou%","name":"detailstoupdate"},{"source":"%ExistingDetails%","name":"existingdetails"},{"source":"PersonalDetails","name":"context"}],"controlWidth":12,"conditionType":"Hide if False","bStandalone":false},"name":"NextOrRedirectLWC","level":1,"JSONPath":"AboutYou:NextOrRedirectLWC","indexInParent":9,"index":0,"children":[],"bHasAttachment":false,"bcustomlightningwebcomponent2":true,"lwcId":"lwc19-0"}],"bHasAttachment":false}],"bAccordionOpen":false,"bAccordionActive":false,"bStep":true,"isStep":true,"JSONPath":"AboutYou","lwcId":"lwc1"}],"bReusable":true,"bpVersion":2,"bpType":"vpl","bpSubType":"AboutYou","bpLang":"English","bHasAttachment":false,"lwcVarMap":{"IsReview":null,"AboutYou":null,"ExistingDetails":null}};