let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":"","name":""},"type":"IntegrationProcedures","value":{"dsDelay":"","inputMap":{"caseId":"{Parent.CaseId}","ownerType":"{ownerType}"},"ipMethod":"val_CaseChangeOwnerGetData","jsonMap":"{\"ownerType\":\"{ownerType}\",\"Parent.CaseId\":\"{Parent.CaseId}\"}","resultVar":"","vlocityAsync":false}},"enableLwc":true,"events":[],"isFlex":true,"lwc":{"DeveloperName":"cfValCaseActionsChangeOwner_1_Telefonica","Id":"0Rb78000000LaVBCA0","MasterLabel":"cfValCaseActionsChangeOwner_1_Telefonica","NamespacePrefix":"c","ManageableState":"unmanaged"},"multilanguageSupport":true,"osSupport":true,"selectableMode":"Multi","states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Text-0","name":"Text","property":{"card":"{card}","mergeField":"%3Cdiv%20class=%22slds-text-align_center%22%3E%3Cspan%20style=%22font-size:%2018pt;%22%3ETrocar%20Propriet&aacute;rio%20do%20Caso%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#939393","radius":"","style":"","type":"border_bottom","width":"1"},"class":"slds-border_bottom slds-p-top_x-small slds-p-bottom_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"top:x-small","size":"x-small","type":"top"},{"label":"bottom:small","size":"small","type":"bottom"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-bottom: #939393 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#939393","radius":"","style":"","type":"border_bottom","width":"1"},"class":"slds-border_bottom slds-p-top_x-small slds-p-bottom_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"top:x-small","size":"x-small","type":"top"},{"label":"bottom:small","size":"small","type":"bottom"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-bottom: #939393 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"text"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Select-1","name":"Select","property":{"action":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1708456007759-iodytihv9","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1708456874557","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_CaseChangeOwnerGetData\",\"vlocityAsync\":false,\"inputMap\":{\"caseId\":\"{Parent.CaseId}\",\"ownerType\":\"{element.value}\"},\"jsonMap\":\"{\\\"element.value\\\":\\\"{element.value}\\\",\\\"Parent.CaseId\\\":\\\"{Parent.CaseId}\\\"}\",\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"element.value\",\"val\":\"\",\"id\":4},{\"name\":\"Parent.CaseId\",\"val\":\"\",\"id\":4}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}}],"eventType":"onchange","iconName":"standard-default","label":"Action","showSpinner":"true"},"card":"{card}","propertyObj":{"action":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1708456007759-iodytihv9","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1708456874557","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_CaseChangeOwnerGetData\",\"vlocityAsync\":false,\"inputMap\":{\"caseId\":\"{Parent.CaseId}\",\"ownerType\":\"{element.value}\"},\"jsonMap\":\"{\\\"element.value\\\":\\\"{element.value}\\\",\\\"Parent.CaseId\\\":\\\"{Parent.CaseId}\\\"}\",\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"element.value\",\"val\":\"\",\"id\":4},{\"name\":\"Parent.CaseId\",\"val\":\"\",\"id\":4}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}}],"eventType":"onchange","iconName":"standard-default","label":"Action","showSpinner":"true"},"customProperties":[{"id":0,"label":"messageWhenValueMissing","value":"Tipo é obrigatório."}],"fieldBinding":"{OwnerType}","label":"Tipo","options":[{"group":"","id":1,"label":"Fila","value":"Queue"},{"group":"","id":2,"label":"Usuário","value":"User"}],"required":true,"type":"combobox","value":""},"record":"{record}","type":"combobox"},"size":{"default":"2","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-right_small slds-p-left_x-small slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"},{"label":"left:x-small","size":"x-small","type":"left"}],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-right_small slds-p-left_x-small slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"},{"label":"left:x-small","size":"x-small","type":"left"}],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Select-2","name":"Select","property":{"card":"{card}","data-conditions":{"group":[{"field":"OwnerType","hasMergeField":false,"id":"state-new-condition-27","operator":"==","type":"custom","value":"User"},{"field":"hasUserWithPermission","hasMergeField":false,"id":"state-new-condition-0","logicalOperator":"&&","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"propertyObj":{"customProperties":[{"id":0,"label":"options","value":"{options}"},{"id":1,"label":"messageWhenValueMissing","value":"Usuário é obrigatório."}],"fieldBinding":"{UserSelected}","label":"Usuário","options":[],"required":true,"type":"combobox","value":""},"record":"{record}","type":"combobox"},"size":{"default":"9","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" slds-p-right_small slds-p-bottom_small slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"},{"label":"bottom:small","size":"small","type":"bottom"}],"size":{"default":"9","isResponsive":false},"sizeClass":"slds-size_9-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" slds-p-right_small slds-p-bottom_small slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"},{"label":"bottom:small","size":"small","type":"bottom"}],"size":{"default":"9","isResponsive":false},"sizeClass":"slds-size_9-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Select-2-clone-0","name":"Select","property":{"card":"{card}","data-conditions":{"group":[{"field":"OwnerType","hasMergeField":false,"id":"state-new-condition-27","operator":"==","type":"custom","value":"User"},{"field":"hasUserWithPermission","hasMergeField":false,"id":"state-new-condition-0","logicalOperator":"&&","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"propertyObj":{"customProperties":[{"id":1,"label":"messageWhenValueMissing","value":"Usuário é obrigatório."}],"fieldBinding":"","label":"Usuário","options":[],"placeholder":"Nenhum usuário com permissão configurada","readOnly":true,"required":true,"type":"combobox","value":""},"record":"{record}","styles":{"value":{"backgroundColor":"#D0CFCF"}},"type":"combobox"},"size":{"default":"9","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" slds-p-right_small slds-p-bottom_small slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{"styles":{"value":{"backgroundColor":"#D0CFCF"}}},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"},{"label":"bottom:small","size":"small","type":"bottom"}],"size":{"default":"9","isResponsive":false},"sizeClass":"slds-size_9-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" slds-p-right_small slds-p-bottom_small slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{"styles":{"value":{"backgroundColor":"#D0CFCF"}}},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"},{"label":"bottom:small","size":"small","type":"bottom"}],"size":{"default":"9","isResponsive":false},"sizeClass":"slds-size_9-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Select-3","name":"Select","property":{"card":"{card}","data-conditions":{"group":[{"field":"OwnerType","hasMergeField":false,"id":"state-new-condition-27","operator":"==","type":"custom","value":"Queue"}],"id":"state-condition-object","isParent":true},"propertyObj":{"customProperties":[{"id":0,"label":"options","value":"{options}"},{"id":1,"label":"messageWhenValueMissing","value":"Fila é obrigatório."}],"fieldBinding":"{QueueSelected}","label":"Fila","options":[],"required":true,"type":"combobox","value":""},"record":"{record}","type":"combobox"},"size":{"default":"9","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" slds-p-right_small slds-p-bottom_small slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"},{"label":"bottom:small","size":"small","type":"bottom"}],"size":{"default":"9","isResponsive":false},"sizeClass":"slds-size_9-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" slds-p-right_small slds-p-bottom_small slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"},{"label":"bottom:small","size":"small","type":"bottom"}],"size":{"default":"9","isResponsive":false},"sizeClass":"slds-size_9-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"children":[],"class":"slds-col ","element":"block","elementLabel":"Block-4","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"height":"150px","inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n     height:150px;    ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"height":"150px","inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n     height:150px;    ","text":{"align":"","color":""}}}],"type":"block"},{"children":[{"children":[],"class":"slds-col ","element":"block","elementLabel":"Block-1","key":"element_element_block_5_0_block_0_0","name":"Block","parentElementKey":"element_block_5_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"8","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"8","isResponsive":false},"sizeClass":"slds-size_8-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"8","isResponsive":false},"sizeClass":"slds-size_8-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"action","elementLabel":"Action-2","key":"element_element_block_5_0_action_1_0","name":"Action","parentElementKey":"element_block_5_0","property":{"actionList":[{"actionIndex":0,"draggable":true,"isOpen":true,"key":"1708434901365-4lpfgplad","label":"ActionClose","stateAction":{"eventName":"close_modal","id":"flex-action-1708435002565","message":"close","openUrlIn":"Current Window","subType":"PubSub","type":"Event"}}],"buttonVariant":"neutral","card":"{card}","displayAsButton":true,"flyoutDetails":{},"hideActionIcon":true,"iconName":"standard-default","label":"Cancelar","record":"{record}","showSpinner":"false","stateObj":"{record}"},"size":{"default":"2","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"      \n         ","text":{"align":"center","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"      \n         ","text":{"align":"center","color":""}}}],"type":"element"},{"class":"slds-col ","element":"action","elementLabel":"Action-3","key":"element_element_block_5_0_action_2_0","name":"Action","parentElementKey":"element_block_5_0","property":{"actionList":[{"actionIndex":2,"card":"{card}","draggable":true,"isOpen":false,"key":"1708518823331-4ey6xctar","label":"ActionChangeOwner","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1708518933578","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_CaseChangeOwner\",\"vlocityAsync\":false,\"inputMap\":{\"caseId\":\"{Parent.CaseId}\",\"ownerType\":\"{ownerType}\",\"userSelected\":\"{UserSelected}\",\"queueSelected\":\"{QueueSelected}\"},\"jsonMap\":\"{\\\"ownerType\\\":\\\"{ownerType}\\\",\\\"Parent.CaseId\\\":\\\"{Parent.CaseId}\\\",\\\"UserSelected\\\":\\\"{UserSelected}\\\",\\\"QueueSelected\\\":\\\"{QueueSelected}\\\"}\",\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"ownerType\",\"val\":\"\",\"id\":43},{\"name\":\"Parent.CaseId\",\"val\":\"\",\"id\":44},{\"name\":\"UserSelected\",\"val\":\"\",\"id\":6},{\"name\":\"QueueSelected\",\"val\":\"\",\"id\":8}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":false,"key":"1708465093644-apwpuct6t","label":"ActionToastWarning","stateAction":{"actionConditions":{"group":[{"field":"status","hasMergeField":false,"id":"state-new-condition-13","operator":"==","type":"custom","value":"Erro"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valToast","extraParams":{"message":"{errorMessage}","variant":"warning"},"hasExtraParams":true,"id":"flex-action-1708525784031","message":"showToast","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":3,"card":"{card}","draggable":true,"isOpen":false,"key":"1708538118747-yg332y2ik","label":"ActionToastSuccess","stateAction":{"actionConditions":{"group":[{"field":"status","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"Sucesso"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valToast","extraParams":{"message":"{message}","variant":"success"},"hasExtraParams":true,"id":"flex-action-1708538168982","message":"showToast","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":4,"card":"{card}","draggable":true,"isOpen":false,"key":"1708538219965-1q9uckds3","label":"ActionNavigateToRecord","stateAction":{"Record":{"targetAction":"view","targetId":"{Parent.CaseId}","targetName":"Case"},"actionConditions":{"group":[{"field":"status","hasMergeField":false,"id":"state-new-condition-7","operator":"==","type":"custom","value":"Sucesso"}],"id":"state-condition-object","isParent":true},"displayName":"Action","id":"flex-action-1708631926924","openUrlIn":"Current Window","targetType":"Record","type":"Custom","vlocityIcon":"standard-default"}},{"actionIndex":5,"card":"{card}","draggable":true,"isOpen":false,"key":"1708601256605-o8nnszeg2","label":"ActionReloadActionsPage","stateAction":{"actionConditions":{"group":[{"field":"status","hasMergeField":false,"id":"state-new-condition-32","operator":"==","type":"custom","value":"Sucesso"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"val_CaseValidationDetails","hasExtraParams":false,"id":"flex-action-1708601283246","message":"Reload","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":5,"draggable":true,"isOpen":false,"key":"1708461531136-vhh8ioq0z","label":"ActionClose","stateAction":{"actionConditions":{"group":[{"field":"status","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"Sucesso"}],"id":"state-condition-object","isParent":true},"eventName":"close_modal","id":"flex-action-1708631817079","message":"close","openUrlIn":"Current Window","subType":"PubSub","type":"Event"}}],"buttonVariant":"brand","card":"{card}","displayAsButton":true,"flyoutDetails":{},"hideActionIcon":true,"iconName":"standard-default","label":"Concluir","record":"{record}","showSpinner":"true","stateObj":"{record}"},"size":{"default":"2","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"      \n         ","text":{"align":"center","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"      \n         ","text":{"align":"center","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-5","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#f3f2f2","image":"","position":"","repeat":"","size":""},"border":{"color":"#939393","radius":"","style":"","type":"border_top","width":"1"},"class":"slds-border_top slds-p-top_small slds-p-bottom_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"top:small","size":"small","type":"top"},{"label":"bottom:small","size":"small","type":"bottom"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#f3f2f2;     border-top: #939393 1px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#f3f2f2","image":"","position":"","repeat":"","size":""},"border":{"color":"#939393","radius":"","style":"","type":"border_top","width":"1"},"class":"slds-border_top slds-p-top_small slds-p-bottom_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"top:small","size":"small","type":"top"},{"label":"bottom:small","size":"small","type":"bottom"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#f3f2f2;     border-top: #939393 1px solid; \n         ","text":{"align":"","color":""}}}],"type":"block"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":true,"large":"12","medium":"12","small":"12"},"sizeClass":"slds-large-size_12-of-12 slds-medium-size_12-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valCaseActionsChangeOwner","Name":"valCaseActionsChangeOwner","uniqueKey":"valCaseActionsChangeOwner_undefined_undefined","Id":"a5W78000000L0wSEAS","vlocity_cmt__GlobalKey__c":"valCaseActionsChangeOwner/Telefonica/1/1708368923329","vlocity_cmt__IsChildCard__c":true};
  export default definition