/*
---------------------------------------------------
@authors - Geimison Oliveira | Pedro Salles 
@company - Telefonica 
@date - 25/03/2020
@description - Classe Controller dos componentes 
customizados de Ofertas para retenção de contas 
do tipo Fixa e Móvel
---------------------------------------------------

*/
public class CardOfferController {
    @AuraEnabled
    public static Map<String, Object> getBillingAccountCard(String JSONFixed, String JSONMobile, String JSONMobileAlta, String IdOfferAlta, String accountId, Id userId){  
        Type idArrType = Type.forName('List<AccountRetentionController.BillingAccount>');
        Type idArrTypeOffer = Type.forName('List<AccountRetentionController.Offer>');
        
        system.debug('Json de Fixa : ' + JSONFixed);
        system.debug('Json de Movel : ' + JSONMobile);
        system.debug('Json de Alta : ' + JSONMobileAlta);
        system.debug('Id de Alta : ' + IdOfferAlta);
        system.debug('Account Id : ' + accountId);
        system.debug('User Id : ' + userId);
        
        List<AccountRetentionController.BillingAccount> ltBillingAccountFixed = (List<AccountRetentionController.BillingAccount>)JSON.deserialize(JSONFixed,idArrType);
        
        List<AccountRetentionController.BillingAccount> ltBillingAccountMobile= (List<AccountRetentionController.BillingAccount>)JSON.deserialize(JSONMobile,idArrType);
        
        List<AccountRetentionController.Offer> ltBillingAccountOfferAlta= (List<AccountRetentionController.Offer>)JSON.deserialize(JSONMobileAlta,idArrTypeOffer);
        Map<String,Object> mapReturn = new Map<String,Object>();
        Set<Id> setBillingSelected = new Set<Id>();
        Set<Id> setOfferSelected = new Set<Id>();
        billingAccountCard billingCard;
        List<billingAccountCard> ltCardFixed = new List<billingAccountCard>();
        List<billingAccountCard> ltCardMobile = new List<billingAccountCard>();
        List<billingAccountCard> ltCardProposal = new List<billingAccountCard>();
        List<billingAccountCard> ltCardProposalAlta = new List<billingAccountCard>();
        List<billingAccountCard> ltCardOfferAlta = new List<billingAccountCard>();
        Map<String,Object> mapResult = new Map<String,Object>();
        //mapResult = getAccountRetention(Id.valueOf(accountId),userId);
        
        Decimal billingValue;
        Decimal billingValueProposalFixed = 0;
        Decimal billingValueProposalMobile = 0;
        Decimal billingValueProposal = 0;
        Decimal billingValueProposalDiffFixed = 0;
        Decimal billingValueProposalDiffMobile = 0;
        Decimal billingValueProposalDiff = 0;
        Decimal billingValueServiceFixed = 0;
        Decimal billingValueServiceMobile = 0;
        Decimal billingValueService = 0;
        Decimal billingValueServiceAlta = 0;
        Boolean hasOffer = false;
        Boolean hasOfferFixed = false;
        Boolean hasOfferMobile = false;
        Boolean hasOfferAlta = false;
        boolean hasTotalProposal = false;
        
        Decimal valueProposalOrig = (Decimal)mapResult.get('totalPriceProposal');
        Decimal valueProposalFixed = (Decimal)mapResult.get('totalPriceFixed');
        Decimal valueProposalMobile= (Decimal)mapResult.get('totalPriceMobile');         
        Decimal valueProposalAlta = (Decimal)mapResult.get('totalPriceMobile');
        
        
        billingValue = 0;
        String field2 = '';
        String field3 = '';
        String field4 = '';
        String field5 = '';
        String field6 = '';
        String field7 = '';
        String field8 = '';
        String field9 = '';
        String field10 = '';
        String field11 = '';
        String field12 = '';
        String field13 = '';
        
        Map<Id, AccountRetentionController.Offer> mapOffer = new Map<Id, AccountRetentionController.Offer>();
        for(AccountRetentionController.BillingAccount itemBilling : ltBillingAccountFixed){
            if(itemBilling.selectedOfferId != null && String.isNotEmpty(itemBilling.selectedOfferId)  ){
                hasOfferFixed = true;
                setBillingSelected.add(itemBilling.idBilling);
                setOfferSelected.add(itemBilling.selectedOfferId);
                for(AccountRetentionController.Offer itemOffer : itemBilling.ltOffer){
                    mapOffer.put(itemOffer.idOffer, itemOffer);
                    
                }                
            }
        }
        
        
        // Lógica de calculo das ofertas de Fixa
        
        for(AccountRetentionController.BillingAccount itemBilling : ltBillingAccountFixed){ 
            if(itemBilling.selectedOfferId != null && String.isNotEmpty(itemBilling.selectedOfferId) && SetBillingSelected.contains(itemBilling.idBilling)){
                billingCard = new billingAccountCard();
                billingCard.billingAccount      = itemBilling.idBilling;
                billingCard.billingAccountName  = itemBilling.name; 
                billingValue = Decimal.valueOf(mapOffer.get(itemBilling.selectedOfferId).field1);
                field2 = mapOffer.get(itemBilling.selectedOfferId).field2;	
                field3 = mapOffer.get(itemBilling.selectedOfferId).field3;
                field4 = mapOffer.get(itemBilling.selectedOfferId).field4;
                field5 = mapOffer.get(itemBilling.selectedOfferId).field5;
                field6 = mapOffer.get(itemBilling.selectedOfferId).field6;
                field7 = mapOffer.get(itemBilling.selectedOfferId).field7;
                field8 = mapOffer.get(itemBilling.selectedOfferId).field8;
                field9 = itemBilling.name;
                field10 = mapOffer.get(itemBilling.selectedOfferId).field10;
                field11 = mapOffer.get(itemBilling.selectedOfferId).field11;
                field12 = mapOffer.get(itemBilling.selectedOfferId).field12;
                
                billingCard.billingValue = billingValue;
                billingCard.field2 = field2;
                billingCard.field3 = field3;
                billingCard.field4 = field4;
                billingCard.field5 = field5;
                billingCard.field6 = field6;
                billingCard.field7 = field7;
                billingCard.field8 = field8;
                billingCard.field9 = field9;
                billingCard.field10 = field10;
                billingCard.field11 = field11;
                billingCard.field12 = field12;
                billingValueProposalFixed += billingValue;
                
                billingValueServiceFixed += (itemBilling.totalPrice != null ? itemBilling.totalPrice : 0); 
                ltCardFixed.add(billingCard);
            }else if(SetBillingSelected.contains(itemBilling.idBilling)){                        
                billingValueProposalFixed +=itemBilling.totalPrice; 
                billingValueServiceFixed += itemBilling.totalPrice; 
                
            }            
            
            billingValueProposalDiffFixed = billingValueServiceFixed - billingValueProposalFixed;                    
        }
       
        // Lógica de calculo das ofertas de Movel
        
        for(AccountRetentionController.BillingAccount itemBilling : ltBillingAccountMobile){
            if(itemBilling.ltAssetMovel != null && !itemBilling.ltAssetMovel.isEmpty()){
            for(AccountRetentionController.AssetMovel itemAsset : itemBilling.ltAssetMovel ){
                if(itemAsset.selectedOfferId != null && String.isNotEmpty(itemAsset.selectedOfferId) ){
                    hasOfferMobile = true;
                    setBillingSelected.add(itemBilling.idBilling);
                    setOfferSelected.add(itemAsset.selectedOfferId);
                    for(AccountRetentionController.Offer itemOffer : itemAsset.ltOffer){
                        mapOffer.put(itemOffer.idOffer, itemOffer);
                    }
                }
            }
            }
        }        
        billingValue = 0;
        field2 = '';
        field3 = '';
        field4 = '';
        field5 = '';
        field8 = '';
        for(AccountRetentionController.BillingAccount itemBilling : ltBillingAccountMobile){
            if(itemBilling.ltAssetMovel != null && !itemBilling.ltAssetMovel.isEmpty()){
            for(AccountRetentionController.AssetMovel itemAsset : itemBilling.ltAssetMovel ){
                for(Asset itemAssetInd : itemAsset.ltAsset ){     
                    if(itemAsset.selectedOfferId != null && String.isNotEmpty(itemAsset.selectedOfferId) && SetBillingSelected.contains(itemBilling.idBilling)){
                        billingValue = Decimal.valueOf(mapOffer.get(itemAsset.selectedOfferId).field1);
                        field2 = mapOffer.get(itemAsset.selectedOfferId).field2 ;
                        field3 = mapOffer.get(itemAsset.selectedOfferId).field3 ;
                        field4 = mapOffer.get(itemAsset.selectedOfferId).field4 ;
                        field5 = itemAsset.phone ;
                        
                        billingCard = new billingAccountCard();
                        billingCard.billingAccount      = itemBilling.idBilling;
                        billingCard.billingAccountName  = itemBilling.name;
                        
                        billingCard.billingValue = billingValue;
                        billingCard.field2 = field2;
                        billingCard.field3 = field3;
                        billingCard.field4 = field4;
                        billingCard.field5 = field5;
                        billingValueProposalMobile += billingValue;
                        billingValueServiceMobile += itemAsset.priceCurrent; 
                        
                        
                        ltCardMobile.add(billingCard);
                    }else if(SetBillingSelected.contains(itemBilling.idBilling) ) {                        
                        billingValueProposalMobile +=itemAsset.priceCurrent;
                        billingValueServiceMobile += itemAsset.priceCurrent;
                        
                    }
                }
                
            }
            
            billingValueProposalDiffMobile = billingValueServiceMobile - billingValueProposalMobile;     
            
        }
        }
        
        if (ltBillingAccountOfferAlta != null && IdOfferAlta != null){ 
            for(AccountRetentionController.Offer itemOffer : ltBillingAccountOfferAlta){
                if(itemOffer.idOffer == Id.valueOf(IdOfferAlta) ){
                    hasOfferAlta = true;
                    billingCard = new billingAccountCard();
                    billingCard.billingAccount = itemOffer.idOffer;                        
                    billingCard.field1 = itemOffer.field1;
                    billingCard.field2 = itemOffer.field2;
                    billingCard.field3 = itemOffer.field3;       
                    billingCard.field4 = itemOffer.field4; 
                    billingCard.field5 = itemOffer.field5;
                    billingCard.field6 = 'Oferta Alta';
                    billingCard.field7 = 'Economia de ';
                    billingCard.field8 = itemOffer.field8;
                    
                    ltCardOfferAlta.add(billingCard);
                    ltCardProposalAlta.add(billingCard);
                    
                }
            } 
        }
        Decimal valueFixed = (Decimal)mapResult.get('totalPriceFixed');
        Decimal valueMobile = (Decimal)mapResult.get('totalPriceMobile');         
        Decimal valueMobileAlta = (Decimal)mapResult.get('totalPriceMobile');
        
        billingAccountCard billingCardProposal = new billingAccountCard();
        
        if(hasOfferFixed == true && hasOfferMobile == true){
            billingCardProposal.billingProposalValue = billingValueProposalFixed + billingValueProposalMobile;
            billingValueProposalDiff = billingValueProposalDiffFixed + billingValueProposalDiffMobile;
        }else if(hasOfferFixed == true ){
            billingCardProposal.billingProposalValue = billingValueProposalFixed;
            billingValueProposalDiff = billingValueProposalDiffFixed;
        }else if(hasOfferMobile == true){
            billingCardProposal.billingProposalValue = billingValueProposalMobile;
            billingValueProposalDiff = billingValueProposalDiffMobile;
        }        
        
        Decimal FixedOffer = (Decimal)mapResult.get('totalPriceFixed');
        Decimal MobileOffer = (Decimal)mapResult.get('totalPriceMobile');         
        Decimal AltaOffer = (Decimal)mapResult.get('totalPriceMobile');
         
        Decimal totalFixed = (Decimal)mapResult.get('totalPriceFixed');
        Decimal totalMobile = (Decimal)mapResult.get('totalPriceMobile');         
        Decimal totalAlta = (Decimal)mapResult.get('totalPriceMobile');
        
        if(billingValueProposalDiff > 0){
            billingCardProposal.field3 = 'Valor da Proposta : ';
            billingCardProposal.field1 = 'Economia de  ';   
            billingCardProposal.field2 = String.valueOf((billingValueProposalDiff));
            hasTotalProposal = true;
            ltCardProposal.add(billingCardProposal);
            
        } else if(billingValueProposalDiff < 0){
            billingCardProposal.field3 = 'Valor da Proposta : ';
            billingCardProposal.field1 = 'Acréscimo de  ';
            billingCardProposal.field2 = String.valueOf((billingValueProposalDiff* -1));
            hasTotalProposal = true;         
            ltCardProposal.add(billingCardProposal);
        }else if(billingValueProposalDiff == 0 ){
            billingCardProposal.field3 = '';
            billingCardProposal.field1 = '';
            billingCardProposal.field2 = '';
            hasTotalProposal = true;         
            ltCardProposal.add(billingCardProposal);
        }
        
        mapReturn.put('setOfferSelected', setOfferSelected);
        mapReturn.put('ltCardFixed', ltCardFixed);   
        mapReturn.put('hasOfferFixed', hasOfferFixed);
        mapReturn.put('ltCardMobile', ltCardMobile);
        mapReturn.put('hasOfferMobile', hasOfferMobile);
        mapReturn.put('ltCardProposal', ltCardProposal);
        mapReturn.put('ltCardOfferAlta', ltCardOfferAlta);
        mapReturn.put('ltCardProposalAlta', ltCardProposalAlta);
        mapReturn.put('hasOfferAlta', hasOfferAlta);
        mapReturn.put('hasTotalProposal', hasTotalProposal);
        return mapReturn;
        
    }
     
   
   
    
    public class billingAccountCard{
        
        @Auraenabled public String billingAccount;
        @Auraenabled public String billingAccountName;
        @Auraenabled public Decimal billingValue;
        @Auraenabled public Decimal billingProposalValue;
        @Auraenabled public String field1;
        @Auraenabled public String field2;
        @Auraenabled public String field3;
        @Auraenabled public String field4;
        @Auraenabled public String field5;
        @Auraenabled public String field6;
        @Auraenabled public String field7;
        @Auraenabled public String field8;
        @Auraenabled public String field9;
        @Auraenabled public String field10;
        @Auraenabled public String field11;
        @Auraenabled public String field12;
    }
    
}