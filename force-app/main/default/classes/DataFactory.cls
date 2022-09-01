/*
* @authors - Diego Costa @Deloitte   
* @date - 07/06/2022
* @description - fábrica de Fatura__c para classes de testes
*/
@IsTest
public class DataFactory {

    /*
    public static Invoice__c createInvoiceHistory(Id accountId){
        Invoice__c invoiceHistory = new Invoice__c();
        
        invoiceHistory.Name = 'serviceHistory';
        invoiceHistory.AccountId__c = accountId;
        invoiceHistory.InvoiceId__c = '1234567890';
        invoiceHistory.Name = 'Test Invoice';
        invoiceHistory.CreationDate__c = System.today();
        invoiceHistory.StartDate__c = System.today();
        invoiceHistory.EndDate__c = System.today();
        invoiceHistory.DueDate__c = System.today();
        invoiceHistory.PaymentDate__c = System.today();
        invoiceHistory.NextInvoiceDate__c = System.today();
        invoiceHistory.TotalAmount__c = 324.44;
        invoiceHistory.TaxInclude__c = true;
        invoiceHistory.PaymentStatus__c = 'Unpaid';
        invoiceHistory.Downloadurl__c = 'https://invoicedownload.free.beeceptor.com/invoice';

        return invoiceHistory;
    }
    */
    public static Account createAccount(){ 
        Account account = new Account();

        account.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Billing').getrecordTypeId();
        account.Name = 'Account Test';
        account.DocumentNumber__c = '11111111111111';
        account.vlocity_cmt__CustomerClass__c = 'Móvel';
        account.CustomerSegment__c = 'PLATINUM';
        account.vlocity_cmt__Active__c = 'Yes';

        return account;
    }
    
/*
    public static Asset createAsset(Id accountId, String type){
        Asset asset = new Asset();
        
        asset.Name = 'Test Asset';
        asset.AccountId = accountId;        
        asset.MainProductDescription__c = 'Test ' + type;
        asset.vlocity_cmt__BillingAccountId__c = accountId;
        asset.Type__c = type;
        asset.IsHolder__c = 'Sim';
        asset.HasBonus__c = false;
        asset.HasDiscount__c = false;
        asset.PriceOver__c = 150;
        asset.PriceCurrent__c = 200;
        asset.PhoneNumber__c = '12345678901';
        asset.Speed__c = '30';
        asset.ProductType__c = 'VOZ';
        asset.PhoneNumber__c = '11999999999';
        asset.Technology__c = 'FTTH';
        asset.Cabinet__c = 'Cabinet';
        asset.LegacySystem__c = 'ATLYS';

        return asset;
    }
    */
    
    public static vlocity_cmt__CustomerInteraction__c createCustomerInteraction(Id accountId) {
        vlocity_cmt__CustomerInteraction__c customerInteraction = new vlocity_cmt__CustomerInteraction__c();
        customerInteraction.vlocity_cmt__AccountId__c = accountId;
		customerInteraction.Name = 'Test Customer Interaction';		
		customerInteraction.vlocity_cmt__StartDateTime__c = System.today();
		customerInteraction.InteractionNumber__c = '20220630123456';
		customerInteraction.vlocity_cmt__StartDateTime__c = System.today();
		customerInteraction.vlocity_cmt__Type__c = 'Presencial';
		customerInteraction.vlocity_cmt__Verified__c = false;
        
        return customerInteraction;
    }

}