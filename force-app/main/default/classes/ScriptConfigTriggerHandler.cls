public without sharing class ScriptConfigTriggerHandler {
    
    public static void createRoute(List<ScriptConfig__c> ltScriptConfig) {
        
        Id groupRT = Schema.SObjectType.ScriptConfig__c.getRecordTypeInfosByDeveloperName().get('Group').getRecordTypeId();
        Id routeRT = Schema.SObjectType.ScriptConfig__c.getRecordTypeInfosByDeveloperName().get('Route').getRecordTypeId();
        Id instructionRT = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('Instruction').getRecordTypeId();


        Map<Id, List<Script__c>> mapScriptOptions = new Map<Id, List<Script__c>>();
        Set<Id> setScriptShow = new Set<Id>();
        Set<Id> setRecordTypeScript = new Set<Id>();
        List<Script__c> ltAnswer;

        List<ScriptConfig__c> ltRoute = new List<ScriptConfig__c>();
        ScriptConfig__c routeItem;

        for(ScriptConfig__c item : ltScriptConfig){
            if(item.RecordTypeId == groupRT){
                setScriptShow.add(item.ScriptToShow__c);
            }
        }

        List<Script__c> ltScript = [SELECT Id, RecordType.Id FROM Script__c WHERE Id IN: setScriptShow AND RecordType.DeveloperName = 'Instruction'];

        for(Script__c item : ltScript){
            if(item.RecordTypeId == instructionRT){
                setRecordTypeScript.add(item.Id);
            }
        }

        if(setScriptShow.size() > 0){
            for(Script__c item : [SELECT Id, QuestionScript__c FROM Script__c WHERE QuestionScript__c IN: setScriptShow]){
                ltAnswer = new List<Script__c>();
                if(mapScriptOptions.containsKey(item.QuestionScript__c)){
                    ltAnswer = mapScriptOptions.get(item.QuestionScript__c);
                }
                ltAnswer.add(item);
                mapScriptOptions.put(item.QuestionScript__c, ltAnswer);
            }
        }

        for(ScriptConfig__c item : ltScriptConfig){
            if(item.RecordTypeId == groupRT){
                if(mapScriptOptions.containsKey(item.ScriptToShow__c)){
                    for(Script__c option : mapScriptOptions.get(item.ScriptToShow__c)){
                        routeItem = new ScriptConfig__c();
                        routeItem.RecordTypeId          = routeRT;
                        routeItem.ParentScript__c       = item.ParentScript__c;
                        routeItem.ScriptToShow__c       = item.ScriptToShow__c;
                        routeItem.ParentScriptConfig__c = item.Id;
                        routeItem.ChildScript__c        = option.Id;

                        ltRoute.add(routeItem);
                    }
                } else if(setRecordTypeScript.size() > 0) {
                    routeItem = new ScriptConfig__c();
                    routeItem.RecordTypeId          = routeRT;
                    routeItem.ParentScript__c       = item.ParentScript__c;
                    routeItem.ScriptToShow__c       = item.ScriptToShow__c;
                    routeItem.ParentScriptConfig__c = item.Id;
                    routeItem.AnswerOption__c       = 'Finalizar';
                    ltRoute.add(routeItem);
               }else {
                    routeItem = new ScriptConfig__c();
                    routeItem.RecordTypeId          = routeRT;
                    routeItem.ParentScript__c       = item.ParentScript__c;
                    routeItem.ScriptToShow__c       = item.ScriptToShow__c;
                    routeItem.ParentScriptConfig__c = item.Id;
                    routeItem.AnswerOption__c       = 'Sim';
                    ltRoute.add(routeItem);

                    routeItem = new ScriptConfig__c();
                    routeItem.RecordTypeId          = routeRT;
                    routeItem.ParentScript__c       = item.ParentScript__c;
                    routeItem.ScriptToShow__c       = item.ScriptToShow__c;
                    routeItem.ParentScriptConfig__c = item.Id;
                    routeItem.AnswerOption__c       = 'Não';
                    ltRoute.add(routeItem);

                }
            }
        }

        if( ltRoute.size() > 0){
            insert ltRoute;
        }

    }

    public static void createGroupToRoute(List<ScriptConfig__c> ltScriptConfig) {

        if(ltScriptConfig.size() > 1){
            return;
        }
        Id routeRT = Schema.SObjectType.ScriptConfig__c.getRecordTypeInfosByDeveloperName().get('Route').getRecordTypeId();
        Id groupRT = Schema.SObjectType.ScriptConfig__c.getRecordTypeInfosByDeveloperName().get('Group').getRecordTypeId();        
        Id questionId = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('Question').getRecordTypeId();

        Set<Id> setNextScriptTech = new Set<Id>();
        Set<Id> setQuestionId = new Set<Id>();
        Map<Id, ScriptConfig__c> mapGroup = new Map<Id, ScriptConfig__c>();
        ScriptConfig__c groupItem;
        
        

        for(ScriptConfig__c item : ltScriptConfig){
            if(item.NextScriptTech__c != null){
                setNextScriptTech.add(item.NextScriptTech__c);
            }
        }

        List<Script__c> ltScript = [SELECT Id, RecordType.Id FROM Script__c WHERE Id IN: setNextScriptTech AND RecordType.DeveloperName = 'Question'];
		system.debug('ltScript : ' + ltScript);
        for(Script__c item : ltScript){
            if(item.RecordTypeId == questionId){
                setQuestionId.add(item.Id);
            }
        }
        
        
		system.debug('setQuestionId : ' + setQuestionId);
        List<Script__c> ltAnswer = [SELECT Id FROM Script__c WHERE QuestionScript__c IN: setQuestionId ];
        system.debug('ltScriptConfig : ' + ltScriptConfig);
        system.debug('ltAnswer : ' + ltAnswer);

        if(setQuestionId.size() > 0){
            for(ScriptConfig__c item : ltScriptConfig){
                system.debug('ITEM : ' + item.NextScriptConfig__c);
                for(Script__c itemScript : ltScript){
                    if(item.RecordTypeId == routeRT && item.NextScriptTech__c != null && item.NextScriptConfig__c == null && ltAnswer.size() > 0){
                        groupItem = new ScriptConfig__c();
                        groupItem.RecordTypeId = groupRT;
                        groupItem.ParentScript__c = item.ParentScript__c;
                        groupItem.ScriptToShow__c = item.NextScriptTech__c;
    
                        mapGroup.put(item.NextScriptTech__c, groupItem);
                    } else{
                        item.NextScriptTech__c.addError('Não é possível vincular uma pergunta sem respostas cadastradas');
                    }
                }
            }           

        } else{
            system.debug('ltScriptConfig : '+ ltScriptConfig);
            for(ScriptConfig__c item : ltScriptConfig){
                    if(item.RecordTypeId == routeRT && item.NextScriptTech__c != null && item.NextScriptConfig__c == null){
                        groupItem = new ScriptConfig__c();
                        groupItem.RecordTypeId = groupRT;
                        groupItem.ParentScript__c = item.ParentScript__c;
                        groupItem.ScriptToShow__c = item.NextScriptTech__c;
    
                        mapGroup.put(item.NextScriptTech__c, groupItem);
                    }
                
            }
        }
        
        if(mapGroup.size() > 0){
            insert mapGroup.values();

            for(ScriptConfig__c item : ltScriptConfig){
                if(item.RecordTypeId == routeRT && item.NextScriptTech__c != null && item.NextScriptConfig__c == null && 
                    mapGroup.containsKey(item.NextScriptTech__c))
                {
                    item.NextScriptConfig__c = mapGroup.get(item.NextScriptTech__c).Id;
                    item.NextScriptTech__c = null;
                }

            }
        }

    }
}