let definition = 
                {"GlobalKey__c":"vplAdditionalBuy/vlocityDev/1/1610956006542","dataSource":{"contextVariables":[],"type":"IntegrationProcedures","value":{"inputMap":{"InteractionId":"{{params.id}}"},"ipMethod":"vpl_AdditionalBuyPreProcess","optionsMap":{"vlcClass":"vlocity_cmt.IntegrationProcedureService"}}},"enableLwc":true,"filter":{},"sessionVars":[],"states":[{"blankCardState":false,"conditions":{"group":[{"field":"$scope.data.status","operator":"===","type":"system","value":"'active'"}]},"customLwc":false,"customLwcRepeat":true,"definedActions":{"actions":[{"collapse":true,"displayName":"Custom Action","hasExtraParams":false,"id":"Custom Action","isCustomAction":true,"openUrlIn":"_self","type":"Custom","url":"/apex/"}]},"disableAddCondition":false,"editMode":false,"fields":[],"filter":"$scope.data.status === 'active'","isSmartAction":false,"lwc":{"DeveloperName":"b2cCmexAdditionalBuyBtn","Id":"0Rb4x0000015IvpCAE","MasterLabel":"b2cCmexBuyAdditionalBtn","name":"b2cCmexAdditionalBuyBtn"},"name":"Active","smartAction":{}}],"title":"Additional buy card"}; 
            export default definition