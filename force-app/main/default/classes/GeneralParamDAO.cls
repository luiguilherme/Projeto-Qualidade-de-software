/** 
 * @author Diego Costa @ Deloitte
 * @date 07/06/2022
 * @description Controla a busca e criação do objeto Custom Settings
 */
public with sharing class GeneralParamDAO {

    public static List<GeneralParam__c> getLoadParams(){
        return [
            SELECT    
                Id, 
                AccountLoadDate__c,
                AssetLoadDate__c,
                BillingAccountLoadDate__c,
                InvoiceLoadDate__c,
                AddressLoadDate__c,
                AssetJob__c,
                BillingAccountJob__c,
                AccountJob__c,
                AddressJob__c,
                InvoiceJob__c,
                SearchRange__c,
            	SearchRangeInvoice__c,
            	ServiceHistoryExpiration__c,
                TotalNumberRecords__c,
                CustomerType__c,
                CustomerSegment__c,
                ScriptDetailHistoryExpiration__c,
                AccessesMinute__c
            FROM 
                GeneralParam__c    
        ];
    }
}