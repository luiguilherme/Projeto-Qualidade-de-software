@isTest
public class CartAccountTriggerTest {

    @testSetup 
    static void setup(){
        Account account = DataFactory.createAccount();
        insert account;

        List<Offer__c> lstOffer = new List<Offer__c>();

        lstOffer.add(DataFactory.createOfferMobile(account.Id, 'Movel'));
        lstOffer.add(DataFactory.createOfferMobile(account.Id, 'AltaMovel'));
        lstOffer.add(DataFactory.createOfferFixed(account.Id));

        insert lstOffer;

        CartAccount__c cartAccount = DataFactory.createCartAccount(account.Id);
        cartAccount.Status__c = 'SaleData';
        insert cartAccount;

        List<CartOffer__c> lstCartOffer = new List<CartOffer__c>();

        for (Offer__c itemLstOffer: lstOffer) {
            String recordTypeOffer = Schema.getGlobalDescribe().get('Offer__c').getDescribe().getRecordTypeInfosById().get(itemLstOffer.RecordTypeId).getDeveloperName();
            CartOffer__c cartOffer = DataFactory.createCartOffer(cartAccount.Id, itemLstOffer.Id);
            if (recordTypeOffer == 'Movel' || recordTypeOffer == 'AltaMovel') 
                cartOffer.RecordTypeId = Schema.SObjectType.CartOffer__c.getRecordTypeInfosByDeveloperName().get('Mobile').getrecordTypeId();
            else 
                cartOffer.RecordTypeId = Schema.SObjectType.CartOffer__c.getRecordTypeInfosByDeveloperName().get('Fixed').getrecordTypeId();
            lstCartOffer.add(cartOffer);
        }
        
        insert lstCartOffer;


    }

    @isTest
    public static void updateChipAmount(){      
        CartAccount__c cartAccount = [SELECT Id, ChipAmount__c FROM CartAccount__c LIMIT 1];

        Test.startTest();
        
        cartAccount.ChipAmount__c = 3;
        Database.update(cartAccount);
        cartAccount.ChipAmount__c = 2;
        Database.update(cartAccount);
        List<CartOffer__c> lstCartOffers = [SELECT CartId__c, OfferId__c, RecordType.DeveloperName FROM CartOffer__c WHERE CartId__c =: cartAccount.Id AND RecordType.DeveloperName = 'Chip'];
        System.assertEquals(2, lstCartOffers.size());
        
        Test.stopTest();
    }
    
    @isTest
    public static void updateReason(){      
        CartAccount__c cartAccount = [SELECT Id, ChipAmount__c, Status__c FROM CartAccount__c LIMIT 1];
        cartAccount.Status__c = 'RegistrationData';
        cartAccount.ChipAmount__c = 2;
        Database.update(cartAccount);

        List<CartOffer__c> lstCartOffers = [SELECT Reason__c FROM CartOffer__c WHERE CartId__c =: cartAccount.Id AND RecordType.DeveloperName = 'Chip'];
        CartOffer__c chip1 = lstCartOffers[0];
        CartOffer__c chip2 = lstCartOffers[1];
        chip1.Reason__c = 'Enabling';
        Database.update(chip1);
        chip2.Reason__c = 'Enabling';
        Database.update(chip2);  

        Test.startTest();
        cartAccount.Status__c = 'RegistrationData';
        Database.SaveResult result = Database.update(cartAccount);
        Test.stopTest();
        System.assert(result.isSuccess());

    } 

    @isTest
    public static void validaChipTest(){
        Test.startTest();
        Boolean hasFamilyPlan = true;
        Decimal chipAmount = 2;
      	Boolean result = CartAccountTriggerHandler.validaChip(hasFamilyPlan, chipAmount);        
        Test.stopTest();
        System.assertEquals(true, result);
    }
    
    @isTest
    public static void validaChipTestTwo(){
        Test.startTest();
        Boolean hasFamilyPlan = false;
        Decimal chipAmount = 2;
      	Boolean result = CartAccountTriggerHandler.validaChip(hasFamilyPlan, chipAmount);        
        Test.stopTest();
        System.assertEquals(true, result);
    }    
}