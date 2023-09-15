let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":"","name":""},"type":"Custom","value":{"body":"{\"schedule\":\"value\"}","dsDelay":"","resultVar":""}},"enableLwc":true,"isFlex":true,"lwc":{"DeveloperName":"cfValMonthlyStatementSubScheduleHistoryFlyOut_1_GuilhermeKaiser","Id":"0Rb760000008ypXCAQ","ManageableState":"unmanaged","MasterLabel":"cfValMonthlyStatementSubScheduleHistoryFlyOut_1_GuilhermeKaiser","NamespacePrefix":"c"},"selectableMode":"Multi","states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Text-1","key":"element_element_block_0_0_outputField_0_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","mergeField":"%3Cdiv%20class=%22slds-text-align_center%22%3E%3Cspan%20style=%22font-size:%2018pt;%22%3E%3Cstrong%3EDeseja%20Realmente%20Cancelar?%3C/strong%3E%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"text"}],"class":"slds-col ","element":"block","elementLabel":"Block-0","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"sizeClass":"slds-size_12-of-12"},"type":"block"},{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Block-1-Text-0","key":"element_element_block_1_0_outputField_0_0","name":"Text","parentElementKey":"element_block_1_0","property":{"card":"{card}","mergeField":"%3Cdiv%20class=%22slds-text-align_center%22%3E%3Cspan%20style=%22font-size:%2014pt;%22%3EAo%20cancelar%20o%20agendamento%20ele%20n&atilde;o%20poder&aacute;%20ser%20recuperado,%20deseja%20realmente%20prosseguir?%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"text"}],"class":"slds-col ","element":"block","elementLabel":"Block-1","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"sizeClass":"slds-size_12-of-12"},"type":"block"},{"children":[{"class":"slds-col ","element":"action","elementLabel":"Block-2-Action-1","key":"element_element_block_2_0_action_0_0","name":"Action","parentElementKey":"element_block_2_0","property":{"actionList":[{"actionIndex":0,"draggable":true,"isOpen":true,"key":"1691092598907-7ggklwyuw","label":"Action","stateAction":{"eventName":"valMonthlyStatementSubScheduleHistory","extraParams":{"recordId":"{recordId}"},"hasExtraParams":true,"id":"flex-action-1691092660035","message":"returnPage","openUrlIn":"Current Window","subType":"PubSub","type":"Event"}}],"buttonVariant":"neutral","card":"{card}","displayAsButton":true,"flyoutDetails":{},"hideActionIcon":true,"iconName":"standard-default","label":"Voltar","record":"{record}","showSpinner":"false","stateObj":"{record}"},"size":{"default":"10","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"      \n         ","text":{"align":"right","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"      \n         ","text":{"align":"right","color":""}}}],"type":"element"},{"class":"slds-col ","element":"action","elementLabel":"Block-2-Action-0","key":"element_element_block_2_0_action_1_0","name":"Action","parentElementKey":"element_block_2_0","property":{"actionList":[{"actionIndex":0,"draggable":false,"isOpen":true,"key":"1691090729982-9ujbjcrrl","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"id":"flex-action-1691094006205","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_ScheduleAndCancelReport\",\"vlocityAsync\":false,\"inputMap\":{\"typeOfCall\":\"cancel\",\"assetId\":\"{recordId}\"},\"jsonMap\":\"{\\\"recordId\\\":\\\"{recordId}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"recordId\",\"val\":\"\",\"id\":5}]}","openUrlIn":"Current Window","responseNode":"","targetType":"Web Page","type":"DataAction"}},{"actionIndex":1,"card":"{card}","draggable":false,"isOpen":true,"key":"1691090941355-wssqjmnra","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"statusCode","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"204"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"Cancel","extraParams":{"Id":"{Parent.Id}","InteractionId":"{Parent.InteractionId}","recordId":"{recordId}"},"hasExtraParams":true,"id":"flex-action-1691093465485","message":"Cancel","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":2,"card":"{card}","draggable":false,"isOpen":true,"key":"1691093601577-d4bcea5gk","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"statusCode","hasMergeField":false,"id":"state-new-condition-0","operator":"!=","type":"custom","value":"204"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valToast","extraParams":{"message":"{message}","variant":"warning"},"hasExtraParams":true,"id":"flex-action-1691154639201","message":"showToast","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"buttonVariant":"destructive","card":"{card}","displayAsButton":true,"flyoutDetails":{},"hideActionIcon":true,"iconName":"standard-default","label":"Prosseguir","record":"{record}","showSpinner":"true","stateObj":"{record}","styles":{"label":{"textAlign":"left"}}},"size":{"default":"2","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_left slds-p-left_medium ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"textAlign":"left"}}},"inlineStyle":"","margin":[],"padding":[{"label":"left:medium","size":"medium","type":"left"}],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"      \n         ","text":{"align":"left","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_left slds-p-left_medium ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"textAlign":"left"}}},"inlineStyle":"","margin":[],"padding":[{"label":"left:medium","size":"medium","type":"left"}],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"      \n         ","text":{"align":"left","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-2","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#f3f2f2","image":"","position":"","repeat":"round","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_medium ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:medium","size":"medium","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#f3f2f2;  background-repeat:round;    \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#f3f2f2","image":"","position":"","repeat":"round","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_medium ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:medium","size":"medium","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#f3f2f2;  background-repeat:round;    \n         ","text":{"align":"","color":""}}}],"type":"block"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"ValMonthlyStatementSubScheduleHistoryFlyOut","Name":"ValMonthlyStatementSubScheduleHistoryFlyOut","uniqueKey":"ValMonthlyStatementSubScheduleHistoryFlyOut_undefined_undefined","Id":"a5W78000000L0QKEA0","vlocity_cmt__GlobalKey__c":"ValMonthlyStatementSubScheduleHistoryFlyOut/GuilhermeKaiser/1/1691093207856","vlocity_cmt__IsChildCard__c":true};
  export default definition