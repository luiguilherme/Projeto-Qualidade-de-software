@isTest
public class OfferTest {

    @testSetup 
    static void setup(){
        Account account = DataFactory.createAccount();
        insert account;

        Offer__c offer = DataFactory.createOfferFixed(account.Id);
        insert offer;

        CartAccount__c cartAccount = DataFactory.createCartAccount(account.Id);
        insert cartAccount;

        CartOffer__c cartOffer = new CartOffer__c();
        cartOffer = DataFactory.createCartOffer(cartAccount.Id, offer.Id);
        insert cartOffer;
    }

    @isTest
    public static void deleteOfferWithCart(){
        
        Offer__c lOffer = [SELECT Id FROM Offer__c WHERE RecordType.DeveloperName = 'Fixa' LIMIT 1];

        Test.startTest();
        
        try{
            Database.delete(lOffer);
        } catch(Exception e){
            system.assert(e.getMessage().contains(System.Label.DeleteActiveOfferCartValidation));
        }        
        
        
        Test.stopTest();

    } 


}