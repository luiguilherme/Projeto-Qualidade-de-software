/*
* @author Diego Costa @ Deloitte
* @date 06/06/2022
* @description - Classe responsável por verificar se há dados nas respectivas APIs após execução de batchs e realizações novas chamadas
*/
public with sharing class InvoiceHistoryDAO {    
    public static final String WEBSERVICE_NAME = 'FourthPlataformInvoiceCallout';    
    
    public static List<Invoice__c> getInvoiceByAccountId(Id accountId, Datetime searchInvoiceTime){
        Webservice__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);
        
        integer refreshTime = Integer.valueOf(wsConfig.Validate__c) *-1;
        Datetime searchInvoiceDate = system.now().addSeconds(refreshTime);
        
        return [
            SELECT    
                Id 
            FROM 
                Invoice__c
            WHERE
            	AccountId__c =: accountId
            	AND
            	LastModifiedDate >: searchInvoiceDate
            	AND 
            	ID != NULL
        ];
    }
    
}