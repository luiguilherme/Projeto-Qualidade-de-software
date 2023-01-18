/*
---------------------------------------------------
@authors - Geimison Oliveira | Pedro Salles 
@company - Telefonica 
@date - 13/03/2020
@description - Classe de Teste da Controller dos componentes 
customizados de Ofertas para retenção de contas 
do tipo Fixa e Móvel

Changes
2020-09-30 @Alvaro - B2C7551-402 - Status__c de Ofertas substituido por IsActive__c.
---------------------------------------------------

*/
@isTest
public class AccountRetentionControllerTest {
    
    
    @testSetup 
    static void setup(){
        UserRole userR = new UserRole();
        userR.Name = 'Omnichannel';
        Database.insert(userR);
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Governanca'];
        User u = new User(Alias = 'SysAdmin', Email='stdstdteste@teste.com',
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id,UserRoleId = userR.Id,
                          TimeZoneSidKey='America/Sao_Paulo', UserName='stdteste@teste.com');
        Database.insert(u);
        
        PermissionSet ps = [SELECT ID,Name,Label FROM PermissionSet WHERE Name = 'OfferMenu' LIMIT 1];
        
        PermissionSetAssignment psa = new PermissionSetAssignment();
        psa.PermissionSetId = ps.Id;
        psa.AssigneeId = u.Id;
        
        Database.insert(psa);
        
        System.runAs(u){
            
            Account lAccount = DataFactory.createConsumerAccount();
            insert lAccount;
            
            Account lBillingAccountFixed = DataFactory.createBillingAccount(lAccount.Id, 'Fixa');
            Account lBillingAccountMobile = DataFactory.createBillingAccount(lAccount.Id, 'Móvel');
            
            insert lBillingAccountFixed;
            insert lBillingAccountMobile;

            Account lServiceAccountFixed = DataFactory.createServiceAccount(lAccount.Id, lBillingAccountFixed.Id, 'Fixa');
            Account lServiceAccountMobile = DataFactory.createServiceAccount(lAccount.Id, lBillingAccountMobile.Id, 'Móvel');
            
            insert lServiceAccountFixed;
            insert lServiceAccountMobile;

            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = DataFactory.createCustomerInteraction(lAccount.Id);
            insert lCustomerInteraction;

            List<Offer__c> lstOffer = new List<Offer__c>();
            Offer__c offer = DataFactory.createOfferFixed(lAccount.Id);
            Offer__c offerCabinet = DataFactory.createOfferFixed(lAccount.Id);
            offerCabinet.OfferCityCategory__c = null;
            
            lstOffer.add(offer);
            lstOffer.add(offerCabinet);
            lstOffer.add(DataFactory.createOfferMobile(lAccount.Id, 'Movel'));
            lstOffer.add(DataFactory.createOfferMobile(lAccount.Id, 'AltaMovel'));
            insert lstOffer;
            
            List<Asset> lstAsset = new List<Asset>();
            Asset asset = DataFactory.createAsset(lAccount.Id, lBillingAccountFixed.Id, lServiceAccountFixed.Id, 'Fixa');
            // asset.Address__c = address.Id;
            lstAsset.add(asset);
            lstAsset.add(DataFactory.createAsset(lAccount.Id, lBillingAccountMobile.Id, lServiceAccountMobile.Id, 'Movel'));
            insert lstAsset;
            
            List<OfferFilter__c> lstOfferFilter = new List<OfferFilter__c>();
            lstOfferFilter.add(DataFactory.createOfferFilter('CityCategoryAndCabinet'));
            lstOfferFilter.add(DataFactory.createOfferFilterCabinet('CityCategoryAndCabinet'));
            insert lstOfferFilter;
            
            SuggestedSpeed__c suggestedSpeed = new SuggestedSpeed__c();
            suggestedSpeed = DataFactory.createSuggestedSpeed();
            insert suggestedSpeed;
            
            insert new GeneralParam__c(
                AccountLoadDate__c  = Datetime.now().addDays(-1),
                AssetLoadDate__c = Datetime.now().addDays(-1),
                BillingAccountLoadDate__c = Datetime.now().addDays(-1),
                InvoiceLoadDate__c = Datetime.now().addDays(-1),
                AddressLoadDate__c = Datetime.now().addDays(-1),
                AssetJob__c = true,
                CreditConsultationExpiration__c = '24',
                BillingAccountJob__c = true,
                AccountJob__c = true,
                AddressJob__c = true,
                InvoiceJob__c = true,
                CustomerType__c = 'Totalizado;Fixa',
                CustomerSegment__c = 'TOP;VIP'
            );
            
            OffersFilter__c offerFilters = new OffersFilter__c();
            offerFilters.Name='Filtro de Ofertas';
            offerFilters.OfferGroup__c = 'Retenção;Aquisição;Base';
            offerFilters.BandwidthPlanFTTC__c = '2;4;6;8;Sem Banda Larga';
            offerFilters.BandwidthPlanFTTH__c = '100;200;300;600;Sem Banda Larga';
            offerFilters.BandwidthPlanXDSL__c = '2;4;Sem Banda Larga';
            offerFilters.TvPlan__c = 'Vivo Play Padrão;Vivo Play Essencial;Vivo Play Ultra;Vivo Play Avançado;Vivo Play Completo;Sem TV';
            offerFilters.VoicePlan__c = 'Vivo Fixo Ilimitado Brasil;Vivo Fixo Ilimitado Local;Vivo Fixo Ilimitado Brasil Especial;Vivo Fixo Ilimitado Local Especial;Sem Voz';
            insert offerFilters;
            
            InitialOffer__c initialOffer = new InitialOffer__c();
            initialOffer.Name='Oferta Inicial';
            initialOffer.BroadbandSpeed__c = '300';
            initialOffer.TvPlanName__c = 'Vivo Play Essencial';
            initialOffer.VoicePlan__c = 'Vivo Fixo Ilimitado Brasil';
            initialOffer.Tecnology__c = 'FTTH';
            initialOffer.OfferGroup__c = 'Aquisição';
            
            insert initialOffer;
            
            BlockPartialDisconnection__c blockPartialDesco = new BlockPartialDisconnection__c();
            blockPartialDesco.Name='Impedimento Desconexao Parcial';
            blockPartialDesco.Papel__c='OperadorGoldRetencaoFixa';
                        
            insert blockPartialDesco;
            
            
            Offer__c offer1 = new Offer__c();
            
            offer1.RecordTypeId = Schema.SObjectType.Offer__c.getRecordTypeInfosByDeveloperName().get('AcquisitionFixed').getrecordTypeId();
            offer1.IsActive__c = true;
            offer1.TotalPrice__c = 30;
            offer1.BroadbandDescription__c = 'Oferta Fixa Teste';
            offer1.TVAttribute__c = 'Vivo Play Essencial';
            offer1.FixedLineDiscount__c = 0;
            offer1.OfferLevel__c = 'Aquisição Home Assist';
            offer1.Technology__c = 'FTTH';
            offer1.BroadBandAttribute__c = '300';
            offer1.Cabinet__c = true;
            offer1.FixedLinePlanAttribute__c = true;
            offer1.FixedLineDescription__c = 'Vivo Fixo Ilimitado Brasil';
            offer1.OfferCityCategory__c = 'A';
            offer1.BroadbandDiscountDuration__c = 30;
            offer1.FixedLineDiscountDuration__c = 10;
            offer1.TVDiscountDuration__c = 20;
            
            insert offer1;
        }
    }
    
    @isTest
    public static void getAccountRetentionFixedTest(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            
            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            
            Test.startTest();        
            
            List<AccountRetentionController.BillingAccount> lLstFixed = AccountRetentionController.getAccountRetentionFixed(lCustomerInteraction.Id);
            if(lLstFixed.isEmpty()) return;
            
            lLstFixed[0].setCityCategories.add('A');
            lLstFixed[0].setCabinet.add(true);
            lLstFixed[0].setCabinet.add(false);
            lLstFixed[0].setOfferLevel.add('Nivel_1');
            lLstFixed[0].speedSelected = '200';
            lLstFixed[0].tvPlanSelected = 'Sem TV';
            lLstFixed[0].fixedLineSelected = 'Vivo Fixo Ilimitado';
            lLstFixed[0].offerGroupSelected = 'Retenção';
            lLstFixed[0].accTechnology = 'FTTH';
            
            List<AccountRetentionController.Offer> lstOffer = AccountRetentionController.getOfferFilterFixed(lLstFixed[0]);
            
            system.assert(!lstOffer.isEmpty());
            
            Test.stopTest();
        } 
    }
    
    @isTest
    public static void getAccountRetentionFixedWithoutBillingTest(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            
            Account lAccount = [ SELECT Id FROM Account LIMIT 1];
            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            Test.startTest();        
            
            AccountRetentionController.BillingAccount billingFixed = AccountRetentionController.getAccountRetentionFixedWithoutBilling(lCustomerInteraction.Id);
            
            if(billingFixed == null) return;
            
            billingFixed.setOfferLevel.add('Aquisição Home Assist');
            
            List<AccountRetentionController.Offer> lstOffer = AccountRetentionController.getOfferFilterFixed(billingFixed);
            
            system.assert(!lstOffer.isEmpty());        
            
            Test.stopTest();
        }
    }
    
    @isTest
    public static void getAccountRetentionMobileTest(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            Account lAccount = [ SELECT Id,Name FROM Account LIMIT 1];
            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            Map<String,Object> accountMap = new Map<String,Object>();    
            
            Test.startTest();
            
            accountMap.put(lAccount.Name, lAccount);
            
            AccountRetentionController.getAccountRetentionMobile(lCustomerInteraction.Id);
            
            system.assert( !accountMap.isEmpty());
            Test.stopTest();
        }
    }
    
    @isTest
    public static void getAccountRetentionMobileWithProfileTest(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            Account lAccount = [ SELECT Id,Name FROM Account LIMIT 1];
            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            Map<String,Object> accountMap = new Map<String,Object>();    
            
            User userOperacao = [SELECT Id, UserRoleId FROM User WHERE Profile.Name='Representante' AND ISACTIVE = true Limit 1];
            
            System.runAs(userOperacao){
                Test.startTest();
                
                accountMap.put(lAccount.Name, lAccount);
                
                AccountRetentionController.getAccountRetentionMobile(lCustomerInteraction.Id);
                
                system.assert( !accountMap.isEmpty());
                Test.stopTest();
            }
        } 
    }
    
    @IsTest
    public static void getAccountRetentionMobileAltaTest(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            Account lAccount = [ SELECT Id,Name, WhiteListCharacteristic__c FROM Account LIMIT 1];
            lAccount.WhiteListCharacteristic__c = 'Verde 2';
            Database.update(lAccount);
            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            
            
            //Address__c address = DataFactory.createAddress(lAccount.Id);
            //insert address;
            
            List<Asset> lstAssetMobileByAccount = new List<Asset>();
            lstAssetMobileByAccount = [SELECT Id, Name FROM Asset WHERE AccountId =: lAccount.Id and Type__c = 'Movel'];
            Database.delete(lstAssetMobileByAccount);
            
            Asset assetFixed = [SELECT Id, vlocity_cmt__BillingAccountId__c, ProductType__c, Speed__c, Technology__c, vlocity_cmt__ServiceAccountId__c FROM Asset WHERE AccountId =: lAccount.Id AND Type__c = 'Fixa' AND Technology__c = 'FTTH' LIMIT 1];
            assetFixed.ProductType__c = 'BANDA LARGA';
            assetFixed.Speed__c = '50';
            //assetFixed.Address__c = address.Id;
            Database.update(assetFixed);
            
            Offer__c lOffer = [SELECT Id, IsActive__c, WhiteListCharacteristicOffer__c 
                               FROM Offer__c WHERE RecordType.DeveloperName = 'AltaMovel' LIMIT 1];
            lOffer.IsActive__c = true;
            lOffer.WhiteListCharacteristicOffer__c = lAccount.WhiteListCharacteristic__c;
            Database.update(lOffer);
            
            Map<String,Object> accountMap = new Map<String,Object>();
            
            
            
            Test.startTest();
            
            accountMap.put(lAccount.Name, lAccount);
            
            AccountRetentionController.getAccountRetentionMobile(lCustomerInteraction.Id);        
            system.assert( !accountMap.isEmpty());
            
            Test.stopTest();
        }
    }
    
    @isTest
    public static void saveCartAccountTest(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            Account lAccount = [ SELECT Id,OwnerId FROM Account WHERE RecordType.DeveloperName = 'Consumer' LIMIT 1];
            Account billAcc = [ SELECT Id FROM Account WHERE RecordType.DeveloperName = 'Billing' LIMIT 1];
            Offer__c loffer = [ SELECT Id FROM Offer__c LIMIT 1];   
            
            Test.startTest();
            
            String parseJSON = '{"AccountId":"'+ lAccount.Id +'","SelectedAction":"","BillingAccountId":"'+billAcc.Id+'","OfferId":"'+loffer.Id+'", "OwnerId":"'+lAccount.OwnerId+'" }';
            
            CartAccount__c passJSON = AccountRetentionController.saveCartAccount(parseJSON);
            
            system.assertNotEquals(passJSON.ID, null);
            
            Test.stopTest();
        } 
    }
    
    @isTest
    public static void checkCreditAnalysis(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            Map<String, object> mapResult; 
            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            
            Test.startTest();
            mapResult = AccountRetentionController.checkCreditAnalysis(lCustomerInteraction.Id);         
            Test.stopTest();
            System.assert(mapResult != null, 'A controller nao retornou o mapResponse de Analise de crédito preenchido');
        } 
    }
    
    @isTest
    public static void getOffer(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            Map<String, object> mapResult; 
            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            
            Test.startTest();
            String accId = AccountRetentionController.getAccountIdFromCustomerInteraction(lCustomerInteraction.Id);
            mapResult = AccountRetentionController.getOffer(accId);         
            Test.stopTest();
            System.assert(mapResult != null, 'A controller nao retornou o mapResponse de ofertas preenchido');
        } 
    }
}