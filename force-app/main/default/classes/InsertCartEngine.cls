public without sharing class InsertCartEngine{
    public static Map<String, Object> setInsertOffer(String offerId, String ltCardProposal, Id recordId, Id selectedOfferAltaId, Id userId, String ltBillingAccountFixed, String ltBillingAccountMobile){
      
        GeneralParam__c generalParamObj = GeneralParam__c.getInstance();
        DateTime accountLoadDate = generalParamObj.AccountLoadDate__c;
     
        if (String.isEmpty(ltCardProposal) || String.isEmpty(ltBillingAccountFixed) || String.isEmpty(ltBillingAccountMobile)) {
            Map<String, Object> mapInsertCart = new Map<String,Object>();
            return mapInsertCart;
        }
        
        String accountId = getAccountIdFromCustomerInteraction(recordId);
        List<CardOfferController.billingAccountCard> listProposal = (List<CardOfferController.billingAccountCard>)JSON.deserialize(ltCardProposal,List<CardOfferController.billingAccountCard>.class);
        List<AccountRetentionController.BillingAccount> ltFixed = (List<AccountRetentionController.BillingAccount>)JSON.deserialize(ltBillingAccountFixed,List<AccountRetentionController.BillingAccount>.class);
        List<AccountRetentionController.BillingAccount> ltMobile= (List<AccountRetentionController.BillingAccount>)JSON.deserialize(ltBillingAccountMobile,List<AccountRetentionController.BillingAccount>.class);
        List<Id> listOfferId = new List<Id> ();
        List<CartAccount__c> ltCardAccount;
        List<Offer__c> ltOffer = new List<Offer__c>();
        List<TemplateMessage__mdt> templateFixed;
        List<TemplateMessage__mdt> templateMobile;
        List<TemplateMessage__mdt> templateFixedAlta;
        List<TemplateMessage__mdt> templateMobileAlta;
        Set<Id> setBillingSelected = new Set<Id>();
        Set<Id> setOfferSelected = new Set<Id>();
        Map<Id, AccountRetentionController.Offer> mapOffer = new Map<Id, AccountRetentionController.Offer>();
        Map<String,Object> mapInsertCart = new Map<String,Object>(); 

        Account accountObj;
        CartAccount__c cartAccountObj = new CartAccount__c();
        CartOffer__c insertCartOffer = new CartOffer__c();
        List<CartOffer__c> ltCartOffer = new List<CartOffer__c>();
        
        Boolean haveSelectedOfferAltaId = String.isNotBlank(selectedOfferAltaId);
        Boolean isOpen = false;
        String templateOffer;
        String templateOfferClient = '';
        String templateOfferFixed = '';
        String templateOfferFixedAlta = '';
        String templateOfferMobile = '';
        String templateOfferMobileAlta = '';
        String fixas = '';
        String moveis = '';        
        String papelUserLogado = getRoleOfUser(UserInfo.getUserId());
        Set<Id> setOffers = new Set<Id>();
        Map<String,Id> mapId = new Map<String,Id>();
        mapId.put('Fixed', SchemaSelector.getIdRecordTypeByDeveloperName('CartOffer__c', 'Fixed'));
        mapId.put('UpSellMobileTotaled', SchemaSelector.getIdRecordTypeByDeveloperName('CartAccount__c', 'UpSellMobileTotaled'));
        mapId.put('Mobile', SchemaSelector.getIdRecordTypeByDeveloperName('CartOffer__c', 'Mobile'));
        mapId.put('SelectCart', SchemaSelector.getIdRecordTypeByDeveloperName('CartAccount__c', 'SelectCart'));

        if (offerId != null && offerId != ''){
            listOfferId = (List<Id>) JSON.deserialize(offerId, List<Id>.class);
            setOffers = transformStringToSetId(offerId);
        }  
        
        if (accountId != null){
            accountObj = AccountDAO.getAccountByIdAndLastMod(accountId, accountLoadDate);
            List<TemplateMessage__mdt> templateClient = InsertCartSelector.getListTemplateMessageByType('Cliente');
            templateOfferClient = templateClient[0].TemplateMessage__c;        
            templateOfferClient = templateOfferClient.replace('[Name]', accountObj.Name);
        }        
        
        ltCardAccount = CartAccountDAO.getListCartByIdUserRecordTypeCreatedToday(new Set<Id>{accountId}, userId, 'SelectCart');
        
        // Caso não haja nenhum registro de Carrinho que atenda os filtros da consulta anterior (1 Carrinho x 1 Usuário no mesmo dia), ele irá entrar no if e criar um novo carrinho para a conta
        if (ltCardAccount.size() == 0 || haveSelectedOfferAltaId){
            if (listOfferId.size() > 0 && haveSelectedOfferAltaId){
                insert cartAccountObj = createCartAccount(recordId, 
                                                        mapId.get('UpSellMobileTotaled'),
                                                        accountObj.Contacts[0].Email, 
                                                        accountObj.vlocity_cmt__PrimaryContactId__r.MotherName__c,
                                                        accountObj.vlocity_cmt__PrimaryContactId__r.Birthdate,
                                                        accountObj.vlocity_cmt__PrimaryContactId__r.MobilePhone,
                                                        listProposal);
                isOpen = true;
                ltOffer = OfferDAO.getOffersById(setOffers);
                for (Offer__c itemOffer : ltOffer){
                    insertCartOffer = createCartOffer(mapId.get('Fixed'), cartAccountObj.Id, itemOffer.id);  
                    ltCartOffer.add(insertCartOffer);               
                }
                insert ltCartOffer;

                insert insertCartOffer = createCartOffer(mapId.get('Mobile'), cartAccountObj.Id, selectedOfferAltaId); 
                mapId.put('recordId', cartAccountObj.Id);
            } else if (listOfferId.size() > 0){ 
                cartAccountObj = createCartAccount(recordId,
                                                    mapId.get('SelectCart'),
                                                    accountObj.Contacts[0].Email,
                                                    listProposal);
                insert cartAccountObj;
                isOpen = true;
                ltOffer = OfferDAO.getOffersById(setOffers);
                
                for (Offer__c itemOffer : ltOffer){
                    insertCartOffer = createCartOffer(mapId.get('Fixed'), cartAccountObj.Id, itemOffer.id); 
                    ltCartOffer.add(insertCartOffer);            
                }
                insert ltCartOffer;
            } else if (haveSelectedOfferAltaId){
                insert cartAccountObj = createCartAccount(recordId, 
                                                        mapId.get('UpSellMobileTotaled'),
                                                        accountObj.Contacts[0].Email, 
                                                        accountObj.vlocity_cmt__PrimaryContactId__r.MotherName__c,
                                                        accountObj.vlocity_cmt__PrimaryContactId__r.Birthdate,
                                                        accountObj.vlocity_cmt__PrimaryContactId__r.MobilePhone,
                                                        listProposal);
                isOpen = true;       
                insertCartOffer = createCartOffer(mapId.get('Mobile'), cartAccountObj.Id, selectedOfferAltaId); 
                insert insertCartOffer;

                mapId.put('recordId', cartAccountObj.Id);

                templateMobileAlta = InsertCartSelector.getListTemplateMessageByType('Alta Movel');  
                if (!templateMobileAlta.isEmpty()){
                    templateOfferMobileAlta = getTemplateByRole(templateMobileAlta, papelUserLogado);
                }  

                templateOfferMobileAlta = buildOfferMobileAltaTemplateMessage(selectedOfferAltaId, templateOfferMobileAlta);
                templateOffer = templateOfferClient +'\n'+ templateOfferMobileAlta;
                templateOffer = templateOffer.replace('<br>', '');
            } 

            if (ltOffer.size() > 0){
                templateFixed = InsertCartSelector.getListTemplateMessageByType('Fixa');
                if (!templateFixed.isEmpty()){
                    templateOfferFixed = getTemplateByRole(templateFixed, papelUserLogado);
                }

                templateFixedAlta = InsertCartSelector.getListTemplateMessageByType('Alta Fixa');
                if (!templateFixedAlta.isEmpty()){
                    templateOfferFixedAlta = templateFixedAlta[0].TemplateMessage__c;
                }

                templateMobile = InsertCartSelector.getListTemplateMessageByType('Movel');
                if (!templateMobile.isEmpty()){
                    templateOfferMobile = getTemplateByRole(templateMobile, papelUserLogado);
                }

                templateMobileAlta = InsertCartSelector.getListTemplateMessageByType('Alta Movel');  
                if (!templateMobileAlta.isEmpty()){
                    templateOfferMobileAlta = getTemplateByRole(templateMobileAlta, papelUserLogado);
                }    

                if (haveSelectedOfferAltaId){
                    templateOfferMobileAlta = buildOfferMobileAltaTemplateMessage(selectedOfferAltaId, templateOfferMobileAlta);
                } else{
                    templateOfferMobileAlta = '';
                }
                
                if (templateOfferFixed != null) {
                    for (AccountRetentionController.BillingAccount itemBilling : ltFixed){
                        if (itemBilling.selectedOfferId != null && String.isNotEmpty(itemBilling.selectedOfferId)  ){
                            setBillingSelected.add(itemBilling.idBilling);
                            setOfferSelected.add(itemBilling.selectedOfferId);   
                            for (AccountRetentionController.Offer itemOffer : itemBilling.ltOffer){
                                mapOffer.put(itemOffer.idOffer, itemOffer);
                            }  
                        }
                    }
    
                    fixas = buildFixasTemplateMessage(ltFixed, setBillingSelected, templateFixed, papelUserLogado, templateOfferFixed, mapOffer, templateOfferFixedAlta);    
                }
                  
                if (templateOfferMobile != null){
                    for (AccountRetentionController.BillingAccount itemBilling : ltMobile){
                        if (itemBilling.ltAssetMovel != null && !itemBilling.ltAssetMovel.isEmpty()){
                            for (AccountRetentionController.AssetMovel itemAsset : itemBilling.ltAssetMovel ){
                                if (itemAsset.selectedOfferId != null && String.isNotEmpty(itemAsset.selectedOfferId) ){
                                    setBillingSelected.add(itemBilling.idBilling);
                                    setOfferSelected.add(itemAsset.selectedOfferId);
                                    for (AccountRetentionController.Offer itemOffer : itemAsset.ltOffer){
                                        mapOffer.put(itemOffer.idOffer, itemOffer);
                                    }
                                }
                            }
                        }
                    }
                    
                    moveis = buildMoveisTemplateMessage(ltMobile, setBillingSelected, templateMobile, papelUserLogado, templateOfferMobile, mapOffer);
                }
            }
            
            templateOffer = templateOfferClient +'\n' + fixas + moveis + templateOfferMobileAlta;
            templateOffer = templateOffer.replace('<br>', '');            
        } 
        
        // Caso já tenha um registro de Carrinho criado, a lógica a seguir irá realizar o update das informações
        else{
            templateFixed = InsertCartSelector.getListTemplateMessageByType('Fixa');
            if (!templateFixed.isEmpty()){
                templateOfferFixed = getTemplateByRole(templateFixed, papelUserLogado);
            }

            templateFixedAlta = InsertCartSelector.getListTemplateMessageByType('Alta Fixa');
            if (!templateFixedAlta.isEmpty()){
                templateOfferFixedAlta = templateFixedAlta[0].TemplateMessage__c;
            }

            templateMobile = InsertCartSelector.getListTemplateMessageByType('Movel');
            if (!templateMobile.isEmpty()){
                templateOfferMobile = getTemplateByRole(templateMobile, papelUserLogado);
            }

            templateMobileAlta = InsertCartSelector.getListTemplateMessageByType('Alta Movel');    
            if (!templateMobileAlta.isEmpty()){
                templateOfferMobileAlta = getTemplateByRole(templateMobileAlta, papelUserLogado);
            } 
            
            if (haveSelectedOfferAltaId){
                templateOfferMobileAlta = buildOfferMobileAltaTemplateMessage(selectedOfferAltaId, templateOfferMobileAlta);
            } else{
                templateOfferMobileAlta = '';
            }

            // Update das Ofertas selecionadas para a Oferta do Carrinho
            CartAccount__c selectCart = CartAccountDAO.getCartByIdUserRecordTypeCreatedToday(accountId, userId, 'SelectCart');
            
            if (selectCart != null){
                List<CartOffer__c> findCartOffer = CartOfferDAO.getCartOfferByCartId(new Set<Id>{selectCart.Id});
                delete findCartOffer;
                
                for (CardOfferController.billingAccountCard item : listProposal){
                    cartAccountObj.Id = selectCart.Id;
                    cartAccountObj.TotalPrice__c = (item.billingProposalValue != null ? item.billingProposalValue : 0) ;
                    cartAccountObj.Discount__c = Decimal.valueOf((item.field2) != '' ? (item.field2) : '0');
                }

                cartAccountObj.RecordTypeId = mapId.get('SelectCart');         
                update cartAccountObj;

                isOpen = true;
                ltOffer = OfferDAO.getOffersById(setOffers);
                
                if (ltOffer.size() > 0){
                    for (Offer__c itemOffer : ltOffer){
                        insertCartOffer = createCartOffer(mapId.get('Fixed'), cartAccountObj.Id, itemOffer.id); 
                        ltCartOffer.add(insertCartOffer);                
                    }
                    insert ltCartOffer;
                }       
            }
            
            if (templateOfferFixed != null) { 
                for (AccountRetentionController.BillingAccount itemBilling : ltFixed){
                    if (itemBilling.selectedOfferId != null && String.isNotEmpty(itemBilling.selectedOfferId)  ){
                        setBillingSelected.add(itemBilling.idBilling);
                        setOfferSelected.add(itemBilling.selectedOfferId);   
                        for (AccountRetentionController.Offer itemOffer : itemBilling.ltOffer){
                            mapOffer.put(itemOffer.idOffer, itemOffer);
                        }  
                    }
                }

                fixas = buildFixasTemplateMessage(ltFixed, setBillingSelected, templateFixed, papelUserLogado, templateOfferFixed, mapOffer,templateOfferFixedAlta);
            }

            if (templateOfferMobile != null){
                for (AccountRetentionController.BillingAccount itemBilling : ltMobile){
                    if (itemBilling.ltAssetMovel != null && !itemBilling.ltAssetMovel.isEmpty()){
                        for (AccountRetentionController.AssetMovel itemAsset : itemBilling.ltAssetMovel ){
                            if (itemAsset.selectedOfferId != null && String.isNotEmpty(itemAsset.selectedOfferId) ){
                                setBillingSelected.add(itemBilling.idBilling);
                                setOfferSelected.add(itemAsset.selectedOfferId);
                                for (AccountRetentionController.Offer itemOffer : itemAsset.ltOffer){
                                    mapOffer.put(itemOffer.idOffer, itemOffer);
                                }
                            }
                        }
                    }
                }

                moveis = buildMoveisTemplateMessage(ltMobile, setBillingSelected, templateMobile, papelUserLogado, templateOfferMobile, mapOffer);
            }
            
            templateOffer = templateOfferClient +'\n'+ fixas + moveis + templateOfferMobileAlta;
            templateOffer = templateOffer.replace('<br>', '');
            isOpen = true;
        } 
        
        mapInsertCart.put('isOpen', isOpen);
        mapInsertCart.put('listProposal', listProposal);
        mapInsertCart.put('templateOffer', templateOffer);
        mapInsertCart.put('recordId', mapId.get('recordId'));
        return mapInsertCart;
    }

    private static Set<Id> transformStringToSetId (String offers){
        Set<Id> setId = new Set<Id>();
        List<String> ltSplitString = new List<String>();
        offers = offers.remove('[');
        offers = offers.remove(']');
        offers = offers.remove('"');

        if (String.isNotBlank(offers)) {
            ltSplitString = offers.split(',');    
        }        

        if (!ltSplitString.isEmpty()) {
            for (String item : ltSplitString) {
                if (item != null) {
                    setId.add(Id.valueOf(item));    
                }            
            }    
        }

        return setId;
    }

    private static String getRoleOfUser(Id userId){
        String loggedUserRole = '';
        User dadosUser = UserDAO.getById(userId);

        if (dadosUser.IsPortalEnabled == true && dadosUser.PartnerGroup__c != null){
            loggedUserRole = dadosUser.PartnerGroup__c;
        } else if (dadosUser.UserRole.Name != null){
            loggedUserRole = dadosUser.UserRole.Name;
        }

        return loggedUserRole;
    } 

    private static String getTemplateByRole(List<TemplateMessage__mdt> ltTemplate, String papelUserLogado){
        // Boolean notPass = true;
        List <String> listRoles;
        String template = '';
        for (TemplateMessage__mdt x: ltTemplate){
            listRoles = x.Roles__c.split(';');
            for (String v: listRoles){
                if (papelUserLogado.contains(v) /*&& notPass*/){
                    template = x.TemplateMessage__c;
                    // notPass = false;
                    break;
                }
            }
        }
        return template;
    }

    private static String buildFixasTemplateMessage(List<AccountRetentionController.BillingAccount> ltFixed, Set<Id> setBillingSelected, List<TemplateMessage__mdt> templateFixed, String papelUserLogado,  String templateOfferFixed, Map<Id, AccountRetentionController.Offer> mapOffer, String templateOfferFixedAlta){
        String fixas = '';
        for (AccountRetentionController.BillingAccount itemBilling : ltFixed){
            if(itemBilling.ltAsset != null && !itemBilling.ltAsset.isEmpty()){    
                if (itemBilling.selectedOfferId != null && String.isNotEmpty(itemBilling.selectedOfferId) && SetBillingSelected.contains(itemBilling.idBilling)){
                    String assets = '';
                    String products = '';
                    templateOfferFixed = getTemplateByRole(templateFixed, papelUserLogado);
                    for (Asset itemAsset : itemBilling.ltAsset){
                        assets += itemAsset.ProductType__c + ' ' + itemAsset.Instance__c + ', ';
                        products += itemAsset.MainProductDescription__c + ' ';                                
                    }

                    templateOfferFixed = templateOfferFixed.replace('[BillingAccount__c]', ((itemBilling.name) != null ?  (itemBilling.name) : ''));
                    templateOfferFixed = templateOfferFixed.replace('[Asset__c.ProductType__c,Asset__c.Instance__c]', assets);
                    templateOfferFixed = templateOfferFixed.replace('[Asset__c.MainProductDescription__c]', products);
                    templateOfferFixed = templateOfferFixed.replace('[FixedLineDescription__c]', ((mapOffer.get(itemBilling.selectedOfferId).field2) != null ?  (mapOffer.get(itemBilling.selectedOfferId).field2) : ''));
                    templateOfferFixed = templateOfferFixed.replace('[BroadbandDescription__c]', ((mapOffer.get(itemBilling.selectedOfferId).field3) != null ?  (mapOffer.get(itemBilling.selectedOfferId).field3) : ''));
                    templateOfferFixed = templateOfferFixed.replace('[TVDescription__c]', ((mapOffer.get(itemBilling.selectedOfferId).field4) != null ?  (mapOffer.get(itemBilling.selectedOfferId).field4) : ''));
                    templateOfferFixed = templateOfferFixed.replace('[TotalPrice__c]', ((mapOffer.get(itemBilling.selectedOfferId).field1) != null ?  (mapOffer.get(itemBilling.selectedOfferId).field1) : ''));
                    templateOfferFixed = templateOfferFixed.replace('[FixedCampaignRTD__c]', ((mapOffer.get(itemBilling.selectedOfferId).field5) != null ?  (mapOffer.get(itemBilling.selectedOfferId).field5) : ''));
                    templateOfferFixed = templateOfferFixed.replace('[PlanTotalPrice__c]', (String.valueOf((mapOffer.get(itemBilling.selectedOfferId).planTotalPrice)) != null ?  String.valueOf((mapOffer.get(itemBilling.selectedOfferId).planTotalPrice)) : ''));

                    fixas +=  templateOfferFixed + '\n' ;
                }
            }else{
                if(itemBilling.selectedOfferId != null && String.isNotEmpty(itemBilling.selectedOfferId)){

                    templateOfferFixedAlta = templateOfferFixedAlta.replace('[BroadBandAttribute__c]', ((mapOffer.get(itemBilling.selectedOfferId).broadBandAttribute) != null ?  (mapOffer.get(itemBilling.selectedOfferId).broadBandAttribute) : ''));
                    templateOfferFixedAlta = templateOfferFixedAlta.replace('[TVAttribute__c]', ((mapOffer.get(itemBilling.selectedOfferId).tvAttribute) != null ?  (mapOffer.get(itemBilling.selectedOfferId).tvAttribute) : ''));
                    templateOfferFixedAlta = templateOfferFixedAlta.replace('[FixedLineDescription__c]', ((mapOffer.get(itemBilling.selectedOfferId).fixedLineDescription) != null ?  (mapOffer.get(itemBilling.selectedOfferId).fixedLineDescription) : ''));
                    templateOfferFixedAlta = templateOfferFixedAlta.replace('[FixedCampaignRTD__c]', String.valueOf(((mapOffer.get(itemBilling.selectedOfferId).field5) != null ?  (mapOffer.get(itemBilling.selectedOfferId).field5) : '')));
                    templateOfferFixedAlta = templateOfferFixedAlta.replace('[TotalPrice__c]', String.valueOf(((mapOffer.get(itemBilling.selectedOfferId).field1) != null ?  (mapOffer.get(itemBilling.selectedOfferId).field1) : '')));
                    templateOfferFixedAlta = templateOfferFixedAlta.replace('[PlanTotalPrice__c]', String.valueOf(((mapOffer.get(itemBilling.selectedOfferId).planTotalPrice) != null && (mapOffer.get(itemBilling.selectedOfferId).planTotalPrice) != 0 ?  (mapOffer.get(itemBilling.selectedOfferId).planTotalPrice) : null)));


                    fixas +=  templateOfferFixedAlta + '\n' ;
                }

            }
        }
        return fixas;
    }

    private static String buildMoveisTemplateMessage(List<AccountRetentionController.BillingAccount> ltMobile, Set<Id> setBillingSelected, List<TemplateMessage__mdt> templateMobile, String papelUserLogado, String templateOfferMobile, Map<Id, AccountRetentionController.Offer> mapOffer){
        String moveis = '';
        for (AccountRetentionController.BillingAccount itemBilling : ltMobile){
            if (itemBilling.ltAssetMovel != null && !itemBilling.ltAssetMovel.isEmpty()){
                for (AccountRetentionController.AssetMovel itemAsset : itemBilling.ltAssetMovel ){
                    for (Asset itemAssetInd : itemAsset.ltAsset ){     
                        if (itemAsset.selectedOfferId != null && String.isNotEmpty(itemAsset.selectedOfferId) && SetBillingSelected.contains(itemBilling.idBilling)){
                            templateOfferMobile = getTemplateByRole(templateMobile, papelUserLogado);

                            templateOfferMobile = templateOfferMobile.replace('[BillingAccount__c]', ((itemBilling.name) != null ?  (itemBilling.name) : '')); 
                            templateOfferMobile = templateOfferMobile.replace('[Asset__c.PhoneNumber__c]', (itemAsset.phone) != null ?  (itemAsset.phone) : '');
                            templateOfferMobile = templateOfferMobile.replace('[MobileDescription__c]', (mapOffer.get(itemAsset.selectedOfferId).field2 ) != null ?  (mapOffer.get(itemAsset.selectedOfferId).field2 ) : '');
                            templateOfferMobile = templateOfferMobile.replace('[MobileInternetDescription__c]', (mapOffer.get(itemAsset.selectedOfferId).field3 ) != null ?  (mapOffer.get(itemAsset.selectedOfferId).field3 ) : '');
                            templateOfferMobile = templateOfferMobile.replace('[TotalPrice__c]', String.ValueOf((mapOffer.get(itemAsset.selectedOfferId).field1 ) != null ?  (mapOffer.get(itemAsset.selectedOfferId).field1 ) : ''));
                            
                            moveis += templateOfferMobile + '\n';
                        }
                    }
                }
            }   
        }
        return moveis;
    }   

    private static String buildOfferMobileAltaTemplateMessage(Id selectedOfferAltaId, String templateOfferMobileAlta){
        Offer__c findOfferAlta = InsertCartSelector.getOfferAlta(selectedOfferAltaId);
        templateOfferMobileAlta = templateOfferMobileAlta.replace('[MobileDescription__c]', (findOfferAlta.MobileDescription__c != null ? findOfferAlta.MobileDescription__c : '') ); 
        templateOfferMobileAlta = templateOfferMobileAlta.replace('[MobileInternetDescription__c]', (String.valueOf(findOfferAlta.MobileInternetDescription__c != null ?  String.valueOf(findOfferAlta.MobileInternetDescription__c) : '')));
        templateOfferMobileAlta = templateOfferMobileAlta.replace('[TotalPrice__c]', (String.valueOf(findOfferAlta.TotalPrice__c != null ?  String.valueOf(findOfferAlta.TotalPrice__c) : '')));
        return templateOfferMobileAlta;
    }
    

    private static CartAccount__c createCartAccount(Id recordId, Id recordTypeId, String contactEmail, String motherName, Date birthDate, String phone, List<CardOfferController.billingAccountCard> listProposal){
        CartAccount__c insertCartAccount = new CartAccount__c();
        Id accountId = getAccountIdFromCustomerInteraction(recordId);
        insertCartAccount.AccountId__c = accountId;
        insertCartAccount.RecordTypeId = recordTypeId; 
        insertCartAccount.ContactEmail__c = contactEmail;      
        insertCartAccount.MotherName__c = motherName;
        insertCartAccount.Birthdate__c = birthDate;   
        insertCartAccount.ContactPhoneNumber__c = phone;                            
        for (CardOfferController.billingAccountCard item : listProposal){
            insertCartAccount.TotalPrice__c = (item.billingProposalValue != null ? item.billingProposalValue : 0) ;
            insertCartAccount.Discount__c = Decimal.valueOf((item.field2) != '' ? (item.field2) : '0');
        }
        return insertCartAccount;
    }

    private static CartAccount__c createCartAccount(Id recordId, Id recordTypeId, String contactEmail, List<CardOfferController.billingAccountCard> listProposal){
        CartAccount__c cartAccountObj = new CartAccount__c();
        Id accountId = getAccountIdFromCustomerInteraction(recordId);
        cartAccountObj.AccountId__c = accountId;
        cartAccountObj.RecordTypeId = recordTypeId;
        cartAccountObj.ContactEmail__c = contactEmail;                                                                                  
        for (CardOfferController.billingAccountCard item : listProposal){
            cartAccountObj.TotalPrice__c = item.billingProposalValue;
            cartAccountObj.Discount__c = Decimal.valueOf((item.field2) != '' ? (item.field2) : '0');
        }
        return cartAccountObj;
    }

    private static CartOffer__c createCartOffer(Id recordTypeId, Id cartId, Id offerId){
        CartOffer__c insertCartOffer = new CartOffer__c();                                                                                                           
        insertCartOffer.RecordTypeId = recordTypeId;             
        insertCartOffer.CartId__c = cartId;
        insertCartOffer.OfferId__c = offerId;
        return insertCartOffer;
    }

    public static Id getAccountIdFromCustomerInteraction(Id recordId) {
        List<vlocity_cmt__CustomerInteraction__c> customerInteraction = [SELECT vlocity_cmt__AccountId__c FROM vlocity_cmt__CustomerInteraction__c WHERE Id =: recordId LIMIT 1];
        return customerInteraction.isEmpty() ? null : customerInteraction[0].vlocity_cmt__AccountId__c;        
    }
}