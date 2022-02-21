let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":false,"name":""},"type":"Custom","value":{"body":" [\n\t\t{\n\t\t\t\"actions\": {},\n\t\t\t\"Description\": \"$500\",\n\t\t\t\"DetailType\": \"PRICE\",\n\t\t\t\"StartValue\": 500,\n\t\t\t\"EndValue\": 500,\n\t\t\t\"AdjustmentType\": \"None\",\n\t\t\t\"AdjustmentMethod\": null,\n\t\t\t\"AdjustmentValue\": 0\n\t\t},\n\t\t{\n\t\t\t\"actions\": {},\n\t\t\t\"Description\": \"Test Discount 1\",\n\t\t\t\"DetailType\": \"ADJUSTMENT\",\n\t\t\t\"StartValue\": 500,\n\t\t\t\"EndValue\": 475,\n\t\t\t\"AdjustmentType\": \"Discount\",\n\t\t\t\"AdjustmentMethod\": \"Percent\",\n\t\t\t\"AdjustmentValue\": -5\n\t\t},\n\t\t{\n\t\t\t\"actions\": {\n\t\t\t\t\"deleteAdjustment\": {\n\t\t\t\t\t\"rest\": {\n\t\t\t\t\t\t\"params\": {},\n\t\t\t\t\t\t\"method\": null,\n\t\t\t\t\t\t\"link\": null\n\t\t\t\t\t},\n\t\t\t\t\t\"remote\": {\n\t\t\t\t\t\t\"params\": {\n\t\t\t\t\t\t\t\"cartId\": \"8014W000001zKCBQA2\",\n\t\t\t\t\t\t\t\"id\": \"8024W000007zAFZQA2\",\n\t\t\t\t\t\t\t\"adjustmentId\": \"a2v4W0000022HygQAE\",\n\t\t\t\t\t\t\t\"deleteAdjustment\": true,\n\t\t\t\t\t\t\t\"methodName\": \"deleteAdjustment\"\n\t\t\t\t\t\t}\n\t\t\t\t\t},\n\t\t\t\t\t\"client\": {\n\t\t\t\t\t\t\"records\": [],\n\t\t\t\t\t\t\"params\": {}\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t\t},\n\t\t\t\"AppliedBy\": \"Pareek Pareek\",\n\t\t\t\"DateApplied\": \"2021-01-21T06:40:32.000Z\",\n\t\t\t\"Description\": \"Discount applied by Pareek Pareek\",\n\t\t\t\"DetailType\": \"ADJUSTMENT\",\n\t\t\t\"StartValue\": 475,\n\t\t\t\"EndValue\": 437,\n\t\t\t\"AdjustmentType\": \"Discount\",\n\t\t\t\"AdjustmentMethod\": \"Percent\",\n\t\t\t\"AdjustmentValue\": -8\n\t\t},\n\t\t{\n\t\t\t\"actions\": {\n\t\t\t\t\"deleteAdjustment\": {\n\t\t\t\t\t\"rest\": {\n\t\t\t\t\t\t\"params\": {},\n\t\t\t\t\t\t\"method\": null,\n\t\t\t\t\t\t\"link\": null\n\t\t\t\t\t},\n\t\t\t\t\t\"remote\": {\n\t\t\t\t\t\t\"params\": {\n\t\t\t\t\t\t\t\"cartId\": \"8014W000001zKCBQA2\",\n\t\t\t\t\t\t\t\"id\": \"8024W000007zAFZQA2\",\n\t\t\t\t\t\t\t\"adjustmentId\": \"a2v4W0000022I11QAE\",\n\t\t\t\t\t\t\t\"deleteAdjustment\": true,\n\t\t\t\t\t\t\t\"methodName\": \"deleteAdjustment\"\n\t\t\t\t\t\t}\n\t\t\t\t\t},\n\t\t\t\t\t\"client\": {\n\t\t\t\t\t\t\"records\": [],\n\t\t\t\t\t\t\"params\": {}\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t\t},\n\t\t\t\"AppliedBy\": \"Pareek Pareek\",\n\t\t\t\"DateApplied\": \"2021-01-22T04:58:46.000Z\",\n\t\t\t\"Description\": \"Discount applied by Pareek Pareek\",\n\t\t\t\"DetailType\": \"ADJUSTMENT\",\n\t\t\t\"StartValue\": 437,\n\t\t\t\"EndValue\": 425,\n\t\t\t\"AdjustmentType\": \"Discount\",\n\t\t\t\"AdjustmentMethod\": \"Absolute\",\n\t\t\t\"AdjustmentValue\": -12\n\t\t},\n{\"actions\":{},\"Description\":\"[Recurring Calculated Price (88.00) + Rollup Recurring Total (0.00)] x Quantity (1.00)\",\"DetailType\":null,\"StartValue\":null,\"EndValue\":null,\"AdjustmentType\":null,\"AdjustmentMethod\":null,\"AdjustmentValue\":null}\n\t]","dsDelay":0,"resultVar":""}},"enableLwc":true,"events":[],"globalCSS":false,"isFlex":true,"isRepeatable":true,"lwc":{"DeveloperName":"cfCpqPriceAdjustmentList_11_Vlocity","Id":"0Rb5g000000RBlJCAW","ManageableState":"unmanaged","MasterLabel":"cfCpqPriceAdjustmentList_11_Vlocity","NamespacePrefix":"vlocity_cmt"},"multilanguageSupport":true,"sessionVars":[{"name":"x","val":"initialX"}],"states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"AdjustmentDescriptionText","key":"element_element_block_0_0_outputField_0_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"DetailType","id":"state-new-condition-0","operator":"!=","type":"custom","value":"PRICE"}],"id":"state-condition-object","isParent":true},"mergeField":"%3Cdiv%20class=%22slds-text-heading_small%22%3E%3Cspan%20style=%22font-size:%2012pt;%22%3E%7BDescription%7D%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"4","isResponsive":true,"large":"8","medium":"7","small":"5"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"customClass":"","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":true,"large":"8","medium":"7","small":"5"},"sizeClass":"slds-large-size_8-of-12 slds-medium-size_7-of-12 slds-small-size_5-of-12 slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n        color:#000000; ","text":{"align":"","color":"#000000"}},"type":"text","userUpdatedElementLabel":true},{"class":"slds-col ","element":"outputField","elementLabel":"BasePriceText","key":"element_element_block_0_0_outputField_1_0","name":"Text","parentElementKey":"element_block_0_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"DetailType","id":"state-new-condition-0","operator":"==","type":"custom","value":"PRICE"}],"id":"state-condition-object","isParent":true},"mergeField":"%3Cdiv%20class=%22slds-text-heading_small%22%3E%3Cspan%20style=%22font-size:%2012pt;%22%3E%7BLabel.CPQBasePrice%7D%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"4","isResponsive":true,"large":"8","medium":"7","small":"5"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"customClass":"","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":true,"large":"8","medium":"7","small":"5"},"sizeClass":"slds-large-size_8-of-12 slds-medium-size_7-of-12 slds-small-size_5-of-12 slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n        color:#000000; ","text":{"align":"","color":"#000000"}},"type":"text","userUpdatedElementLabel":true},{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"LeftParenthesisText","key":"element_element_element_block_0_0_block_2_0_outputField_0_0","name":"Text","parentElementKey":"element_element_block_0_0_block_2_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"DetailType","id":"state-new-condition-49","operator":"!=","type":"custom","value":"PRICE"}],"id":"state-condition-object","isParent":true},"mergeField":"%3Cdiv%3E%3Cspan%20style=%22color:%20#979797;%20font-size:%208pt;%22%3E(%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"4","isResponsive":false,"large":"2","medium":"2","small":"3"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center slds-col_bump-left cpq__text-width_auto","container":{"class":"slds-col_bump-left"},"customClass":"cpq__text-width_auto","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":false,"large":"2","medium":"2","small":"3"},"sizeClass":"slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n        color:#000000; ","text":{"align":"center","color":"#000000"}},"type":"text","userUpdatedElementLabel":true},{"class":"slds-col ","element":"outputField","elementLabel":"AdjustmentPriceBlock-Text-0-clone-0","key":"element_element_element_block_0_0_block_2_0_outputField_1_0","name":"Text","parentElementKey":"element_element_block_0_0_block_2_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"DetailType","id":"state-new-condition-49","operator":"!=","type":"custom","value":"PRICE"},{"field":"AdjustmentValue","id":"state-new-condition-45","logicalOperator":"&&","operator":">","type":"custom","value":"0"}],"id":"state-condition-object","isParent":true},"mergeField":"%3Cdiv%3E%3Cspan%20style=%22color:%20#979797;%20font-size:%208pt;%22%3E+%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"4","isResponsive":false,"large":"2","medium":"2","small":"3"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center cpq__text-width_auto","container":{"class":""},"customClass":"cpq__text-width_auto","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":false,"large":"2","medium":"2","small":"3"},"sizeClass":"slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n        color:#000000; ","text":{"align":"center","color":"#000000"}},"type":"text","userUpdatedElementLabel":true},{"class":"slds-col ","element":"outputField","elementLabel":"PercentAdjustmentAmount","key":"element_element_element_block_0_0_block_2_0_outputField_2_0","name":"Text","parentElementKey":"element_element_block_0_0_block_2_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"AdjustmentMethod","id":"state-new-condition-49","operator":"==","type":"custom","value":"Percent"}],"id":"state-condition-object","isParent":true},"mergeField":"%3Cdiv%3E%3Cspan%20style=%22color:%20#979797;%20font-size:%208pt;%22%3E%7BAdjustmentValue%7D%25%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"4","isResponsive":false,"large":"2","medium":"2","small":"3"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center cpq__text-width_auto","container":{"class":""},"customClass":"cpq__text-width_auto","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":false,"large":"2","medium":"2","small":"3"},"sizeClass":"slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n        color:#000000; ","text":{"align":"center","color":"#000000"}},"type":"text","userUpdatedElementLabel":true},{"class":"slds-col ","element":"outputField","elementLabel":"AbsoluteAdjustmentAmount","key":"element_element_element_block_0_0_block_2_0_outputField_3_0","name":"Field","parentElementKey":"element_element_block_0_0_block_2_0","property":{"card":"{card}","currency":"","data-conditions":{"group":[{"field":"AdjustmentMethod","id":"state-new-condition-30","operator":"==","type":"custom","value":"Absolute"}],"id":"state-condition-object","isParent":true},"fieldName":"AdjustmentValue","locale":"","placeholder":"10","record":"{record}","styles":{"value":{"color":"#979797","fontSize":"12px","textAlign":"right"}},"type":"currency"},"size":{"default":"4","isResponsive":false,"large":"2","medium":"2","small":"3"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center cpq__text-width_auto","container":{"class":""},"customClass":"cpq__text-width_auto","elementStyleProperties":{"styles":{"value":{"color":"#979797","fontSize":"12px","textAlign":"right"}}},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":false,"large":"2","medium":"2","small":"3"},"sizeClass":"slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"center","color":""}},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"outputField","elementLabel":"RightParenthesisText","key":"element_element_element_block_0_0_block_2_0_outputField_4_0","name":"Text","parentElementKey":"element_element_block_0_0_block_2_0","property":{"card":"{card}","data-conditions":{"group":[{"field":"DetailType","id":"state-new-condition-49","operator":"!=","type":"custom","value":"PRICE"}],"id":"state-condition-object","isParent":true},"mergeField":"%3Cdiv%3E%3Cspan%20style=%22color:%20#979797;%20font-size:%208pt;%22%3E)%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"4","isResponsive":false,"large":"2","medium":"2","small":"3"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center cpq__text-width_auto","container":{"class":""},"customClass":"cpq__text-width_auto","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"4","isResponsive":false,"large":"2","medium":"2","small":"3"},"sizeClass":"slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n        color:#000000; ","text":{"align":"center","color":"#000000"}},"type":"text","userUpdatedElementLabel":true},{"class":"slds-col ","element":"outputField","elementLabel":"AdjustmentEndValue","key":"element_element_element_block_0_0_block_2_0_outputField_5_0","name":"Field","parentElementKey":"element_element_block_0_0_block_2_0","property":{"card":"{card}","currency":"","data-conditions":{"group":[{"field":"DetailType","id":"state-new-condition-28","operator":"!=","type":"custom","value":"PRICE"}],"id":"state-condition-object","isParent":true},"fieldName":"EndValue","locale":"","placeholder":"output","record":"{record}","type":"currency"},"size":{"default":4,"isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-p-left_small slds-size_none slds-text-heading_small cpq__text-width_auto","container":{"class":""},"customClass":"slds-size_none slds-text-heading_small cpq__text-width_auto","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:small","size":"small","type":"left"}],"size":{"default":4,"isResponsive":false},"sizeClass":"slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"outputField","elementLabel":"AdjustmentPriceBlock-Field-2-clone-0","key":"element_element_element_block_0_0_block_2_0_outputField_6_0","name":"Field","parentElementKey":"element_element_block_0_0_block_2_0","property":{"card":"{card}","currency":"","data-conditions":{"group":[{"field":"DetailType","id":"state-new-condition-19","operator":"==","type":"custom","value":"PRICE"}],"id":"state-condition-object","isParent":true},"fieldName":"EndValue","locale":"","placeholder":"output","record":"{record}","type":"currency"},"size":{"default":4,"isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-col_bump-left slds-p-left_small slds-text-heading_small cpq__text-width_auto","container":{"class":"slds-col_bump-left"},"customClass":"slds-text-heading_small cpq__text-width_auto","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"left:small","size":"small","type":"left"}],"size":{"default":4,"isResponsive":false},"sizeClass":"slds-size_4-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"element","userUpdatedElementLabel":true}],"class":"slds-col ","element":"block","elementLabel":"AdjustmentPriceBlock","key":"element_element_block_0_0_block_2_0","name":"Block","parentElementKey":"element_block_0_0","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"7","isResponsive":true,"large":"3","medium":"4","small":"6"},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right slds-grid_align-end","container":{"class":""},"customClass":"slds-grid_align-end","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"7","isResponsive":true,"large":"3","medium":"4","small":"6"},"sizeClass":"slds-large-size_3-of-12 slds-medium-size_4-of-12 slds-small-size_6-of-12 slds-size_7-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"right","color":""}},"type":"block","userUpdatedElementLabel":true},{"class":"slds-col ","element":"flexIcon","elementLabel":"DeleteAdjustmentIcon","key":"element_element_block_0_0_flexIcon_3_0","name":"Icon","parentElementKey":"element_block_0_0","property":{"action":{"actionData":{"card":"{card}","stateAction":{"bubbles":true,"composed":true,"displayName":"Action","eventName":"cpq_{recordId}","extraParams":{"actionObjName":"deleteAdjustment","cartType":"shoppingCart","input":"{}","methodName":"deletePriceAdjustment","record":"{record}","responseEventName":"cpq_adjustment_delete"},"hasExtraParams":true,"id":"flex-action-1625930139508","message":"cpq_adjustment_delete_click","openUrlIn":"Current Window","subType":"PubSub","type":"Event","vlocityIcon":"standard-default"},"stateObj":"{record}"},"eventType":"onclick","iconName":"standard-default","label":"Action","name":""},"data-conditions":{"group":[{"field":"actions.deleteAdjustment","id":"state-new-condition-62","operator":"!=","type":"custom","value":"undefined"}],"id":"state-condition-object","isParent":true},"extraclass":"slds-icon_container slds-icon__svg--default ","iconName":"utility:delete","iconType":"Salesforce SVG","imgsrc":"","record":"{record}","size":"x-small","variant":"default"},"size":{"default":"1","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_right ","container":{"class":""},"customClass":"","elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"1","isResponsive":false},"sizeClass":"slds-size_1-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"right","color":""}},"type":"element","userUpdatedElementLabel":true}],"class":"slds-col ","element":"block","elementLabel":"Block-0","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":12,"isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#000000","radius":"","style":"","type":[],"width":""},"class":" slds-p-vertical_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"vertical:x-small","size":"x-small","type":"vertical"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"type":"block"}]}},"conditions":{"group":[{"field":"DetailType","id":"state-new-condition-0","operator":"!=","type":"custom","value":"NULL"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Charge","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"AdjustmentDescriptionText","key":"element_element_block_0_1_outputField_0_1","name":"Text","parentElementKey":"element_block_0_1","property":{"card":"{card}","mergeField":"%3Cdiv%3E%3Cspan%20class=%22slds-text-heading_small%22%20style=%22font-size:%2012pt;%20color:%20#000000;%22%3E%7BDescription%7D%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"11","isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"11","isResponsive":false},"sizeClass":"slds-size_11-of-12 ","style":"     : #ccc 1px solid; \n         ","text":{"align":"","color":""}},"type":"text","userUpdatedElementLabel":true}],"class":"slds-col ","element":"block","elementLabel":"Block-0","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":12,"isResponsive":false},"stateIndex":1,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#000000","radius":"","style":"","type":[],"width":""},"class":" slds-p-vertical_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"vertical:x-small","size":"x-small","type":"vertical"}],"size":{"default":12,"isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}},"type":"block"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Total","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"cpqPriceAdjustmentList","Id":"a5W7j000000f2qKEAQ","vlocity_cmt__GlobalKey__c":"cpqPriceAdjustmentList/Vlocity/11/1616736051292"};
  export default definition