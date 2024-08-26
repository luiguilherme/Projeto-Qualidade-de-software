let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":"","name":""},"type":"IntegrationProcedures","value":{"dsDelay":"","inputMap":{"Line":"{Line}","ProductType":"{ProductType}","ProfileName":"{User.userProfileName}","RecordId":"{recordId}"},"ipMethod":"val_getServiceFlowAddressProduct","resultVar":"","vlocityAsync":false}},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1671584500949-ue16zs44j","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1671671375259","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_getServiceFlowAddressProduct\",\"vlocityAsync\":false,\"inputMap\":{\"RecordId\":\"{recordId}\",\"ProductType\":\"{action.ProductType}\",\"Line\":\"{action.Line}\",\"ProfileName\":\"{User.userProfileName}\"}},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"action.recordId\",\"val\":\"\",\"id\":8},{\"name\":\"action.ProductType\",\"val\":\"\",\"id\":9},{\"name\":\"action.Line\",\"val\":\"\",\"id\":10},{\"name\":\"action.ProfileName\",\"val\":\"\",\"id\":11},{\"name\":\"recordId\",\"val\":\"\",\"id\":8},{\"name\":\"Line\",\"val\":\"\",\"id\":9},{\"name\":\"User.userProfileName\",\"val\":\"\",\"id\":10}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}}],"channelname":"valServiceFlow","displayLabel":"valServiceFlow:update","element":"action","eventLabel":"pubsub","eventname":"update","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1672183249858-bznoyrziz","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"Session.ShowTree","fieldValue":"true"}],"id":"flex-action-1672225915837","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valServiceFlow","displayLabel":"valServiceFlow:showtree","element":"action","eventLabel":"pubsub","eventname":"showtree","eventtype":"pubsub","key":"event-1","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":true,"key":"1672183304996-n0tz8n0s8","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"setValues","fieldValues":[{"fieldName":"Session.ShowTree","fieldValue":"false"}],"id":"flex-action-1672183317069","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valServiceFlow","displayLabel":"valServiceFlow:hidetree","element":"action","eventLabel":"pubsub","eventname":"hidetree","eventtype":"pubsub","key":"event-2","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1672245916060-ari0cjidu","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"reload","id":"flex-action-1672245916992","openUrlIn":"Current Window","targetType":"Web Page","type":"cardAction","vlocityIcon":"standard-default"}}],"channelname":"valServiceFlow","displayLabel":"valServiceFlow:refresh","element":"action","eventLabel":"pubsub","eventname":"refresh","eventtype":"pubsub","key":"event-3","recordIndex":"0","showSpinner":"false"}],"globalCSS":false,"isFlex":true,"lwc":{"DeveloperName":"cfValServiceFlow_4_usPalitagemCrossRegistrarPalito","Id":"0Rb8D000000td1KSAQ","ManageableState":"unmanaged","MasterLabel":"cfValServiceFlow_4_usPalitagemCrossRegistrarPalito","NamespacePrefix":"c"},"multilanguageSupport":true,"osSupport":true,"selectableMode":"Multi","sessionVars":[{"name":"ShowTree","val":"false"},{"name":"OtherProduct","val":""}],"states":[{"actions":[],"childCards":["valAddRelationshipTopicModal"],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Block-1-Text-0","key":"element_element_block_0_0_outputField_0_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","mergeField":"%3Cdiv%3E%3Cspan%20style=%22font-size:%2014pt;%22%3E%3Cstrong%3EFluxo%20de%20Atendimento%3C/strong%3E%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" slds-m-bottom_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" slds-m-bottom_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"text"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Block-1-Select-1","key":"element_element_block_0_0_baseInputElement_1_0","name":"Select","parentElementKey":"element_block_0_0","property":{"action":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":false,"key":"1671585634594-h2zcmhxxe","label":"Action","stateAction":{"actionConditions":{"group":[],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valServiceFlow","extraParams":{"Line":"","ProductType":"{ProductType}"},"hasExtraParams":true,"id":"flex-action-1671588436125","message":"update","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":false,"isOpen":true,"key":"1672183415530-943v1vkwd","label":"Action","stateAction":{"displayName":"Action","eventName":"valServiceFlow","id":"flex-action-1672225966979","message":"hidetree","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"eventType":"onchange","iconName":"standard-default","label":"Action","showSpinner":"true"},"card":"{card}","propertyObj":{"action":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":false,"key":"1671585634594-h2zcmhxxe","label":"Action","stateAction":{"actionConditions":{"group":[],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valServiceFlow","extraParams":{"Line":"","ProductType":"{ProductType}"},"hasExtraParams":true,"id":"flex-action-1671588436125","message":"update","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":false,"isOpen":true,"key":"1672183415530-943v1vkwd","label":"Action","stateAction":{"displayName":"Action","eventName":"valServiceFlow","id":"flex-action-1672225966979","message":"hidetree","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"eventType":"onchange","iconName":"standard-default","label":"Action","showSpinner":"true"},"customProperties":[],"fieldBinding":"{ProductType}","label":"Produto:","options":[{"group":"","id":2,"label":"Fixa","value":"Fixed"},{"group":"","id":3,"label":"Móvel","value":"Mobile"}],"placeholder":"","required":true,"type":"combobox","value":""},"record":"{record}","type":"combobox"},"size":{"default":"3","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-right_small slds-m-bottom_xx-small ","container":{"class":""},"customClass":"","elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-right_small slds-m-bottom_xx-small ","container":{"class":""},"customClass":"","elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"children":[],"class":"slds-col ","element":"block","elementLabel":"Block-1-Block-2","key":"element_element_block_0_0_block_2_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"2","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 "},"type":"block"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Select","key":"element_element_block_0_0_baseInputElement_3_0","name":"Select","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-4","operator":"==","type":"custom","value":"Fixed"},{"field":"hasPermissionFixed","hasMergeField":false,"id":"state-new-condition-173","logicalOperator":"&&","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"propertyObj":{"customProperties":[{"id":0,"label":"name","value":"Select"},{"id":1,"label":"options","value":"{options2}"}],"fieldBinding":"{options2}","label":"Endereço","placeholder":"Selecione o Endereço","type":"combobox"},"record":"{record}","type":"combobox"},"size":{"default":"3","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-right_x-small","margin":[{"size":"xx-small","type":"bottom"}],"padding":[{"size":"small","type":"right"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 "},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Typeahead","key":"element_element_block_0_0_baseInputElement_4_0","name":"Typeahead","parentElementKey":"element_block_0_0","property":{"action":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":true,"key":"1671453693930-ygo0alxfv","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-2","operator":"==","type":"custom","value":"Mobile"},{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-9","logicalOperator":"&&","operator":"==","type":"custom","value":"Fixed"},{"field":"1","hasMergeField":false,"id":"state-new-condition-7","logicalOperator":"&&","operator":"==","type":"custom","value":"2"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"navigationtree","extraParams":{"Active":"Active","ProductType":"{ProductType}","ProfileName":"{User.userProfileName}","SelectedFunction":"RelationshipTopic","ServiceTree":"Service"},"hasExtraParams":true,"id":"flex-action-1671655677540","message":"update","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":false,"isOpen":true,"key":"1671593091356-9qdzolmu0","label":"Action","stateAction":{"displayName":"Action","eventName":"valServiceFlow","extraParams":{"Line":"{Line}","ProductType":"{ProductType}"},"hasExtraParams":true,"id":"flex-action-1671655863279","message":"update","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"eventType":"onselect","iconName":"standard-default","label":"Action","showSpinner":"true"},"card":"{card}","data-conditions":{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-45","operator":"==","type":"custom","value":"Mobile"},{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-54","logicalOperator":"&&","operator":"==","type":"custom","value":"Fixed"}],"id":"state-condition-object","isParent":true},"propertyObj":{"action":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":true,"key":"1671453693930-ygo0alxfv","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-2","operator":"==","type":"custom","value":"Mobile"},{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-9","logicalOperator":"&&","operator":"==","type":"custom","value":"Fixed"},{"field":"1","hasMergeField":false,"id":"state-new-condition-7","logicalOperator":"&&","operator":"==","type":"custom","value":"2"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"navigationtree","extraParams":{"Active":"Active","ProductType":"{ProductType}","ProfileName":"{User.userProfileName}","SelectedFunction":"RelationshipTopic","ServiceTree":"Service"},"hasExtraParams":true,"id":"flex-action-1671655677540","message":"update","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":false,"isOpen":true,"key":"1671593091356-9qdzolmu0","label":"Action","stateAction":{"displayName":"Action","eventName":"valServiceFlow","extraParams":{"Line":"{Line}","ProductType":"{ProductType}"},"hasExtraParams":true,"id":"flex-action-1671655863279","message":"update","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"eventType":"onselect","iconName":"standard-default","label":"Action","showSpinner":"true"},"customProperties":[{"id":0,"label":"iconNameRight","value":"utility:search"},{"id":1,"label":"name","value":"Typeahead"},{"id":2,"label":"maxLength","value":"255"},{"id":3,"label":"options","value":"{options}"}],"fieldBinding":"{Line}","label":"Linha ou Instância","options":[],"required":false,"type":"typeahead","value":""},"record":"{record}","type":"typeahead"},"size":{"default":"3","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-right_small slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"height":"","inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-right_small slds-m-bottom_xx-small ","container":{"class":""},"elementStyleProperties":{},"height":"","inlineStyle":"","margin":[{"label":"bottom:xx-small","size":"xx-small","type":"bottom"}],"padding":[{"label":"right:small","size":"small","type":"right"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Block-1-Select-5","key":"element_element_block_0_0_baseInputElement_5_0","name":"Select","parentElementKey":"element_block_0_0","property":{"action":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1671824358214-tgdjwwwt8","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"Line","hasMergeField":false,"id":"state-new-condition-0","operator":"!=","type":"custom","value":"Outros"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"navigationtree","extraParams":{"Active":"Active","AssetId":"{Line}","CustomerInteractionId":"{recordId}","OtherProduct":"{OtherProduct}","ProductType":"{ProductType}","ProfileName":"''","SelectedFunction":"RelationshipTopic","ServiceTree":"{ServiceTree}"},"hasExtraParams":true,"id":"flex-action-1672235296882","message":"update","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":false,"isOpen":true,"key":"1672183342149-t8n3vpm1p","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"Line","hasMergeField":false,"id":"state-new-condition-27","operator":"!=","type":"custom","value":"Outros"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valServiceFlow","id":"flex-action-1672225994362","message":"showtree","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":2,"card":"{card}","draggable":false,"isOpen":true,"key":"1672226231925-jm1rvw3ji","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"Line","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"Outros"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valServiceFlow","id":"flex-action-1672226246841","message":"hidetree","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"eventType":"onchange","iconName":"standard-default","label":"Action","showSpinner":"true"},"card":"{card}","data-conditions":{"group":[{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"Mobile"},{"field":"hasPermissionMobile","hasMergeField":false,"id":"state-new-condition-36","logicalOperator":"&&","operator":"==","type":"custom","value":"true"}],"id":"state-new-group-1"},{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-2","operator":"==","type":"custom","value":"Fixed"},{"field":"hasPermissionFixed","hasMergeField":false,"id":"state-new-condition-107","logicalOperator":"&&","operator":"==","type":"custom","value":"true"}],"id":"state-new-group-3","logicalOperator":"||"}],"id":"state-condition-object","isParent":true},"propertyObj":{"action":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1671824358214-tgdjwwwt8","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"Line","hasMergeField":false,"id":"state-new-condition-0","operator":"!=","type":"custom","value":"Outros"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"navigationtree","extraParams":{"Active":"Active","AssetId":"{Line}","CustomerInteractionId":"{recordId}","OtherProduct":"{OtherProduct}","ProductType":"{ProductType}","ProfileName":"''","SelectedFunction":"RelationshipTopic","ServiceTree":"{ServiceTree}"},"hasExtraParams":true,"id":"flex-action-1672235296882","message":"update","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":false,"isOpen":true,"key":"1672183342149-t8n3vpm1p","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"Line","hasMergeField":false,"id":"state-new-condition-27","operator":"!=","type":"custom","value":"Outros"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valServiceFlow","id":"flex-action-1672225994362","message":"showtree","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":2,"card":"{card}","draggable":false,"isOpen":true,"key":"1672226231925-jm1rvw3ji","label":"Action","stateAction":{"actionConditions":{"group":[{"field":"Line","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"Outros"}],"id":"state-condition-object","isParent":true},"displayName":"Action","eventName":"valServiceFlow","id":"flex-action-1672226246841","message":"hidetree","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"eventType":"onchange","iconName":"standard-default","label":"Action","showSpinner":"true"},"customProperties":[{"id":0,"label":"options","value":"{options}"},{"id":1,"label":"messageWhenFieldRequired","value":"{Label.cmpFieldRequired}"}],"fieldBinding":"{Line}","label":"Linha ou Instância","options":[],"placeholder":"Escolha a Linha ou Instância","required":true,"type":"combobox"},"record":"{record}","type":"combobox"},"size":{"default":"3","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-right_x-small","margin":[{"size":"xx-small","type":"bottom"}],"padding":[{"size":"small","type":"right"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 "},"type":"element"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Block-1-Text-6","key":"element_element_block_0_0_baseInputElement_6_0","name":"Text","parentElementKey":"element_block_0_0","property":{"action":{"actionList":[{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":true,"key":"1671223332532-69o5ojhpr","label":"Action","stateAction":{"displayName":"Action","eventName":"navigationtree","extraParams":{"Active":"Active","AssetId":"''","CustomerInteractionId":"{recordId}","OtherProduct":"{Session.OtherProduct}","ProductType":"{ProductType}","ProfileName":"''","SelectedFunction":"RelationshipTopic","ServiceTree":"{ServiceTree}"},"hasExtraParams":true,"id":"flex-action-1672235917015","message":"update","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":true,"key":"1672226024146-1uaxixtle","label":"Action","stateAction":{"displayName":"Action","eventName":"valServiceFlow","id":"flex-action-1672226033306","message":"showtree","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"eventType":"onchange","iconName":"standard-default","label":"Action","showSpinner":"true"},"card":"{card}","data-conditions":{"group":[{"field":"Line","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"Outros"},{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-12","logicalOperator":"&&","operator":"==","type":"custom","value":"Mobile"}],"id":"state-condition-object","isParent":true},"propertyObj":{"action":{"actionList":[{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":true,"key":"1671223332532-69o5ojhpr","label":"Action","stateAction":{"displayName":"Action","eventName":"navigationtree","extraParams":{"Active":"Active","AssetId":"''","CustomerInteractionId":"{recordId}","OtherProduct":"{Session.OtherProduct}","ProductType":"{ProductType}","ProfileName":"''","SelectedFunction":"RelationshipTopic","ServiceTree":"{ServiceTree}"},"hasExtraParams":true,"id":"flex-action-1672235917015","message":"update","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":true,"key":"1672226024146-1uaxixtle","label":"Action","stateAction":{"displayName":"Action","eventName":"valServiceFlow","id":"flex-action-1672226033306","message":"showtree","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"eventType":"onchange","iconName":"standard-default","label":"Action","showSpinner":"true"},"customProperties":[{"id":0,"label":"messageWhenValueMissing","value":"{Label.cmpFieldValueMissing}"}],"fieldBinding":"{Session.OtherProduct}","label":"Especifique o Produto","placeholder":"Especifique o produto","required":true},"record":"{record}","type":"text"},"size":{"default":"3","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-right_x-small","margin":[{"size":"xx-small","type":"bottom"}],"padding":[{"size":"small","type":"right"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 "},"type":"element"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-1-Text-7","key":"element_element_block_0_0_outputField_7_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-195","operator":"==","type":"custom","value":"Mobile"},{"field":"hasPermissionMobile","hasMergeField":false,"id":"state-new-condition-198","logicalOperator":"&&","operator":"==","type":"custom","value":"false"}],"id":"state-new-group-196"},{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-199","operator":"==","type":"custom","value":"Fixed"},{"field":"hasPermissionFixed","hasMergeField":false,"id":"state-new-condition-205","logicalOperator":"&&","operator":"==","type":"custom","value":"false"}],"id":"state-new-group-200","logicalOperator":"||"}],"id":"state-condition-object","isParent":true},"mergeField":"%3Cdiv%3EOperador%20sem%20permiss&atilde;o%3C/div%3E","record":"{record}"},"size":{"default":"3","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"      \n        color:#FF0000; ","text":{"align":"","color":"#FF0000"}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"      \n        color:#FF0000; ","text":{"align":"","color":"#FF0000"}}}],"type":"text"}],"class":"slds-col ","element":"block","elementLabel":"Block-1","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 "},"type":"block"},{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-2-FlexCard-1","key":"element_element_block_1_0_childCardPreview_1_0","name":"FlexCard","parentElementKey":"element_block_1_0","property":{"cardName":"valAddRelationshipTopicModal","cardNode":"","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"parentAttribute":{"CustomerInteractionId":"CustomerInteractionId","{PCusttedFunction}":"RelationshipTopic"},"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-2","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"data-conditions":{"group":[{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-11","operator":"==","type":"custom","value":"Mobile"},{"group":[{"field":"Line","hasMergeField":false,"id":"state-new-condition-190","operator":"==","type":"custom","value":"Outros"},{"field":"Line","hasMergeField":false,"id":"state-new-condition-277","logicalOperator":"||","operator":"!=","type":"custom","value":""}],"id":"state-new-group-191","logicalOperator":"&&"},{"field":"1","hasMergeField":false,"id":"state-new-condition-8","logicalOperator":"&&","operator":"==","type":"custom","value":"2"}],"id":"state-new-group-12"},{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-75","operator":"==","type":"custom","value":"Fixed"},{"field":"Line","hasMergeField":false,"id":"state-new-condition-114","logicalOperator":"&&","operator":"!=","type":"custom","value":"Outros"},{"field":"1","hasMergeField":false,"id":"state-new-condition-73","logicalOperator":"&&","operator":"==","type":"custom","value":"2"}],"id":"state-new-group-76","logicalOperator":"||"},{"field":"Session.ShowTree","hasMergeField":false,"id":"state-new-condition-137","logicalOperator":"||","operator":"==","type":"custom","value":"true"}],"id":"state-condition-object","isParent":true},"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"sizeClass":"slds-size_12-of-12"},"type":"block"},{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Block-3-Text-0","key":"element_element_block_2_0_outputField_0_0","name":"Text","parentElementKey":"element_block_2_0","property":{"card":"{card}","mergeField":"%3Cdiv%3E%3Cstrong%3EFixa+Outros%3C/strong%3E.Cliente%20indispon&iacute;vel%20em%20Salesforce,%20prossiga%20com%20o%20pedido%20do%20cliente%20diretamente%20pelo%20GPS.&nbsp;%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_left ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"text-align: center","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         text-align: center","text":{"align":"left","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_left ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"text-align: center","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         text-align: center","text":{"align":"left","color":""}}}],"type":"text"}],"class":"slds-col ","element":"block","elementLabel":"Block-3","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"data-conditions":{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-4","operator":"==","type":"custom","value":"Fixed"},{"field":"Line","hasMergeField":false,"id":"state-new-condition-11","logicalOperator":"&&","operator":"==","type":"custom","value":"Outros"}],"id":"state-condition-object","isParent":true},"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"sizeClass":"slds-size_12-of-12"},"type":"block"},{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Block-4-Text-0","key":"element_element_block_3_0_outputField_0_0","name":"Text","parentElementKey":"element_block_3_0","property":{"card":"{card}","mergeField":"%3Cdiv%3E%3Cstrong%3Efixa+!Sibel%3C/strong%3E.Aten&ccedil;&atilde;o!%20Esse%20produto%20est&aacute;%20no%20Next,%20acesse%20o%20sistema%20e%20siga%20com%20o%20atendimento.%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"text-align: center","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         text-align: center","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"text-align: center","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         text-align: center","text":{"align":"","color":""}}}],"type":"text"}],"class":"slds-col ","element":"block","elementLabel":"Block-4","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"data-conditions":{"group":[{"field":"ProductType","hasMergeField":false,"id":"state-new-condition-7","operator":"==","type":"custom","value":"Fixed"},{"field":"Line","hasMergeField":false,"id":"state-new-condition-0","logicalOperator":"&&","operator":"!=","type":"custom","value":""},{"field":"SourceSystem","hasMergeField":false,"id":"state-new-condition-33","logicalOperator":"&&","operator":"!=","type":"custom","value":"SIEBEL"}],"id":"state-condition-object","isParent":true},"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"sizeClass":"slds-size_12-of-12"},"type":"block"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-card slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_x-small slds-m-bottom_x-small ","container":{"class":"slds-card"},"elementStyleProperties":{},"height":"","inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}}},{"actions":[],"blankCardState":true,"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Text-0","name":"Text","property":{"card":"{card}","mergeField":"%3Cdiv%3E%3Cspan%20style=%22font-size:%2014pt;%22%3E%3Cstrong%3EFluxo%20de%20Atendimento%3C/strong%3E%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" slds-m-bottom_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" slds-m-bottom_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"text"},{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Block-1-Text-0","key":"element_element_block_1_1_outputField_0_1","name":"Text","parentElementKey":"element_block_1_1","property":{"card":"{card}","mergeField":"%3Cdiv%3EOperador%20sem%20permiss&atilde;o.%3C/div%3E","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"text"}],"class":"slds-col ","element":"block","elementLabel":"Block-2","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 "},"type":"block"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Operador sem permissão","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small ","container":{"class":"slds-card"},"elementStyleProperties":{},"height":"","inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valServiceFlow","Id":"a5W78000000KzVoEAK","vlocity_cmt__GlobalKey__c":"valServiceFlow/usPalitagemCrossRegistrarPalito/4/1671735617140","vlocity_cmt__IsChildCard__c":false};
  export default definition