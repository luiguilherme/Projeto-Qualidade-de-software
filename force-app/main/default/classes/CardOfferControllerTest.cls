/*
---------------------------------------------------
@authors - Geimison Oliveira | Pedro Salles 
@company - Telefonica 
@date - 08/04/2020
@description - Classe de Teste da Controller dos componentes 
customizados de Ofertas para retenção de contas 
do tipo Fixa e Móvel
---------------------------------------------------

*/
@isTest
public class CardOfferControllerTest {
    
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
            
            Account lAccount = DataFactory.createAccount();
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
            lstAsset.add(DataFactory.createAsset(lAccount.Id, lBillingAccountMobile.Id, lServiceAccountMobile.Id, 'Móvel'));
            insert lstAsset;
            
            List<OfferFilter__c> lstOfferFilter = new List<OfferFilter__c>();
            lstOfferFilter.add(DataFactory.createOfferFilter('Cabinet'));
            lstOfferFilter.add(DataFactory.createOfferFilter('CityCategory'));
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
        }
    }
    
    @isTest
    public static void getBillingAccountCardTest(){
        
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            
            Map<String,Object> accountMap = new Map<String,Object>(); 
            Account lAccount = [ SELECT Id, Name FROM Account LIMIT 1];
            Id userId = UserInfo.getUserId();
            
            Test.startTest();       
            Id idOfferFixed;
            Id idOfferMobile;
            Id idOfferMobileAlta;
            
            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            List<AccountRetentionController.BillingAccount> lLstFixed = AccountRetentionController.getAccountRetentionFixed(lCustomerInteraction.Id);
            for(AccountRetentionController.BillingAccount itemBilling : lLstFixed){
                
                itemBilling.setCityCategories = new List<String>{'A'};
                    itemBilling.setCabinet.add(true);
                itemBilling.setCabinet.add(false);
                itemBilling.setOfferLevel.add('Nivel_1');
                itemBilling.speedSelected = '25';
                itemBilling.tvPlanSelected = 'Sem TV';
                itemBilling.fixedLineSelected = 'Vivo Fixo Ilimitado';
                itemBilling.offerGroupSelected = 'Retenção';
                itemBilling.accTechnology = 'FTTH';
                
                List<AccountRetentionController.Offer> lstOffer = AccountRetentionController.getOfferFilterFixed(itemBilling);
                itemBilling.ltOffer = lstOffer;
                for(AccountRetentionController.Offer itemOffer : lstOffer){
                    idOfferFixed = itemOffer.idOffer;                    
                }
                itemBilling.selectedOfferId = idOfferFixed;            
                
            }
            
            List<AccountRetentionController.BillingAccount> lLstMobile = new List<AccountRetentionController.BillingAccount>(); 
            
            List<AccountRetentionController.Offer> lLstMobileAlta = new List<AccountRetentionController.Offer>();
            
            accountMap = AccountRetentionController.getAccountRetentionMobile(lCustomerInteraction.Id);
            
            lLstMobile.addAll((List<AccountRetentionController.BillingAccount>) accountMap.get('ltBillingAccount'));
            for(AccountRetentionController.BillingAccount itemBilling : lLstMobile){
                if(itemBilling.ltAssetMovel != null && !itemBilling.ltAssetMovel.isEmpty()){
                    for(AccountRetentionController.AssetMovel itemAsset : itemBilling.ltAssetMovel ){
                        if(itemAsset.ltOffer != null && !itemAsset.ltOffer.isEmpty()){
                            for(AccountRetentionController.Offer itemOffer : itemAsset.ltOffer){
                                idOfferMobile = itemOffer.idOffer;
                            }
                            itemAsset.selectedOfferId = idOfferMobile;
                        }
                    }
                }            
            }
            lLstMobileAlta.addAll((List<AccountRetentionController.Offer>) AccountRetentionController.getOffer(lAccount.Id).get('ltOfferAlta'));
            
            for(AccountRetentionController.Offer itemOffer : lLstMobileAlta){            
                idOfferMobileAlta = itemOffer.idOffer;                    
            }
            
            String JSONFixed = JSON.serialize(lLstFixed);
            String JSONMobile = JSON.serialize(lLstMobile);
            String JSONMobileAlta = JSON.serialize(lLstMobileAlta);
            
            CardOfferController.getBillingAccountCard(JSONFixed, JSONMobile, JSONMobileAlta, idOfferMobileAlta, lAccount.Id, userId);
            
            Test.stopTest();
        }
    } 
    
    
}