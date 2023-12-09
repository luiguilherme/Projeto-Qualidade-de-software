let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":"","name":""},"type":"IntegrationProcedures","value":{"dsDelay":"","inputMap":{"recordId":"{recordId}"},"ipMethod":"val_GetUserPermission","jsonMap":"{\"recordId\":\"{recordId}\"}","resultVar":"","vlocityAsync":false}},"enableLwc":true,"isFlex":true,"lwc":{"DeveloperName":"cfValReviewRegistration_5_Valentina","Id":"0Rb76000000DFEeCAO","ManageableState":"unmanaged","MasterLabel":"cfValReviewRegistration_5_Valentina","NamespacePrefix":"c"},"selectableMode":"Multi","states":[{"actions":[],"childCards":["valReviewOutdatedData","valReviewRequiredData","valChildReviewCustomerV2"],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"childCardPreview","elementLabel":"Block-0-FlexCard-1","key":"element_element_block_0_0_childCardPreview_0_0","name":"FlexCard","parentElementKey":"element_block_0_0","property":{"cardName":"valReviewOutdatedData","cardNode":"","data-conditions":{"group":[{"group":[{"field":"UserPermission.RealizarAlteracaoCadastral","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"true"},{"field":"UserPermission.ConsultarAlteracaoCadastral","hasMergeField":false,"id":"state-new-condition-16","logicalOperator":"||","operator":"==","type":"custom","value":"true"}],"id":"state-new-group-1"},{"field":"CustomerClass","hasMergeField":false,"id":"state-new-condition-57","logicalOperator":"&&","operator":"==","type":"custom","value":""}],"id":"state-condition-object","isParent":true},"data-preloadConditionalElement":false,"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"WarningCustomAttribute"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-0","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-1","name":"FlexCard","property":{"cardName":"valReviewRequiredData","cardNode":"","data-conditions":{"group":[{"field":"CustomerClass","hasMergeField":false,"id":"state-new-condition-113","operator":"==","type":"custom","value":""},{"group":[{"field":"UserPermission.RealizarAlteracaoCadastral","hasMergeField":false,"id":"state-new-condition-2","operator":"==","type":"custom","value":"true"},{"field":"UserPermission.ConsultarAlteracaoCadastral","hasMergeField":false,"id":"state-new-condition-27","logicalOperator":"||","operator":"==","type":"custom","value":"true"}],"id":"state-new-group-3","logicalOperator":"&&"}],"id":"state-condition-object","isParent":true},"data-preloadConditionalElement":false,"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"WarningCustomAttribute"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-2","name":"FlexCard","property":{"cardName":"valChildReviewCustomerV2","cardNode":"","isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-m-top_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:small","size":"small","type":"top"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-m-top_small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:small","size":"small","type":"top"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"element"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-m-bottom_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valReviewRegistration","Name":"valReviewRegistration","uniqueKey":"valReviewRegistration_undefined_undefined","Id":"a5W78000000L0a1EAC","vlocity_cmt__GlobalKey__c":"valReviewRegistration/Valentina/5/1695736609018","vlocity_cmt__IsChildCard__c":false};
  export default definition