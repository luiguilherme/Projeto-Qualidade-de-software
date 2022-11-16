public class CardOfferServiceReturn {

	@AuraEnabled public String card_type;
	@AuraEnabled public String title;
	@AuraEnabled public String container_id;
	@AuraEnabled public String card_layout;
	@AuraEnabled public String msg;
	@AuraEnabled public List<Card> cards;

	public CardOfferServiceReturn() {
		card_type = this.card_type;
		title = this.title;
		container_id = this.container_id;
		card_layout = this.card_layout;
		cards = this.cards;
		msg = 'error';
	}

	public CardOfferServiceReturn(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'card_type') {
						card_type = parser.getText();
					} else if (text == 'title') {
						title = parser.getText();
					} else if (text == 'container_id') {
						container_id = parser.getText();
					} else if (text == 'card_layout') {
						card_layout = parser.getText();
					} else if (text == 'cards') {
						cards = arrayOfCards(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'CardOfferServiceReturn consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class SubOffers {
		@AuraEnabled public String name;
		@AuraEnabled public String description;
		@AuraEnabled public String categories;
		@AuraEnabled public String type;
		@AuraEnabled public String offerPrice;
		@AuraEnabled public String campaignCode;

		public SubOffers(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'categories') {
							categories = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'SubOffers consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Image {
		public String url;
		public String alt;

		public Image(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'url') {
							url = parser.getText();
						} else if (text == 'alt') {
							alt = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Image consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Identifiers {
		public String type;
		public String id;

		public Identifiers(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'type') {
							type = parser.getText();
						} else if (text == 'id') {
							id = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Identifiers consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Card {
		@AuraEnabled public String id;
		@AuraEnabled public String title;
		@AuraEnabled public Image image;
		@AuraEnabled public String description;
		@AuraEnabled public String actionDescription;
		@AuraEnabled public Boolean accepts_feedback;
		@AuraEnabled public Boolean isFocused;
		@AuraEnabled public Boolean isDisabled;
		@AuraEnabled public List<Identifiers> identifiers;
		@AuraEnabled public String source;
		@AuraEnabled public String rank;
		@AuraEnabled public String voucher_code;
		@AuraEnabled public String campaignCode;
		@AuraEnabled public List<SubOffers> sub_offers;
		@AuraEnabled public List<String> ltOptions;

		public Card(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'title') {
							title = parser.getText();
						} else if (text == 'image') {
							image = new Image(parser);
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'accepts_feedback') {
							accepts_feedback = parser.getBooleanValue();
						} else if (text == 'identifiers') {
							identifiers = arrayOfIdentifiers(parser);
						} else if (text == 'source') {
							source = parser.getText();
						} else if (text == 'rank') {
							rank = parser.getText();
						} else if (text == 'voucher_code') {
							voucher_code = parser.getText();
						} else if (text == 'sub_offers') {
							sub_offers = arrayOfSub_offers(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Card consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public static CardOfferServiceReturn parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		List<CardOfferServiceReturn> ltParser = arrayOfCardOfferServiceReturn(parser);
		return ltParser[0];
	}

	public static List<CardOfferServiceReturn> parseList(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return arrayOfCardOfferServiceReturn(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	
    private static List<Card> arrayOfCards(System.JSONParser p) {
        List<Card> res = new List<Card>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Card(p));
        }
        return res;
    }

    private static List<Identifiers> arrayOfIdentifiers(System.JSONParser p) {
        List<Identifiers> res = new List<Identifiers>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Identifiers(p));
        }
        return res;
    }

    private static List<CardOfferServiceReturn> arrayOfCardOfferServiceReturn(System.JSONParser p) {
        List<CardOfferServiceReturn> res = new List<CardOfferServiceReturn>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new CardOfferServiceReturn(p));
        }
        return res;
    }

    private static List<SubOffers> arrayOfSub_offers(System.JSONParser p) {
        List<SubOffers> res = new List<SubOffers>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new SubOffers(p));
        }
        return res;
    }
}