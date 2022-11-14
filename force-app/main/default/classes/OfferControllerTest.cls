@isTest
public inherited sharing class OfferControllerTest {
    
    @testSetup 
    static void setup() {
        Account lAccount = DataFactory.createAccount();
        insert lAccount;
        
        Offer__c offerTest = DataFactory.createOffer();
		insert offerTest;

        Offer__c offerSA = DataFactory.createAdditionalService();
		insert offerSA;
    }
    
    public static testMethod void run(){
        OfferController.Filters filters = new OfferController.Filters();

        filters.technology = 'FTTH';
        filters.broadBand = '200';
        filters.servAdicionais = false;
        filters.isActive = true;

        Test.startTest();
        PagedResult pr = OfferController.getOffers(filters, 1);
        System.assert(pr.totalItemCount > 0);
        Test.stopTest();
    }

    public static testMethod void verifyResults(){
        OfferController.Filters filters = new OfferController.Filters();

        filters.searchKey = 'teste';
        filters.technology = 'FTTC';
        filters.offerGroup = 'Base';
        filters.bundleType = '1P';
        filters.broadBand = '25';
        filters.tvAttribute = 'Full HD';
        filters.promotionGroup = 'Rentabilização';
        filters.homeAssist = 'y';
        filters.servAdicionais = true;
        filters.isActive = false;

        Test.startTest();
        PagedResult pr = OfferController.getOffers(filters, 1);
        System.assert(pr.totalItemCount == 0);
        Test.stopTest();
    }

    public static testMethod void verifyResultsNoHomeAssist(){
        OfferController.Filters filters = new OfferController.Filters();

        filters.searchKey = 'teste';
        filters.technology = 'FTTC';
        filters.offerGroup = 'Base';
        filters.bundleType = '1P';
        filters.broadBand = '25';
        filters.tvAttribute = 'Full HD';
        filters.promotionGroup = 'Rentabilização';
        filters.homeAssist = 'n';
        filters.servAdicionais = true;
        filters.isActive = false;

        Test.startTest();
        PagedResult pr = OfferController.getOffers(filters, 1);
        System.assert(pr.totalItemCount == 0);
        Test.stopTest();
    }

    public static testMethod void verifyAdditionalServices() {
        Test.startTest();
        List<Offer__c> servAdicionais =  OfferController.getAdditionalServices();
        System.assert(servAdicionais.size() > 0);
        Test.stopTest();
    }
}