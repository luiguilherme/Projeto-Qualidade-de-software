/* -------------------------------------------------------------------------
* Autor....: Renan S. de Freitas - Deloitte
* Data.....: 26/01/2024
* Objetivo.: Batcha de Rotina de Expurgos
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
        
        Integer frequency = objPurgeSetting.Frequency__c.intValue();
        String frequencyMeasurementUnit = ('Meses'.equalsIgnoreCase(objPurgeSetting.FrequencyMeasurementUnit__c)) ? 'LAST_N_MONTHS:' : 'LAST_N_DAYS:';              
        String query = ' SELECT Id FROM ' + objPurgeSetting.ObjectName__c + ' WHERE LastModifiedDate < ' + frequencyMeasurementUnit + frequency;
        return  Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Sobject> lstSobjectToDelete) 
    {
        system.debug('BatchPurgeRoutines.execute lstSobjectToDelete: ' + lstSobjectToDelete);
        
        List<Database.DeleteResult> lstDeleteResultsTotal = Database.delete(lstSobjectToDelete, false);        
        
        List<vlocity_cmt__VlocityErrorLogEntry__c> lstVlocityErrorLogEntry = new List<vlocity_cmt__VlocityErrorLogEntry__c>();
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
       system.debug('finish objPurgeSetting.SchedulingDate__c: ' + objPurgeSetting.SchedulingDate__c);        
       updateScheduleTime(objPurgeSetting);  
    }
    
    public void updateScheduleTime(PurgeSetting__c objPurgeSetting)
    {
        if('Meses'.equalsIgnoreCase(objPurgeSetting.FrequencyMeasurementUnit__c))
        {            
            objPurgeSetting.SchedulingDate__c = objPurgeSetting.SchedulingDate__c.addMonths(objPurgeSetting.Frequency__c.intValue());
        }
        
        if('Dias'.equalsIgnoreCase(objPurgeSetting.FrequencyMeasurementUnit__c))
        {
            objPurgeSetting.SchedulingDate__c = objPurgeSetting.SchedulingDate__c.addDays(objPurgeSetting.Frequency__c.intValue());            
        }
        
        Database.Update(objPurgeSetting);
        system.debug('updateScheduleTime objPurgeSetting.SchedulingDate__c: ' + objPurgeSetting.SchedulingDate__c);
    }
    
    private vlocity_cmt__VlocityErrorLogEntry__c createLog(Id recordId, Database.DeleteResult objResult,  Database.Error objError)
    {
        vlocity_cmt__VlocityErrorLogEntry__c objVlocityErrorLogEntry = new vlocity_cmt__VlocityErrorLogEntry__c();
        objVlocityErrorLogEntry.Name = String.valueof(recordId);
        objVlocityErrorLogEntry.vlocity_cmt__ObjectName__c = String.valueof(recordId.getsobjecttype());
        objVlocityErrorLogEntry.vlocity_cmt__ErrorMessage__c = objError.getMessage();
        return objVlocityErrorLogEntry;        
    }
    
    public class BatchPurgeRoutinesException extends Exception{}
}