let definition =
      {"dataSource":{"type":"IntegrationProcedures","value":{"dsDelay":"","ipMethod":"val_GetCustomerProducts","vlocityAsync":false,"inputMap":{"CurrentPage":"1","RecordId":"{recordId}"},"jsonMap":"{\"recordId\":\"{recordId}\"}","resultVar":""},"orderBy":{"name":"","isReverse":""},"contextVariables":[]},"dynamicCanvasWidth":{"type":"desktop"},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1652905262318-bcucx30fy","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1653076359683","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_GetCustomerProducts\",\"vlocityAsync\":false,\"inputMap\":{\"CurrentPage\":\"1\",\"FilterValue\":\"{action.value}\",\"TotalPages\":\"{PageControl.TotalPages}\",\"RecordId\":\"{recordId}\"}},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"action.value\",\"val\":\"\",\"id\":3},{\"name\":\"PageControl.TotalPages\",\"val\":\"\",\"id\":4},{\"name\":\"recordId\",\"val\":\"\",\"id\":6},{\"name\":\"FilterValueTypeAhead\",\"val\":\"\",\"id\":8}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}}],"channelname":"type","displayLabel":"type:basetypeaheadinputchange","element":"action","eventLabel":"pubsub","eventname":"basetypeaheadinputchange","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"true"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1652905479977-o8dan0pst","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1652905557535","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_GetCustomerProducts\",\"vlocityAsync\":false,\"inputMap\":{\"CurrentPage\":\"{PageControl.CurrentPage}\",\"Navigation\":\"next\",\"TotalPages\":\"{PageControl.TotalPages}\",\"FilterValue\":\"{FilterValue}\",\"RecordId\":\"{recordId}\"}},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"PageControl.CurrentPage\",\"val\":\"\",\"id\":5},{\"name\":\"PageControl.TotalPages\",\"val\":\"\",\"id\":6},{\"name\":\"FilterValue\",\"val\":\"\",\"id\":7},{\"name\":\"recordId\",\"val\":\"\",\"id\":8}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}}],"channelname":"updatedatasource","displayLabel":"updatedatasource:nextpage","element":"action","eventLabel":"pubsub","eventname":"nextpage","eventtype":"pubsub","key":"event-1","recordIndex":"0","showSpinner":"true"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1652905583970-vnt2gffim","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","eventName":"reload","id":"flex-action-1652905659652","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_GetCustomerProducts\",\"vlocityAsync\":false,\"inputMap\":{\"CurrentPage\":\"{PageControl.CurrentPage}\",\"Navigation\":\"previous\",\"TotalPages\":\"{PageControl.TotalPages}\",\"FilterValue\":\"{FilterValue}\",\"RecordId\":\"{recordId}\"}},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"PageControl.CurrentPage\",\"val\":\"\",\"id\":6},{\"name\":\"PageControl.TotalPages\",\"val\":\"\",\"id\":7},{\"name\":\"FilterValue\",\"val\":\"\",\"id\":8},{\"name\":\"recordId\",\"val\":\"\",\"id\":9}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}}],"channelname":"updatedatasource","displayLabel":"updatedatasource:previouspage","element":"action","eventLabel":"pubsub","eventname":"previouspage","eventtype":"pubsub","key":"event-2","recordIndex":"0","showSpinner":"true"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1653315159536-udl2x17wq","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1653315415489","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_GetCustomerProducts\",\"vlocityAsync\":false,\"inputMap\":{\"RecordId\":\"{recordId}\",\"CurrentPage\":\"1\",\"FilterValue\":\"{action.value}\",\"TotalPages\":\"{PageControl.TotalPages}\"}},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"recordId\",\"val\":\"a1c760000008bsEAAQ\",\"id\":1},{\"name\":\"action.value\",\"val\":\"\",\"id\":5},{\"name\":\"PageControl.\",\"val\":\"\",\"id\":7},{\"name\":\"PageControl.TotalPages\",\"val\":\"\",\"id\":8}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}}],"channelname":"type","displayLabel":"type:baseinputvaluechange","element":"action","eventLabel":"pubsub","eventname":"baseinputvaluechange","eventtype":"pubsub","key":"event-3","recordIndex":"0","showSpinner":"true"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1685046270467-x1y3m11v4","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1694809354072","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"resultVar\":\"[\\\"Products\\\"]\",\"ipMethod\":\"val_GetCustomerProducts\",\"vlocityAsync\":false,\"inputMap\":{\"CurrentPage\":\"1\",\"RecordId\":\"{recordId}\",\"Initial\":\"YES\"},\"jsonMap\":\"{\\\"recordId\\\":\\\"{recordId}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"id\":1,\"name\":\"recordId\",\"val\":\"a1c78000000OxXrAAK\"}]}","openUrlIn":"Current Window","responseNode":"Products","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":true,"isOpen":false,"key":"1688649144285-k59og9p71","label":"valChildReviewCustomer Refresh Data","stateAction":{"displayName":"Action","eventName":"valChildReviewCustomer","id":"flex-action-1690839534866","message":"refresh","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"}}],"channelname":"updatedata","displayLabel":"updatedata:refreshdata","element":"action","eventLabel":"pubsub","eventname":"refreshdata","eventtype":"pubsub","key":"event-4","recordIndex":"0","showSpinner":"false"}],"isFlex":true,"lwc":{"DeveloperName":"cfValProductTableView_5_Telefonica","Id":"0Rb8D000001UXhlSAG","ManageableState":"unmanaged","MasterLabel":"cfValProductTableView_5_Telefonica","NamespacePrefix":"c"},"selectableMode":"Multi","states":[{"actions":[],"blankCardState":false,"childCards":["valProductSummaryTitle","valProductsData","valDataPagination"],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"customLwc","elementLabel":"Custom LWC-0","name":"Custom LWC","property":{"customlwcname":"subscribedProductsUpdate"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-1","name":"FlexCard","property":{"cardName":"valProductSummaryTitle","cardNode":"","data-conditions":{"group":[{"field":"Products[1].ErrorType","hasMergeField":false,"id":"state-new-condition-10","operator":"==","type":"custom","value":"undefined"}],"id":"state-condition-object","isParent":true},"isChildCardTrackingEnabled":false,"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false,"large":"12","medium":"12","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_left ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"max-width:100%;\nmargin:0;\npadding:0;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false,"large":"12","medium":"12","small":"12"},"sizeClass":"slds-size_12-of-12 ","style":"      \n         max-width:100%;\nmargin:0;\npadding:0;","text":{"align":"left","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_left ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"max-width:100%;\nmargin:0;\npadding:0;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false,"large":"12","medium":"12","small":"12"},"sizeClass":"slds-size_12-of-12 ","style":"      \n         max-width:100%;\nmargin:0;\npadding:0;","text":{"align":"left","color":""}}}],"type":"element"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-2","name":"FlexCard","property":{"cardName":"valProductsData","cardNode":"{record.Products}","isChildCardTrackingEnabled":false,"parentAttribute":{"view":"list"},"recordId":"{recordId}","selectedState":"ListView"},"size":{"default":"12","isResponsive":false,"large":"12","medium":"12","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_left ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"max-width:100%;\nmargin:0;\npadding:0;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false,"large":"12","medium":"12","small":"12"},"sizeClass":"slds-size_12-of-12 ","style":"      \n         max-width:100%;\nmargin:0;\npadding:0;","text":{"align":"left","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_left ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"max-width:100%;\nmargin:0;\npadding:0;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false,"large":"12","medium":"12","small":"12"},"sizeClass":"slds-size_12-of-12 ","style":"      \n         max-width:100%;\nmargin:0;\npadding:0;","text":{"align":"left","color":""}}}],"type":"element"},{"children":[],"class":"slds-col ","element":"block","elementLabel":"Block-3","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"max-width:100%;\nmargin:0;\npadding:0;","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         max-width:100%;\nmargin:0;\npadding:0;","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"max-width:100%;\nmargin:0;\npadding:0;","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         max-width:100%;\nmargin:0;\npadding:0;","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-4","name":"FlexCard","property":{"cardName":"valDataPagination","cardNode":"","isChildCardTrackingEnabled":false,"parentAttribute":{"currentPage":"{PageControl.CurrentPage}","state":"{PageControl.State}","totalPages":"{PageControl.TotalPages}"},"recordId":"{recordId}","selectedState":"SinglePage"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"max-width:100%;\nmargin:0;\npadding:0;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         max-width:100%;\nmargin:0;\npadding:0;","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"max-width:100%;\nmargin:0;\npadding:0;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         max-width:100%;\nmargin:0;\npadding:0;","text":{"align":"","color":""}}}],"type":"element"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-scrollable_x","container":{"class":"slds-card"},"customClass":"slds-scrollable_x","elementStyleProperties":{},"inlineStyle":"max-width: 100%;\noverflow-x: visible;\noverflow-y:hidden;","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         max-width: 100%;\noverflow-x: visible;\noverflow-y:hidden;","text":{"align":"","color":""}}}],"theme":"slds","title":"valProductTableView","Name":"valProductTableView","uniqueKey":"valProductTableView_undefined_undefined","Id":"a5W78000000L0DzEAK","vlocity_cmt__GlobalKey__c":"valProductTableView/Telefonica/5/1690839535126","vlocity_cmt__IsChildCard__c":true};
  export default definition