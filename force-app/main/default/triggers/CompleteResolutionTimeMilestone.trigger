trigger CompleteResolutionTimeMilestone on Case (after update) {
    if (UserInfo.getUserType() == 'Standard'){
        DateTime completionDate = System.now(); 
            List<Id> updateCases = new List<Id>();
            for (Case c : Trigger.new){
               System.debug('isClosed................: '+ c.isClosed);
               System.debug('iStatus.................: '+ c.Status);
               System.debug('CreatedDate ............: '+ c.CreatedDate);
               System.debug('completionDate..........: '+ completionDate);
               System.debug('SlaExitDate ............: '+ c.SlaExitDate );
               System.debug('canChange ..............: '+ (((c.isClosed == true)||(c.Status == 'Closed' || c.Status == 'On Return' ))&&((c.SlaStartDateHandling__c <= completionDate)&&(c.SlaExitDate == null))));
                        
               if (((c.isClosed == true)||(c.Status == 'Closed' || c.Status == 'On Return' ))&&((c.CreatedDate <= completionDate)&&(c.SlaExitDate == null)))
                  updateCases.add(c.Id);
            }
    if (updateCases.isEmpty() == false)
        milestoneUtils.completeMilestone(updateCases, 'Tempo de resolução', completionDate);
    }else{
        System.debug('Case.CompleteResolutionTimeMilestone -> Nenhum registro de Milestone foi encontrado');
    }
}