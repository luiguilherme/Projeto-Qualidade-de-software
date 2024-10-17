let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":"","name":""},"type":"IntegrationProcedures","value":{"dsDelay":"","inputMap":{"IdSelectTopicTree":"{Parent.IdTopicTree}","showMaintenanceForm":"false","tabActivated":"{Parent.tabActivated}"},"ipMethod":"val_TopicsTreeAdditionalSettingsList","jsonMap":"{\"Parent.additionalSettingsType\":\"{Parent.additionalSettingsType}\",\"Parent.tabActivated\":\"{Parent.tabActivated}\",\"Parent.Id\":\"{Parent.Id}\",\"Parent.IdTopicTree\":\"{Parent.IdTopicTree}\"}","resultVar":"","vlocityAsync":false}},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1711130714252-b077yeq30","label":"ActionHideMaintenanceForm","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"showMaintenanceForm","fieldValue":"false"}],"id":"flex-action-1711130765171","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"TopicsTreeAdditionalSettingsChannel","displayLabel":"TopicsTreeAdditionalSettingsChannel:hidemaintenanceform","element":"action","eventLabel":"pubsub","eventname":"hidemaintenanceform","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1718115908835-d32es4p9v","label":"Action","stateAction":{"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"selectRow","fieldValue":"{action.result.selectrow}"},{"fieldName":"result","fieldValue":"{action.result}"},{"fieldName":"showMaintenanceForm","fieldValue":"false"},{"fieldName":"success","fieldValue":""}],"id":"flex-action-1721155235107","message":"disablesavebuttonUpdate","openUrlIn":"Current Window","subType":"PubSub","type":"cardAction","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":false,"key":"1718377755148-h4g6qe1al","label":"ActionSelectedValues","stateAction":{"displayName":"Action","eventName":"valTopicsTreeAdditionalSettingsList","hasExtraParams":false,"id":"flex-action-1718398142015","message":"selectsetvalues","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"channelname":"TopicsTreeAdditionalSettingsChannel","displayLabel":"selectrow","element":"action","eventLabel":"custom event","eventname":"selectrow","eventtype":"event","key":"event-1","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1718295785127-qgz7dkzt2","label":"ActionShowMessageToast","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"success","fieldValue":"{action.success}"},{"fieldName":"messageToastError","fieldValue":"{action.errorResponse}"}],"id":"flex-action-1718301587765","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"TopicsTreeAdditionalSettingsMaintenance","displayLabel":"TopicsTreeAdditionalSettingsMaintenance:toast","element":"action","eventLabel":"pubsub","eventname":"toast","eventtype":"pubsub","key":"event-2","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":false,"key":"1718326051618-oh77ijrov","label":"ActionUpdateDataSource","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"updatedatasource","id":"flex-action-1718326439234","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_TopicsTreeAdditionalSettingsList\",\"vlocityAsync\":false,\"inputMap\":{\"tabActivated\":\"{action.tab}\",\"IdSelectTopicTree\":\"{action.IdTopicTree}\"},\"jsonMap\":\"{\\\"action.IdTopicTree\\\":\\\"{action.IdTopicTree}\\\",\\\"action.tab\\\":\\\"{action.tab}\\\"}\",\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"action.IdTopicTree\",\"val\":\"\",\"id\":7},{\"name\":\"action.tab\",\"val\":\"\",\"id\":9}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":false,"isOpen":true,"key":"1718327140781-dzoffjlqm","label":"ActionToastSuccess","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"success","fieldValue":"OK"},{"fieldName":"selectRow","fieldValue":"false"}],"id":"flex-action-1718422922165","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valTopicsTreeAdditionalSettingsMaintenance","displayLabel":"valTopicsTreeAdditionalSettingsMaintenance:updatedatasource","element":"action","eventLabel":"pubsub","eventname":"updatedatasource","eventtype":"pubsub","key":"event-3","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1718383336991-54c9diog3","label":"ActionCloseToastError","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"success","fieldValue":"close"},{"fieldName":"selectRow","fieldValue":"false"}],"id":"flex-action-1718422772569","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valTopicsTreeAdditionalSettingsMaintenance","displayLabel":"valTopicsTreeAdditionalSettingsMaintenance:closeerrortoast","element":"action","eventLabel":"pubsub","eventname":"closeerrortoast","eventtype":"pubsub","key":"event-4","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1718639484597-eiypkddnt","label":"ActionUpdateDataSourceDelete","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"updatedatasource","id":"flex-action-1718641273939","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_TopicsTreeAdditionalSettingsList\",\"vlocityAsync\":false,\"inputMap\":{\"tabActivated\":\"{Parent.tabActivated}\",\"IdSelectTopicTree\":\"{Parent.IdTopicTree}\"},\"jsonMap\":\"{\\\"Parent.tabActivated\\\":\\\"{Parent.tabActivated}\\\",\\\"Parent.IdTopicTree\\\":\\\"{Parent.IdTopicTree}\\\"}\",\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"Parent.tabActivated\",\"val\":\"FollowUpCase\",\"id\":13},{\"name\":\"Parent.IdTopicTree\",\"val\":\"a6z6t000000CrXNAA0\",\"id\":15}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valTopicsTreeAdditionalSettingsListDataTable","displayLabel":"valTopicsTreeAdditionalSettingsListDataTable:updatesourcedatatable","element":"action","eventLabel":"pubsub","eventname":"updatesourcedatatable","eventtype":"pubsub","key":"event-5","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1719492071977-71lpzl5zx","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"success","fieldValue":"close"},{"fieldName":"showMaintenanceForm","fieldValue":"false"},{"fieldName":"selectRow","fieldValue":"false"}],"id":"flex-action-1719492262227","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valTopicsTreeFilterParms","displayLabel":"valTopicsTreeFilterParms:reloadcard","element":"action","eventLabel":"pubsub","eventname":"reloadcard","eventtype":"pubsub","key":"event-6","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1721156389437-bp3kn7dv0","label":"ActionCloseToastError","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"success","fieldValue":"close"}],"id":"flex-action-1721156413479","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valTopicsTreeAdditionalSettingsMaintenance","displayLabel":"valTopicsTreeAdditionalSettingsMaintenance:closetoasterror","element":"action","eventLabel":"pubsub","eventname":"closetoasterror","eventtype":"pubsub","key":"event-7","recordIndex":"0","showSpinner":"false"}],"isFlex":true,"lwc":{"DeveloperName":"cfValTopicsTreeAdditionalSettingsList_1_TelefonicaBrasil_MarcioLas","Id":"0Rb6t000001cVEPCA2","ManageableState":"unmanaged","MasterLabel":"cfValTopicsTreeAdditionalSettingsList_1_TelefonicaBrasil_MarcioLas","NamespacePrefix":"c"},"multilanguageSupport":true,"selectableField":"","selectableMode":"Multi","selectedCardsLabel":"valTopicsTreeAdditionalSettingsMaintenance","states":[{"actions":[],"childCards":["valTopicsTreeAdditionalSettingsListDataTable2","valTopicsTreeAdditionalSettingsListDataTable","valTopicsTreeAdditionalSettingsMaintenance","valTopicsTreeAdditionalSettingsUpdate"],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"lblSettings","key":"element_element_block_0_0_outputField_0_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","mergeField":"%3Cdiv%3E%0A%3Cdiv%3E%3Cspan%20style=%22font-size:%2010pt;%22%3E%3Cstrong%3EParametriza&ccedil;&otilde;es%3C/strong%3E%3C/span%3E%3C/div%3E%0A%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-m-bottom_medium ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:medium","size":"medium","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-m-bottom_medium ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:medium","size":"medium","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"text","userUpdatedElementLabel":true},{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-2-FlexCard-1","key":"element_element_block_0_0_childCardPreview_1_0","name":"FlexCard","parentElementKey":"element_block_0_0","property":{"cardName":"valTopicsTreeAdditionalSettingsListDataTable2","cardNode":"{record.TopicConfigFollowUpTreatmentCase}","data-conditions":{"group":[{"field":"Parent.tabActivated","hasMergeField":false,"id":"state-new-condition-6","operator":"==","type":"custom","value":"TreatmentCase"}],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-2-FlexCard-2","key":"element_element_block_0_0_childCardPreview_2_0","name":"FlexCard","parentElementKey":"element_block_0_0","property":{"cardName":"valTopicsTreeAdditionalSettingsListDataTable","cardNode":"{record.TopicConfigFollowUpTreatmentCase}","data-conditions":{"group":[{"field":"Parent.tabActivated","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"FollowUpCase"}],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"},{"class":"slds-col ","element":"action","elementLabel":"btnAddSetting","key":"element_element_block_0_0_action_3_0","name":"Action","parentElementKey":"element_block_0_0","property":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":true,"key":"1719431578113-k7bg3870c","label":"ActionReloadForm","stateAction":{"displayName":"Action","eventName":"TopicsTreeAdditionalSettingsList","id":"flex-action-1719431646127","message":"reloadCard","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":0,"draggable":true,"isOpen":true,"key":"1711060129257-1cd35rp2j","label":"ActionShowMaintenanceForm","stateAction":{"eventName":"setValues","fieldValues":[{"fieldName":"showMaintenanceForm","fieldValue":"true"}],"id":"flex-action-1718057879170","openUrlIn":"Current Window","subType":"PubSub","type":"cardAction"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":false,"key":"1718059708496-44zozwj3x","label":"ActionDisableSaveButton","stateAction":{"displayName":"Action","eventName":"TopicsTreeAdditionalSettingsChannel","extraParams":{"buttonSave":"{showMaintenanceForm}"},"hasExtraParams":true,"id":"flex-action-1718062990987","message":"disablesavebutton","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":2,"card":"{card}","draggable":true,"isOpen":true,"key":"1718383150235-cwr4l4uza","label":"ActionCloseToast","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"success","fieldValue":"close"},{"fieldName":"selectRow","fieldValue":"false"}],"id":"flex-action-1718422556629","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"buttonVariant":"brand","card":"{card}","disabled":"\\{showMaintenanceForm}","displayAsButton":true,"flyoutDetails":{},"hideActionIcon":true,"iconName":"standard-default","label":"Adicionar Configuração","record":"{record}","showSpinner":"false","stateObj":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right slds-m-bottom_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:small","size":"small","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"right","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right slds-m-bottom_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:small","size":"small","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"right","color":""}}}],"type":"element","userUpdatedElementLabel":true},{"children":[{"class":"slds-col ","element":"flexIcon","elementLabel":"Block-2-Block-5-Icon-0","key":"element_element_element_block_3_0_block_5_0_flexIcon_0_0","name":"Icon","parentElementKey":"element_element_block_3_0_block_5_0","property":{"card":"{card}","color":"#FFFFFF","extraclass":"","iconName":"utility:check","iconType":"Salesforce SVG","imgsrc":"","record":"{record}","size":"medium","variant":"success"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#2E844A","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"color":"#FFFFFF"},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"background-color:#2E844A;      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#2E844A","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"color":"#FFFFFF"},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"background-color:#2E844A;      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-2-Block-5-Text-1","key":"element_element_element_block_3_0_block_5_0_outputField_1_0","name":"Text","parentElementKey":"element_element_block_3_0_block_5_0","property":{"card":"{card}","mergeField":"%3Cdiv%20class=%22slds-text-color_inverse%22%3EConfigura&ccedil;&atilde;o%20Salva%20com%20%3Cstrong%3ESucesso%3C/strong%3E!%3C/div%3E","record":"{record}"},"size":{"default":"10","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-top_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"top:x-small","size":"x-small","type":"top"}],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-top_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"top:x-small","size":"x-small","type":"top"}],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"text"},{"class":"slds-col ","element":"action","elementLabel":"Block-2-Block-5-Action-2","key":"element_element_element_block_3_0_block_5_0_action_2_0","name":"Action","parentElementKey":"element_element_block_3_0_block_5_0","property":{"actionList":[{"actionIndex":0,"draggable":true,"isOpen":true,"key":"1718296423927-wi3ts2oh2","label":"ActionCloseToast","stateAction":{"Web Page":{"targetName":"/apex"},"eventName":"setValues","fieldValues":[{"fieldName":"success","fieldValue":"close"}],"id":"flex-action-1718383135481","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction"}}],"card":"{card}","flyoutDetails":{},"iconColor":"#FFFFFF","iconName":"utility:close","iconOnly":true,"label":"Fechar","record":"{record}","showSpinner":"false","stateObj":"{record}"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right slds-p-right_medium ","container":{"class":""},"elementStyleProperties":{"iconColor":"#FFFFFF"},"inlineStyle":"","margin":[],"padding":[{"label":"right:medium","size":"medium","type":"right"}],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"right","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right slds-p-right_medium ","container":{"class":""},"elementStyleProperties":{"iconColor":"#FFFFFF"},"inlineStyle":"","margin":[],"padding":[{"label":"right:medium","size":"medium","type":"right"}],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"right","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-2-Block-5","key":"element_element_block_0_0_block_4_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"data-conditions":{"group":[{"field":"success","hasMergeField":false,"id":"state-new-condition-7","operator":"==","type":"custom","value":"OK"},{"field":"selectRow","hasMergeField":false,"id":"state-new-condition-9","logicalOperator":"&&","operator":"!=","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#2E844A","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#2E844A;      \n    border-radius:5px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#2E844A","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#2E844A;      \n    border-radius:5px;     ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"valTopicsTreeAdditionalSettingsMaintenance","key":"element_element_block_0_0_childCardPreview_5_0","name":"FlexCard","parentElementKey":"element_block_0_0","property":{"cardName":"valTopicsTreeAdditionalSettingsMaintenance","cardNode":"","data-conditions":{"group":[{"field":"showMaintenanceForm","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"parentAttribute":{"IdTopicTree":"{Parent.IdTopicTree}","tab":"{Parent.tabActivated}"},"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small slds-m-top_medium ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:medium","size":"medium","type":"top"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small slds-m-top_medium ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:medium","size":"medium","type":"top"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}}}],"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-4","key":"element_element_block_0_0_childCardPreview_6_0","name":"FlexCard","parentElementKey":"element_block_0_0","property":{"cardName":"valTopicsTreeAdditionalSettingsUpdate","cardNode":"","data-conditions":{"group":[{"field":"selectRow","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"true"},{"field":"showMaintenanceForm","hasMergeField":false,"id":"state-new-condition-2","logicalOperator":"&&","operator":"!=","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"parentAttribute":{"CaseReason":"{result.CaseReason__c}","CaseRecordType":"{result.CaseRecordType__c}","CustomerSegment":"{result.CustomerSegment__c}","IdTopicConfig":"{result.Id}","IdTopicTree":"{Parent.IdTopicTree}","IsActive":"{result.IsActive__c}","IsOmniRequest":"{result.IsOmniRequest__c}","OperatorRoles":"{result.OperatorRoles__c}","OperatorSegment":"{result.OperatorSegment__c}","VisibleTo":"{result.VisibleTo__c}","tab":"{Parent.tabActivated}"},"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small slds-m-top_medium ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:medium","size":"medium","type":"top"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small slds-m-top_medium ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:medium","size":"medium","type":"top"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}}}],"type":"element"},{"children":[{"class":"slds-col ","element":"flexIcon","elementLabel":"Block-2-Block-5-Icon-0","key":"element_element_element_block_1_0_block_8_0_flexIcon_0_0","name":"Icon","parentElementKey":"element_element_block_1_0_block_8_0","property":{"card":"{card}","color":"#FFFFFF","extraclass":"","iconName":"utility:error","iconType":"Salesforce SVG","imgsrc":"","record":"{record}","size":"medium","variant":"error"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#C23934","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"color":"#FFFFFF"},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"background-color:#C23934;      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#C23934","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"color":"#FFFFFF"},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"background-color:#C23934;      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-2-Block-5-Text-1","key":"element_element_element_block_1_0_block_8_0_outputField_1_0","name":"Text","parentElementKey":"element_element_block_1_0_block_8_0","property":{"card":"{card}","mergeField":"%3Cdiv%20class=%22slds-text-color_inverse%22%3E%3Cstrong%3EErro%3C/strong%3E%20%3Cstrong%3Eao%20salvar%20a%20configura&ccedil;&atilde;o.%3C/strong%3E%3C/div%3E%0A%3Cdiv%20class=%22slds-text-color_inverse%22%3E%7BmessageToastError%7D%3C/div%3E","record":"{record}"},"size":{"default":"10","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-top_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"top:x-small","size":"x-small","type":"top"}],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-top_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"top:x-small","size":"x-small","type":"top"}],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"text"},{"class":"slds-col ","element":"action","elementLabel":"Block-2-Block-5-Action-2","key":"element_element_element_block_1_0_block_8_0_action_2_0","name":"Action","parentElementKey":"element_element_block_1_0_block_8_0","property":{"actionList":[{"actionIndex":0,"draggable":true,"isOpen":true,"key":"1718296423927-wi3ts2oh2","label":"ActionCloseToast","stateAction":{"Web Page":{"targetName":"/apex"},"eventName":"setValues","fieldValues":[{"fieldName":"success","fieldValue":"close"}],"id":"flex-action-1718296983334","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction"}}],"card":"{card}","flyoutDetails":{},"iconColor":"#FFFFFF","iconName":"utility:close","iconOnly":true,"label":"Action","record":"{record}","showSpinner":"false","stateObj":"{record}"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right slds-p-right_medium ","container":{"class":""},"elementStyleProperties":{"iconColor":"#FFFFFF"},"inlineStyle":"","margin":[],"padding":[{"label":"right:medium","size":"medium","type":"right"}],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"right","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right slds-p-right_medium ","container":{"class":""},"elementStyleProperties":{"iconColor":"#FFFFFF"},"inlineStyle":"","margin":[],"padding":[{"label":"right:medium","size":"medium","type":"right"}],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"      \n         ","text":{"align":"right","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-2-Block-5-clone-0","key":"element_element_block_0_0_block_7_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"data-conditions":{"group":[{"field":"success","hasMergeField":false,"id":"state-new-condition-7","operator":"==","type":"custom","value":"false"}],"id":"state-condition-object","isParent":true},"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#C23934","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#C23934;      \n    border-radius:5px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#C23934","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"background-color:#C23934;      \n    border-radius:5px;     ","text":{"align":"","color":""}}}],"type":"block"}],"class":"slds-col ","element":"block","elementLabel":"Block-4","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}}}],"type":"block"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valTopicsTreeAdditionalSettingsList","Id":"a5W8M000000GuHxUAK","vlocity_cmt__GlobalKey__c":"valTopicsTreeAdditionalSettingsList/TelefonicaBrasil_MarcioLas/1/1721048404249","vlocity_cmt__IsChildCard__c":true};
  export default definition