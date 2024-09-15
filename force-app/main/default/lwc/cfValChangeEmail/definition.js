let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{"isReverse":"","name":""},"type":"Custom","value":{"body":"{\n  \"MobilePhone\": \"null\",\n  \"ResidentialPhone\": \"null\",\n  \"ComercialPhone\": \"null\",\n  \"MobilePhonePrincipal\": \"false\",\n  \"ResidentialPhonePrincipal\": \"false\",\n  \"ComercialPhonePrincipal\": \"false\",\n  \"MobilePhonePrincipalDisable\": true,\n  \"ResidentialPhonePrincipalDisable\": true,\n  \"ComercialPhonePrincipalDisable\": true,\n  \"Email\": \"\",\n  \"OtherEmail\": \"\",\n  \"options\": [\n    {\n      \"name\": \"\"\n    }\n  ],\n    \"OtherEmailOptions\": [\n    {\n      \"name\": \"\"\n    }\n  ]\n}","dsDelay":"","resultVar":""}},"enableLwc":true,"events":[{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1690314621905-s7kflyv7d","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1695060906448","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"ipMethod\":\"val_getEmailTypeAhead\",\"vlocityAsync\":false,\"inputMap\":{\"EmailInput\":\"{action.value}\"},\"jsonMap\":\"{\\\"action.value\\\":\\\"{action.value}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"action.value\",\"val\":\"\",\"id\":1}]}","openUrlIn":"Current Window","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":false,"isOpen":true,"key":"1690315417378-n0ob7tn1z","label":"Action","stateAction":{"displayName":"Action","elementId":"ContactData","extraParams":{"Email":"{action.value}"},"hasExtraParams":true,"id":"flex-action-1695060916918","openUrlIn":"Current Window","type":"updateOmniScript","vlocityIcon":"standard-default"}}],"channelname":"Email","displayLabel":"Email:basetypeaheadinputchange","element":"action","eventLabel":"pubsub","eventname":"basetypeaheadinputchange","eventtype":"pubsub","key":"event-0","recordIndex":"0","showSpinner":"true"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1678394905998-26q6ddiwj","label":"ActionUpdateOS","stateAction":{"displayName":"Action","elementId":"ContactData","extraParams":{"Email":"{Session.Email}","OtherEmail":"{Session.OtherEmail}"},"hasExtraParams":true,"id":"flex-action-1712956991473","openUrlIn":"Current Window","type":"updateOmniScript","vlocityIcon":"standard-default"}}],"channelname":"omniscript_step","displayLabel":"omniscript_step:data","element":"action","eventLabel":"pubsub","eventname":"data","eventtype":"pubsub","key":"event-1","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1690314702528-2srx7eh2d","label":"Action","stateAction":{"displayName":"Action","elementId":"ContactData","extraParams":{"Email":"{Session.Email}","OtherEmail":"{Session.OtherEmail}"},"hasExtraParams":true,"id":"flex-action-1712957042087","openUrlIn":"Current Window","type":"updateOmniScript","vlocityIcon":"standard-default"}}],"channelname":"omniscript_action","displayLabel":"omniscript_action:data","element":"action","eventLabel":"pubsub","eventname":"data","eventtype":"pubsub","key":"event-2","recordIndex":"0","showSpinner":"false"},{"actionList":[{"actionIndex":0,"card":"{card}","draggable":true,"isOpen":false,"key":"1697477428385-9qjr0kqeb","label":"Action","stateAction":{"Web Page":{"targetName":"/apex"},"displayName":"Action","id":"flex-action-1697479170009","message":"{\"type\":\"IntegrationProcedures\",\"value\":{\"dsDelay\":\"\",\"resultVar\":\"[\\\"options\\\"]\",\"ipMethod\":\"val_getEmailTypeAhead\",\"vlocityAsync\":false,\"inputMap\":{\"EmailInput\":\"{action.value}\"},\"jsonMap\":\"{\\\"action.value\\\":\\\"{action.value}\\\"}\"},\"orderBy\":{\"name\":\"\",\"isReverse\":\"\"},\"contextVariables\":[{\"name\":\"action.value\",\"val\":\"teste\",\"id\":1}]}","openUrlIn":"Current Window","responseNode":"OtherEmailOptions","targetType":"Web Page","type":"DataAction","vlocityIcon":"standard-default"}},{"actionIndex":1,"card":"{card}","draggable":false,"isOpen":true,"key":"1697650963899-l0n22d1g9","label":"UpdateOmniScript","stateAction":{"displayName":"Action","elementId":"ContactData","extraParams":{"OtherEmail":"{action.value}"},"hasExtraParams":true,"id":"flex-action-1697650992898","openUrlIn":"Current Window","type":"updateOmniScript","vlocityIcon":"standard-default"}}],"channelname":"OtherEmail","displayLabel":"OtherEmail:basetypeaheadinputchange","element":"action","eventLabel":"pubsub","eventname":"basetypeaheadinputchange","eventtype":"pubsub","key":"event-3","recordIndex":"0","showSpinner":"true"}],"isFlex":true,"lwc":{"DeveloperName":"cfValChangeEmail_1_GKaiser","Id":"0Rb760000000fUcCAI","ManageableState":"unmanaged","MasterLabel":"cfValChangeEmail_1_GKaiser","NamespacePrefix":"c"},"multilanguageSupport":true,"osSupport":true,"selectableField":"ResidentialPhonePrincipal","selectableMode":"Multi","selectedCardsLabel":"Telefone Residencial","sessionVars":[{"isApi":true,"name":"Email","val":""},{"isApi":true,"name":"OtherEmail","val":""}],"states":[{"actions":[],"blankCardState":false,"childCards":[],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Block-3-Text-0","key":"element_element_block_4_0_outputField_0_0","name":"Text","parentElementKey":"element_block_4_0","property":{"card":"{card}","mergeField":"%3Cdiv%3E%3Cspan%20style=%22font-size:%2010pt;%22%3E%3Cstrong%3EE-mail%20Principal%3C/strong%3E%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"11","isResponsive":false},"stateIndex":0,"styleObject":{"size":{"default":"11","isResponsive":false},"sizeClass":"slds-size_11-of-12 "},"type":"text"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Email","key":"element_element_block_4_0_baseInputElement_1_0","name":"Typeahead","parentElementKey":"element_block_4_0","property":{"action":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1654282847502-wr5wqosf2","label":"Action","stateAction":{"displayName":"Action","elementId":"ContactData","extraParams":{"ComercialPhone":"{Session.ComercialPhone}","ComercialPhonePrincipal":"{Session.ComercialPhonePrincipal}","Email":"{element.value}","MobilePhone":"{Session.MobilePhone}","MobilePhonePrincipal":"{Session.MobilePhonePrincipal}","OtherEmail":"{Session.OtherEmail}","ResidentialPhone":"{Session.ResidentialPhone}","ResidentialPhonePrincipal":"{Session.ResidentialPhonePrincipal}"},"hasExtraParams":true,"id":"flex-action-1697640074066","openUrlIn":"Current Window","type":"updateOmniScript","vlocityIcon":"standard-default"}}],"eventType":"onselect","iconName":"standard-default","label":"Action","showSpinner":"false"},"card":"{card}","propertyObj":{"action":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1654282847502-wr5wqosf2","label":"Action","stateAction":{"displayName":"Action","elementId":"ContactData","extraParams":{"ComercialPhone":"{Session.ComercialPhone}","ComercialPhonePrincipal":"{Session.ComercialPhonePrincipal}","Email":"{element.value}","MobilePhone":"{Session.MobilePhone}","MobilePhonePrincipal":"{Session.MobilePhonePrincipal}","OtherEmail":"{Session.OtherEmail}","ResidentialPhone":"{Session.ResidentialPhone}","ResidentialPhonePrincipal":"{Session.ResidentialPhonePrincipal}"},"hasExtraParams":true,"id":"flex-action-1697640074066","openUrlIn":"Current Window","type":"updateOmniScript","vlocityIcon":"standard-default"}}],"eventType":"onselect","iconName":"standard-default","label":"Action","showSpinner":"false"},"customProperties":[{"id":0,"label":"options","value":"{options}"},{"id":1,"label":"name","value":"Email"}],"fieldBinding":"{Session.Email}","label":" E-mail Principal","type":"typeahead"},"record":"{record}","type":"typeahead"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-right_x-small","margin":[{"size":"xx-small","type":"bottom"}],"padding":[{"size":"small","type":"right"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 "},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"flexIcon","elementLabel":"Block-3-Icon-3","key":"element_element_block_4_0_flexIcon_2_0","name":"Icon","parentElementKey":"element_block_4_0","property":{"card":"{card}","extraclass":"slds-icon_container slds-icon__svg--default ","iconName":"utility:comments","iconType":"Salesforce SVG","imgsrc":"","record":"{record}","size":"medium","variant":"default"},"size":{"default":"2","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#f3f3f3","image":"","position":"","repeat":"","size":""},"border":{"color":"#f3f3f3","radius":"","style":"","type":"border_top","width":"1"},"class":"slds-text-align_center slds-border_top slds-m-top_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:x-small","size":"x-small","type":"top"}],"padding":[],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"background-color:#f3f3f3;     border-top: #f3f3f3 1px solid; \n         ","text":{"align":"center","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#f3f3f3","image":"","position":"","repeat":"","size":""},"border":{"color":"#f3f3f3","radius":"","style":"","type":"border_top","width":"1"},"class":"slds-text-align_center slds-border_top slds-m-top_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:x-small","size":"x-small","type":"top"}],"padding":[],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"background-color:#f3f3f3;     border-top: #f3f3f3 1px solid; \n         ","text":{"align":"center","color":""}}}],"type":"element"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-3-Field-4","key":"element_element_block_4_0_outputField_3_0","name":"Field","parentElementKey":"element_block_4_0","property":{"card":"{card}","fieldName":"","placeholder":"Contato não elegível como principal","record":"{record}","type":"text"},"size":{"default":"10","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#f3f3f3","image":"","position":"","repeat":"","size":""},"border":{"color":"#f3f3f3","radius":"","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"6"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-m-top_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:x-small","size":"x-small","type":"top"}],"padding":[],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"background-color:#f3f3f3;     border-top: #f3f3f3 6px solid;border-right: #f3f3f3 6px solid;border-bottom: #f3f3f3 6px solid;border-left: #f3f3f3 6px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#f3f3f3","image":"","position":"","repeat":"","size":""},"border":{"color":"#f3f3f3","radius":"","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"6"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-m-top_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:x-small","size":"x-small","type":"top"}],"padding":[],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"background-color:#f3f3f3;     border-top: #f3f3f3 6px solid;border-right: #f3f3f3 6px solid;border-bottom: #f3f3f3 6px solid;border-left: #f3f3f3 6px solid; \n         ","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-4","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"3","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_xx-small slds-m-around_xxx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:xxx-small","size":"xxx-small","type":"around"}],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_xx-small slds-m-around_xxx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:xxx-small","size":"xxx-small","type":"around"}],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}}}],"type":"block"},{"children":[{"class":"slds-col ","element":"outputField","elementLabel":"Block-3-Text-0","key":"element_element_block_5_0_outputField_0_0","name":"Text","parentElementKey":"element_block_5_0","property":{"card":"{card}","mergeField":"%3Cdiv%3E%3Cspan%20style=%22font-size:%2010pt;%22%3E%3Cstrong%3EE-mail%20Alternativo%3C/strong%3E%3C/span%3E%3C/div%3E","record":"{record}"},"size":{"default":"11","isResponsive":false},"stateIndex":0,"styleObject":{"size":{"default":"11","isResponsive":false},"sizeClass":"slds-size_11-of-12 "},"type":"text"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Block-4-Typeahead-1-clone-0","key":"element_element_block_5_0_baseInputElement_1_0","name":"Typeahead","parentElementKey":"element_block_5_0","property":{"action":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1654282847502-wr5wqosf2","label":"Action","stateAction":{"displayName":"Action","elementId":"ContactData","extraParams":{"ComercialPhone":"{Session.ComercialPhone}","ComercialPhonePrincipal":"{Session.ComercialPhonePrincipal}","Email":"{Session.Email}","MobilePhone":"{Session.MobilePhone}","MobilePhonePrincipal":"{Session.MobilePhonePrincipal}","OtherEmail":"{element.value}","ResidentialPhone":"{Session.ResidentialPhone}","ResidentialPhonePrincipal":"{Session.ResidentialPhonePrincipal}"},"hasExtraParams":true,"id":"flex-action-1697640806455","openUrlIn":"Current Window","type":"updateOmniScript","vlocityIcon":"standard-default"}}],"eventType":"onselect","iconName":"standard-default","label":"Action","showSpinner":"false"},"card":"{card}","propertyObj":{"action":{"actionList":[{"actionIndex":0,"card":"{card}","draggable":false,"isOpen":true,"key":"1654282847502-wr5wqosf2","label":"Action","stateAction":{"displayName":"Action","elementId":"ContactData","extraParams":{"ComercialPhone":"{Session.ComercialPhone}","ComercialPhonePrincipal":"{Session.ComercialPhonePrincipal}","Email":"{Session.Email}","MobilePhone":"{Session.MobilePhone}","MobilePhonePrincipal":"{Session.MobilePhonePrincipal}","OtherEmail":"{element.value}","ResidentialPhone":"{Session.ResidentialPhone}","ResidentialPhonePrincipal":"{Session.ResidentialPhonePrincipal}"},"hasExtraParams":true,"id":"flex-action-1697640806455","openUrlIn":"Current Window","type":"updateOmniScript","vlocityIcon":"standard-default"}}],"eventType":"onselect","iconName":"standard-default","label":"Action","showSpinner":"false"},"customProperties":[{"id":0,"label":"options","value":"{OtherEmailOptions}"},{"id":1,"label":"name","value":"OtherEmail"}],"fieldBinding":"{Session.OtherEmail}","label":" E-mail Alternativo","type":"typeahead"},"record":"{record}","type":"typeahead"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"class":"slds-p-right_x-small","margin":[{"size":"xx-small","type":"bottom"}],"padding":[{"size":"small","type":"right"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 "},"type":"element","userUpdatedElementLabel":true},{"class":"slds-col ","element":"flexIcon","elementLabel":"Block-3-Icon-3","key":"element_element_block_5_0_flexIcon_2_0","name":"Icon","parentElementKey":"element_block_5_0","property":{"card":"{card}","extraclass":"slds-icon_container slds-icon__svg--default ","iconName":"utility:comments","iconType":"Salesforce SVG","imgsrc":"","record":"{record}","size":"medium","variant":"default"},"size":{"default":"2","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#f3f3f3","image":"","position":"","repeat":"","size":""},"border":{"color":"#f3f3f3","radius":"","style":"","type":"border_top","width":"1"},"class":"slds-text-align_center slds-border_top slds-m-top_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:x-small","size":"x-small","type":"top"}],"padding":[],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"background-color:#f3f3f3;     border-top: #f3f3f3 1px solid; \n         ","text":{"align":"center","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#f3f3f3","image":"","position":"","repeat":"","size":""},"border":{"color":"#f3f3f3","radius":"","style":"","type":"border_top","width":"1"},"class":"slds-text-align_center slds-border_top slds-m-top_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:x-small","size":"x-small","type":"top"}],"padding":[],"size":{"default":"2","isResponsive":false},"sizeClass":"slds-size_2-of-12 ","style":"background-color:#f3f3f3;     border-top: #f3f3f3 1px solid; \n         ","text":{"align":"center","color":""}}}],"type":"element"},{"class":"slds-col ","element":"outputField","elementLabel":"Block-3-Field-4","key":"element_element_block_5_0_outputField_3_0","name":"Field","parentElementKey":"element_block_5_0","property":{"card":"{card}","fieldName":"","placeholder":"Contato não elegível como principal","record":"{record}","type":"text"},"size":{"default":"10","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"#f3f3f3","image":"","position":"","repeat":"","size":""},"border":{"color":"#f3f3f3","radius":"","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"6"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-m-top_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:x-small","size":"x-small","type":"top"}],"padding":[],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"background-color:#f3f3f3;     border-top: #f3f3f3 6px solid;border-right: #f3f3f3 6px solid;border-bottom: #f3f3f3 6px solid;border-left: #f3f3f3 6px solid; \n         ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"#f3f3f3","image":"","position":"","repeat":"","size":""},"border":{"color":"#f3f3f3","radius":"","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"6"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-m-top_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"top:x-small","size":"x-small","type":"top"}],"padding":[],"size":{"default":"10","isResponsive":false},"sizeClass":"slds-size_10-of-12 ","style":"background-color:#f3f3f3;     border-top: #f3f3f3 6px solid;border-right: #f3f3f3 6px solid;border-bottom: #f3f3f3 6px solid;border-left: #f3f3f3 6px solid; \n         ","text":{"align":"","color":""}}}],"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-5","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"3","isResponsive":false},"stateIndex":0,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_xx-small slds-m-around_xxx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:xxx-small","size":"xxx-small","type":"around"}],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}},"styleObjects":[{"conditionString":"","conditions":"default","draggable":false,"key":0,"label":"Default","name":"Default","styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"5px","style":"","type":["border_top","border_right","border_bottom","border_left"],"width":"1"},"class":"slds-border_top slds-border_right slds-border_bottom slds-border_left slds-p-around_xx-small slds-m-around_xxx-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:xxx-small","size":"xxx-small","type":"around"}],"padding":[{"label":"around:xx-small","size":"xx-small","type":"around"}],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"     border-top: #cccccc 1px solid;border-right: #cccccc 1px solid;border-bottom: #cccccc 1px solid;border-left: #cccccc 1px solid; \n    border-radius:5px;     ","text":{"align":"","color":""}}}],"type":"block"}]}},"conditions":{"group":[],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Active","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"#cccccc","radius":"","style":"","type":[],"width":""},"class":" ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[],"size":{"default":"12","isResponsive":false,"large":"3","medium":"3","small":"3"},"sizeClass":"slds-size_12-of-12 ","style":"      \n         ","text":{"align":"","color":""}}}],"theme":"slds","title":"valCreateAccountContact","tracking":{"businessEvent":""},"Id":"a5W8I000000FnPVUA0","vlocity_cmt__GlobalKey__c":"valCreateAccountContact/GKaiser/1","vlocity_cmt__IsChildCard__c":true};
  export default definition