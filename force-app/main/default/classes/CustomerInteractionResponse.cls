public class CustomerInteractionResponse {

	public CustomerInteractionResponse(){

	}

	public class ProtocolItems {
		@InvocableVariable
		@AuraEnabled
		public String idProtocolItem;
		@AuraEnabled
		@InvocableVariable
		public Protocol protocol;
		@AuraEnabled
		@InvocableVariable 
		public Network network;
		@AuraEnabled
		@InvocableVariable
		public ItemProtocol itemProtocol;
		@AuraEnabled
		@InvocableVariable
		public SourceSystem sourceSystem;
		@AuraEnabled
		@InvocableVariable
		public RelatedProtocol relatedProtocol;
		@AuraEnabled
		@InvocableVariable
		public String channelName;
		@AuraEnabled
		@InvocableVariable
		public Datetime creationDate;
		@AuraEnabled
		@InvocableVariable
		public Datetime endDate;
		@AuraEnabled
		@InvocableVariable
		public String protocolId;
		@AuraEnabled
		@InvocableVariable
		public String externalSystem;
		@AuraEnabled
		@InvocableVariable
		public String notesX9;
		@AuraEnabled
		@InvocableVariable
		public Individual individual;
		@AuraEnabled
		@InvocableVariable
		public List<Items> items;

		public ProtocolItems(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'idProtocolItem') {
							idProtocolItem = parser.getText();
						} else if (text == 'protocol') {
							protocol = new Protocol(parser);
						} else if (text == 'network') {
							network = new Network(parser);
						} else if (text == 'itemProtocol') {
							itemProtocol = new ItemProtocol(parser);
						} else if (text == 'sourceSystem') {
							sourceSystem = new SourceSystem(parser);
						} else if (text == 'relatedProtocol') {
							relatedProtocol = new RelatedProtocol(parser);
						} else if (text == 'channelName') {
							channelName = parser.getText();
						} else if (text == 'creationDate') {
							creationDate = parser.getDatetimeValue();
						} else if (text == 'endDate') {
							endDate = parser.getDatetimeValue();
						} else if (text == 'protocolId') {
							protocolId = parser.getText();
						} else if (text == 'externalSystem') {
							externalSystem = parser.getText();
						} else if (text == 'notesX9') {
							notesX9 = parser.getText();
						} else if (text == 'individual') {
							individual = new Individual(parser);
						} else if (text == 'items') {
							items = arrayOfItems(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'ProtocolItems consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ItemProtocol {
		@InvocableVariable
		@AuraEnabled
		public String description;
		@AuraEnabled
		@InvocableVariable
		public String status;
		@AuraEnabled
		@InvocableVariable
		public String subStatus;
		@AuraEnabled
		@InvocableVariable
		public DateTime openingDate;
		@AuraEnabled
		@InvocableVariable
		public DateTime closingDate;

		public ItemProtocol(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'description') {
							description = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'subStatus') {
							subStatus = parser.getText();
						} else if (text == 'openingDate') {
							openingDate = parser.getDatetimeValue();
						} else if (text == 'closingDate') {
							closingDate = parser.getDatetimeValue();
						} else {
							System.debug(LoggingLevel.WARN, 'ItemProtocol consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Individual {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String email;

		public Individual(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'email') {
							email = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Individual consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Network {
		@InvocableVariable
		@AuraEnabled
		public String geographicAreaCode;
		@InvocableVariable
		@AuraEnabled
		public String networkNumber;
		@AuraEnabled
		@InvocableVariable
		public String digitNetwork;

		public Network(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'geographicAreaCode') {
							geographicAreaCode = parser.getText();
						} else if (text == 'networkNumber') {
							networkNumber = parser.getText();
						} else if (text == 'digitNetwork') {
							digitNetwork = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Network consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class RelatedProtocol {
		@InvocableVariable
		@AuraEnabled
		public String protocolNumber;

		public RelatedProtocol(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'protocolNumber') {
							protocolNumber = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'RelatedProtocol consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Items {
		@InvocableVariable
		@AuraEnabled
		public String caseId;
		@AuraEnabled
		@InvocableVariable
		public Boolean p2pIndicator;
		@InvocableVariable
		@AuraEnabled
		public String reasonLevel1;
		@InvocableVariable
		@AuraEnabled
		public String reasonLevel2;
		@InvocableVariable
		@AuraEnabled
		public String result;
		@InvocableVariable
		@AuraEnabled
		public String workId;
		@InvocableVariable
		@AuraEnabled
		public String workType;

		public Items(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'caseId') {
							caseId = parser.getText();
						} else if (text == 'p2pIndicator') {
							p2pIndicator = parser.getBooleanValue();
						} else if (text == 'reasonLevel1') {
							reasonLevel1 = parser.getText();
						} else if (text == 'reasonLevel2') {
							reasonLevel2 = parser.getText();
						} else if (text == 'result') {
							result = parser.getText();
						} else if (text == 'workId') {
							workId = parser.getText();
						} else if (text == 'workType') {
							workType = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Items consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	@InvocableVariable
	@AuraEnabled
	public List<ProtocolItems> protocolItems;

	public CustomerInteractionResponse(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'protocolItems') {
						protocolItems = arrayOfProtocolItems(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'CustomerInteractionResponse consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Protocol {
		@InvocableVariable
		@AuraEnabled
		public String protocolNumber;
		@InvocableVariable
		@AuraEnabled
		public String submissionStatus;
		@InvocableVariable
		@AuraEnabled
		public String smsClassification;
		@InvocableVariable
		@AuraEnabled
		public DateTime openingDate;
		@InvocableVariable
		@AuraEnabled
		public DateTime closingDate;
		@InvocableVariable
		@AuraEnabled
		public String protocolType;
		@InvocableVariable
		@AuraEnabled
		public String protocolStatus;

		public Protocol(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'protocolNumber') {
							protocolNumber = parser.getText();
						} else if (text == 'submissionStatus') {
							submissionStatus = parser.getText();
						} else if (text == 'smsClassification') {
							smsClassification = parser.getText();
						} else if (text == 'openingDate') {
							openingDate = parser.getDatetimeValue();
						} else if (text == 'closingDate') {
							closingDate = parser.getDatetimeValue();
						} else if (text == 'protocolType') {
							protocolType = parser.getText();
						} else if (text == 'protocolStatus') {
							protocolStatus = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Protocol consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class SourceSystem {
		@InvocableVariable
		@AuraEnabled
		public String systemName;

		public SourceSystem(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'systemName') {
							systemName = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'SourceSystem consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static CustomerInteractionResponse parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new CustomerInteractionResponse(parser);
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
	










    private static List<Items> arrayOfItems(System.JSONParser p) {
        List<Items> res = new List<Items>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Items(p));
        }
        return res;
    }


    private static List<ProtocolItems> arrayOfProtocolItems(System.JSONParser p) {
        List<ProtocolItems> res = new List<ProtocolItems>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new ProtocolItems(p));
        }
        return res;
    }




}