let definition =
      {"dataSource":{"contextVariables":[],"orderBy":{},"type":null,"value":{}},"enableLwc":true,"globalCSS":false,"isFlex":true,"isRepeatable":true,"lwc":{"DeveloperName":"cfCPQAttributeConfigFields","Id":"0Rb5g000000QkMqCAK","ManageableState":"unmanaged","MasterLabel":"cfCPQAttributeConfigFields","NamespacePrefix":"vlocity_cmt"},"multilanguageSupport":true,"states":[{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Text-1","name":"Text","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"readOnly","value":"{readonly}"},{"id":1,"label":"disabled","value":"{disabled}"},{"id":2,"label":"required","value":"{required}"},{"id":3,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValues}"},"record":"{record}","type":"text"},"size":{"default":"12","isResponsive":false},"stateIndex":0,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-condition-16","operator":"==","type":"custom","value":"text"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Text","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_small ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:small","size":"small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Currency-1","name":"Currency","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValues}"},"record":"{record}","type":"currency"},"size":{"default":"12","isResponsive":false},"stateIndex":1,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-condition-3","operator":"==","type":"custom","value":"number"},{"field":"dataType","id":"state-new-condition-0","logicalOperator":"&&","operator":"==","type":"custom","value":"currency"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Currency","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Number-1","name":"Number","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"disabled","value":"{disabled}"},{"id":1,"label":"readOnly","value":"{readonly}"},{"id":2,"label":"required","value":"{required}"},{"id":3,"label":"min","value":"{min}"},{"id":4,"label":"max","value":"{max}"},{"id":5,"label":"messageWhenTooShort","value":"Age should be above 18 years"},{"id":6,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValues}"},"record":"{record}","type":"number"},"size":{"default":"12","isResponsive":false},"stateIndex":2,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-condition-6","operator":"==","type":"custom","value":"number"},{"field":"dataTypes","id":"state-new-condition-48","logicalOperator":"&&","operator":"!=","type":"custom","value":"currency"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Number","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Email-1","name":"Email","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"required","value":"{required}"},{"id":1,"label":"readOnly","value":"{readonly}"},{"id":2,"label":"disabled","value":"{disabled}"},{"id":4,"label":"pattern","value":"^[A-Za-z0-9._%+-]+@salesforce.com$"},{"id":5,"label":"messageWhenPatternMismatch","value":"Please enter salesforce email id"},{"id":5,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValues}"},"record":"{record}","type":"email"},"size":{"default":"12","isResponsive":false},"stateIndex":3,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"email"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Email","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Text-1","name":"Text","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"type","value":"password"},{"id":1,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValues}"},"record":"{record}","type":"text"},"size":{"default":"12","isResponsive":false},"stateIndex":4,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"password"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Password","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Tel-2","name":"Tel","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValues}"},"record":"{record}","type":"tel"},"size":{"default":"12","isResponsive":false},"stateIndex":5,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"tel"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Tel","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Date-1","name":"Date","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValues}"},"record":"{record}","type":"date"},"size":{"default":"12","isResponsive":false},"stateIndex":6,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"date"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Date","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Time-1","name":"Time","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValues}"},"record":"{record}","type":"time"},"size":{"default":"12","isResponsive":false},"stateIndex":7,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"time"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Time","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"DateTime-1","name":"DateTime","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValues}"},"record":"{record}","type":"datetime"},"size":{"default":"12","isResponsive":false},"stateIndex":8,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"datetime"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Datetime","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Range-1","name":"Range","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"min","value":"{min}"},{"id":1,"label":"max","value":"{max}"},{"id":2,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValue}"},"record":"{record}","type":"range"},"size":{"default":"12","isResponsive":false},"stateIndex":9,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"range"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Range","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Color-1","name":"Color","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValues}"},"record":"{record}","type":"color"},"size":{"default":"12","isResponsive":false},"stateIndex":10,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"color"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Color","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"TextArea-1","name":"TextArea","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValue}"},"record":"{record}","type":"textarea"},"size":{"default":"12","isResponsive":false},"stateIndex":11,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"textarea"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Textarea","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"CheckBoxGroup-1","name":"CheckBoxGroup","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"options","value":"{values}"},{"id":1,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValue}"},"record":"{record}","type":"checkboxgroup"},"size":{"default":"12","isResponsive":false},"stateIndex":12,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"checkbox"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Checkbox","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"CheckBoxGroup-1","name":"CheckBoxGroup","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"options","value":"{values}"},{"id":1,"label":"data-attributename","value":"{code}"},{"id":2,"label":"type","value":"button"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValue}"},"record":"{record}","type":"checkboxgroup"},"size":{"default":"12","isResponsive":false},"stateIndex":13,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"checkbox-button"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Checkbox-Button","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"blankCardState":false,"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Radio Color Pick Group-1","name":"Radio Color Pick Group","property":{"card":"{card}","propertyObj":{"controlHeight":"80","controlWidth":"135","customProperties":[{"id":0,"label":"options","value":"{values}"},{"id":1,"label":"isColorDisplay","value":"true"},{"id":2,"label":"data-attributename","value":"{code}"}],"isImage":false,"label":"{label}","name":"CPQAttributeDynamicForm"},"record":"{record}","type":"radiocolorpickgroup"},"size":{"default":"12","isResponsive":false},"stateIndex":13,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"},{"class":"slds-col ","element":"baseInputElement","elementLabel":"Radio Color Pick Group-2","name":"Radio Color Pick Group","property":{"card":"{card}","propertyObj":{"controlHeight":"200px","controlWidth":"100px","label":"{label}","name":"{code}"},"record":"{record}","type":"radiocolorpickgroup"},"size":{"default":"12","isResponsive":false},"stateIndex":13,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-condition-5","operator":"==","type":"custom","value":"radioImage"}],"id":"state-condition-object","isParent":true},"documents":[],"fields":[],"isSmartAction":false,"name":"Radio Color Pick Group","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"7","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_7-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"RadioGroup-1","name":"RadioGroup","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"options","value":"{values}"},{"id":1,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValue}"},"record":"{record}","type":"radiogroup"},"size":{"default":"12","isResponsive":false},"stateIndex":14,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"radio"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Radio","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"RadioGroup-1","name":"RadioGroup","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"options","value":"{values}"},{"id":1,"label":"data-attributename","value":"{code}"},{"id":2,"label":"type","value":"button"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValue}"},"record":"{record}","type":"radiogroup"},"size":{"default":"12","isResponsive":false},"stateIndex":16,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"radio-button"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Radio Button","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"flexToggle","elementLabel":"{code}","name":"Toggle","property":{"card":"{card}","checked":"false","label":"\\{label}","name":"\\{label}","record":"{record}","type":"toggle","updateDS":false},"size":{"default":"12","isResponsive":false},"stateIndex":15,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element","userUpdatedElementLabel":true}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"Toggle"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Toggle","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"ComboBox-1","name":"ComboBox","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"options","value":"{values}"},{"id":1,"label":"multiple","value":"{multiselect}"},{"id":2,"label":"deleteMultiple","value":"true"},{"id":3,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","options":[],"value":"{userValues}"},"record":"{record}","type":"combobox"},"size":{"default":"12","isResponsive":false},"stateIndex":16,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"dropdown"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Combobox","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Typeahead-0","name":"Typeahead","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"options","value":"{options}"},{"id":1,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValues}"},"record":"{record}","type":"typeahead"},"size":{"default":"12","isResponsive":false},"stateIndex":17,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-condition-3","operator":"==","type":"custom","value":"typeahead"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Typeahead","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"childCards":[],"components":{"layer-0":{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Pill-0","name":"Pill","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"options","value":"{values}"},{"id":1,"label":"data-attributename","value":"{code}"}],"label":"{label}","name":"CPQAttributeDynamicForm","value":"{userValues}"},"record":"{record}","type":"pill"},"size":{"default":"12","isResponsive":false},"stateIndex":18,"styleObject":{"sizeClass":"slds-size_12-of-12"},"type":"element"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-0","operator":"==","type":"custom","value":"pill"}],"id":"state-condition-object","isParent":true},"definedActions":{"actions":[]},"documents":[],"fields":[],"isSmartAction":false,"name":"Pill","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-around_none ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"around:none","size":"none","type":"around"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":true,"large":"4","medium":"6","small":"12"},"sizeClass":"slds-large-size_4-of-12 slds-medium-size_6-of-12 slds-small-size_12-of-12 slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}},{"actions":[],"blankCardState":false,"childCards":[],"components":{"layer-0":{"children":[{"children":[{"class":"slds-col ","element":"baseInputElement","elementLabel":"Button-0","key":"element_element_block_0_18_baseInputElement_0_18","name":"Button","parentElementKey":"element_block_0_18","property":{"card":"{card}","propertyObj":{"customProperties":[{"id":0,"label":"variant","value":"success"},{"id":1,"label":"extraclass","value":"vdfbutton"}],"disabled":false,"label":" ","name":"{code}","readOnly":false,"required":false,"value":"{label}"},"record":"{record}","styles":{"value":{"backgroundColor":"#067EB6","color":"#FFFFFF"}},"type":"button"},"size":{"default":"3","isResponsive":false},"stateIndex":18,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"","container":{"class":""},"elementStyleProperties":{"styles":{"value":{"backgroundColor":"#067EB6","color":"#FFFFFF"}}},"inlineStyle":"margin: auto;","margin":[],"padding":[],"size":{"default":"3","isResponsive":false},"sizeClass":"slds-size_3-of-12 ","style":"             margin: auto;","text":{"align":"","color":""}},"type":"element"}],"class":"slds-col ","element":"block","elementLabel":"Block-1","name":"Block","property":{"card":"{card}","collapsedByDefault":false,"collapsible":false,"label":"Block","record":"{record}"},"size":{"default":"12","isResponsive":false},"stateIndex":18,"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-text-align_center slds-p-around_x-small ","container":{"class":""},"elementStyleProperties":{},"inlineStyle":"","margin":[],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"             ","text":{"align":"center","color":""}},"type":"block"}]}},"conditions":{"group":[{"field":"inputType","id":"state-new-condition-9","operator":"==","type":"custom","value":"button"}],"id":"state-condition-object","isParent":true},"documents":[],"fields":[],"isSmartAction":false,"name":"Button","omniscripts":[],"smartAction":{},"styleObject":{"background":{"color":"","image":"","position":"","repeat":"","size":""},"border":{"color":"","radius":"","style":"","type":"","width":""},"class":"slds-card slds-p-around_x-small slds-m-bottom_x-small ","container":{"class":"slds-card"},"elementStyleProperties":{},"inlineStyle":"","margin":[{"label":"bottom:x-small","size":"x-small","type":"bottom"}],"padding":[{"label":"around:x-small","size":"x-small","type":"around"}],"size":{"default":"12","isResponsive":false},"sizeClass":"slds-size_12-of-12 ","style":"             ","text":{"align":"","color":""}}}],"theme":"slds","title":"CPQAttributeConfigFields","tracking":{"businessEvent":""},"Id":"a5W7j000000f2qEEAQ","vlocity_cmt__GlobalKey__c":"CPQAttributeConfigFields/Vlocity/2/1605070466958"};
  export default definition