/*
---------------------------------------------------
@authors - Geimison Oliveira | Pedro Salles 
@company - Telefonica  
@date - 13/03/2020
@description - Classe Controller dos componentes 
customizados de Ofertas para retenção de contas 
do tipo Fixa e Móvel

Changes
2020-09-30 @Alvaro - B2C7551-481 - Get Offer Mobile - Filtro Customer Type (SOQL) - variavel acc (Linha 302);
2020-09-30 @Alvaro - B2C7551-402 - Linhas Alteradas: 146 - Novo campo no SOQL;  itemOffer.field2, field3 e field4 atualizado;
2020-09-30 @Alvaro - B2C7551-402 - Removido Asset__c e Status__c do SOQL de Offer__c;
2020-09-30 @Alvaro - B2C7551-402 - Comentados : insertCartAcc.OfferId__c = listField.OfferId; e insertCartAcc.BillingAccountId__c = listField.BillingAccountId;
2021-2-11 @Lucas - B2C7551-398 - Adicionado campo de Streaming
2021-2-11 @Lucas - B2C7551-553 - Adicionado campo de Sistema de origem para oferta móvel
2021-4-30 @Lucas - B2C7551- - Alteração no filtro de ofertas
2021-09-28 @jitalo - PTINFE-504,505,506 - Refatoração do Filtro de Ofertas para oferta fixa
---------------------------------------------------
*/
public class AccountRetentionController {
    public class BillingAccount {
        @AuraEnabled public Id idBilling {get; set;}
        @AuraEnabled public String name {get; set;}
        @AuraEnabled public Decimal totalPrice {get; set;}        
        @AuraEnabled public Decimal totalAmount {get; set;}        
        @AuraEnabled public List<Asset> ltAsset {get; set;}
        @AuraEnabled public List<AssetMovel> ltAssetMovel {get; set;}
        @AuraEnabled public List<Offer> ltOffer {get; set;}
        @AuraEnabled public Id selectedOfferId {get; set;}
        @AuraEnabled public Boolean hasAsset {get; set;}
        @AuraEnabled public Boolean hasMultipleAssets {get; set;}
        @AuraEnabled public Boolean hasOffer {get; set;}
        @AuraEnabled public String offerMessage {get; set;}
        @AuraEnabled public List<String> SpeedList {get; set;}
        @AuraEnabled public List<String> TVPlanList {get; set;}
        @AuraEnabled public List<String> FixedLineList {get; set;}
        @AuraEnabled public List<String> OfferGroupList {get; set;}
        @AuraEnabled public List<String> setCityCategories {get; set;}
        @AuraEnabled public List<Boolean> setCabinet {get; set;}
        @AuraEnabled public List<String> setOfferLevel {get; set;}
        @AuraEnabled public String speedSelected {get; set;}
        @AuraEnabled public String tvPlanSelected {get; set;}
        @AuraEnabled public String fixedLineSelected {get; set;}
        @AuraEnabled public String offerGroupSelected {get; set;}
        @AuraEnabled public String accTechnology {get; set;}
    }
        
    public class AssetMovel {
        @AuraEnabled public Id idBilling;
        @AuraEnabled public Asset itemAsset;
        @AuraEnabled public List<Asset> ltAsset;
        @AuraEnabled public List<Offer> ltOffer;
        @AuraEnabled public List<Offer> ltITVOffer;
        @AuraEnabled public Id selectedOfferId;
        @AuraEnabled public Id selectedITVOfferId;
        @AuraEnabled public String phone;
        @AuraEnabled public Boolean hasOffer;
        @AuraEnabled public Decimal priceCurrent;  
    }
    
    public class Offer {
        @AuraEnabled public Id idBilling {get; set;}
        @AuraEnabled public Id idOffer {get; set;}
        @AuraEnabled public Id selectedOfferId {get; set;}
        @AuraEnabled public Id selectedOfferAltaId {get; set;}
        @AuraEnabled public Decimal planTotalPrice {get; set;}
        @AuraEnabled public String offerMessag {get; set;}
        @AuraEnabled public String field1 {get; set;}
        @AuraEnabled public String field2 {get; set;}
        @AuraEnabled public String field3 {get; set;}
        @AuraEnabled public String field4 {get; set;}
        @AuraEnabled public String field5 {get; set;}
        @AuraEnabled public String field6 {get; set;}
        @AuraEnabled public String field7 {get; set;}
        @AuraEnabled public String field8 {get; set;}
        @AuraEnabled public String field10 {get; set;}
        @AuraEnabled public String field11 {get; set;}
        @AuraEnabled public String field12 {get; set;}
        @AuraEnabled public String broadBandAttribute {get; set;}
        @AuraEnabled public String fixedLineDescription {get; set;}
        @AuraEnabled public String tvAttribute {get; set;} 
    }
    
    public with sharing class fieldWrapper {
        public id AccountId {get; set;}
        public String SelectedAction {get; set;}
        public id BillingAccountId {get; set;}
        public id OfferId {get; set;}      
        public id OwnerId {get; set;}   
    }

    public with sharing class PermissionWrapper {
        @AuraEnabled public Boolean isRetention {get; set;}
        @AuraEnabled public Boolean isIntern {get; set;}
        @AuraEnabled public List<String> OffersLevels {get; set;}
        @AuraEnabled public Boolean isOfferMenuPermission {get; set;}
        @AuraEnabled public Boolean isBlock {get; set;}
    }

    @AuraEnabled(Cacheable=true)
    public static List<BillingAccount> getAccountRetentionFixed(Id recordId) {
        Map<String, Object> mapReturn = new Map<String, Object>();
        List<Account> lstAccount = new List<Account>();
        List<String> lstCustomerSegment = new List<String>();
        List<String> lstCustomerType = new List<String>();
        
        List<GeneralParam__c> lstGeneralParams = GeneralParamDAO.getLoadParams();
        DateTime accountLoadDate = lstGeneralParams[0].AccountLoadDate__c;
        DateTime addressLoadDate = lstGeneralParams[0].AddressLoadDate__c;
        DateTime assetLoadDate = lstGeneralParams[0].AssetLoadDate__c;
        DateTime billingAccountLoadDate = lstGeneralParams[0].BillingAccountLoadDate__c;
        String customerSegment = ((lstGeneralParams[0].CustomerSegment__c != null) ? lstGeneralParams[0].CustomerSegment__c : '');
        String customerType = ((lstGeneralParams[0].CustomerType__c != null) ? lstGeneralParams[0].CustomerType__c : '');

        Map<Id,BillingAccount> mapBillingAccount = new Map<Id,BillingAccount>();
        List<BillingAccount> ltBillingAccount = new List<BillingAccount>();
        Map<Id, List<Asset>> mapAsset = new Map<Id, List<Asset>>();
        List<Asset> lstAllAssets = new List<Asset>();
        List<Asset> ltAsset;
        List<Offer> ltOffer = new List<Offer>();
        Offer itemOffer;

        String accountId = getAccountIdFromCustomerInteraction(recordId);
        
        if (customerSegment.contains(';')) {
            lstCustomerSegment = customerSegment.split(';');

        } else if (String.isNotBlank(customerSegment)) {
            lstCustomerSegment.add(customerSegment);
        }

        if (customerType.contains(';')) {
            lstCustomerType = customerType.split(';');

        } else if (String.isNotBlank(customerType)) {
            lstCustomerType.add(customerType);
        }
                
        lstAccount = AccountDAO.getActiveById(accountId);
        
        if (lstAccount.isEmpty() || (
                lstCustomerSegment.contains(lstAccount[0].vlocity_cmt__CustomerValue__c) && 
                lstCustomerType.contains(lstAccount[0].vlocity_cmt__CustomerClass__c) && 
                lstAccount[0].LastModifiedDate < accountLoadDate
            )
        ) {
            return (ltBillingAccount);
        }
        
        BillingAccount billingAcc;
        List<Account> lstBillingAccount =  new List<Account>();
        String billingType = String.escapeSingleQuotes('Fixa');

        if (lstCustomerSegment.contains(lstAccount[0].vlocity_cmt__CustomerValue__c) && 
            lstCustomerType.contains(lstAccount[0].vlocity_cmt__CustomerClass__c)
        ) {
            lstBillingAccount = BillingAccountDAO.getByAccountIdDeveloperNameLastmodifiedDate(
                accountId, billingType, billingAccountLoadDate
            );
        
        } else {
            lstBillingAccount = BillingAccountDAO.getByAccountIdDeveloperName(accountId, billingType);
        }

        if (lstBillingAccount == null || lstBillingAccount.isEmpty()) {
            return (ltBillingAccount);
        }

        // Get and map City Category and Cabinets
        Map<Id, Set<String>> mapCityCategory = new Map<Id, Set<String>>();
        String CityCategoryAndCabinet = String.escapeSingleQuotes('CityCategoryAndCabinet');
        List<OfferFilter__c> lstAllCityCategories = OfferFilterDAO.getAllCitiesCategories(CityCategoryAndCabinet);

        // Get Assets
        if (lstCustomerSegment.contains(lstAccount[0].vlocity_cmt__CustomerValue__c) && 
            lstCustomerType.contains(lstAccount[0].vlocity_cmt__CustomerClass__c)
        ) {
            lstAllAssets = AssetDAO.getAssetFixedByAccountAndLastModifiedDate(accountId,assetLoadDate);

        } else {
            lstAllAssets = AssetDAO.getAssetFixedByAccount(accountId);
        }

        if (lstAllAssets == null || lstAllAssets.isEmpty()) {
            return (ltBillingAccount);
        }

        for (Asset item : lstAllAssets) {
            ltAsset = new List<Asset>();
            
            if (mapAsset.containsKey(item.vlocity_cmt__BillingAccountId__c)) {
                ltAsset = mapAsset.get(item.vlocity_cmt__BillingAccountId__c);
            }

            ltAsset.add(item);

            mapAsset.put(item.vlocity_cmt__BillingAccountId__c, ltAsset);
        }
        
        Set<Boolean> setCabinet = new Set<Boolean>();
        Boolean hasCabinet = false;
        Set<String> setSpeed = new Set<String>();
        
        List<SuggestedSpeed__c> lstSuggestedSpeed = SuggestedSpeedDAO.getSuggestedSpeed();
        Map<String, List<String>> mapSuggestedSpeed = new Map<String, List<String>>();

        for (SuggestedSpeed__c speed : lstSuggestedSpeed) {
            List<String> ltSpeed = new List<String>();

            if (mapSuggestedSpeed.containsKey(speed.CurrentSpeed__c)) {
                ltSpeed = mapSuggestedSpeed.get(speed.CurrentSpeed__c);
            }

            ltSpeed.add(speed.SuggestedSpeed__c);

            mapSuggestedSpeed.put(speed.CurrentSpeed__c, ltSpeed);
        }

        setCabinet.add(false);

        for (Asset item : lstAllAssets) {
            if (item.Speed__c != null && mapSuggestedSpeed.containsKey(item.Speed__c)) {
                setSpeed.addAll(mapSuggestedSpeed.get(item.Speed__c));
            }
            
            for (OfferFilter__c offerFilter : lstAllCityCategories) {
                if (offerFilter.StateCode__c == item.vlocity_cmt__ServiceAccountId__r.ShippingState &&
                    offerFilter.City__c == item.vlocity_cmt__ServiceAccountId__r.ShippingCity && 
                    offerFilter.Technology__c == item.Technology__c && 
                    (offerFilter.Cabinet__c == '' || offerFilter.Cabinet__c == null || (item.Cabinet__c == offerFilter.Cabinet__c))
                ) {
                    Set<String> setFilterCode = mapCityCategory.get(item.Id);
                    
                    if (setFilterCode == null) {
                        setFilterCode = new Set<String>();
                    }
                   
                    setFilterCode.add(offerFilter.FilterCode__c);

                    mapCityCategory.put(item.Id, setFilterCode);

                    setCabinet.add(true);
                }
            }
        }
        
        PermissionWrapper pw = getUserPermission();

        if (pw.isOfferMenuPermission) {
            return (mapBillingAccount.values());
        }

        // Get Offer Message 
        Template_Offer__mdt offerMessage = [
            SELECT 
                Message__c 
            FROM 
                Template_Offer__mdt 
            LIMIT 1
        ];

        OffersFilter__c offerFilter = OffersFilter__c.getValues('Filtro de Ofertas');
        
        // Map Billing Account
        for (Account bAcc : lstBillingAccount) {
            if (bAcc.ExternalId__c == null) {
                continue;
            }
             
            billingAcc = new BillingAccount();

            billingAcc.ltAsset = new List<Asset>();
            billingAcc.setCityCategories = new List<String>();
            billingAcc.idBilling = bAcc.Id;
            billingAcc.name = 'Conta Faturamento: ' + bAcc.ExternalId__c; 
            billingAcc.totalPrice = bAcc.OfferReferenceValue__c;
            billingAcc.hasMultipleAssets = false;
            billingAcc.setCabinet = new List<Boolean>(setCabinet);
            billingAcc.setOfferLevel = pw.OffersLevels;
            billingAcc.FixedLineList = offerFilter.VoicePlan__c.split(';');
            billingAcc.OfferGroupList = offerFilter.OfferGroup__c.split(';');
            
            Map<String, InitialOffer__c> initialPlans = InitialOffer__c.getAll();
            InitialOffer__c	initialFixed = new InitialOffer__c();

            String accTechnology;
            Set<String> setProductType = new Set<String>();
            Set<String> setAddress = new Set<String>();
            List<Asset> lstAsset = (mapAsset.containsKey(bAcc.Id) ? mapAsset.get(bAcc.Id) : null);

            if (lstAsset != null ) {
                billingAcc.hasAsset = true;

                for (Asset asset : mapAsset.get(bAcc.Id)) {
                    billingAcc.ltAsset.add(asset);

                    if (!setProductType.contains(asset.ProductType__c)) {
                        setAddress.add(asset.vlocity_cmt__ServiceAccountId__r.FullAddress__c);
                        setProductType.add(asset.ProductType__c);

                    } else {
                        billingAcc.hasMultipleAssets = true;

                        continue;
                    }

                    if (mapCityCategory.get(asset.Id) != null) {
                        billingAcc.setCityCategories.addAll(mapCityCategory.get(asset.Id));
                    }

                    if (asset.Speed__c != null) {
                        if (asset.Technology__c != null) {
                            if (asset.Technology__c == 'BL POP' || asset.Technology__c == 'ADSL') {
                                billingAcc.accTechnology = 'XDSL';

                            } else {
                                billingAcc.accTechnology = asset.Technology__c;   
                            }

                            String fieldTechnologyName = ('BandwidthPlan' + billingAcc.accTechnology.toUpperCase() + '__c');
                            String lstBandwidthFilters = (String) offerFilter.get(fieldTechnologyName);
                            
                            billingAcc.SpeedList = lstBandwidthFilters.split(';');
                        }

                        if (mapSuggestedSpeed.containsKey(asset.Speed__c)) {
                            if (billingAcc.SpeedList.contains(asset.Speed__c) && mapSuggestedSpeed.get(asset.Speed__c).contains(asset.Speed__c)) {
                                billingAcc.speedSelected = asset.Speed__c;

                            } else {
                                for (String spd : mapSuggestedSpeed.get(asset.Speed__c)) {
                                    if (billingAcc.SpeedList.contains(spd)) {
                                        billingAcc.speedSelected = spd;

                                        break;
                                    }
                                }
                            }
                        }
                    }
                    
                    if (asset.ProductType__c == 'TV' && asset.TVOfferFormula__c != null) {
                        billingAcc.tvPlanSelected = asset.TVOfferFormula__c;
                    }
                    
                    if (asset.ProductType__c == 'VOZ' && asset.MainProductDescription__c != null) {
                        billingAcc.fixedLineSelected = asset.MainProductDescription__c;
                    }                        
                }
            }

            if (billingAcc.accTechnology == null) {
                billingAcc.accTechnology = 'FTTH';
                billingAcc.SpeedList = offerFilter.BandwidthPlanFTTH__c.split(';');

            } else if (billingAcc.fixedLineSelected != null && initialPlans.keySet().contains(billingAcc.accTechnology)) {
                initialFixed = initialPlans.get(billingAcc.accTechnology);
                billingAcc.fixedLineSelected = initialFixed.VoicePlan__c;

            } else if (billingAcc.fixedLineSelected != null && billingAcc.accTechnology == 'FTTH' && 
                initialPlans.keySet().contains(billingAcc.speedSelected)
            ) {
                initialFixed = initialPlans.get(billingAcc.speedSelected);
                billingAcc.fixedLineSelected = initialFixed.VoicePlan__c;
            }

            if (billingAcc.accTechnology == 'FTTH') {
                billingAcc.TVPlanList = offerFilter.TvPlan__c.split(';');

            } else {
                billingAcc.TVPlanList = offerFilter.TvPlanWithoutFTTH__c.split(';');
            }

            if (billingAcc.speedSelected == null || billingAcc.speedSelected == '') {
                billingAcc.speedSelected = 'Sem Banda Larga';

            } else if (pw.isBlock) {
                billingAcc.SpeedList.remove(billingAcc.SpeedList.indexOf('Sem Banda Larga'));
            }

            if (billingAcc.tvPlanSelected == null || billingAcc.tvPlanSelected == '') {
                billingAcc.tvPlanSelected = 'Sem TV';

            } else if (pw.isBlock) {
                billingAcc.TVPlanList.remove(billingAcc.TVPlanList.indexOf('Sem TV'));
            }

            if (billingAcc.fixedLineSelected == null || billingAcc.fixedLineSelected == '') {
                billingAcc.fixedLineSelected = 'Sem Voz';

            } else if (pw.isBlock) {
                billingAcc.FixedLineList.remove(billingAcc.FixedLineList.indexOf('Sem Voz'));
            }

            if (setAddress.isEmpty() || setAddress.size() > 1) {
                billingAcc.hasAsset = false;
            }

            if (pw.isRetention) {
                billingAcc.offerGroupSelected = 'Retenção';

            } else {
                billingAcc.OfferGroupList.remove(0);
                billingAcc.offerGroupSelected = 'Aquisição';
            }
                       
            billingAcc.setCityCategories.add('TODAS');
            billingAcc.offerMessage = offerMessage.Message__c;

            mapBillingAccount.put(billingAcc.idBilling, billingAcc);

            ltBillingAccount.add(billingAcc);
        }

        return (mapBillingAccount.values());        
    }
    
    @AuraEnabled(Cacheable=true)
    public static BillingAccount getAccountRetentionFixedWithoutBilling(Id recordId) {
        BillingAccount billingAcc = new BillingAccount();

        List<Account> lstAccount = new List<Account>();
        List<String> lstCustomerSegment = new List<String>();
        List<String> lstCustomerType = new List<String>();
        
        List<GeneralParam__c> lstGeneralParams = GeneralParamDAO.getLoadParams();
        DateTime accountLoadDate = lstGeneralParams[0].AccountLoadDate__c;
        DateTime addressLoadDate = lstGeneralParams[0].AddressLoadDate__c;
        DateTime assetLoadDate = lstGeneralParams[0].AssetLoadDate__c;
        DateTime billingAccountLoadDate = lstGeneralParams[0].BillingAccountLoadDate__c;
        String customerSegment = ((lstGeneralParams[0].CustomerSegment__c != null) ? lstGeneralParams[0].CustomerSegment__c : '');
        String customerType = ((lstGeneralParams[0].CustomerType__c != null) ? lstGeneralParams[0].CustomerType__c : '');
        
        String accountId = getAccountIdFromCustomerInteraction(recordId);

        if (customerSegment.contains(';')) {
            lstCustomerSegment = customerSegment.split(';');

        } else if (String.isNotBlank(customerSegment)) {
            lstCustomerSegment.add(customerSegment);
        }

        if (customerType.contains(';')) {
            lstCustomerType = customerType.split(';');

        } else if (String.isNotBlank(customerType)) {
            lstCustomerType.add(customerType);
        }
                
        lstAccount = AccountDAO.getActiveById(accountId);

        if (lstAccount.isEmpty() || (
                lstCustomerSegment.contains(lstAccount[0].vlocity_cmt__CustomerValue__c) && 
                lstCustomerType.contains(lstAccount[0].vlocity_cmt__CustomerClass__c) && 
                lstAccount[0].LastModifiedDate < accountLoadDate
            )
        ) {
            return (billingAcc);
        }

        List<Schema.Account> lstAddress = [
            SELECT 
                Id, 
                BillingCity, 
                BillingState 
            FROM 
                Account 
            WHERE 
                ParentId =: accountId
        ];

        if (lstAddress == null || lstAddress.isEmpty()) {
            return (billingAcc);
        }
        
        PermissionWrapper pw = getUserPermission();

        if (pw.isOfferMenuPermission) {
            return (null);
        }

        // Get Offer Message 
        Template_Offer__mdt offerMessage = [
            SELECT 
                Message__c 
            FROM 
                Template_Offer__mdt 
            LIMIT 1
        ];

        OffersFilter__c offerFilter = OffersFilter__c.getValues('Filtro de Ofertas');

        billingAcc.SpeedList = offerFilter.BandwidthPlanFTTH__c.split(';');
        billingAcc.TVPlanList = offerFilter.TvPlan__c.split(';');
        billingAcc.FixedLineList = offerFilter.VoicePlan__c.split(';');
        billingAcc.OfferGroupList = offerFilter.OfferGroup__c.split(';');

        InitialOffer__c initialOffer = InitialOffer__c.getValues('Oferta Inicial');

        billingAcc.speedSelected = initialOffer.BroadbandSpeed__c;
        billingAcc.tvPlanSelected = initialOffer.TvPlanName__c;
        billingAcc.fixedLineSelected = initialOffer.VoicePlan__c;
        billingAcc.accTechnology = initialOffer.Tecnology__c;
        billingAcc.offerGroupSelected = initialOffer.OfferGroup__c;

        billingAcc.OfferGroupList.remove(0);

        billingAcc.setCabinet = new List<Boolean>{true,false};

        Set<String> setCityCategories = new Set<String>();
        String CityCategoryAndCabinet = String.escapeSingleQuotes('CityCategoryAndCabinet');
        List<OfferFilter__c> lstAllCityCategories = OfferFilterDAO.getAllCitiesCategories(CityCategoryAndCabinet);
        
        for (Account ad : lstAddress) {
            for (OfferFilter__c offerFilterCity : lstAllCityCategories) {
                if (offerFilterCity.StateCode__c == ad.BillingState &&
                    offerFilterCity.City__c == ad.BillingCity && 
                    offerFilterCity.Technology__c == billingAcc.accTechnology
                ) {
                    setCityCategories.add(offerFilterCity.FilterCode__c);   
                }
            }
        }

        setCityCategories.add('TODAS');
        billingAcc.offerMessage = offerMessage.Message__c;
        billingAcc.setOfferLevel = pw.OffersLevels;
        billingAcc.setCityCategories = new List<String>(setCityCategories);
        
        return (billingAcc);
    }

    @AuraEnabled
    public static List<Offer> getOfferFilterFixed(BillingAccount accBilling) {
        String offerType;
        List<Offer> offersFiltered = new List<Offer>();
        Boolean order = true;

        accBilling.speedSelected = ((accBilling.speedSelected == 'Sem Banda Larga') ? '' : accBilling.speedSelected);
        accBilling.tvPlanSelected = ((accBilling.tvPlanSelected == 'Sem TV') ? '' : accBilling.tvPlanSelected);
        accBilling.fixedLineSelected = ((accBilling.fixedLineSelected == 'Sem Voz') ? '' : accBilling.fixedLineSelected);

        if (accBilling.offerGroupSelected == 'Aquisição') {
            offerType = 'AcquisitionFixed';

        } else if (accBilling.offerGroupSelected == 'Base') {
            offerType = 'BaseFixed';

        } else if (accBilling.offerGroupSelected == 'Retenção') {
            offerType = 'Fixa';
            order = false;
        }

        List<Offer__c> lstOffer = OfferDAO.getEnabledFilteredOffers(accBilling.setCityCategories, accBilling.accTechnology, 
            accBilling.setOfferLevel, accBilling.setCabinet, offerType, accBilling.speedSelected, accBilling.tvPlanSelected, 
            accBilling.fixedLineSelected, order
        );
        
        Offer itemOffer;

        if (lstOffer != null && !lstOffer.isEmpty()) {
            for (Offer__c item : lstOffer) {
                itemOffer = new Offer();

                itemOffer.idOffer = item.Id;
                itemOffer.field1 = String.valueOf(item.TotalPrice__c);
                itemOffer.field2 = item.OfferCardDescription__c;
                itemOffer.field3 = item.BroadbandDescription__c;
                itemOffer.field4 = item.TVDescription__c;
                itemOffer.field5 = item.FixedCampaignRTD__c;
                itemOffer.field6 = String.valueOf(item.BroadBandDiscount__c);
                itemOffer.field7 = String.valueOf(item.TVDiscount__c);
                itemOffer.field8 = String.valueOf(item.FixedLineDiscount__c);
                itemOffer.field10 = String.valueOf(item.BroadbandDiscountDuration__c);
                itemOffer.field11 = String.valueOf(item.FixedLineDiscountDuration__c);
                itemOffer.field12 = String.valueOf(item.TVDiscountDuration__c);
                itemOffer.planTotalPrice = item.PlanTotalPrice__c;
                itemOffer.broadBandAttribute = String.valueOf(item.BroadBandAttribute__c);
                itemOffer.fixedLineDescription = String.valueOf(item.FixedLineDescription__c);
                itemOffer.tvAttribute = String.valueOf(item.TVAttribute__c);
                            
                offersFiltered.add(itemOffer);
            }
        }

        return (offersFiltered);
    }

    @AuraEnabled
    public static Map<String, Object> getAccountRetentionMobile(Id recordId) {
        Map<String, Object> mapReturn = new Map<String, Object>();
        List<Account> lstAccount = new List<Account>();
        List<String> lstCustomerSegment = new List<String>();
        List<String> lstCustomerType = new List<String>();
        
        List<GeneralParam__c> lstGeneralParams = GeneralParamDAO.getLoadParams();
        DateTime accountLoadDate = lstGeneralParams[0].AccountLoadDate__c;
        DateTime addressLoadDate = lstGeneralParams[0].AddressLoadDate__c;
        DateTime assetLoadDate = lstGeneralParams[0].AssetLoadDate__c;
        DateTime billingAccountLoadDate = lstGeneralParams[0].BillingAccountLoadDate__c;
        String customerSegment = ((lstGeneralParams[0].CustomerSegment__c != null) ? lstGeneralParams[0].CustomerSegment__c : '');
        String customerType = ((lstGeneralParams[0].CustomerType__c != null) ? lstGeneralParams[0].CustomerType__c : '');

        String accountId = getAccountIdFromCustomerInteraction(recordId);

        if (customerSegment.contains(';')) {
            lstCustomerSegment = customerSegment.split(';');

        } else if (String.isNotBlank(customerSegment)) {
            lstCustomerSegment.add(customerSegment);
        }

        if (customerType.contains(';')) {
            lstCustomerType = customerType.split(';');

        } else if (String.isNotBlank(customerType)) {
            lstCustomerType.add(customerType);
        }
        
        lstAccount = AccountDAO.getActiveById(accountId);
        
        if (lstAccount.isEmpty() || (
                lstCustomerSegment.contains(lstAccount[0].vlocity_cmt__CustomerValue__c) && 
                lstCustomerType.contains(lstAccount[0].vlocity_cmt__CustomerClass__c) && 
                lstAccount[0].LastModifiedDate < accountLoadDate
            )
        ) {
            return mapReturn;
        }

        String accCustomerType = ((lstAccount.size() > 0) ? lstAccount[0].vlocity_cmt__CustomerClass__c : '');
        Map<Id, List<AssetMovel>> mapAsset = new Map<Id, List<AssetMovel>>();
        List<AssetMovel> ltAsset;
        AssetMovel itemAsset;
        
        Map<String, List<Offer>> mapOffer = new Map<String, List<Offer>>();
        Map<String, List<Offer>> mapITVOffer = new Map<String, List<Offer>>();
        List<Offer> ltOffer;
        List<Offer> ltOfferITV = new List<Offer>();
        Offer itemOffer;
        
        Map<Id, BillingAccount> mapBillingAccount = new Map<Id, BillingAccount>();
        List<BillingAccount> ltBillingAccount = new List<BillingAccount>();
        BillingAccount billingAcc;
        
        List<Account> lstBillingAccount = new List<Account>();

        if (lstCustomerSegment.contains(lstAccount[0].vlocity_cmt__CustomerValue__c) && 
            lstCustomerType.contains(lstAccount[0].vlocity_cmt__CustomerClass__c)
        ) {
            lstBillingAccount = [
                SELECT 
                    Id, 
                    ParentId, 
                    FullAddress__c, 
                    ExternalId__c, 
                    TotalAmount__c, 
                    OfferReferenceValue__c 
                FROM 
                    Account 
                WHERE 
                    Id IN (
                        SELECT 
                            vlocity_cmt__BillingAccountId__c 
                        FROM 
                            Asset 
                        WHERE 
                            AccountId = :accountId
                    ) AND 
                    (BillingAccountType__c = 'Movel' OR BillingAccountType__c = 'Móvel') AND 
                    LastModifiedDate > :billingAccountLoadDate
            ];
        
        } else {
            lstBillingAccount = [
                SELECT 
                    Id, 
                    ParentId, 
                    FullAddress__c, 
                    ExternalId__c, 
                    TotalAmount__c, 
                    OfferReferenceValue__c 
                FROM 
                    Account 
                WHERE 
                    Id IN (
                        SELECT 
                            vlocity_cmt__BillingAccountId__c 
                        FROM 
                            Asset 
                        WHERE 
                            AccountId = :accountId
                    ) AND 
                    (BillingAccountType__c = 'Movel' OR BillingAccountType__c = 'Móvel')
            ];
        }

        List<Offer> ltOfferAlta = new List<Offer>();
        Set<String> setMainProductDescription = new Set<String>();

        List<Asset> lstAsset = new List<Asset>();

        if (lstCustomerSegment.contains(lstAccount[0].vlocity_cmt__CustomerValue__c) && 
            lstCustomerType.contains(lstAccount[0].vlocity_cmt__CustomerClass__c)
        ) {
            lstAsset = AssetDAO.getAssetMobileByAccountAndLastModifiedDate(accountId, assetLoadDate);

        } else {
            lstAsset = AssetDAO.getAssetMobileByAccount(accountId);
        }

        // Check Profile/PermissionSet
        Boolean hasPermission = true;

        Profile currentProfile = [
            SELECT 
                Id, 
                Name 
            FROM 
                Profile 
            WHERE 
                Id = :UserInfo.getProfileId()
        ];

        if (currentProfile.Name == 'Representante') {
            List<PermissionSetAssignment> ltCurrentPSA = new List<PermissionSetAssignment>([
                SELECT 
                    Id, 
                    PermissionSetId 
                FROM 
                    PermissionSetAssignment 
                WHERE 
                    AssigneeId = :UserInfo.getUserId() AND 
                    PermissionSet.Name = 'OfferMenu'
            ]);

            if (ltCurrentPSA == null || ltCurrentPSA.isEmpty()) {
                hasPermission = false;
            }
        }

        // Get Mobile Plan information
        for (Asset item : lstAsset) {
            setMainProductDescription.add(item.MainProductDescription__c);
        }

        if (hasPermission) {
            // Get Offers mobile
            for (Offer__c item : OfferDao.getOfferMobileByOrder(setMainProductDescription, String.escapeSingleQuotes('Movel'), String.escapeSingleQuotes(accCustomerType))) {
                ltOffer = new List<Offer>();

                String key = (item.MobilePlan__c + item.DDDOferta__c);

                if (mapOffer.containsKey(key)) {
                    ltOffer = mapOffer.get(key);
                }

                itemOffer = new Offer();

                itemOffer.idOffer = item.Id;
                itemOffer.field1 = String.valueOf(item.TotalPrice__c);
                itemOffer.field2 = item.MobileDescription__c;
                itemOffer.field3 = item.MobileInternetDescription__c;
                itemOffer.field4 = item.SourceSystem__c;

                ltOffer.add(itemOffer);

                mapOffer.put(key, ltOffer);
            }

            for (Offer__c item : OfferDAO.getOfferMovelITV('ITV')) {
                itemOffer = new Offer();

                itemOffer.idOffer = item.Id;
                itemOffer.field1 = String.valueOf(item.TotalPrice__c);
                itemOffer.field2 = item.MobileDescription__c;
                itemOffer.field3 = item.Instructions__c;

                ltOfferITV.add(itemOffer);
            }
        }

        // Get Specials DDD's
        MobileOffersSettings__c settingOffers = MobileOffersSettings__c.getValues('DDD_Ofertas');
        List<String> dddOffers = new List<String>();
        
        if (settingOffers != null && settingOffers.DDDOferta__c != null && String.isNotBlank(settingOffers.DDDOferta__c)) {
            dddOffers = settingOffers.DDDOferta__c.split(';');
        }

        // Get Assets
        for (Asset item : lstAsset) {
            ltAsset = new List<AssetMovel>();

            if (mapAsset.containsKey(item.vlocity_cmt__BillingAccountId__c)) { 
                ltAsset = mapAsset.get(item.vlocity_cmt__BillingAccountId__c);
            }

            itemAsset = new AssetMovel();
            
            String phone = item.PhoneNumber__c;

            itemAsset.idBilling = item.vlocity_cmt__BillingAccountId__c;
            itemAsset.itemAsset = item;
            itemAsset.ltAsset   = new List<Asset>{item};

            String DDDkey = ((phone.length() == 10 || phone.length() == 11) ? phone.substring(0, 2) : null);

            if (!dddOffers.contains(DDDkey)) {
                DDDkey = 'BR';
            }

            String key = (item.MainProductDescription__c + DDDkey);

            itemAsset.ltOffer = (mapOffer.containsKey(key) ? mapOffer.get(key) : null);
            itemAsset.hasOffer = (mapOffer.containsKey(key) ? (mapOffer.get(key).size() > 0) : false);
            itemAsset.ltITVOffer = ltOfferITV;
            
            if (phone.length() == 10) {
                itemAsset.phone = ('Número do Telefone: (' + phone.substring(0, 2) + ') ' + phone.substring(2, 6) + '-' + phone.substring(6));
            
            } else if (phone.length() == 11) {
                itemAsset.phone = ('Número do Telefone: (' + phone.substring(0, 2) + ') ' + phone.substring(2, 7) + '-' + phone.substring(7));
            
            } else {
                itemAsset.phone = ('Número do Telefone: ' + phone);
            }

            itemAsset.priceCurrent = item.PriceCurrent__c;
            
            ltAsset.add(itemAsset);

            mapAsset.put(item.vlocity_cmt__BillingAccountId__c, ltAsset);
        }

        // Map Billing Account
        for (Account bAcc : lstBillingAccount) {
            billingAcc = new BillingAccount();

            billingAcc.idBilling = bAcc.Id;
            billingAcc.name = ('Conta Faturamento: ' + bAcc.ExternalId__c);

            Decimal totalFat = 0;

            if (mapAsset.containsKey(bAcc.Id)) {
                for (AssetMovel am : mapAsset.get(bAcc.Id)) {
                    totalFat += am.itemAsset.PriceCurrent__c;
                }
            }

            billingAcc.totalPrice = totalFat;
            billingAcc.ltAssetMovel = (mapAsset.containsKey(bAcc.Id) ? mapAsset.get(bAcc.Id) : null);
            
            mapBillingAccount.put(billingAcc.idBilling, billingAcc);

            ltBillingAccount.add(billingAcc);
        }

        mapReturn.put('ltBillingAccount', mapBillingAccount.values());

        return (mapReturn);
    }
    
    @AuraEnabled
    public static CartAccount__c saveCartAccount(String fieldListJSON) { 
        fieldWrapper listField = (fieldWrapper) JSON.deserialize(fieldListJSON, fieldWrapper.class);
        
        CartAccount__c insertCartAcc = new CartAccount__c();

        insertCartAcc.AccountId__c = listField.AccountId;
        insertCartAcc.OwnerId = listField.OwnerId;

        insert insertCartAcc;
        
        return (insertCartAcc);
    }

    @AuraEnabled
    public static Map<String, object> checkCreditAnalysis(String recordId) {
        map<String, Object> mapResult = new Map<String,Object>();
        
        try {
            String accountId = getAccountIdFromCustomerInteraction(recordId);
            List<Asset> lstAssetFixed = AssetDAO.getAssetFixed(accountId);
            List<Asset> lstAssetMobileByAccount = AssetDAO.getAssetMobileByAccount(accountId);
            Boolean showOffersAltaMovel = false;

            if (!lstAssetFixed.isEmpty() && lstAssetMobileByAccount.isEmpty()) {
                for (Asset assetFixed : lstAssetFixed) {
                    if (Double.valueOf(assetFixed.Speed__c) >= 4.0) {
                        showOffersAltaMovel = true;

                        break;
                    }
                }
            }

            if (!showOffersAltaMovel) {
                mapResult.put('ltOfferAlta', null);

                return (mapResult);
            }

            mapResult = CreditAnalysisService.executeCreditAnalysis(AccountDAO.getAccountById(accountId)[0]);

            if (mapResult.get('success') == null) {
                return (mapResult);
            }

            return getOffer(accountId);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Map<String, object> getOffer(String accountId) {
        try {
            List<Offer> ltOfferAlta = new List<Offer>();
            List<Offer> ltOfferITVAlta = new List<Offer>();
            Map<String, Object> mapReturn = new Map<String,Object>();
            Offer itemOffer;

            // Check Profile/PermissionSet
            Boolean hasPermission = true;

            Profile currentProfile = [
                SELECT 
                    Id, 
                    Name 
                FROM 
                    Profile 
                WHERE 
                    Id = :UserInfo.getProfileId()
            ];

            if (currentProfile.Name == 'Representante') {
                List<PermissionSetAssignment> ltCurrentPSA = new List<PermissionSetAssignment>([
                    SELECT 
                        Id, 
                        PermissionSetId 
                    FROM 
                        PermissionSetAssignment 
                    WHERE 
                        AssigneeId = : UserInfo.getUserId() AND 
                        PermissionSet.Name = 'OfferMenu'
                ]);

                if (ltCurrentPSA == null || ltCurrentPSA.isEmpty()) {
                    hasPermission = false;
                }
            }

            List<Account> acc = AccountDAO.getAccountById(accountId);

            if (hasPermission) {
                // Get Offers - Alta Móvel
                for (Offer__c item : OfferDAO.getOfferAltaMovelByCreditScore(String.valueOf(acc[0].vlocity_cmt__CreditScore__c))) {
                    itemOffer = new Offer();

                    itemOffer.idOffer = item.Id;
                    itemOffer.field1 = String.valueOf(item.TotalPrice__c);
                    itemOffer.field2 = item.MobileDescription__c;
                    itemOffer.field3 = item.MobileInternetDescription__c;
                    itemOffer.field4 = item.MobilePlan__c;
                    itemOffer.field5 = String.valueOf(item.MobilePriceDiscount__c);
                    itemOffer.field8 = item.SourceSystem__c;

                    ltOfferAlta.add(itemOffer);
                }

                for (Offer__c item : OfferDAO.getOfferMovelITV('ITVAltaMovel')) {
                    itemOffer = new Offer();

                    itemOffer.idOffer = item.Id;
                    itemOffer.field1 = String.valueOf(item.TotalPrice__c);
                    itemOffer.field2 = item.MobileDescription__c;
                    itemOffer.field3 = item.Instructions__c;

                    ltOfferITVAlta.add(itemOffer);
                }
            }

            mapReturn.put('ltOfferAlta', ltOfferAlta);
            mapReturn.put('ltOfferITVAlta', ltOfferITVAlta);

            return (mapReturn);

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @testVisible
    private static String Normalizer(String texto) {
        if (texto != null && texto != '') {
            final String comAcentos = 'ÄÅÁÂÀÃäáâàãÉÊËÈéêëèÍÎÏÌíîïìÖÓÔÒÕöóôòõÜÚÛüúûùÇç';
            final String semAcentos = 'AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc';

            List<String> withAccent = comAcentos.split('');
            List<String> withoutAccent = semAcentos.split('');

            for (Integer i = 0; i < withAccent.size(); i++) {
                texto = texto.Replace(withAccent[i], withoutAccent[i]);
            }
            
            texto = texto.deleteWhitespace();
        }

        return (texto);
    }

    @testVisible
    private static PermissionWrapper getUserPermission() {
        final String groupType = String.escapeSingleQuotes('Retencao');
        final String groupType2 = String.escapeSingleQuotes('Omnichannel');
        final List<String> groupsTypes = new List<String>{groupType,groupType2};
        final String permissionName = String.escapeSingleQuotes('OfferMenu');
        final String objectType = String.escapeSingleQuotes('PublicGroup');
        final String offerLevel = String.escapeSingleQuotes('OfferLevel');

        List<String> lstOfferLevel = new List<String>();
        Map<String,String> groupsLevels = new Map<String,String> ();

        BlockPartialDisconnection__c blockPartialDesco = BlockPartialDisconnection__c.getValues('Impedimento Desconexao Parcial');

        User user = UserDAO.getById(UserInfo.getUserId());

        if (user == null) {
            PermissionWrapper pw = new PermissionWrapper();

            pw.isOfferMenuPermission = true;

            return (pw);
        }

        user.UserRole.DeveloperName = (user.UserRole.DeveloperName == null) ? '': user.UserRole.DeveloperName;
        user.PartnerGroup__c = (user.PartnerGroup__c == null) ? '': user.PartnerGroup__c;
        
        Boolean intern = user.PartnerGroup__c == '';
        String userRole = ((!intern)  ? Normalizer(user.PartnerGroup__c) : Normalizer(user.UserRole.DeveloperName));
        Boolean isBlock = (blockPartialDesco.Papel__c.contains(userRole));
        List<FromToMapping__mdt> roles = FromToMappingDAO.getUserPermission(userRole, groupsTypes);        
        Boolean retention = !roles.isEmpty();
        List<PermissionSetAssignment> ltCurrentPSA = PermissionSetAssigmentDAO.getCurrentPSA(UserInfo.getUserId(), permissionName);

        for (FromToMapping__mdt groupPublic : FromToMappingDAO.getGroupMap(objectType, offerLevel)) {
            groupsLevels.put(groupPublic.OriginApiName__c, groupPublic.DestinyApiName__c);
        }

        if (user.Profile.Name == 'Representante' || user.Profile.Name == 'Governanca') {         
            for (String level : GroupMemberService.getEnabledGroupsDevName(UserInfo.getUserRoleId())) {
                if (groupsLevels.containsKey(level)) {
                    lstOfferLevel.add(groupsLevels.get(level));
                }
            }

        } else if (user.Profile.Name == 'AliadoExterno') {
            for (PublicGroup__mdt publicGroup : PublicGroupDAO.getPublicsGroups(userRole)) {   
                if (publicGroup.SimplifiedPublicGroups__c != null && publicGroup.SimplifiedPublicGroups__c != '') {
                    lstOfferLevel.add(publicGroup.SimplifiedPublicGroups__c);
                }
            }

        } else if (user.Profile.Name == 'Administrador do sistema' || user.Profile.Name == 'System Administrator' || 
                    user.Profile.Name == 'AdministracaoSistema'
        ) {
            lstOfferLevel.addAll(groupsLevels.values());
        }

        PermissionWrapper pw = new PermissionWrapper();

        pw.isRetention = retention;
        pw.OffersLevels = lstOfferLevel;
        pw.isOfferMenuPermission = ltCurrentPSA.isEmpty(); 
        pw.isIntern = intern;
        pw.isBlock = isBlock;
        
        return (pw);
    }

    public static Id getAccountIdFromCustomerInteraction(Id recordId) {
        List<vlocity_cmt__CustomerInteraction__c> customerInteraction = [
            SELECT 
                vlocity_cmt__AccountId__c 
            FROM 
                vlocity_cmt__CustomerInteraction__c 
            WHERE 
                Id =: recordId 
            LIMIT 1
        ];

        return (customerInteraction.isEmpty() ? null : customerInteraction[0].vlocity_cmt__AccountId__c);        
    }
}