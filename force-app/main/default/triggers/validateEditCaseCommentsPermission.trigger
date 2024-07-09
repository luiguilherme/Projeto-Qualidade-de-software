trigger validateEditCaseCommentsPermission on CaseComment (before insert, before delete, before update) {
    Set<Id> parentCase=new Set<Id>();
    Id CaseProcessRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Caso Processo').getRecordTypeId();
    Id CasePortabilityRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Caso Portabilidade').getRecordTypeId();
	Id UserId = UserInfo.getUserId();
    Map<Id,Case> mapCase=new Map<Id,Case>();
    
    if(trigger.isDelete){
        for (CaseComment t: Trigger.old ) {
            parentCase.add(t.ParentId);
        }
    }
    
     if(!trigger.isDelete){
        for (CaseComment t: Trigger.new ) {
            parentCase.add(t.ParentId);
        }
    }

	List<Case> lstCase=[Select Id,Status, RecordTypeId, OwnerId from case where Id in :parentCase ];
	for(case c: lstCase){
		mapCase.put(c.Id,c);
	}
    
    if(trigger.isDelete){
        for (CaseComment t: Trigger.old){
            if(mapCase.containskey(t.ParentId)) {
                if(mapCase.get(t.ParentId).Status!='Closed' && mapCase.get(t.ParentId).OwnerId != UserId && (mapCase.get(t.ParentId).RecordTypeId == CaseProcessRecordTypeId || mapCase.get(t.ParentId).RecordTypeId == CasePortabilityRecordTypeId)){
                    t.addError('Não é possível excluir seu comentário, sendo permitido somente quando o atendente está tratando ou retornando o caso.');		
                }
                if(mapCase.get(t.ParentId).Status=='Closed' && (mapCase.get(t.ParentId).RecordTypeId == CaseProcessRecordTypeId || mapCase.get(t.ParentId).RecordTypeId == CasePortabilityRecordTypeId)){
                    t.addError('Não é possível excluir seu comentário, sendo permitido somente quando o atendente está tratando ou retornando o caso.');		
                }
            }
       	}
	}

    if(!trigger.isDelete){
        for (CaseComment t: Trigger.new){
            if(mapCase.containskey(t.ParentId)) {
                if(mapCase.get(t.ParentId).Status=='Closed' && (mapCase.get(t.ParentId).RecordTypeId == CaseProcessRecordTypeId || mapCase.get(t.ParentId).RecordTypeId == CasePortabilityRecordTypeId)){
                    t.addError('Não é possível fazer inclusão ou alteração de comentários quando o Status do caso estiver Fechado.');		
                }
                if(trigger.IsUpdate && mapCase.get(t.ParentId).Status!='Closed' && mapCase.get(t.ParentId).OwnerId != UserId && (mapCase.get(t.ParentId).RecordTypeId == CaseProcessRecordTypeId || mapCase.get(t.ParentId).RecordTypeId == CasePortabilityRecordTypeId)){
                    t.addError('Não é possível editar seu comentário, sendo permitido somente quando o atendente está tratando ou retornando o caso.');		
                }                             
            }
       	}
	}
}