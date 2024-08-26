let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":false,"name":""},"type":"DataRaptor","value":{"bundle":"valGetOrderItemParentDetailsMaster","bundleType":"","dsDelay":"","inputMap":{"OrderId":"{recordId}"},"jsonMap":"{\"recordId\":\"{recordId}\"}","resultVar":""}},"dynamicCanvasWidth":{"type":"desktop"},"enableLwc":true,"isFlex":true,"isRepeatable":true,"lwc":{"DeveloperName":"cfValReviewItems_6_Telefonica_Brasil_Valentina","Id":"0Rb760000004xYGCAY","ManageableState":"unmanaged","MasterLabel":"cfValReviewItems_6_Telefonica_Brasil_Valentina","NamespacePrefix":"c"},"states":[{"actions":[],"childCards":["valReviewItemsChild"],"components":{"layer-0":{"children":[{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Block-0-Block-1-Description-1-clone-0","key":"element_element_element_block_0_0_block_0_0_outputField_0_0","name":"Description","parentElementKey":"element_element_block_0_0_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"action","hasMergeField":false,"id":"state-new-condition-62","operator":"!=","type":"custom","value":""},{"field":"Parent.functionality","hasMergeField":false,"id":"state-new-condition-0","logicalOperator":"&&","operator":"==","type":"custom","value":"Promotion"}],"id":"state-condition-object","isParent":true},"fieldName":"action","label":"","mask":"#,##0.###","placeholder":"","record":"{record}","styles":{"label":{"color":"#000000","textAlign":""},"value":{"color":"#165F2F","fontSize":"12px; font-weight:bold;","textAlign":"center","textDecoration":"bold"}},"type":"text"},"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"#D4FAD7","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"23px","style":"","type":"","width":""},"class":"slds-p-horizontal_x-small slds-p-vertical_xxx-small ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000","textAlign":""},"value":{"color":"#165F2F","fontSize":"12px; font-weight:bold;","textAlign":"center","textDecoration":"bold"}}},"inlineStyle":"width:max-content;","margin":[],"padding":[{"label":"horizontal:x-small","size":"x-small","type":"horizontal"},{"label":"vertical:xxx-small","size":"xxx-small","type":"vertical"}],"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_6-of-12 ","style":"background-color:#D4FAD7;      \n    border-radius:23px;     width:max-content;","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"isSetForDesignTime":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#000000","textDecoration":"bold"}}},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_6-of-12 ","style":"      \n         ","text":{"align":"","color":""}}},{"conditionString":"action == Add || action == Novo","conditions":{"group":[{"field":"action","hasMergeField":false,"id":"state-new-condition-2","operator":"==","type":"custom","value":"Add"},{"field":"action","hasMergeField":false,"id":"state-new-condition-0","logicalOperator":"||","operator":"==","type":"custom","value":"Novo"}],"id":"state-condition-object","isParent":true},"draggable":true,"isSetForDesignTime":true,"isopen":true,"key":1,"label":"Add","name":"Add","styleObject":{"background":{"color":"#D4FAD7","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"23px","style":"","type":"","width":""},"class":"slds-p-horizontal_x-small slds-p-vertical_xxx-small ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000","textAlign":""},"value":{"color":"#165F2F","fontSize":"12px; font-weight:bold;","textAlign":"center","textDecoration":"bold"}}},"inlineStyle":"width:max-content;","margin":[],"padding":[{"label":"horizontal:x-small","size":"x-small","type":"horizontal"},{"label":"vertical:xxx-small","size":"xxx-small","type":"vertical"}],"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_6-of-12 ","style":"background-color:#D4FAD7;      \n    border-radius:23px;     width:max-content;","text":{"align":"","color":""}}},{"conditionString":"action == Change || action == Alterar","conditions":{"group":[{"field":"action","hasMergeField":false,"id":"state-new-condition-20","operator":"==","type":"custom","value":"Change"},{"field":"action","hasMergeField":false,"id":"state-new-condition-13","logicalOperator":"||","operator":"==","type":"custom","value":"Alterar"}],"id":"state-condition-object","isParent":true},"draggable":true,"isSetForDesignTime":false,"isopen":true,"key":2,"label":"Change","name":"Change","styleObject":{"background":{"color":"#FACA9B","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"23px","style":"","type":"","width":""},"class":"slds-p-horizontal_x-small slds-p-vertical_xxx-small ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#080707","fontSize":"12px; font-weight:bold;","textAlign":"center","textDecoration":"bold"}}},"inlineStyle":"width:max-content;","margin":[],"padding":[{"label":"horizontal:x-small","size":"x-small","type":"horizontal"},{"label":"vertical:xxx-small","size":"xxx-small","type":"vertical"}],"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_6-of-12 ","style":"background-color:#FACA9B;      \n    border-radius:23px;     width:max-content;","text":{"align":"","color":""}}},{"conditionString":"action == Disconnect || action == Desconectado","conditions":{"group":[{"field":"action","hasMergeField":false,"id":"state-new-condition-27","operator":"==","type":"custom","value":"Disconnect"},{"field":"action","hasMergeField":false,"id":"state-new-condition-26","logicalOperator":"||","operator":"==","type":"custom","value":"Desconectado"}],"id":"state-condition-object","isParent":true},"draggable":true,"isSetForDesignTime":false,"isopen":true,"key":3,"label":"Disconnect","name":"Disconnect","styleObject":{"background":{"color":"#FEF1EE","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"23px","style":"","type":"","width":""},"class":"slds-p-horizontal_x-small slds-p-vertical_xxx-small ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#8E030F","fontSize":"12px; font-weight:bold;","textAlign":"right","textDecoration":"bold"}}},"inlineStyle":"width:max-content;","margin":[],"padding":[{"label":"horizontal:x-small","size":"x-small","type":"horizontal"},{"label":"vertical:xxx-small","size":"xxx-small","type":"vertical"}],"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_6-of-12 ","style":"background-color:#FEF1EE;      \n    border-radius:23px;     width:max-content;","text":{"align":"","color":""}}},{"conditionString":"action == Existing || action == Atual","conditions":{"group":[{"field":"action","hasMergeField":false,"id":"state-new-condition-55","operator":"==","type":"custom","value":"Existing"},{"field":"action","hasMergeField":false,"id":"state-new-condition-39","logicalOperator":"||","operator":"==","type":"custom","value":"Atual"}],"id":"state-condition-object","isParent":true},"draggable":true,"isSetForDesignTime":false,"isopen":true,"key":4,"label":"Existing","name":"Existing","styleObject":{"background":{"color":"#E7ECF3","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"23px","style":"","type":"","width":""},"class":"slds-p-horizontal_x-small slds-p-vertical_xxx-small ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#0176D3","fontSize":"12px; font-weight:bold;","textAlign":"center","textDecoration":"bold"}}},"inlineStyle":"width:max-content;","margin":[],"padding":[{"label":"horizontal:x-small","size":"x-small","type":"horizontal"},{"label":"vertical:xxx-small","size":"xxx-small","type":"vertical"}],"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_6-of-12 ","style":"background-color:#E7ECF3;      \n    border-radius:23px;     width:max-content;","text":{"align":"","color":""}}}],"type":"field"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-0-Block-1-Description-0-clone-0","key":"element_element_element_block_0_0_block_0_0_outputField_1_0","name":"Description","parentElementKey":"element_element_block_0_0_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"subAction","hasMergeField":false,"id":"state-new-condition-62","operator":"!=","type":"custom","value":""},{"field":"Parent.functionality","hasMergeField":false,"id":"state-new-condition-0","logicalOperator":"&&","operator":"==","type":"custom","value":"Promotion"}],"id":"state-condition-object","isParent":true},"fieldName":"subAction","label":"","mask":"#,##0.###","placeholder":"","record":"{record}","styles":{"label":{"color":"#000000"},"value":{"color":"#080707","fontSize":"12px; font-weight:bold;","textAlign":"center","textDecoration":"bold"}},"type":"text"},"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"#ECEBEA","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"23px","style":"","type":"","width":""},"class":"slds-p-horizontal_x-small slds-p-vertical_xxx-small ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#080707","fontSize":"12px; font-weight:bold;","textAlign":"center","textDecoration":"bold"}}},"inlineStyle":"width:max-content;","margin":[],"padding":[{"label":"horizontal:x-small","size":"x-small","type":"horizontal"},{"label":"vertical:xxx-small","size":"xxx-small","type":"vertical"}],"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_6-of-12 ","style":"background-color:#ECEBEA;      \n    border-radius:23px;     width:max-content;","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"isSetForDesignTime":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#000000","textDecoration":"bold"}}},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_6-of-12 ","style":"      \n         ","text":{"align":"","color":""}}},{"conditionString":"subAction == Move || subAction == Movido","conditions":{"group":[{"field":"subAction","hasMergeField":false,"id":"state-new-condition-2","operator":"==","type":"custom","value":"Move"},{"field":"subAction","hasMergeField":false,"id":"state-new-condition-0","logicalOperator":"||","operator":"==","type":"custom","value":"Movido"}],"id":"state-condition-object","isParent":true},"draggable":true,"isSetForDesignTime":false,"isopen":true,"key":1,"label":"Move","name":"Move","styleObject":{"background":{"color":"#ECEBEA","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"23px","style":"","type":"","width":""},"class":"slds-p-horizontal_x-small slds-p-vertical_xxx-small ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000","textAlign":""},"value":{"color":"#297544","fontSize":"12px; font-weight:bold;","textAlign":"center","textDecoration":"bold"}}},"inlineStyle":"width:max-content;","margin":[],"padding":[{"label":"horizontal:x-small","size":"x-small","type":"horizontal"},{"label":"vertical:xxx-small","size":"xxx-small","type":"vertical"}],"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_6-of-12 ","style":"background-color:#ECEBEA;      \n    border-radius:23px;     width:max-content;","text":{"align":"","color":""}}},{"conditionString":"subAction == Replace || subAction == Substituído","conditions":{"group":[{"field":"subAction","hasMergeField":false,"id":"state-new-condition-20","operator":"==","type":"custom","value":"Replace"},{"field":"subAction","hasMergeField":false,"id":"state-new-condition-13","logicalOperator":"||","operator":"==","type":"custom","value":"Substituído"}],"id":"state-condition-object","isParent":true},"draggable":true,"isSetForDesignTime":true,"isopen":true,"key":2,"label":"Replace","name":"Replace","styleObject":{"background":{"color":"#ECEBEA","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"23px","style":"","type":"","width":""},"class":"slds-p-horizontal_x-small slds-p-vertical_xxx-small ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#080707","fontSize":"12px; font-weight:bold;","textAlign":"center","textDecoration":"bold"}}},"inlineStyle":"width:max-content;","margin":[],"padding":[{"label":"horizontal:x-small","size":"x-small","type":"horizontal"},{"label":"vertical:xxx-small","size":"xxx-small","type":"vertical"}],"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_6-of-12 ","style":"background-color:#ECEBEA;      \n    border-radius:23px;     width:max-content;","text":{"align":"","color":""}}},{"conditionString":"subAction == Cancel || subAction == Cancelado","conditions":{"group":[{"field":"subAction","hasMergeField":false,"id":"state-new-condition-27","operator":"==","type":"custom","value":"Cancel"},{"field":"subAction","hasMergeField":false,"id":"state-new-condition-26","logicalOperator":"||","operator":"==","type":"custom","value":"Cancelado"}],"id":"state-condition-object","isParent":true},"draggable":true,"isSetForDesignTime":false,"isopen":true,"key":3,"label":"Cancel","name":"Cancel","styleObject":{"background":{"color":"#ECEBEA","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"23px","style":"","type":"","width":""},"class":"slds-p-horizontal_x-small slds-p-vertical_xxx-small ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#8E030F","fontSize":"12px; font-weight:bold;","textAlign":"center","textDecoration":"bold"}}},"inlineStyle":"width:max-content;","margin":[],"padding":[{"label":"horizontal:x-small","size":"x-small","type":"horizontal"},{"label":"vertical:xxx-small","size":"xxx-small","type":"vertical"}],"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_6-of-12 ","style":"background-color:#ECEBEA;      \n    border-radius:23px;     width:max-content;","text":{"align":"","color":""}}},{"conditionString":"subAction == Reassign || subAction == Reatribuído","conditions":{"group":[{"field":"subAction","hasMergeField":false,"id":"state-new-condition-55","operator":"==","type":"custom","value":"Reassign"},{"field":"subAction","hasMergeField":false,"id":"state-new-condition-39","logicalOperator":"||","operator":"==","type":"custom","value":"Reatribuído"}],"id":"state-condition-object","isParent":true},"draggable":true,"isSetForDesignTime":false,"isopen":true,"key":4,"label":"Reassign","name":"Reassign","styleObject":{"background":{"color":"#ECEBEA","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"23px","style":"","type":"","width":""},"class":"slds-p-horizontal_x-small slds-p-vertical_xxx-small ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#0176D3","fontSize":"12px; font-weight:bold;","textAlign":"center","textDecoration":"bold"}}},"inlineStyle":"width:max-content;","margin":[],"padding":[{"label":"horizontal:x-small","size":"x-small","type":"horizontal"},{"label":"vertical:xxx-small","size":"xxx-small","type":"vertical"}],"size":{"default":"6","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_6-of-12 ","style":"background-color:#ECEBEA;      \n    border-radius:23px;     width:max-content;","text":{"align":"","color":""}}}],"type":"field"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-0-Block-0-Name-0","key":"element_element_element_block_0_0_block_0_0_outputField_2_0","name":"Name","parentElementKey":"element_element_block_0_0_block_0_0","property":{"card":"{card}","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"fieldName":"productName","label":"","placeholder":"","record":"{record}","styles":{"label":{"color":"#000000"},"value":{"color":"#000000","fontSize":"20px; font-weight:bold;"}},"type":"text"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#000000","fontSize":"20px; font-weight:bold;"}}},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"center","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center ","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#000000","fontSize":"20px; font-weight:bold;"}}},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"center","color":""}}}],"type":"field"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-0-Block-0-Description-1","key":"element_element_element_block_0_0_block_0_0_outputField_3_0","name":"Description","parentElementKey":"element_element_block_0_0_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"1","hasMergeField":false,"id":"state-new-condition-0","operator":"==","type":"custom","value":"2"}],"id":"state-condition-object","isParent":true},"fieldName":"description","label":"Descrição","mask":"#,##0.###","placeholder":"","record":"{record}","styles":{"label":{"color":"#000000"},"value":{"color":"#000000","textDecoration":"bold"}},"type":"text"},"size":{"default":"12","isResponsive":false,"large":"6","medium":"6","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#000000","textDecoration":"bold"}}},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#000000","textDecoration":"bold"}}},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"field"},{"children":[],"class":"slds-col ","element":"block","elementLabel":"Block-0-Block-0-Block-2","key":"element_element_element_block_0_0_block_0_0_block_4_0","name":"Block","parentElementKey":"element_element_block_0_0_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-around_x-small","padding":[{"size":"x-small","type":"around"}],"sizeClass":"slds-size_12-of-12"},"type":"block"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-0-Block-0-Description-3","key":"element_element_element_block_0_0_block_0_0_outputField_5_0","name":"Description","parentElementKey":"element_element_block_0_0_block_0_0","property":{"card":"{card}","currency":"BRL","data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"fieldName":"totalPrice","label":"Valor","locale":"pt-BR","placeholder":"","record":"{record}","styles":{"label":{"color":"#000000"},"value":{"color":"#000000","textDecoration":"bold"}},"type":"currency"},"size":{"default":"4","isResponsive":false,"large":"6","medium":"6","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#000000","textDecoration":"bold"}}},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_4-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"styles":{"label":{"color":"#000000"},"value":{"color":"#000000","textDecoration":"bold"}}},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":false,"large":"6","medium":"6","small":"12"},"sizeClass":"slds-size_4-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"field"}],"class":"slds-col ","element":"block","elementLabel":"Block-0-Block-1","key":"element_element_block_0_0_block_0_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"data-conditions":{"group":[],"id":"state-condition-object","isParent":true},"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false,"large":"12","medium":"12","small":"12"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false,"large":"12","medium":"12","small":"12"},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false,"large":"12","medium":"12","small":"12"},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"type":"block"}],"class":"slds-col ","element":"block","elementLabel":"Block-0","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}}}],"type":"block"},{"class":"slds-col ","element":"childCardPreview","elementLabel":"FlexCard-1","name":"FlexCard","property":{"cardName":"valReviewItemsChild","cardNode":"","isChildCardTrackingEnabled":false,"parentAttribute":{"OrderId":"{recordId}","assetReferenceId":"{assetReferenceId}","functionality":"{Parent.functionality}"},"recordId":"{recordId}","selectedState":"Active"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"1","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:1;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"1","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:1;     ","text":{"align":"","color":""}}}],"type":"element"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"height":"","inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"2","medium":"2","small":"12"},"sizeClass":"slds-large-size_2-of-12 slds-medium-size_2-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valReviewItems","Name":"valReviewItems","uniqueKey":"valReviewItems_undefined_undefined","Id":"a5W78000000L0e7EAC","vlocity_cmt__GlobalKey__c":"valReviewItems/Telefonica_Brasil_Valentina/6/1699301476903","vlocity_cmt__IsChildCard__c":true};
  export default definition