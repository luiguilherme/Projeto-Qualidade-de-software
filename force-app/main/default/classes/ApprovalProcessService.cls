/* -------------------------------------------------------------------------
* Autor....: Renan S. de Freitas - Deloitte
* Data.....: 08/04/2024
* Objetivo.: Remover Processso de aprovação
* US - J21 - Troca de SimCard - Loja Própria - Solicitar autorização para alçada
*  -------------------------------------------------------------------------
* How to execute:           
*/ 
global class ApprovalProcessService implements vlocity_cmt.VlocityOpenInterface2
{
    global Object invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options)
    {
        Boolean success = true;
        String errors = 'OK';
        
        try
        {
            switch on methodName 
            {
                when 'approvalProcess' 
                {
                    approvalProcess(inputMap, outMap, options); 
                }            
            }
        }catch(Exception e)
        {
            errors = e.getMessage();
            success = false;            
        }
        
        outMap.put('success', success);
        outMap.put('error', errors);
        return success;        
    }
    
    public void approvalProcess(Map<String, Object> inputMap, Map<String, Object> outMap, Map<String, Object> options)
    {
        system.debug('Entrou approvalProcess: ' + inputMap);
        string varTargetObjectId = (string)inputMap.get('TargetObjectId');
        system.debug('varTargetObjectId: ' + varTargetObjectId);
        
        List<Approval.ProcessWorkitemRequest> lstProcessWorkitemRequest = new List<Approval.ProcessWorkitemRequest>();
        
        //Get ProcessInstance Items        
        Map<ID,ProcessInstance> mapProcessInstance = New Map<ID,ProcessInstance>([Select Id from ProcessInstance where TargetObjectId =: varTargetObjectId]);
        system.debug('mapProcessInstance: ' + mapProcessInstance);
        
        List<ProcessInstanceWorkItem> lstProcessInstanceWorkItem = [Select Id from ProcessInstanceWorkItem where ProcessInstanceId IN :mapProcessInstance.keySet()];
        system.debug('lstProcessInstanceWorkItem: ' + lstProcessInstanceWorkItem);
        
        for(ProcessInstanceWorkItem objProcessInstanceWorkItem : lstProcessInstanceWorkItem)
        {
            // if there's a work item, set the action to 'removed' and execute
            Approval.ProcessWorkitemRequest objProcessWorkitemRequest = new Approval.ProcessWorkitemRequest();
            objProcessWorkitemRequest.setAction('Removed');
            objProcessWorkitemRequest.setWorkitemId(objProcessInstanceWorkItem.Id);
            lstProcessWorkitemRequest.add(objProcessWorkitemRequest);
        }
        
        system.debug('lstProcessInstanceWorkItem: ' + lstProcessWorkitemRequest);
        Approval.ProcessResult[] lstProcessResults = Approval.process(lstProcessWorkitemRequest, true);
        
        for(Approval.ProcessResult result : lstProcessResults) 
        {
            if(result.isSuccess())
            {
                System.debug('Approval process was successful!');
                outMap.put('Retorno do Processo de  Aprovação', 'Approval process was successful!');
                outMap.put('lstProcessResults ', lstProcessResults);
            }else
            {
                System.debug('Approval process failed: ' + result.getErrors());
            }
        }
    }
}