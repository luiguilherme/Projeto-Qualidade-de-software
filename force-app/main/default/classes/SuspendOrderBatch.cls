/**
 * Batch responsável por iniciar processo de suspensão
 * Criação: US-418 - 26/01/2023
 * @author: diogsousa@deloitte.com & carlosaraujo@deloitte.com
 */
public class SuspendOrderBatch implements Database.Batchable<sObject> { 
    
    Map<String,  TimerParametros__mdt> mapParamsMdt = new Map<String,  TimerParametros__mdt>();
    String timerType;
    
    public SuspendOrderBatch(String processName, String type){
        List<TimerParametros__mdt> params = [
            SELECT Code__c, Value__c, IntegrationProcName__c 
            FROM TimerParametros__mdt 
            WHERE Process__c =: processName
        ];
        timerType = type;
        for (TimerParametros__mdt mdt : params) {
            mapParamsMdt.put(mdt.Code__c, mdt);   
        }
    }
    
    public Database.QueryLocator start(Database.BatchableContext info) {        
        return Database.getQueryLocator('SELECT StartDate__c, Type__c, OrderId__c FROM Timer__c WHERE Status__c = \'Aberto\' AND Type__c = \'' + timerType + '\'');
    }
    
    public void execute(Database.BatchableContext info, List<Timer__c> timers) {
        List<String> lstOrderId = new List<String>();   
        for (Timer__c timer : timers) {
            if (mapParamsMdt.containsKey(timer.Type__c)) {
                Integer valueInDays = Integer.valueOf(mapParamsMdt.get(timer.Type__c).Value__c) / 24;
                Date startDate = date.newinstance(timer.StartDate__c.year(), timer.StartDate__c.month(), timer.StartDate__c.day());

                if (valueInDays <= (startDate.daysBetween(System.today()))) {
                    lstOrderId.add(timer.OrderId__c);
                }
            }
		}

        callIP(mapParamsMdt.get(this.timerType).IntegrationProcName__c, lstOrderId);
    }
    public void finish(Database.BatchableContext info) {
		System.debug('SuspendOrderBatch >> finish');
    }

    /**
	 * @author carlosaraujo@deloitte.com & diogsousa@deloitte.com
     * @modify_date 05/06/2023
	 * @description Chama a Integration Procedure
     * @param procedureName Nome da Integration Procedure
     * @param lstOrderId Ids da ordem vinculada ao Timer [Timer__c]
	 */
    public void callIP(String procedureName, List<String> lstOrderId){
        Map <String, Object> ipInput = new Map <String, Object> ();
        Map <String, Object> ipOutput = new Map <String, Object> ();
        Map <String, Object> ipOptions = new Map <String, Object> ();
        
        /* Populating input map for an Integration Procedure. Follow whatever structure your VIP expects */
        ipInput.put('ListOrderId', lstOrderId);
        /* Call the IP via runIntegrationService, and save the output to ipOutput */
        ipOutput = (Map <String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(procedureName, ipInput, ipOptions);  
        System.debug('IP Result: ' + ipOutput);      
    }
}