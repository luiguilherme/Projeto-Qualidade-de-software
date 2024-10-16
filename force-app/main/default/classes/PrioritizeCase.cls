global without sharing class PrioritizeCase implements vlocity_cmt.VlocityOpenInterface2 { 
     global Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionMap) {   
         Boolean success = true;
       	 String errors = 'OK';
         
         try{
            if (methodName == 'updatePriorityCase') {
                    updatePriorityCase(inputMap,outputMap); 
            }

        } catch (Exception e) {
            errors = e.getMessage(); 
            success = false;
        } 
         
        outputMap.put('Success', success);
        outputMap.put('Error', errors);
        
        return success;
     }
    
     private void updatePriorityCase(Map<String, Object> putMap, Map<String, Object> outputMap) {
         String priorityDet = (String) putMap.get('PriorityDet');
         String caseIdBlock = (String) putMap.get('CaseIdBlock');
         
         Case caseUpdate = [
             SELECT 
                 Id,
                 CriticalComment__c,
                 Status,
                 Priority
             FROM 
             	Case 
             WHERE 
             	Id = :caseIdBlock
         ];
         
         caseUpdate.CriticalComment__c = priorityDet;
         caseUpdate.Status = 'Crítico';
         caseUpdate.Priority = 'Critical';
         
         update caseUpdate;    
    }
}