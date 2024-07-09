/* -------------------------------------------------------------------------
* Autor....: Renan S. de Freitas - Deloitte
* Data.....: 21/03/2024
* Objetivo.: Agendador de Rotina de Expurgos
* US - Rotina de Expurgos
*  -------------------------------------------------------------------------
* Autor....: Pedro Richtmann - Deloitte
* Data.....: 18/06/2024
* Alteração: Remoção da condicional de data para rodar processo para todos os objetos cadastrados na custom setting diariamente
* US - Rotina de Expurgos
*  -------------------------------------------------------------------------
* How to execute:
*/ 
public class SchedulePurgeRoutines implements Schedulable
{
    public void execute(SchedulableContext sc)
    {
        List<PurgeSetting__c> lstPurgeSetting = [SELECT Id, Name FROM PurgeSetting__c WHERE PurgeEnabled__c = TRUE];
        
        for(PurgeSetting__c objPurgeSetting : lstPurgeSetting)
        {
            BatchPurgeRoutines objBatch = new BatchPurgeRoutines(objPurgeSetting.Name); 
            Database.executeBatch(objBatch, 200);             
        }
   }
}