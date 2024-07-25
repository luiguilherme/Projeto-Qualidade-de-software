let definition =
      {"dataSource":{"type":"Custom","value":{"dsDelay":"","body":"{\n \"ValidateBalanceLine\":{},\n\"Products\":{\n\"SubscriptionStatus\":\"Ativo\"\n}\n}","resultVar":""},"orderBy":{"name":"","isReverse":""},"contextVariables":[]},"dynamicCanvasWidth":{"type":"desktop"},"enableLwc":true,"events":[{"eventname":"AnteciparPromocao","channelname":"valPrePaidAssetDetailsButtons_AnteciparButton","element":"action","eventtype":"pubsub","recordIndex":"0","actionList":[{"key":"1721265335737-r8f9hx90w","label":"CheckValidations","draggable":true,"isOpen":false,"card":"{card}","stateAction":{"id":"flex-action-1721268820639","type":"DataAction","displayName":"Action","vlocityIcon":"standard-default","targetType":"Web Page","openUrlIn":"Current Window","Web Page":{"targetName":"/apex"},"message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_ValidateAllJourneys\",\"vlocityAsync\":false,\"inputMap\":{\"ValidatePortability\":\"true\",\"Functionality\":\"ChangeServiceIdentifier\",\"AssetId\":\"{Parent.AssetId}\"},\"jsonMap\":\"{\\\"recordId\\\":\\\"{recordId}\\\",\\\"Parent.AssetId\\\":\\\"{Parent.AssetId}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"id\":4,\"name\":\"recordId\",\"val\":\"02i76000009Pdg3AAC\"},{\"name\":\"Parent.AssetId\",\"val\":\"\",\"id\":3}]}"},"actionIndex":0},{"key":"1721265743353-le6p6zs8p","label":"showToastError","draggable":true,"isOpen":false,"card":"{card}","stateAction":{"id":"flex-action-1721270283932","type":"Event","displayName":"Action","vlocityIcon":"standard-default","openUrlIn":"Current Window","subType":"PubSub","eventName":"valToast","message":"showToast","hasExtraParams":true,"extraParams":{"variant":"warning","message":"{message}"},"actionConditions":{"id":"state-condition-object","isParent":true,"group":[{"id":"state-new-condition-0","field":"blockJourney","operator":"==","value":"true","type":"custom","hasMergeField":false}]}},"isTrackingDisabled":true,"actionIndex":1},{"key":"1721266052185-qw1u9tlty","label":"LineStateOtherThanActive","draggable":true,"isOpen":false,"card":"{card}","stateAction":{"id":"flex-action-1721269947726","type":"Event","displayName":"Action","vlocityIcon":"standard-default","openUrlIn":"Current Window","actionConditions":{"id":"state-condition-object","isParent":true,"group":[{"id":"state-new-group-1","group":[{"field":"Products.SubscriptionStatus","hasMergeField":false,"id":"state-new-condition-0","operator":"!=","type":"custom","value":"Ativo"},{"field":"Products.SubscriptionStatus","hasMergeField":false,"id":"state-new-condition-9","logicalOperator":"&&","operator":"!=","type":"custom","value":"Barrado"},{"field":"Products.SubscriptionStatus","hasMergeField":false,"id":"state-new-condition-19","logicalOperator":"&&","operator":"!=","type":"custom","value":"Barrado Total"},{"field":"showToast","hasMergeField":false,"id":"state-new-condition-32","logicalOperator":"&&","operator":"==","type":"custom","value":"false"},{"field":"blockJourney","hasMergeField":false,"id":"state-new-condition-48","logicalOperator":"&&","operator":"==","type":"custom","value":"false"}]}]},"subType":"PubSub","eventName":"valToast","message":"showToast","hasExtraParams":true,"extraParams":{"message":"Estado da linha não permite realizar a antecipação da promoção.","variant":"warning"}},"actionIndex":2},{"key":"1721268078636-g2y2b2w7r","label":"ValidateAvailableLineBalance","draggable":true,"isOpen":false,"card":"{card}","stateAction":{"id":"flex-action-1721306087999","type":"DataAction","displayName":"Action","vlocityIcon":"standard-default","targetType":"Web Page","openUrlIn":"Current Window","Web Page":{"targetName":"/apex"},"message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_ValidateBalanceLine\",\"vlocityAsync\":false,\"inputMap\":{\"networkNumber\":\"{Products.LineNumber}\",\"ProductCode\":\"{Products.ProductCode}\",\"PriceAttribute\":\"{Products.Attributes.ATT_DC_RM_PROMO_PO_1}\"},\"jsonMap\":\"{\\\"recordId\\\":\\\"{recordId}\\\",\\\"Products.LineNumber\\\":\\\"{Products.LineNumber}\\\",\\\"Products.ProductCode\\\":\\\"{Products.ProductCode}\\\",\\\"Products.Attributes.ATT_DC_RM_PROMO_PO_1\\\":\\\"{Products.Attributes.ATT_DC_RM_PROMO_PO_1}\\\"}\",\"resultVar\":\"\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"id\":4,\"name\":\"recordId\",\"val\":\"02i76000009Pdg3AAC\"},{\"name\":\"Products.LineNumber\",\"val\":\"\",\"id\":6},{\"name\":\"Products.ProductCode\",\"val\":\"\",\"id\":7},{\"name\":\"Products.Attributes.ATT_DC_RM_PROMO_PO_1\",\"val\":\"\",\"id\":8}]}","actionConditions":{"id":"state-condition-object","isParent":true,"group":[{"id":"state-new-condition-3","field":"blockJourney","operator":"==","value":"false","type":"custom","hasMergeField":false}]},"responseNode":"ValidateBalanceLine"},"actionIndex":3},{"key":"1721269894849-mtobbg08h","label":"ShowToastResult","draggable":true,"isOpen":false,"card":"{card}","stateAction":{"id":"flex-action-1721306074877","type":"Event","displayName":"Action","vlocityIcon":"standard-default","openUrlIn":"Current Window","subType":"PubSub","eventName":"valToast","message":"showToast","hasExtraParams":true,"extraParams":{"message":"{ValidateBalanceLine.message}","variant":"{ValidateBalanceLine.variant}"},"actionConditions":{"id":"state-condition-object","isParent":true,"group":[{"field":" ValidateBalanceLine.InsufficientBallance","hasMergeField":false,"id":"state-new-condition-100","operator":"==","type":"custom","value":"true"},{"group":[{"field":"Products.SubscriptionStatus","hasMergeField":false,"id":"state-new-condition-107","operator":"==","type":"custom","value":"Ativo"},{"field":"Products.SubscriptionStatus","hasMergeField":false,"id":"state-new-condition-139","logicalOperator":"&&","operator":"==","type":"custom","value":"Barrado"},{"field":"Products.SubscriptionStatus","hasMergeField":false,"id":"state-new-condition-142","logicalOperator":"&&","operator":"==","type":"custom","value":"Barrado Total"}],"id":"state-new-group-108","logicalOperator":"&&"},{"field":"blockJourney","hasMergeField":false,"id":"state-new-condition-203","logicalOperator":"&&","operator":"==","type":"custom","value":"false"}]}},"actionIndex":4},{"key":"1721303895638-flycpqjlp","label":"ConfirmModal","draggable":false,"isOpen":true,"card":"{card}","stateAction":{"id":"flex-action-1721312492705","type":"Flyout","displayName":"Action","vlocityIcon":"standard-default","openUrlIn":"Current Window","flyoutType":"childCard","openFlyoutIn":"Modal","channelName":"close_modal","cardName":"valAntecipatePromotionFlyout","flyoutLwc":"valAntecipatePromotionFlyout","cardNode":"{record}","hasExtraParams":true,"flyoutParams":{"AccountId":"{Products.AccountId}","InteractionId":"{Products.InteractionId}","InteractionNumber":"{Products.InteractionNumber}","LineNumber":"{Products.LineNumber}","PO":"{Products.Attributes.ATT_DC_RM_PROMO_PO_1}"},"actionConditions":{"id":"state-condition-object","isParent":true,"group":[]}},"actionIndex":5},{"key":"1721304613392-hauxqv782","label":"PalitagemManual","draggable":true,"isOpen":false,"card":"{card}","stateAction":{"id":"flex-action-1721307982879","type":"OmniScript","displayName":"Action","vlocityIcon":"standard-default","openUrlIn":"New Tab/Window","layoutType":"lightning","omniType":{"Name":"val/AddRelationShipTopic/English","Id":"a308I000000Dv11QAC","isLwcOs":true},"isLwcOS":true,"tabLabel":"Palitar","tabIcon":"standard:cancel_checkout","hasExtraParams":true,"extraParams":{"c__AccountId":"{Parent.AccountId}","c__AssetId":"{Parent.AssetId}","c__CustomerInteractionId":"{Parent.InteractionId}","c__InteractionNumber":"{Parent.InteractionNumber}","c__SourceCalled":"SalesJourney","c__lineNumber":"{Products.LineNumber}"},"actionConditions":{"id":"state-condition-object","isParent":true,"group":[{"id":"state-new-condition-0","field":"blockJourney","operator":"==","value":"true","type":"custom","hasMergeField":false},{"id":"state-new-condition-7","field":"palitagem","operator":"==","value":"true","type":"custom","hasMergeField":false,"logicalOperator":"&&"}]}},"actionIndex":6,"contextId":"\\{Parent.InteractionId}"}],"showSpinner":"false","key":"event-0","displayLabel":"valPrePaidAssetDetailsButtons_AnteciparButton:AnteciparPromocao","eventLabel":"pubsub"}],"globalCSS":false,"isFlex":true,"lwc":{"DeveloperName":"cfValPrePaidAssetDetailsButtons_AnteciparButton_8_Telefonica","Id":"0Rb8I000001tigLSAQ","MasterLabel":"cfValPrePaidAssetDetailsButtons_AnteciparButton_8_Telefonica","NamespacePrefix":"c","ManageableState":"unmanaged"},"multilanguageSupport":true,"osSupport":true,"states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"name":"Action","element":"action","size":{"isResponsive":false,"default":"12"},"stateIndex":0,"class":"slds-col ","property":{"label":"Antecipar promoção 2","iconName":"utility:push","record":"{record}","card":"{card}","stateObj":"{record}","actionList":[{"stateAction":{"id":"flex-action-1721268971827","type":"Event","openUrlIn":"Current Window","subType":"PubSub","eventName":"valPrePaidAssetDetailsButtons_AnteciparButton","message":"AnteciparPromocao"},"key":"1721261287621-rnxjsse0n","label":"Action","draggable":true,"isOpen":true,"actionIndex":0}],"showSpinner":"true","displayAsButton":false,"hideActionIcon":false,"styles":{"label":{"color":"#792BA4"}},"iconColor":"#792BA4","flyoutDetails":{}},"type":"element","styleObject":{"sizeClass":"slds-size_12-of-12 ","padding":[{"type":"left","size":"small","label":"left:small"},{"type":"top","size":"small","label":"top:small"}],"margin":[],"background":{"color":"","image":"","size":"","repeat":"","position":""},"size":{"isResponsive":false,"default":"12"},"container":{"class":"slds-card"},"border":{"type":["border_top","border_right","border_bottom","border_left"],"width":"1","color":"#DDDDDD","radius":"4","style":""},"elementStyleProperties":{"styles":{"label":{"color":"#792BA4"}},"iconColor":"#792BA4"},"text":{"align":"","color":""},"inlineStyle":"height: 55px;","class":"slds-card slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-left_small slds-p-top_small ","style":"     border-top: #DDDDDD 1px solid;border-right: #DDDDDD 1px solid;border-bottom: #DDDDDD 1px solid;border-left: #DDDDDD 1px solid; \n    border-radius:4;     height: 55px;"},"elementLabel":"Block-antecipar-promocao-button2","styleObjects":[{"key":0,"conditions":"default","styleObject":{"sizeClass":"slds-size_12-of-12 ","padding":[{"type":"left","size":"small","label":"left:small"},{"type":"top","size":"small","label":"top:small"}],"margin":[],"background":{"color":"","image":"","size":"","repeat":"","position":""},"size":{"isResponsive":false,"default":"12"},"container":{"class":"slds-card"},"border":{"type":["border_top","border_right","border_bottom","border_left"],"width":"1","color":"#DDDDDD","radius":"4","style":""},"elementStyleProperties":{"styles":{"label":{"color":"#792BA4"}},"iconColor":"#792BA4"},"text":{"align":"","color":""},"inlineStyle":"height: 55px;","class":"slds-card slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-left_small slds-p-top_small ","style":"     border-top: #DDDDDD 1px solid;border-right: #DDDDDD 1px solid;border-bottom: #DDDDDD 1px solid;border-left: #DDDDDD 1px solid; \n    border-radius:4;     height: 55px;"},"label":"Default","name":"Default","conditionString":"","draggable":false}],"userUpdatedElementLabel":true},{"name":"Text","element":"outputField","size":{"isResponsive":false,"default":"12"},"stateIndex":0,"class":"slds-col ","property":{"record":"{record}","mergeField":"%3Cdiv%3ETest%3Cbr%20/%3E%3Cbr%20/%3EBalanceLine%20&gt;&gt;&gt;%20%7BValidateBalanceLine.InsufficientBallance%7D%3C/div%3E%0A%3Cdiv%3EblockJourney%20&gt;&gt;&gt;%7BblockJourney%7D%3C/div%3E%0A%3Cdiv%3EStatus%20&gt;&gt;&gt;%20%7BProducts.SubscriptionStatus%7D%3C/div%3E","card":"{card}"},"type":"text","styleObject":{"sizeClass":"slds-size_12-of-12 ","padding":[],"margin":[],"background":{"color":"","image":"","size":"","repeat":"","position":""},"size":{"isResponsive":false,"default":"12"},"container":{"class":"slds-card"},"border":{"type":"","width":"","color":"","radius":"","style":""},"elementStyleProperties":{},"text":{"align":"","color":""},"inlineStyle":"","class":"slds-card ","style":"      \n         "},"elementLabel":"Text-1","styleObjects":[{"key":0,"conditions":"default","styleObject":{"sizeClass":"slds-size_12-of-12 ","padding":[],"margin":[],"background":{"color":"","image":"","size":"","repeat":"","position":""},"size":{"isResponsive":false,"default":"12"},"container":{"class":"slds-card"},"border":{"type":"","width":"","color":"","radius":"","style":""},"elementStyleProperties":{},"text":{"align":"","color":""},"inlineStyle":"","class":"slds-card ","style":"      \n         "},"label":"Default","name":"Default","conditionString":"","draggable":false}]}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"height: 55px;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         height: 55px;","text":{"align":"","color":""}}}],"theme":"slds","title":"valPrePaidAssetDetailsButtons_AnteciparButton","Name":"valPrePaidAssetDetailsButtons_AnteciparButton","uniqueKey":"valPrePaidAssetDetailsButtons_AnteciparButton_undefined_undefined","Id":"a5W8I000000FnTNUA0","vlocity_cmt__GlobalKey__c":"valPrePaidAssetDetailsButtons_AnteciparButton/Telefonica/8/1721260985305","vlocity_cmt__IsChildCard__c":true};
  export default definition