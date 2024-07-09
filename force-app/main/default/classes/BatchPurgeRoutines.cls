/* -------------------------------------------------------------------------
* Autor....: Renan S. de Freitas - Deloitte
* Data.....: 26/01/2024
* Objetivo.: Batcha de Rotina de Expurgos
* US - Rotina de Expurgos
*  -------------------------------------------------------------------------
* Autor....: Pedro Richtmann - Deloitte
* Data.....: 26/01/2024
* Alteração: Remoção do método updateScheduleTime, responsável pela atualização de data de realização do próximo expurgo; alteração de termo de "frequency" para "retentionPeriod" (API name e label do campo também foram alterados);
* US - Rotina de Expurgos
*  -------------------------------------------------------------------------
* How to execute:           
*/ 
public class BatchPurgeRoutines implements Database.Batchable<Sobject>, Database.Stateful
{
    public String sobjctName;
    public PurgeSetting__c objPurgeSetting;
    
    public BatchPurgeRoutines(String sobjctName)
    {
        this.sobjctName = sobjctName;
        this.objPurgeSetting = PurgeSetting__c.getInstance(sobjctName); 
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        if(objPurgeSetting == null)
        {           
            throw new BatchPurgeRoutinesException('Configuração PurgeSetting__c Inválida: ' + sobjctName);       
        }
        
        Integer retentionPeriod = objPurgeSetting.retentionPeriod__c.intValue();
        String retentionPeriodMeasurementUnit = ('Meses'.equalsIgnoreCase(objPurgeSetting.retentionPeriodMeasurementUnit__c)) ? 'LAST_N_MONTHS:' : 'LAST_N_DAYS:';              
        String query = '';
        
        if(objPurgeSetting.ObjectName__c == 'Order')
        {           
        	query = ' SELECT Id, Status FROM Order WHERE LastModifiedDate < ' + retentionPeriodMeasurementUnit + retentionPeriod;
        }
        else
        {
			query = ' SELECT Id FROM ' + objPurgeSetting.ObjectName__c + ' WHERE LastModifiedDate < ' + retentionPeriodMeasurementUnit + retentionPeriod;
        }
        
        return  Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Sobject> lstSobjectToDelete) 
    {
        system.debug('BatchPurgeRoutines.execute lstSobjectToDelete: ' + lstSobjectToDelete);
        
        if(objPurgeSetting.ObjectName__c == 'Order')
        {           
            for(SObject order : lstSobjectToDelete){
                order.put('Status','Draft');
            }
            update lstSobjectToDelete;
        }
        
        List<Database.DeleteResult> lstDeleteResultsTotal = Database.delete(lstSobjectToDelete, false);        
        
        List<vlocity_cmt__VlocityErrorLogEntry__c> lstVlocityErrorLogEntry = new List<vlocity_cmt__VlocityErrorLogEntry__c>(); // precisa add log nesse objeto da vlocity? faz sentido?
        for(Database.DeleteResult objResult : lstDeleteResultsTotal)
        {
            if(!objResult.isSuccess())
            {
                for(Database.Error objError : objResult.getErrors()) 
                {
                    Id recordId = objResult.getId();
                    lstVlocityErrorLogEntry.add(createLog(recordId, objResult, objError));
                }
            }
        }

		Database.insert(lstVlocityErrorLogEntry, false);
        Database.emptyRecycleBin(lstSobjectToDelete);
    }
    
    public void finish(Database.BatchableContext bc)
    {
       system.debug('finish objPurgeSetting.ObjectName__c: ' + objPurgeSetting.ObjectName__c);
    }
    
    private vlocity_cmt__VlocityErrorLogEntry__c createLog(Id recordId, Database.DeleteResult objResult,  Database.Error objError)  // precisa add log nesse objeto da vlocity? faz sentido?
    {
        vlocity_cmt__VlocityErrorLogEntry__c objVlocityErrorLogEntry = new vlocity_cmt__VlocityErrorLogEntry__c();
        objVlocityErrorLogEntry.Name = String.valueof(recordId);
        objVlocityErrorLogEntry.vlocity_cmt__ObjectName__c = String.valueof(recordId.getsobjecttype());
        objVlocityErrorLogEntry.vlocity_cmt__ErrorMessage__c = objError.getMessage();
        return objVlocityErrorLogEntry;        
    }
     	
    public class BatchPurgeRoutinesException extends Exception{}}