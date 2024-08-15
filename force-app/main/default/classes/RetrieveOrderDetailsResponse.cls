public with sharing class RetrieveOrderDetailsResponse {

    public List<Links> links; 
	public String creationDate; 
	public String currency_Z;
	public String id; 
	public String referenceNumber; 
	public String serviceRequiredDate; 
	public String status; 
	public RecurringPrice recurringPrice; 
	public OneTimePrice oneTimePrice; 
	public List<OrderItems> orderItems; 
	public String originatingSalesChannel; 
	public Boolean allowCancel; 
	public String currentSalesChannel; 
	public PreviousRecurringPrice previousRecurringPrice; 

	public RetrieveOrderDetailsResponse(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'links') {
						links = arrayOfLinks(parser);
					} else if (text == 'creationDate') {
						creationDate = parser.getText();
					} else if (text == 'currency') {
						currency_Z = parser.getText();
					} else if (text == 'id') {
						id = parser.getText();
					} else if (text == 'referenceNumber') {
						referenceNumber = parser.getText();
					} else if (text == 'serviceRequiredDate') {
						serviceRequiredDate = parser.getText();
					} else if (text == 'status') {
						status = parser.getText();
					} else if (text == 'recurringPrice') {
						recurringPrice = new RecurringPrice(parser);
					} else if (text == 'oneTimePrice') {
						oneTimePrice = new OneTimePrice(parser);
					} else if (text == 'orderItems') {
						orderItems = arrayOfOrderItems(parser);
					} else if (text == 'originatingSalesChannel') {
						originatingSalesChannel = parser.getText();
					} else if (text == 'allowCancel') {
						allowCancel = parser.getBooleanValue();
					} else if (text == 'currentSalesChannel') {
						currentSalesChannel = parser.getText();
					} else if (text == 'previousRecurringPrice') {
						previousRecurringPrice = new PreviousRecurringPrice(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'RetrieveOrderDetailsResponse consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}

    public static RetrieveOrderDetailsResponse parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new RetrieveOrderDetailsResponse(parser);
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

	public class OrderItems {
		public String id; 
		public String createdBy; 
		public String actionType; 
		public String creationDate; 
		public String description; 
		public String referenceNumber; 
		public String serviceRequiredDate; 
		public String status; 
		public String implActionTypeX9; 
		public String provisioningDate; 
		public String oacloseDate; 
		public RecurringPrice recurringPrice; 
		public OneTimePrice oneTimePrice; 
		public Plan plan; 
		public String productName; 
		public List<Services> services; 
		public String subscriberRoleX9; 
		public String offerClassificationX9; 
		public String originatingSalesChannel; 
		public Boolean sharedProduct; 
		public List<Plan> plans; 
		public PreviousRecurringPrice previousRecurringPrice; 
		public String productCatalogID; 
		public String voiceLineMsisdn; 
		public String productLineOfBusiness; 
		public Person person; 
		public Boolean equipment; 
		public String productServiceID; 
		public String productID; 


		public OrderItems(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'createdBy') {
							createdBy = parser.getText();
						} else if (text == 'actionType') {
							actionType = parser.getText();
						} else if (text == 'creationDate') {
							creationDate = parser.getText();
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'referenceNumber') {
							referenceNumber = parser.getText();
						} else if (text == 'serviceRequiredDate') {
							serviceRequiredDate = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'implActionTypeX9') {
							implActionTypeX9 = parser.getText();
						} else if (text == 'provisioningDate') {
							provisioningDate = parser.getText();
						} else if (text == 'oacloseDate') {
							oacloseDate = parser.getText();
						} else if (text == 'recurringPrice') {
							recurringPrice = new RecurringPrice(parser);
						} else if (text == 'oneTimePrice') {
							oneTimePrice = new OneTimePrice(parser);
						} else if (text == 'plan') {
							plan = new Plan(parser);
						} else if (text == 'productName') {
							productName = parser.getText();
						} else if (text == 'services') {
							services = arrayOfServices(parser);
						} else if (text == 'subscriberRoleX9') {
							subscriberRoleX9 = parser.getText();
						} else if (text == 'offerClassificationX9') {
							offerClassificationX9 = parser.getText();
						} else if (text == 'originatingSalesChannel') {
							originatingSalesChannel = parser.getText();
						} else if (text == 'sharedProduct') {
							sharedProduct = parser.getBooleanValue();
						} else if (text == 'plans') {
							plans = arrayOfPlan(parser);
						} else if (text == 'previousRecurringPrice') {
							previousRecurringPrice = new PreviousRecurringPrice(parser);
						} else if (text == 'productCatalogID') {
							productCatalogID = parser.getText();
						} else if (text == 'voiceLineMsisdn') {
							voiceLineMsisdn = parser.getText();
						} else if (text == 'productLineOfBusiness') {
							productLineOfBusiness = parser.getText();
						} else if (text == 'person') {
							person = new Person(parser);
						} else if (text == 'equipment') {
							equipment = parser.getBooleanValue();
						} else if (text == 'productServiceID') {
							productServiceID = parser.getText();
						} else if (text == 'productID') {
							productID = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'OrderItems consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
    public class Services {
		public String action; 
		public String catalogItemID; 
		public String catalogItemName; 
		public String id; 
		public String relationToParentID; 
		public String serviceType; 
		public String status; 
		public RecurringPrice recurringPrice; 
		public PreviousRecurringPrice previousRecurringPrice; 
		public OneTimePrice oneTimePrice; 
		public List<ContainedServices> containedServices; 
		public String businessType; 
		public List<Plan> pricePackages; 

		public Services(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'action') {
							action = parser.getText();
						} else if (text == 'catalogItemID') {
							catalogItemID = parser.getText();
						} else if (text == 'catalogItemName') {
							catalogItemName = parser.getText();
						} else if (text == 'id') {
							id = parser.getText();
						} else if (text == 'relationToParentID') {
							relationToParentID = parser.getText();
						} else if (text == 'serviceType') {
							serviceType = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'recurringPrice') {
							recurringPrice = new RecurringPrice(parser);
						} else if (text == 'previousRecurringPrice') {
							previousRecurringPrice = new PreviousRecurringPrice(parser);
						} else if (text == 'oneTimePrice') {
							oneTimePrice = new OneTimePrice(parser);
						} else if (text == 'containedServices') {
							containedServices = arrayOfContainedServices(parser);
						} else if (text == 'businessType') {
							businessType = parser.getText();
						} else if (text == 'pricePackages') {
							pricePackages = arrayOfPlan(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Services consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
    
	public class RecurringPrice {
		public String frequency; 
		public String proratedAmount; 
		public String proratedDiscountAmount; 
		public String proratedTaxAmount; 
		public String finalAmount; 
		public String finalAmountWithTax; 
		public String finalTaxAmount; 
		public String originalAmount; 
		public String originalTaxAmount; 

		public RecurringPrice(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'frequency') {
							frequency = parser.getText();
						} else if (text == 'proratedAmount') {
							proratedAmount = parser.getText();
						} else if (text == 'proratedDiscountAmount') {
							proratedDiscountAmount = parser.getText();
						} else if (text == 'proratedTaxAmount') {
							proratedTaxAmount = parser.getText();
						} else if (text == 'finalAmount') {
							finalAmount = parser.getText();
						} else if (text == 'finalAmountWithTax') {
							finalAmountWithTax = parser.getText();
						} else if (text == 'finalTaxAmount') {
							finalTaxAmount = parser.getText();
						} else if (text == 'originalAmount') {
							originalAmount = parser.getText();
						} else if (text == 'originalTaxAmount') {
							originalTaxAmount = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'RecurringPrice consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ContainedServices {
		public String action; 
		public String catalogItemID; 
		public String catalogItemName; 
		public String id; 
		public String relationToParentID; 
		public String serviceType; 
		public String status; 
		public RecurringPrice recurringPrice; 
		public PreviousRecurringPrice previousRecurringPrice; 
		public OneTimePrice oneTimePrice; 
		public List<Plan> pricePackages; 

		public ContainedServices(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'action') {
							action = parser.getText();
						} else if (text == 'catalogItemID') {
							catalogItemID = parser.getText();
						} else if (text == 'catalogItemName') {
							catalogItemName = parser.getText();
						} else if (text == 'id') {
							id = parser.getText();
						} else if (text == 'relationToParentID') {
							relationToParentID = parser.getText();
						} else if (text == 'serviceType') {
							serviceType = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'recurringPrice') {
							recurringPrice = new RecurringPrice(parser);
						} else if (text == 'previousRecurringPrice') {
							previousRecurringPrice = new PreviousRecurringPrice(parser);
						} else if (text == 'oneTimePrice') {
							oneTimePrice = new OneTimePrice(parser);
						} else if (text == 'pricePackages') {
							pricePackages = arrayOfPlan(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'ContainedServices consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Links {
		public String href; 
		public String rel; 

		public Links(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'href') {
							href = parser.getText();
						} else if (text == 'rel') {
							rel = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Links consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ContainedServices_Z {
		public String action; 
		public String businessType; 
		public String catalogItemID; 
		public String catalogItemName; 
		public String id; 
		public String relationToParentID; 
		public String serviceType; 
		public String status; 
		public RecurringPrice recurringPrice; 
		public PreviousRecurringPrice previousRecurringPrice; 
		public OneTimePrice oneTimePrice; 

		public ContainedServices_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'action') {
							action = parser.getText();
						} else if (text == 'businessType') {
							businessType = parser.getText();
						} else if (text == 'catalogItemID') {
							catalogItemID = parser.getText();
						} else if (text == 'catalogItemName') {
							catalogItemName = parser.getText();
						} else if (text == 'id') {
							id = parser.getText();
						} else if (text == 'relationToParentID') {
							relationToParentID = parser.getText();
						} else if (text == 'serviceType') {
							serviceType = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'recurringPrice') {
							recurringPrice = new RecurringPrice(parser);
						} else if (text == 'previousRecurringPrice') {
							previousRecurringPrice = new PreviousRecurringPrice(parser);
						} else if (text == 'oneTimePrice') {
							oneTimePrice = new OneTimePrice(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'ContainedServices_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class OneTimePrice {
		public String finalAmount; 
		public String finalAmountWithTax; 
		public String finalTaxAmount; 
		public String originalAmount; 
		public String originalTaxAmount; 

		public OneTimePrice(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'finalAmount') {
							finalAmount = parser.getText();
						} else if (text == 'finalAmountWithTax') {
							finalAmountWithTax = parser.getText();
						} else if (text == 'finalTaxAmount') {
							finalTaxAmount = parser.getText();
						} else if (text == 'originalAmount') {
							originalAmount = parser.getText();
						} else if (text == 'originalTaxAmount') {
							originalTaxAmount = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'OneTimePrice consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Plan {
		public String action; 
		public String catalogItemID; 
		public String catalogItemName; 
		public String id; 
		public RecurringPrice recurringPrice; 
		public PreviousRecurringPrice previousRecurringPrice; 
		public OneTimePrice oneTimePrice; 
		public String billingIdX9; 

		public Plan(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'action') {
							action = parser.getText();
						} else if (text == 'catalogItemID') {
							catalogItemID = parser.getText();
						} else if (text == 'catalogItemName') {
							catalogItemName = parser.getText();
						} else if (text == 'id') {
							id = parser.getText();
						} else if (text == 'recurringPrice') {
							recurringPrice = new RecurringPrice(parser);
						} else if (text == 'previousRecurringPrice') {
							previousRecurringPrice = new PreviousRecurringPrice(parser);
						} else if (text == 'oneTimePrice') {
							oneTimePrice = new OneTimePrice(parser);
						} else if (text == 'billingIdX9') {
							billingIdX9 = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Plan consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Person {
		public String personID; 

		public Person(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'personID') {
							personID = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Person consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class PreviousRecurringPrice {
		public String finalAmountWithTax; 
		public String taxAmount; 
		public String amount; 

		public PreviousRecurringPrice(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'finalAmountWithTax') {
							finalAmountWithTax = parser.getText();
						} else if (text == 'taxAmount') {
							taxAmount = parser.getText();
						} else if (text == 'amount') {
							amount = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'PreviousRecurringPrice consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
    private static List<Services> arrayOfServices(System.JSONParser p) {
        List<Services> res = new List<Services>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Services(p));
        }
        return res;
    }

    private static List<OrderItems> arrayOfOrderItems(System.JSONParser p) {
        List<OrderItems> res = new List<OrderItems>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new OrderItems(p));
        }
        return res;
    }

    private static List<Plan> arrayOfPlan(System.JSONParser p) {
        List<Plan> res = new List<Plan>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Plan(p));
        }
        return res;
    }

    private static List<ContainedServices> arrayOfContainedServices(System.JSONParser p) {
        List<ContainedServices> res = new List<ContainedServices>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new ContainedServices(p));
        }
        return res;
    }

    private static List<ContainedServices_Z> arrayOfContainedServices_Z(System.JSONParser p) {
        List<ContainedServices_Z> res = new List<ContainedServices_Z>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new ContainedServices_Z(p));
        }
        return res;
    }

    private static List<Links> arrayOfLinks(System.JSONParser p) {
        List<Links> res = new List<Links>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Links(p));
        }
        return res;
    }

}