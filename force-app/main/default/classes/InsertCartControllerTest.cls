/*
---------------------------------------------------
@authors - Pedro Salles 
@company - Telefonica 
@date - 08/05/2020
@description - Classe de Teste da Controller do componente
de userIndicator
---------------------------------------------------
Changes
2020-09-30 @Alvaro B2C7551-402 - offer.AccountId__c removido do SOQL das listas em Offer__c

*/ 
@isTest
public class InsertCartControllerTest {
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
            
            Contact contact = new Contact();
            contact.Email = 'testeContact@teste.com';
            contact.AccountId = lAccount.Id;
            contact.LastName = 'Teste';
            insert contact;
            
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
            system.debug('AQUI OFERTA FIXA -->' + offer);
            offer.OfferCityCategory__c = 'B';
            lstOffer.add(offer);
            Offer__c offerMobile = DataFactory.createOfferMobile(lAccount.Id, 'Movel');
            offerMobile.DDDOferta__c = 'BR';
            lstOffer.add(offerMobile);
            lstOffer.add(DataFactory.createOfferMobile(lAccount.Id, 'AltaMovel'));
            insert lstOffer;
            
            List<Asset> lstAsset = new List<Asset>();
            Asset asset = DataFactory.createAsset(lAccount.Id, lBillingAccountFixed.Id, lServiceAccountFixed.Id, 'Fixa');
            lstAsset.add(asset);
            lstAsset.add(DataFactory.createAsset(lAccount.Id, lBillingAccountMobile.Id, lServiceAccountMobile.Id, 'Movel'));
            insert lstAsset;
            
            List<OfferFilter__c> lstOfferFilter = new List<OfferFilter__c>();
            lstOfferFilter.add(DataFactory.createOfferFilter('Cabinet'));
            lstOfferFilter.add(DataFactory.createOfferFilterCabinet('CityCategoryAndCabinet'));
            
            lstOfferFilter.add(DataFactory.createOfferFilter('CityCategory'));
            lstOfferFilter.add(DataFactory.createOfferFilter('CityCategoryAndCabinet'));
            
            insert lstOfferFilter;
            
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
                CustomerType__c = 'Totalizado;Teste',
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
            
            MobileOffersSettings__c mobileSetts = new MobileOffersSettings__c();
            mobileSetts.Name ='DDD_Ofertas';
            mobileSetts.DDDOferta__c ='65;64';
            insert mobileSetts;
        }
    }
    
    @isTest
    public static void getUserIndicator(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            System.debug('@jitalo - getUserIndicator');
            Map<String,Object> accountMap = new Map<String,Object>();
            
            Account lAccount = [ SELECT Id,Name, OwnerId FROM Account LIMIT 1];
            system.debug('THIAGO ACCOUNT' +lAccount);
            List<Offer__c> loffer = [ SELECT Id,IsActive__c, OfferCityCategory__c, Technology__c, BroadBandAttribute__c, RecordType.DeveloperName FROM  Offer__c WHERE RecordType.DeveloperName = 'Fixa']; 
            system.debug('# OFFER' +loffer);
            
            Offer__c lofferAlta = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName = 'AltaMovel' LIMIT 1];  
            Id userId = UserInfo.getUserId();
            
            
            Id idOfferFixed;
            Id idOfferMobile;
            Id idOfferMobileAlta;

            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];

            
            Test.startTest();
            
            List<AccountRetentionController.BillingAccount> lLstFixed = AccountRetentionController.getAccountRetentionFixed( lCustomerInteraction.Id);
            system.debug('AQUI A LISTA DE FIXA -->' + lLstFixed);
            for(AccountRetentionController.BillingAccount itemBilling : lLstFixed){
                if(itemBilling.selectedOfferId != null && String.isNotEmpty(itemBilling.selectedOfferId)  ){
                    for(AccountRetentionController.Offer itemOffer : itemBilling.ltOffer){
                        idOfferFixed = itemOffer.idOffer;                    
                    }
                    itemBilling.selectedOfferId = idOfferFixed;
                    
                }
            }
            system.debug('AQUI O ID idOfferFixed -->' + idOfferFixed);
            List<AccountRetentionController.BillingAccount> lLstMobile = new List<AccountRetentionController.BillingAccount>(); 
            
            List<AccountRetentionController.Offer> lLstMobileAlta = new List<AccountRetentionController.Offer>();
            
            accountMap = AccountRetentionController.getAccountRetentionMobile(lCustomerInteraction.Id);
            
            lLstMobile.addAll((List<AccountRetentionController.BillingAccount>) accountMap.get('ltBillingAccount'));
            for(AccountRetentionController.BillingAccount itemBilling : lLstMobile){
                if(itemBilling.ltAssetMovel != null && !itemBilling.ltAssetMovel.isEmpty()){
                    for(AccountRetentionController.AssetMovel itemAsset : itemBilling.ltAssetMovel ){
                        for(AccountRetentionController.Offer itemOffer : itemAsset.ltOffer){
                            idOfferMobile = itemOffer.idOffer;
                        }
                        itemAsset.selectedOfferId = idOfferMobile;
                    }
                }            
            }
            
            
            //lLstMobileAlta.addAll((List<AccountRetentionController.Offer>) accountMap.get('ltOfferAlta'));
            lLstMobileAlta.addAll((List<AccountRetentionController.Offer>) AccountRetentionController.getOffer(lAccount.Id).get('ltOfferAlta'));
            for(AccountRetentionController.Offer itemOffer : lLstMobileAlta){            
                idOfferMobileAlta = itemOffer.idOffer;                    
            }
            
            String OfferId = '';
            for(Offer__c item : loffer){
                OfferId += (item.Id != null ? item.Id : '') + ',';
            }
            
            
            OfferId = JSON.serialize(OfferId);
            OfferId = OfferId.replace('"', '["');
            OfferId = OfferId.replace(',["', '"]');
            OfferId = OfferId.replace(',', '","');
            
            String JSONFixed = JSON.serialize(lLstFixed);
            String JSONMobile = JSON.serialize(lLstMobile);
            String JSONMobileAlta = JSON.serialize(lLstMobileAlta);
            
            accountMap = CardOfferController.getBillingAccountCard(JSONFixed, JSONMobile, JSONMobileAlta, idOfferMobileAlta, lAccount.Id, userId); 
            
            List<CardOfferController.billingAccountCard> ltProposal = new List<CardOfferController.billingAccountCard>();
            ltProposal.addAll((List<CardOfferController.billingAccountCard>) accountMap.get('ltCardProposal'));
            
            String ltProposalJSON = JSON.serialize(ltProposal);
            system.debug('Offer Id :' + OfferId);
            system.debug('Proposal :' + ltProposalJSON);
            system.debug('Account Id :' + lAccount.Id);
            system.debug('OfferAlta Id :' + idOfferMobileAlta);
            system.debug('User Id :' + lAccount.OwnerId);
            system.debug('JSONFixed :' + JSONFixed);
            system.debug('JSONMobile :' + JSONMobile);
            Id idFixa = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName = 'Fixa'].Id; 
            
            system.debug('AQUI TESTE ID FIXO !! -->' + idFixa);
            
            InsertCartController.setInsertOffer(OfferId, ltProposalJSON,lCustomerInteraction.Id, idOfferMobileAlta,lAccount.OwnerId, JSONFixed, JSONMobile);
            Test.stopTest();      
        } 
    }
    
    @isTest
    public static void getUserIndicator2(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            Test.startTest();
            Map<String,Object> accountMap = new Map<String,Object>();
            
            Account lAccount = [ SELECT Id,Name, OwnerId FROM Account LIMIT 1];
            List<Offer__c> lofferNull = new List<Offer__c>();
            List<Offer__c> loffer = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName = 'Fixa' LIMIT 1]; 
            // Offer__c lofferAlta = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName = 'AltaMovel' LIMIT 1];  
            Id userId = UserInfo.getUserId();
            
            
            Id idOfferFixed;
            Id idOfferMobile;
            Id idOfferMobileAlta;

            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];
            
            List<AccountRetentionController.BillingAccount> lLstFixed = AccountRetentionController.getAccountRetentionFixed(lCustomerInteraction.Id);



            
            
            for(AccountRetentionController.BillingAccount itemBilling : lLstFixed){
                itemBilling.selectedOfferId = loffer[0].Id;
                if(itemBilling.selectedOfferId != null && String.isNotEmpty(itemBilling.selectedOfferId)){
                    
                    itemBilling.setCityCategories.add('A');
                    itemBilling.setCabinet.add(true);
                    itemBilling.setCabinet.add(false);
                    itemBilling.setOfferLevel.add('Nivel_1');
                    itemBilling.speedSelected = '25';
                    itemBilling.tvPlanSelected = 'Sem TV';
                    itemBilling.fixedLineSelected = 'Vivo Fixo Ilimitado';
                    itemBilling.offerGroupSelected = 'Retenção';
                    itemBilling.accTechnology = 'FTTH';
                    
                    List<AccountRetentionController.Offer> lstOffer = AccountRetentionController.getOfferFilterFixed(itemBilling);
                    for(AccountRetentionController.Offer itemOffer : lstOffer){
                        idOfferFixed = itemOffer.idOffer;                    
                    }
                    itemBilling.selectedOfferId = idOfferFixed;            
                }
            }
            
            List<AccountRetentionController.BillingAccount> lLstMobile = new List<AccountRetentionController.BillingAccount>(); 
            
            List<AccountRetentionController.Offer> lLstMobileAlta = new List<AccountRetentionController.Offer>();
            
            accountMap = AccountRetentionController.getAccountRetentionMobile(lCustomerInteraction.Id);
            
            lLstMobile.addAll((List<AccountRetentionController.BillingAccount>) accountMap.get('ltBillingAccount'));
            for(AccountRetentionController.BillingAccount itemBilling : lLstMobile){
                if(itemBilling.ltAssetMovel != null && !itemBilling.ltAssetMovel.isEmpty()){
                    for(AccountRetentionController.AssetMovel itemAsset : itemBilling.ltAssetMovel ){
                        for(AccountRetentionController.Offer itemOffer : itemAsset.ltOffer){
                            idOfferMobile = itemOffer.idOffer;
                        }
                        itemAsset.selectedOfferId = idOfferMobile;
                    }
                }            
            }
            
            
            
            lLstMobileAlta.addAll((List<AccountRetentionController.Offer>) AccountRetentionController.getOffer(lAccount.Id).get('ltOfferAlta'));
            for(AccountRetentionController.Offer itemOffer : lLstMobileAlta){            
                idOfferMobileAlta = itemOffer.idOffer;                    
            }
            
            String OfferId = '';
            for(Offer__c item : loffer){
                OfferId += (item.Id != null ? item.Id : '') + ',';
            }
            
            OfferId = JSON.serialize(OfferId);
            OfferId = OfferId.replace('"', '["');
            OfferId = OfferId.replace(',["', '"]');
            OfferId = OfferId.replace(',', '","');
            
            String JSONFixed = JSON.serialize(lLstFixed);
            String JSONMobile = JSON.serialize(lLstMobile);
            String JSONMobileAlta = JSON.serialize(lLstMobileAlta);
            
            accountMap = CardOfferController.getBillingAccountCard(JSONFixed, JSONMobile, JSONMobileAlta, idOfferMobileAlta, lCustomerInteraction.Id, userId); 
            
            List<CardOfferController.billingAccountCard> ltProposal = new List<CardOfferController.billingAccountCard>();
            ltProposal.addAll((List<CardOfferController.billingAccountCard>) accountMap.get('ltCardProposal'));
            
            String ltProposalJSON = JSON.serialize(ltProposal);
            system.debug('Offer Id :' + OfferId);
            system.debug('Proposal :' + ltProposalJSON);
            system.debug('Account Id :' + lAccount.Id);
            system.debug('OfferAlta Id :' + idOfferMobileAlta);
            system.debug('User Id :' + lAccount.OwnerId);
            system.debug('JSONFixed :' + JSONFixed);
            system.debug('JSONMobile :' + JSONMobile);
            
            InsertCartController.setInsertOffer(OfferId, ltProposalJSON,lCustomerInteraction.Id, idOfferMobileAlta,lAccount.OwnerId, JSONFixed, JSONMobile);
            Test.stopTest();
            
        } 
    }
    
    @isTest
    public static void getUserIndicator3(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            System.debug('@jitalo - getUserIndicator3');
            Map<String,Object> accountMap = new Map<String,Object>();
            
            Account lAccount = [ SELECT Id,Name, OwnerId FROM Account LIMIT 1];
            system.debug('THIAGO ACCOUNT' +lAccount);
            List<Offer__c> loffer = [ SELECT Id,IsActive__c, OfferCityCategory__c, Technology__c, BroadBandAttribute__c, RecordType.DeveloperName FROM  Offer__c WHERE RecordType.DeveloperName = 'Fixa']; 
            system.debug('# OFFER' +loffer);
            
            Offer__c lofferAlta = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName = 'AltaMovel' LIMIT 1];  
            Id userId = UserInfo.getUserId();
            
            
            Id idOfferFixed;
            Id idOfferMobile;
            Id idOfferMobileAlta = null;

            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];

            
            Test.startTest();
            
            List<AccountRetentionController.BillingAccount> lLstFixed = AccountRetentionController.getAccountRetentionFixed( lCustomerInteraction.Id);
            system.debug('AQUI A LISTA DE FIXA -->' + lLstFixed);
            for(AccountRetentionController.BillingAccount itemBilling : lLstFixed){
                if(itemBilling.selectedOfferId != null && String.isNotEmpty(itemBilling.selectedOfferId)  ){
                    for(AccountRetentionController.Offer itemOffer : itemBilling.ltOffer){
                        idOfferFixed = itemOffer.idOffer;                    
                    }
                    itemBilling.selectedOfferId = idOfferFixed;
                    
                }
            }
            system.debug('AQUI O ID idOfferFixed -->' + idOfferFixed);
            List<AccountRetentionController.BillingAccount> lLstMobile = new List<AccountRetentionController.BillingAccount>(); 
            
            List<AccountRetentionController.Offer> lLstMobileAlta = new List<AccountRetentionController.Offer>();
            
            accountMap = AccountRetentionController.getAccountRetentionMobile(lCustomerInteraction.Id);
            
            lLstMobile.addAll((List<AccountRetentionController.BillingAccount>) accountMap.get('ltBillingAccount'));
            for(AccountRetentionController.BillingAccount itemBilling : lLstMobile){
                if(itemBilling.ltAssetMovel != null && !itemBilling.ltAssetMovel.isEmpty()){
                    for(AccountRetentionController.AssetMovel itemAsset : itemBilling.ltAssetMovel ){
                        for(AccountRetentionController.Offer itemOffer : itemAsset.ltOffer){
                            idOfferMobile = itemOffer.idOffer;
                        }
                        itemAsset.selectedOfferId = idOfferMobile;
                    }
                }            
            }
            
            
            //lLstMobileAlta.addAll((List<AccountRetentionController.Offer>) accountMap.get('ltOfferAlta'));
            //lLstMobileAlta.addAll((List<AccountRetentionController.Offer>) AccountRetentionController.getOffer(lAccount.Id).get('ltOfferAlta'));
            //for(AccountRetentionController.Offer itemOffer : lLstMobileAlta){            
            //    idOfferMobileAlta = itemOffer.idOffer;                    
            //}
            
            String OfferId = '';
            for(Offer__c item : loffer){
                OfferId += (item.Id != null ? item.Id : '') + ',';
            }
            
            
            OfferId = JSON.serialize(OfferId);
            OfferId = OfferId.replace('"', '["');
            OfferId = OfferId.replace(',["', '"]');
            OfferId = OfferId.replace(',', '","');
            
            String JSONFixed = JSON.serialize(lLstFixed);
            String JSONMobile = JSON.serialize(lLstMobile);
            String JSONMobileAlta = JSON.serialize(lLstMobileAlta);
            
            accountMap = CardOfferController.getBillingAccountCard(JSONFixed, JSONMobile, JSONMobileAlta, idOfferMobileAlta, lCustomerInteraction.Id, userId); 
            
            List<CardOfferController.billingAccountCard> ltProposal = new List<CardOfferController.billingAccountCard>();
            ltProposal.addAll((List<CardOfferController.billingAccountCard>) accountMap.get('ltCardProposal'));
            
            String ltProposalJSON = JSON.serialize(ltProposal);
            system.debug('Offer Id :' + OfferId);
            system.debug('Proposal :' + ltProposalJSON);
            system.debug('Account Id :' + lAccount.Id);
            system.debug('OfferAlta Id :' + idOfferMobileAlta);
            system.debug('User Id :' + lAccount.OwnerId);
            system.debug('JSONFixed :' + JSONFixed);
            system.debug('JSONMobile :' + JSONMobile);
            Id idFixa = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName = 'Fixa'].Id; 
            
            system.debug('AQUI TESTE ID FIXO !! -->' + idFixa);
            
            CartAccount__c cartAccount = cartAccountTestFactory.start(lAccount.Id).isInsertCart(lAccount.Id).create();
            
            InsertCartController.setInsertOffer(OfferId, ltProposalJSON,lCustomerInteraction.Id, idOfferMobileAlta,lAccount.OwnerId, JSONFixed, JSONMobile);
            Test.stopTest();      
        } 
    }
    
    @isTest
    public static void getUserIndicator4(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            System.debug('@jitalo - getUserIndicator4');
            Map<String,Object> accountMap = new Map<String,Object>();
            
            Account lAccount = [ SELECT Id,Name, OwnerId FROM Account LIMIT 1];
            system.debug('THIAGO ACCOUNT' +lAccount);
            List<Offer__c> loffer = [ SELECT Id,IsActive__c, OfferCityCategory__c, Technology__c, BroadBandAttribute__c, RecordType.DeveloperName FROM  Offer__c WHERE RecordType.DeveloperName = 'Fixa']; 
            system.debug('# OFFER' +loffer);
            
            Offer__c lofferAlta = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName = 'AltaMovel' LIMIT 1];  
            Id userId = UserInfo.getUserId();
            
            
            Id idOfferFixed;
            Id idOfferMobile;
            Id idOfferMobileAlta = null;

            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];

            
            Test.startTest();
            
            List<AccountRetentionController.BillingAccount> lLstFixed = AccountRetentionController.getAccountRetentionFixed( lCustomerInteraction.Id);
            system.debug('AQUI A LISTA DE FIXA -->' + lLstFixed);
            for(AccountRetentionController.BillingAccount itemBilling : lLstFixed){
                if(itemBilling.selectedOfferId != null && String.isNotEmpty(itemBilling.selectedOfferId)  ){
                    for(AccountRetentionController.Offer itemOffer : itemBilling.ltOffer){
                        idOfferFixed = itemOffer.idOffer;                    
                    }
                    itemBilling.selectedOfferId = idOfferFixed;
                    
                }
            }
            system.debug('AQUI O ID idOfferFixed -->' + idOfferFixed);
            List<AccountRetentionController.BillingAccount> lLstMobile = new List<AccountRetentionController.BillingAccount>(); 
            
            List<AccountRetentionController.Offer> lLstMobileAlta = new List<AccountRetentionController.Offer>();
            
            accountMap = AccountRetentionController.getAccountRetentionMobile(lCustomerInteraction.Id);
            
            lLstMobile.addAll((List<AccountRetentionController.BillingAccount>) accountMap.get('ltBillingAccount'));
            for(AccountRetentionController.BillingAccount itemBilling : lLstMobile){
                if(itemBilling.ltAssetMovel != null && !itemBilling.ltAssetMovel.isEmpty()){
                    for(AccountRetentionController.AssetMovel itemAsset : itemBilling.ltAssetMovel ){
                        for(AccountRetentionController.Offer itemOffer : itemAsset.ltOffer){
                            idOfferMobile = itemOffer.idOffer;
                        }
                        itemAsset.selectedOfferId = idOfferMobile;
                    }
                }            
            }
            
            
            //lLstMobileAlta.addAll((List<AccountRetentionController.Offer>) accountMap.get('ltOfferAlta'));
            lLstMobileAlta.addAll((List<AccountRetentionController.Offer>) AccountRetentionController.getOffer(lAccount.Id).get('ltOfferAlta'));
            for(AccountRetentionController.Offer itemOffer : lLstMobileAlta){            
                idOfferMobileAlta = itemOffer.idOffer;                    
            }
            
            String OfferId = '';
            for(Offer__c item : loffer){
                OfferId += (item.Id != null ? item.Id : '') + ',';
            }
            
            
            OfferId = JSON.serialize(OfferId);
            OfferId = OfferId.replace('"', '["');
            OfferId = OfferId.replace(',["', '"]');
            OfferId = OfferId.replace(',', '","');
            
            String JSONFixed = JSON.serialize(lLstFixed);
            String JSONMobile = JSON.serialize(lLstMobile);
            String JSONMobileAlta = JSON.serialize(lLstMobileAlta);
            
            accountMap = CardOfferController.getBillingAccountCard(JSONFixed, JSONMobile, JSONMobileAlta, idOfferMobileAlta, lCustomerInteraction.Id, userId); 
            
            List<CardOfferController.billingAccountCard> ltProposal = new List<CardOfferController.billingAccountCard>();
            ltProposal.addAll((List<CardOfferController.billingAccountCard>) accountMap.get('ltCardProposal'));
            
            String ltProposalJSON = JSON.serialize(ltProposal);
            system.debug('Offer Id :' + OfferId);
            system.debug('Proposal :' + ltProposalJSON);
            system.debug('Account Id :' + lAccount.Id);
            system.debug('OfferAlta Id :' + idOfferMobileAlta);
            system.debug('User Id :' + lAccount.OwnerId);
            system.debug('JSONFixed :' + JSONFixed);
            system.debug('JSONMobile :' + JSONMobile);
            Id idFixa = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName = 'Fixa'].Id; 
            
            system.debug('AQUI TESTE ID FIXO !! -->' + idFixa);
            
            InsertCartController.setInsertOffer('',ltProposalJSON,lCustomerInteraction.Id, idOfferMobileAlta,lAccount.OwnerId, JSONFixed, JSONMobile);
            Test.stopTest();      
        }
    }
        
    @isTest
    public static void getInsertCartAccount(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            System.debug('@jitalo - getInsertCartAccount');
            Test.startTest();
            
            Map<String,Object> accountMap = new Map<String,Object>();
            Id idOfferFixed;
            Id idOfferMobile;
            Id idOfferMobileAlta;
            
            Account lAccount = [ SELECT Id,Name, OwnerId FROM Account LIMIT 1];

            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];

            
            CartAccount__c cartAccount = cartAccountTestFactory.start(lAccount.Id).isInsertCart(lAccount.Id).create();
            
            List<Offer__c> loffer = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName <> 'AltaMovel']; 
            Offer__c lofferAlta = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName = 'AltaMovel' LIMIT 1];  
            Id userId = UserInfo.getUserId();
            
            List<AccountRetentionController.BillingAccount> lLstFixed = AccountRetentionController.getAccountRetentionFixed( lCustomerInteraction.Id);
            system.debug('lLstFixed -->' + lLstFixed);
            
            for(AccountRetentionController.BillingAccount itemBilling : lLstFixed){
                itemBilling.setCityCategories.add('A');
                itemBilling.setCabinet.add(true);
                itemBilling.setCabinet.add(false);
                itemBilling.setOfferLevel.add('Nivel_1');
                itemBilling.speedSelected = '25';
                itemBilling.tvPlanSelected = 'Sem TV';
                itemBilling.fixedLineSelected = 'Vivo Fixo Ilimitado';
                itemBilling.offerGroupSelected = 'Retenção';
                itemBilling.accTechnology = 'FTTH';
                
                List<AccountRetentionController.Offer> lstOffer = AccountRetentionController.getOfferFilterFixed(itemBilling);
                
                for(AccountRetentionController.Offer itemOffer : lstOffer){
                    idOfferFixed = itemOffer.idOffer;                    
                }
                system.debug('idOfferFixed OFERTA FIXA -->' + idOfferFixed);
                itemBilling.selectedOfferId = idOfferFixed;            
                
            }
            
            List<AccountRetentionController.BillingAccount> lLstMobile = new List<AccountRetentionController.BillingAccount>(); 
            
            List<AccountRetentionController.Offer> lLstMobileAlta = new List<AccountRetentionController.Offer>();
            
            accountMap = AccountRetentionController.getAccountRetentionMobile(lCustomerInteraction.Id);
            
            lLstMobile.addAll((List<AccountRetentionController.BillingAccount>) accountMap.get('ltBillingAccount'));
            for(AccountRetentionController.BillingAccount itemBilling : lLstMobile){
                if(itemBilling.ltAssetMovel != null && !itemBilling.ltAssetMovel.isEmpty()){
                    for(AccountRetentionController.AssetMovel itemAsset : itemBilling.ltAssetMovel ){
                        for(AccountRetentionController.Offer itemOffer : itemAsset.ltOffer){
                            idOfferMobile = itemOffer.idOffer;
                        }
                        itemAsset.selectedOfferId = idOfferMobile;
                    }
                }            
            }
            
            
            
            lLstMobileAlta.addAll((List<AccountRetentionController.Offer>) AccountRetentionController.getOffer(lAccount.Id).get('ltOfferAlta'));
            for(AccountRetentionController.Offer itemOffer : lLstMobileAlta){            
                idOfferMobileAlta = itemOffer.idOffer;                    
            }
            
            
            
            String OfferId = '';
            for(Offer__c item : loffer){
                OfferId += (item.Id != null ? item.Id : '') + ',';
            }
            
            
            OfferId = JSON.serialize(OfferId);
            OfferId = OfferId.replace('"', '["');
            OfferId = OfferId.replace(',["', '"]');
            OfferId = OfferId.replace(',', '","');       
            String JSONFixed = JSON.serialize(lLstFixed);
            String JSONMobile = JSON.serialize(lLstMobile);
            String JSONMobileAlta = JSON.serialize(lLstMobileAlta);
            
            accountMap = CardOfferController.getBillingAccountCard(JSONFixed, JSONMobile, JSONMobileAlta, idOfferMobileAlta, lCustomerInteraction.Id, userId); 
            
            List<CardOfferController.billingAccountCard> ltProposal = new List<CardOfferController.billingAccountCard>();
            ltProposal.addAll((List<CardOfferController.billingAccountCard>) accountMap.get('ltCardProposal'));
            
            String ltProposalJSON = JSON.serialize(ltProposal);
            system.debug('Offer Id :' + OfferId);
            system.debug('Proposal :' + ltProposalJSON);
            system.debug('Account Id :' + lAccount.Id);
            system.debug('OfferAlta Id :' + idOfferMobileAlta);
            system.debug('User Id :' + lAccount.OwnerId);
            system.debug('JSONFixed :' + JSONFixed);
            system.debug('JSONMobile :' + JSONMobile);
            
            InsertCartController.setInsertOffer(OfferId, ltProposalJSON,lCustomerInteraction.Id, idOfferMobileAlta,lAccount.OwnerId, JSONFixed, JSONMobile);
            Test.stopTest();
            
        } 
    }
    
    @isTest
    public static void getInsertCartAccount1(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            System.debug('@jitalo - getInsertCartAccount1');
            Test.startTest();
            
            Map<String,Object> accountMap = new Map<String,Object>();
            Id idOfferFixed;
            Id idOfferMobile;
            Id idOfferMobileAlta;
            
            Account lAccount = [ SELECT Id,Name, OwnerId FROM Account LIMIT 1];
            
            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];

            
            
            List<Offer__c> loffer = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName <> 'AltaMovel']; 
            List<Offer__c> lofferAlta = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName = 'AltaMovel' LIMIT 1];  
            Id userId = UserInfo.getUserId();
            
            
            List<AccountRetentionController.BillingAccount> lLstFixed = AccountRetentionController.getAccountRetentionFixed( lCustomerInteraction.Id);
            for(AccountRetentionController.BillingAccount itemBilling : lLstFixed){
                itemBilling.setCityCategories.add('A');
                itemBilling.setCabinet.add(true);
                itemBilling.setCabinet.add(false);
                itemBilling.setOfferLevel.add('Nivel_1');
                itemBilling.speedSelected = '25';
                itemBilling.tvPlanSelected = 'Sem TV';
                itemBilling.fixedLineSelected = 'Vivo Fixo Ilimitado';
                itemBilling.offerGroupSelected = 'Retenção';
                itemBilling.accTechnology = 'FTTH';
                
                List<AccountRetentionController.Offer> lstOffer = AccountRetentionController.getOfferFilterFixed(itemBilling);
                
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
                        for(AccountRetentionController.Offer itemOffer : itemAsset.ltOffer){
                            idOfferMobile = itemOffer.idOffer;
                        }
                        itemAsset.selectedOfferId = idOfferMobile;
                    }
                }            
            }
            
            String OfferId = '';
            for(Offer__c item : loffer){
                OfferId += (item.Id != null ? item.Id : '') + ',';
            }
            
            OfferId = JSON.serialize(OfferId);
            OfferId = OfferId.replace('"', '["');
            OfferId = OfferId.replace(',["', '"]');
            OfferId = OfferId.replace(',', '","');
            
            String JSONFixed = JSON.serialize(lLstFixed);
            String JSONMobile = JSON.serialize(lLstMobile);
            String JSONMobileAlta = JSON.serialize(lLstMobileAlta);
            
            accountMap = CardOfferController.getBillingAccountCard(JSONFixed, JSONMobile, JSONMobileAlta, idOfferMobileAlta, lCustomerInteraction.Id, userId); 
            
            List<CardOfferController.billingAccountCard> ltProposal = new List<CardOfferController.billingAccountCard>();
            ltProposal.addAll((List<CardOfferController.billingAccountCard>) accountMap.get('ltCardProposal'));
            
            String ltProposalJSON = JSON.serialize(ltProposal);
            system.debug('Offer Id :' + OfferId);
            system.debug('Proposal :' + ltProposalJSON);
            system.debug('Account Id :' + lAccount.Id);
            system.debug('OfferAlta Id :' + idOfferMobileAlta);
            system.debug('User Id :' + lAccount.OwnerId);
            system.debug('JSONFixed :' + JSONFixed);
            system.debug('JSONMobile :' + JSONMobile);
            
            InsertCartController.setInsertOffer(OfferId, ltProposalJSON,lCustomerInteraction.Id, idOfferMobileAlta,lAccount.OwnerId, JSONFixed, JSONMobile);
            Test.stopTest();
            
        }
    }
    
    @isTest
    public static void getInsertCartAccount2(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            System.debug('@jitalo - getInsertCartAccount2');
            Test.startTest();
            
            Map<String,Object> accountMap = new Map<String,Object>();
            Id idOfferFixed;
            Id idOfferMobile;
            Id idOfferMobileAlta;
            
            Account lAccount = [ SELECT Id,Name, OwnerId FROM Account LIMIT 1];

            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];

            
            
            List<Asset> lstAssetMobileByAccount = new List<Asset>();
            lstAssetMobileByAccount = [SELECT Id, Name FROM Asset WHERE AccountId =: lAccount.Id and Type__c = 'Movel'];
            Database.delete(lstAssetMobileByAccount);
            
            Asset assetFixed = [SELECT Id, ProductType__c, Speed__c, Technology__c FROM Asset WHERE AccountId =: lAccount.Id AND Type__c = 'Fixa' AND Technology__c = 'FTTH' LIMIT 1];
            assetFixed.ProductType__c = 'BANDA LARGA';
            assetFixed.Speed__c = '50';
            Database.update(assetFixed);
            
            List<Offer__c> loffer = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName <> 'AltaMovel']; 
            List<Offer__c> lofferAlta = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName = 'AltaMovel' LIMIT 1];  
            Id userId = UserInfo.getUserId();
            
            
            List<AccountRetentionController.BillingAccount> lLstFixed = AccountRetentionController.getAccountRetentionFixed( lCustomerInteraction.Id);
            for(AccountRetentionController.BillingAccount itemBilling : lLstFixed){
                
                itemBilling.setCityCategories.add('A');
                itemBilling.setCabinet.add(true);
                itemBilling.setCabinet.add(false);
                itemBilling.setOfferLevel.add('Nivel_1');
                itemBilling.speedSelected = '25';
                itemBilling.tvPlanSelected = 'Sem TV';
                itemBilling.fixedLineSelected = 'Vivo Fixo Ilimitado';
                itemBilling.offerGroupSelected = 'Retenção';
                itemBilling.accTechnology = 'FTTH';
                
                List<AccountRetentionController.Offer> lstOffer = AccountRetentionController.getOfferFilterFixed(itemBilling);
                
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
                        for(AccountRetentionController.Offer itemOffer : itemAsset.ltOffer){
                            idOfferMobile = itemOffer.idOffer;
                        }
                        itemAsset.selectedOfferId = idOfferMobile;
                    }
                }            
            }
            
            String OfferId = '';
            for(Offer__c item : loffer){
                OfferId += (item.Id != null ? item.Id : '') + ',';
            }
            
            OfferId = JSON.serialize(OfferId);
            OfferId = OfferId.replace('"', '["');
            OfferId = OfferId.replace(',["', '"]');
            OfferId = OfferId.replace(',', '","');
            
            String JSONFixed = JSON.serialize(lLstFixed);
            String JSONMobile = JSON.serialize(lLstMobile);
            String JSONMobileAlta = JSON.serialize(lLstMobileAlta);
            
            
            List<AccountRetentionController.Offer> ltOffersAltaMovel = new List<AccountRetentionController.Offer>();
            ltOffersAltaMovel.addAll((List<AccountRetentionController.Offer>) AccountRetentionController.getOffer(lAccount.Id).get('ltOfferAlta'));
            
            System.debug('ID DA OFERTA MÓVEL: *********************************');
            System.debug(ltOffersAltaMovel[0].idOffer);
            idOfferMobileAlta = ltOffersAltaMovel[0].idOffer;
            accountMap = CardOfferController.getBillingAccountCard(JSONFixed, JSONMobile, JSONMobileAlta, idOfferMobileAlta, lCustomerInteraction.Id, userId); 
            
            List<CardOfferController.billingAccountCard> ltProposal = new List<CardOfferController.billingAccountCard>();
            ltProposal.addAll((List<CardOfferController.billingAccountCard>) accountMap.get('ltCardProposal'));
            
            String ltProposalJSON = JSON.serialize(ltProposal);
            
            System.debug('Id da Oferta Alta móvel: ');
            System.debug(idOfferMobileAlta);
            InsertCartController.setInsertOffer(OfferId, ltProposalJSON,lCustomerInteraction.Id, idOfferMobileAlta,lAccount.OwnerId, JSONFixed, JSONMobile);
            Test.stopTest();
            
        }
    }
    
    @isTest
    public static void getInsertCartAccount3(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
            System.debug('@jitalo - getInsertCartAccount3');
            Test.startTest();
            
            Map<String,Object> accountMap = new Map<String,Object>();
            Id idOfferFixed;
            Id idOfferMobile;
            Id idOfferMobileAlta;
            
            Account lAccount = [ SELECT Id,Name, OwnerId FROM Account LIMIT 1];

            vlocity_cmt__CustomerInteraction__c lCustomerInteraction = [ SELECT Id FROM vlocity_cmt__CustomerInteraction__c LIMIT 1];

            
            
            List<Asset> lstAssetMobileByAccount = new List<Asset>();
            lstAssetMobileByAccount = [SELECT Id, Name FROM Asset WHERE AccountId =: lAccount.Id and Type__c = 'Movel'];
            Database.delete(lstAssetMobileByAccount);
            
            Asset assetFixed = [SELECT Id, ProductType__c, Speed__c, Technology__c FROM Asset WHERE AccountId =: lAccount.Id AND Type__c = 'Fixa' AND Technology__c = 'FTTH' LIMIT 1];
            assetFixed.ProductType__c = 'BANDA LARGA';
            assetFixed.Speed__c = '50';
            Database.update(assetFixed);
            
            List<Offer__c> loffer = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName <> 'AltaMovel']; 
            List<Offer__c> lofferAlta = [ SELECT Id FROM  Offer__c WHERE RecordType.DeveloperName = 'AltaMovel' LIMIT 1];  
            Id userId = UserInfo.getUserId();
            
            
            List<AccountRetentionController.BillingAccount> lLstFixed = AccountRetentionController.getAccountRetentionFixed( lCustomerInteraction.Id);
            for(AccountRetentionController.BillingAccount itemBilling : lLstFixed){
                
                itemBilling.setCityCategories.add('A');
                itemBilling.setCabinet.add(true);
                itemBilling.setCabinet.add(false);
                itemBilling.setOfferLevel.add('Nivel_1');
                itemBilling.speedSelected = '25';
                itemBilling.tvPlanSelected = 'Sem TV';
                itemBilling.fixedLineSelected = 'Vivo Fixo Ilimitado';
                itemBilling.offerGroupSelected = 'Retenção';
                itemBilling.accTechnology = 'FTTH';
                
                List<AccountRetentionController.Offer> lstOffer = AccountRetentionController.getOfferFilterFixed(itemBilling);	
                
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
                        for(AccountRetentionController.Offer itemOffer : itemAsset.ltOffer){
                            idOfferMobile = itemOffer.idOffer;
                        }
                        itemAsset.selectedOfferId = idOfferMobile;
                    }
                }            
            }
            
            String OfferId = '';
            for(Offer__c item : loffer){
                OfferId += (item.Id != null ? item.Id : '') + ',';
            }
            
            
            
            OfferId = JSON.serialize(OfferId);
            OfferId = OfferId.replace('"', '["');
            OfferId = OfferId.replace(',["', '"]');
            OfferId = OfferId.replace(',', '","');
            
            String JSONFixed = JSON.serialize(lLstFixed);
            String JSONMobile = JSON.serialize(lLstMobile);
            String JSONMobileAlta = JSON.serialize(lLstMobileAlta);
            
            
            List<AccountRetentionController.Offer> ltOffersAltaMovel = new List<AccountRetentionController.Offer>();
            ltOffersAltaMovel.addAll((List<AccountRetentionController.Offer>) AccountRetentionController.getOffer(lAccount.Id).get('ltOfferAlta'));
            
            
            
            // idOfferMobileAlta = ltOffersAltaMovel[0].idOffer;
            accountMap = CardOfferController.getBillingAccountCard(JSONFixed, JSONMobile, JSONMobileAlta, idOfferMobileAlta, lCustomerInteraction.Id, userId); 
            
            List<CardOfferController.billingAccountCard> ltProposal = new List<CardOfferController.billingAccountCard>();
            ltProposal.addAll((List<CardOfferController.billingAccountCard>) accountMap.get('ltCardProposal'));
            
            String ltProposalJSON = JSON.serialize(ltProposal);
            
            
            InsertCartController.setInsertOffer('[]', ltProposalJSON,lCustomerInteraction.Id, idOfferMobileAlta,lAccount.OwnerId, JSONFixed, JSONMobile);
            Test.stopTest();
            
        }
    }
    
    @isTest
    public static void userHavePermissionSet(){
        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];
        System.runAs(u){
        System.debug('@jitalo - userHavePermissionSet');
        Boolean havePermission = InsertCartController.userHavePermissionSet();
        
        system.assertEquals(false, havePermission);
        
        }
    }

    @isTest
    public static void accountHaveLimitTest(){
        Account acc = new Account(name = 'Teste');
        insert acc;
        Test.startTest();
        Boolean haveLimit = InsertCartController.accountHaveLimit(acc.id);
        Test.stopTest();
        System.assertEquals(true, haveLimit);
    }
}