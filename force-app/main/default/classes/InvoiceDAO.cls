/** 
 * @author Diego Costa @ Deloitte
 * @date 15/06/2022
 * @description Controla a busca e criação do objeto Invoice__c
 */
public with sharing class InvoiceDAO {
    public static Invoice__c getById(Id invoiceId) {
        List<Invoice__c> ltInvoice = getById(new Set<Id>{invoiceId});

        return (ltInvoice.IsEmpty() ? null : ltInvoice[0]);
    }
    
    public static List<Invoice__c> getById(Set<Id> setInvoiceId){
        return [
            SELECT 
                Id, 
                Name, 
                InvoiceId__c, 
                Downloadurl__c, 
                SecondaryDownloadUrl__c, 
                AccountId__c 
            FROM 
                Invoice__c 
            WHERE 
                Id = :setInvoiceId
        ]; 
    }
}