/* 
    Histórias:
    B2C7551-1195 NBA/NBO Sales Cloud - Fase I - https://wikicorp.telefonica.com.br/pages/viewpage.action?pageId=170658664
    B2C7551-2186 Aceite ou Recusa da oferta - https://wikicorp.telefonica.com.br/display/PTI/B2C7551-2186+Aceite+ou+Recusa+da+oferta
*/

public with sharing class CarouselCardOfferEngine {
    private static final String CONST_WEB_SERVICE_RTD = 'RtdNbaNboServiceCallout';
    private static final String CONST_WITHOUT_FROM_TO_MAPPING = 'withoutFromToMapping';
    private static final String CONST_NO_CARD_OFFER = 'noCardOffer';
    private static final Integer CONST_SUCCESS_CODE = 200;
    private static final String CONST_ACCOUNT_RECORD_TYPE = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Consumer').getrecordTypeId();
    private static final String CONST_CART_ACCOUNT_NBO_NBA_RECORD_TYPE = Schema.SObjectType.CartAccount__c.getRecordTypeInfosByDeveloperName().get('NextBestOfferAndAction').getrecordTypeId();

    public static Boolean checkIfAccountHaveUserId (Id accountId) {        
        Account account = AccountDAO.getByIds(accountId);
        if (account.UserId__c != null) {
            return true;
        } else {
            return false;
        }
    }
    
    public static CardOfferServiceReturn getCardsOffers (Id accountId) {
        CardOfferServiceReturn cardOffers = new CardOfferServiceReturn();

        Webservice__c wsConfig = Webservice__c.getInstance(CONST_WEB_SERVICE_RTD);
        if (wsConfig == null || !wsConfig.switchedOn__c) {
            return cardOffers;
        }

        Account account = AccountDAO.getByIds(accountId);
        if (account == null) {
            return cardOffers;
        }

        User userObj = UserDAO.getUserInfo()[0];
        if (userObj == null) {
            return cardOffers;
        }

        String userChannel = getUserChannel(userObj);
     
         if(String.isEmpty(userChannel)){
            cardOffers.msg = CONST_WITHOUT_FROM_TO_MAPPING;
            return cardOffers;
        }
        
        String responseBody;
        String parameters = account.UserId__c + '/modules?card_types=next-best-offer&container_ids=' + EncodingUtil.urlEncode(userChannel, 'UTF-8');
        String endpoint = wsConfig.Endpoint__c + parameters;
        System.debug('Endpoint:'+ endpoint);
        HttpClient client = new HttpClient();
        HttpResponse response;
        try {
            response = client.get(wsConfig, endpoint);
            responseBody = response.getBody();
            System.debug('ResponseBody:' + responseBody);
        } catch (Exception e) {
            cardOffers.msg = e.getMessage();
            return cardOffers;
        }

        String strLtCardWhenEmpty = '[]';
        CardOfferServiceReturn responseService;
        if (response.getStatusCode() == CONST_SUCCESS_CODE 
                && !responseBody.contains(strLtCardWhenEmpty) 
                && String.isNotEmpty(responseBody)) {
            responseService = CardOfferServiceReturn.parse(response.getBody());        
        } else if (response.getStatusCode() == CONST_SUCCESS_CODE) {
            cardOffers.msg = CONST_NO_CARD_OFFER;
            return cardOffers;
        } else {
            return cardOffers;
        }

        if (responseService == null) {
            cardOffers.msg = CONST_NO_CARD_OFFER;
            return cardOffers;
        } else {
            cardOffers = responseService;
            cardOffers.msg = 'success';
            return cardOffers;
        }
    }

    private static String getUserChannel (User user) {
        String userChannel;
        FromToMapping__mdt mapping;
        Map<String,FromToMapping__mdt> mapFromTo = new Map<String,FromToMapping__mdt>();
        CollectionUtil.loadMap(mapFromTo, 'OriginApiName__c', 
                                FromToMappingDAO.getFromOriginUsedIn('NbaNbo'));
        
        if (user.Profile.UserLicense.Name != 'Partner Community') {
            mapping = mapFromTo.get(user.UserRole.DeveloperName);
            if (mapping != null) {
                userChannel = mapping.DestinyName__c;
            }
        } else {
            mapping = mapFromTo.get(user.PartnerGroup__c);
            if (mapping != null) {
                userChannel = mapping.DestinyName__c;
            }
        }

        return userChannel != null ? userChannel : '';
    }

    public static Boolean postCardOffers (Id accountId, 
                                          CardOfferServiceReturn.Card card, 
                                          String acceptOrNot, 
                                          String reason) {
        Webservice__c wsConfig = Webservice__c.getInstance(CONST_WEB_SERVICE_RTD);
        if (wsConfig == null || !wsConfig.switchedOn__c) {
            return false;
        }

        Account accountCurrent = AccountDAO.getByIds(accountId);
        if (accountCurrent == null) {
            return false;
        }

        String payload = buildPayloadAcceptOrDeny(card, acceptOrNot, reason);
        wsConfig.Endpoint__c = wsConfig.Endpoint__c + accountCurrent.UserId__c + '/cards/feedback';
        HttpClient client = new HttpClient();
        HttpResponse response;
        try {
            response = client.post(wsConfig, payload);
        } catch (Exception e) {
            return false;
        }

        if (response.getStatusCode() == CONST_SUCCESS_CODE) {
            return true;
        } else {
            return false;
        }
    }

    private static String buildPayloadAcceptOrDeny (CardOfferServiceReturn.Card card, 
                                                    String acceptOrNot, 
                                                    String reason) {
        JSONGenerator jsonGenerator = JSON.createGenerator(true);
        jsonGenerator.writeStartObject();
        jsonGenerator.writeStringField('container_id', card.id);
        jsonGenerator.writeFieldName('outcomes');
        if (card.sub_offers.isEmpty()) {
            jsonGenerator.writeStartArray();    
            jsonGenerator.writeEndArray();
        } else {
            jsonGenerator.writeStartArray();
            for (CardOfferServiceReturn.SubOffers itemSubOffer : card.sub_offers) {
                jsonGenerator.writeStartObject();
                jsonGenerator.writeStringField('outcome', (itemSubOffer.description + ' | ' + itemSubOffer.categories));
                jsonGenerator.writeStringField('card_id', (acceptOrNot + ' | ' + reason));
                jsonGenerator.writeEndObject();
            }
            jsonGenerator.writeEndArray();
        }
        jsonGenerator.writeEndObject();
        
        if (jsonGenerator != null) {
            return jsonGenerator.getAsString();
        } else {
            return '';    
        }
    }

    public static CardOfferServiceReturn toShapeCardOffer (CardOfferServiceReturn cardOfferToReturn) {
        if (cardOfferToReturn.msg == 'success') {
            List<CardOfferServiceReturn.Card> cardList = new List<CardOfferServiceReturn.Card>();
            List<CardOfferServiceReturn.SubOffers> subOfferList;
            List<NextBestOfferAndAction__c> nboActionsList = NextBestOfferAndAction__c.getall().values();

            for (CardOfferServiceReturn.Card itemCard : cardOfferToReturn.cards) {
                if (itemCard.sub_offers != null) {
                    subOfferList = new List<CardOfferServiceReturn.SubOffers>();
                    for (CardOfferServiceReturn.SubOffers itemSubOffer : itemCard.sub_offers) {
                        itemSubOffer.categories = itemSubOffer.categories.trim();
                        if (isPrincipalOffer(itemSubOffer.categories)) {
                            itemSubOffer.offerPrice = itemCard.voucher_code;
                            itemCard.actionDescription = itemSubOffer.name;
                            subOfferList.add(convertDescriptionToFields(itemSubOffer));
                        } else{
                            subOfferList.add(convertDescriptionToFields(itemSubOffer)); 
                        }
                    }

                    subOfferList = sortSubOffersByCategories(subOfferList);
                    itemCard.sub_offers = subOfferList;
                }
                if (itemCard.title != null) {
                    itemCard.ltOptions = getListOfOptionsNotAccepted(itemCard.title, nboActionsList);
                }

                if (itemCard.source == '9999'){
                    itemCard.isBirthday = true;
                }


                cardList.add(itemCard);
            }

            cardOfferToReturn.cards = sortCardsByPriority(cardList);
            cardOfferToReturn.cards[0].isFocused = true; 
            return cardOfferToReturn;
        } else {
            return cardOfferToReturn;
        }
    }

    private static Boolean isPrincipalOffer (String categories) {
        if (categories == 'P') {
            return true;
        } else {
            return false;
        }
    }
    
    private static CardOfferServiceReturn.SubOffers convertDescriptionToFields (CardOfferServiceReturn.SubOffers subOffer) {
        List<String> splitList = subOffer.description.split('\\|');
        if (isPrincipalOffer(subOffer.categories)) {
            subOffer.description = splitList[0];
        } else {
            subOffer.description = splitList[0];
            subOffer.type = splitList[1];
            subOffer.campaignCode = splitList[2];
            subOffer.offerPrice = splitList[3];       
        }
        return subOffer;
    }
    
    private static List<CardOfferServiceReturn.SubOffers> sortSubOffersByCategories (List<CardOfferServiceReturn.SubOffers> ltSubOffer) {
        List<CardOfferServiceReturn.SubOffers> subOfferToSortList = ltSubOffer;
        for (Integer i = 0; i < subOfferToSortList.size() -1 ; i++) {
            for (Integer j = 0; j < subOfferToSortList.size() - 1 - i; j++) {
                if (!isPrincipalOffer(subOfferToSortList[j].categories)) {
                    CardOfferServiceReturn.SubOffers aux = subOfferToSortList[j];
                    subOfferToSortList[j] = subOfferToSortList[j + 1];
                    subOfferToSortList[j + 1] = aux;
                }
            }
        }
        return subOfferToSortList;
    }

    private static List<String> getListOfOptionsNotAccepted (String cardType, 
                                                             List<NextBestOfferAndAction__c> nboActionsList) {
        List<String> optionsOfNotAcceptedList = new List<String>();
        if (nboActionsList != null) {
            for (NextBestOfferAndAction__c nboAction : nboActionsList) {
                if (nboAction.type__c == cardType) {
                    optionsOfNotAcceptedList.add(nboAction.Reason__c);    
                }
            }
            return optionsOfNotAcceptedList;
        } else {
            optionsOfNotAcceptedList.add('');
            return optionsOfNotAcceptedList;
        }
    }
    
    public static List<CardOfferServiceReturn.Card> sortCardsByPriority (List<CardOfferServiceReturn.Card> cardList) {
        List<CardOfferServiceReturn.Card> cardToSortList = cardList;
        for (Integer i = 0; i < cardToSortList.size() -1 ; i++) {
            for (Integer j = 0; j < cardToSortList.size() - 1 - i; j++) {
                if (Integer.valueOf(cardToSortList[j].rank) > Integer.valueOf(cardToSortList[j + 1].rank)) {
                    CardOfferServiceReturn.Card auxCard = cardToSortList[j];
                    cardToSortList[j] = cardToSortList[j + 1];
                    cardToSortList[j + 1] = auxCard;
                }
            }
        }
        return cardToSortList;
    }

    public static String createNboCartAccount (Id accountId, 
                                               CardOfferServiceReturn.Card card, 
                                               String acceptOrNot, 
                                               String reason, 
                                               Boolean postStatus) {
        if (postStatus) {   
            Decimal price = Decimal.valueOf(card.voucher_code);
            CartAccount__c cartAccountToCreate = new CartAccount__c();
            Id nboRecType = CONST_CART_ACCOUNT_NBO_NBA_RECORD_TYPE;
            cartAccountToCreate.recordTypeId = nboRecType;
            cartAccountToCreate.TotalPrice__c = price;
            cartAccountToCreate.OfferType__c = card.title;
            cartAccountToCreate.AccountId__c = accountId;

            if (acceptOrNot == 'ACEITOU') {
                cartAccountToCreate.Accepted__c = 'Accepted';
            } else {
                cartAccountToCreate.Accepted__c = 'NotAccepted';
                cartAccountToCreate.ReasonNotAccepted__c = reason;
            }

            Database.SaveResult saveResult = Database.insert(cartAccountToCreate);
            if (saveResult.isSuccess()) {
                return 'success';
            } else {
                return 'error';
            }   
        } else {
            return 'error';
        }
    }
}