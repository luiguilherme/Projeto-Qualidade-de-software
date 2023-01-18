/**
  * @author Danieli
  * @date 02/01/2020
  * @description Classe de testes B2C_GraficoHistorico
**/
@isTest
private class B2C_GraficoMediaFaturaTest {

    @testSetup
    static void setup(){
        Account lAccount = AccountTestFactory.start().isAccount().create();
        
        // BillingAccount__c lBillingAccountFixed = BillingAccountTestFactory.start(lAccount.Id).isFixed().create();
        // BillingAccount__c lBillingAccountMobile = BillingAccountTestFactory.start(lAccount.Id).isMobile().create();
        // insert new List<Fatura__c> {
        //     FaturaTestFactory.start( lAccount.Id ).isFixed(lBillingAccountFixed.Id).build(),
        //     FaturaTestFactory.start( lAccount.Id ).isMobile(lBillingAccountMobile.Id).build()  
       	// };
            
        insert new GeneralParam__c(
            AccountLoadDate__c  = Datetime.now().addDays(-1),
            AssetLoadDate__c = Datetime.now().addDays(-1),
            BillingAccountLoadDate__c = Datetime.now().addDays(-1),
            InvoiceLoadDate__c = Datetime.now().addDays(-1),
            AddressLoadDate__c = Datetime.now().addDays(-1),
            AssetJob__c = true,
            BillingAccountJob__c = true,
            AccountJob__c = true,
            AddressJob__c = true,
            InvoiceJob__c = true,
            CustomerType__c = 'Totalizado;Fixa',
            CustomerSegment__c = 'TOP;VIP'
        );
    }
    
    @isTest
    public static void getCurrentInvoiceTest(){
        
        Account lAccount = [ SELECT Id FROM Account LIMIT 1];
        
        Test.startTest();
        
        String lresultado = B2C_GraficoMediaFatura.getComboFixa(lAccount.Id);
        system.assert( lresultado!= null);
        
        Test.stopTest();
    }
    
}