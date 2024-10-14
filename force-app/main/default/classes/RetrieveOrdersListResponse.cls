global  without sharing class RetrieveOrdersListResponse {

	global class SalesChannel {
        @AuraEnabled
		@InvocableVariable
		global String salesChannel;
        @AuraEnabled
		@InvocableVariable
		global String originatingSalesChannel;

		global SalesChannel(){

		}

		global SalesChannel(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'salesChannel') {
							salesChannel = parser.getText();
						} else if (text == 'originatingSalesChannel') {
							originatingSalesChannel = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'SalesChannel consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	global class Orders {
        @AuraEnabled
		@InvocableVariable
		global SalesChannel salesChannel; 
        @AuraEnabled
		@InvocableVariable
		global String creationDate;
        @AuraEnabled
		@InvocableVariable
		global String currency_Z;
        @AuraEnabled
		@InvocableVariable
		global String referenceNumber;
        @AuraEnabled
		@InvocableVariable
		global String serviceRequiredDate;
        @AuraEnabled
		@InvocableVariable
		global String status;
        @AuraEnabled
		@InvocableVariable
		global Customer customer;
        @AuraEnabled
		@InvocableVariable
		global RecurringPrice recurringPrice; 
        @AuraEnabled
		@InvocableVariable
		global RecurringPrice oneTimePrice;
        @AuraEnabled
		@InvocableVariable
		global List<OrderItems> orderItems;
		@AuraEnabled
		@InvocableVariable
		global Datetime creationDate1;
		@AuraEnabled
		@InvocableVariable
		global Datetime serviceRequiredDate1;

		global Orders(){

		}

		global Orders(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'salesChannel') {
							salesChannel = new SalesChannel(parser);
						} else if (text == 'creationDate') {
							creationDate = parser.getText();
						} else if (text == 'currency') {
							currency_Z = parser.getText();
						} else if (text == 'referenceNumber') {
							referenceNumber = parser.getText();
						} else if (text == 'serviceRequiredDate') {
							serviceRequiredDate = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'customer') {
							customer = new Customer(parser);
						} else if (text == 'recurringPrice') {
							recurringPrice = new RecurringPrice(parser);
						} else if (text == 'oneTimePrice') {
							oneTimePrice = new RecurringPrice(parser);
						} else if (text == 'orderItems') {
							orderItems = arrayOfOrderItems(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Orders consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	global class OrderItems {
        @AuraEnabled
		@InvocableVariable
		global String id;
        @AuraEnabled
		@InvocableVariable
		global String createdBy; 
        @AuraEnabled
		@InvocableVariable
		global Boolean isPartOfBundle;
        @AuraEnabled
		@InvocableVariable
		global String lineOfBusiness;
        @AuraEnabled
		@InvocableVariable
		global Product product;
        @AuraEnabled
		@InvocableVariable
		global String actionType; 
        @AuraEnabled
		@InvocableVariable
		global String referenceNumber;
        @AuraEnabled
		@InvocableVariable
		global String serviceRequiredDate;
        @AuraEnabled
		@InvocableVariable
		global String status;
        @AuraEnabled
		@InvocableVariable
		global String implActionTypeX9;
        @AuraEnabled
		@InvocableVariable
		global String implOrderTypeX9;
        @AuraEnabled
		@InvocableVariable
		global String provisioningDate;
        @AuraEnabled
		@InvocableVariable
		global String oacloseDate;
        @AuraEnabled
		@InvocableVariable
		global String reasonCode; 
        @AuraEnabled
		@InvocableVariable
		global Boolean replaceOfferIndicator;
        @AuraEnabled
		@InvocableVariable
		global BusinessType businessType; 
		@AuraEnabled
		@InvocableVariable
		global String workOrderIdX9;

		global OrderItems(){

		}

		global OrderItems(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'createdBy') {
							createdBy = parser.getText();
						} else if (text == 'isPartOfBundle') {
							isPartOfBundle = parser.getBooleanValue();
						} else if (text == 'lineOfBusiness') {
							lineOfBusiness = parser.getText();
						} else if (text == 'product') {
							product = new Product(parser);
						} else if (text == 'actionType') {
							actionType = parser.getText();
						} else if (text == 'referenceNumber') {
							referenceNumber = parser.getText();
						} else if (text == 'serviceRequiredDate') {
							serviceRequiredDate = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'implActionTypeX9') {
							implActionTypeX9 = parser.getText();
						} else if (text == 'implOrderTypeX9') {
							implOrderTypeX9 = parser.getText();
						} else if (text == 'provisioningDate') {
							provisioningDate = parser.getText();
						} else if (text == 'oacloseDate') {
							oacloseDate = parser.getText();
						} else if (text == 'reasonCode') {
							reasonCode = parser.getText();
						} else if (text == 'replaceOfferIndicator') {
							replaceOfferIndicator = parser.getBooleanValue();
						} else if (text == 'businessType') {
							businessType = new BusinessType(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'OrderItems consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	global class Customer {
        @AuraEnabled
		@InvocableVariable
		global String id;

		global Customer(){

		}

		global Customer(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Customer consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	global class RecurringPrice {
        @AuraEnabled
		@InvocableVariable
		global String finalAmount; 

		global RecurringPrice(){

		}

		global RecurringPrice(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'finalAmount') {
							finalAmount = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'RecurringPrice consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	global class BusinessType {

		global BusinessType(){

		}

		global BusinessType(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						{
							System.debug(LoggingLevel.WARN, 'BusinessType consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	global class Product {
		@InvocableVariable
        @AuraEnabled
		global String id;
		@InvocableVariable
        @AuraEnabled
		global String catalogId;
        @AuraEnabled
		@InvocableVariable
		global String offeringInstanceId; 
        @AuraEnabled
		@InvocableVariable
		global String offeringName;
        @AuraEnabled
		@InvocableVariable
		global String name;
        @AuraEnabled
		@InvocableVariable
		global String serviceId; 

		global Product(){

		}

		global Product(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'catalogId') {
							catalogId = parser.getText();
						} else if (text == 'offeringInstanceId') {
							offeringInstanceId = parser.getText();
						} else if (text == 'offeringName') {
							offeringName = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'serviceId') {
							serviceId = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Product consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	@AuraEnabled
	@InvocableVariable
	global String itemsPerPage; 
    @AuraEnabled
	@InvocableVariable
	global String startIndex; 
    @AuraEnabled
	@InvocableVariable
	global String totalResults;
    @AuraEnabled
	@InvocableVariable
	global String totalOrdersWithReservations; 
    @AuraEnabled
	@InvocableVariable
	global List<Orders> orders;

	global RetrieveOrdersListResponse() {
		
	}

	global RetrieveOrdersListResponse(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'itemsPerPage') {
						itemsPerPage = parser.getText();
					} else if (text == 'startIndex') {
						startIndex = parser.getText();
					} else if (text == 'totalResults') {
						totalResults = parser.getText();
					} else if (text == 'totalOrdersWithReservations') {
						totalOrdersWithReservations = parser.getText();
					} else if (text == 'orders') {
						orders = arrayOfOrders(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'RetrieveOrdersListResponse consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	global static RetrieveOrdersListResponse parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new RetrieveOrdersListResponse(parser);
	}
	
	global static void consumeObject(System.JSONParser parser) {
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
	
    global static List<OrderItems> arrayOfOrderItems(System.JSONParser p) {
        List<OrderItems> res = new List<OrderItems>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new OrderItems(p));
        }
        return res;
    }
    
    global static List<Orders> arrayOfOrders(System.JSONParser p) {
        List<Orders> res = new List<Orders>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Orders(p));
        }
        return res;
    }
}