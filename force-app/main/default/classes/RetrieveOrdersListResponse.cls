public class RetrieveOrdersListResponse {

	public class SalesChannel {
        @InvocableVariable
		public String salesChannel;
        @InvocableVariable
		public String originatingSalesChannel;

		public SalesChannel(JSONParser parser) {
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

	public class Order {
		@InvocableVariable
		public Orders orders;
	}

	public class Orders {
        @InvocableVariable
		public SalesChannel salesChannel; 
        @InvocableVariable
		public String creationDate;
        @InvocableVariable
		public String currency_Z;
        @InvocableVariable
		public String referenceNumber;
        @InvocableVariable
		public String serviceRequiredDate;
        @InvocableVariable
		public String status;
        @InvocableVariable
		public Customer customer;
        @InvocableVariable
		public RecurringPrice recurringPrice; 
        @InvocableVariable
		public RecurringPrice oneTimePrice;
        @InvocableVariable
		public List<OrderItems> orderItems;

		@InvocableVariable
		public Datetime creationDate1;
		@InvocableVariable
		public Datetime serviceRequiredDate1;

		public Orders(JSONParser parser) {
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
	
	public class OrderItems {
        @InvocableVariable
		public String id;
        @InvocableVariable
		public String createdBy; 
        @InvocableVariable
		public Boolean isPartOfBundle;
        @InvocableVariable
		public String lineOfBusiness;
        @InvocableVariable
		public Product product;
        @InvocableVariable
		public String actionType; 
        @InvocableVariable
		public String referenceNumber;
        @InvocableVariable
		public String serviceRequiredDate;
        @InvocableVariable
		public String status;
        @InvocableVariable
		public String implActionTypeX9;
        @InvocableVariable
		public String implOrderTypeX9;
        @InvocableVariable
		public String provisioningDate;
        @InvocableVariable
		public String oacloseDate;
        @InvocableVariable
		public String reasonCode; 
        @InvocableVariable
		public Boolean replaceOfferIndicator;
        @InvocableVariable
		public BusinessType businessType; 

		public OrderItems(JSONParser parser) {
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
	
	public class Customer {
        @InvocableVariable
		public String id;

		public Customer(JSONParser parser) {
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
	
	public class RecurringPrice {
        @InvocableVariable
		public String finalAmount; 

		public RecurringPrice(JSONParser parser) {
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
	
	public class BusinessType {

		public BusinessType(JSONParser parser) {
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
	
	public class Product {
        @InvocableVariable
		public String id;
        @InvocableVariable
		public String catalogId;
        @InvocableVariable
		public String offeringInstanceId; 
        @InvocableVariable
		public String offeringName;
        @InvocableVariable
		public String name;
        @InvocableVariable
		public String serviceId; 

		public Product(JSONParser parser) {
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
	@InvocableVariable
	public String itemsPerPage; 
    @InvocableVariable
	public String startIndex; 
    @InvocableVariable
	public String totalResults;
    @InvocableVariable
	public String totalOrdersWithReservations; 
    @InvocableVariable
	public List<Orders> orders;

	public RetrieveOrdersListResponse(JSONParser parser) {
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
	
	
	public static RetrieveOrdersListResponse parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new RetrieveOrdersListResponse(parser);
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
	
    private static List<OrderItems> arrayOfOrderItems(System.JSONParser p) {
        List<OrderItems> res = new List<OrderItems>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new OrderItems(p));
        }
        return res;
    }
    
    private static List<Orders> arrayOfOrders(System.JSONParser p) {
        List<Orders> res = new List<Orders>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Orders(p));
        }
        return res;
    }
}