public with sharing class AccountManagementResponse {
	public class Account {
        @InvocableVariable
		public String href;

		public Account(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'href') {
							href = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Account consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ContactMedium {
        @InvocableVariable
		public Characteristic characteristic;

		public ContactMedium(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'characteristic') {
							characteristic = new Characteristic(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'ContactMedium consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Customer {
        @InvocableVariable
		public CustomerAccount customerAccount;

		public Customer(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'customerAccount') {
							customerAccount = new CustomerAccount(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Customer consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Characteristic {
        @InvocableVariable
		public String postCode;

		public Characteristic(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'postCode') {
							postCode = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Characteristic consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class BillingAccount {
        @InvocableVariable
		public String id;
        @InvocableVariable
		public CustomerAccount financialAccountType;
        @InvocableVariable
		public Contact contact;
        @InvocableVariable
		public List<CustomerAccount> product;

		public BillingAccount(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'financialAccountType') {
							financialAccountType = new CustomerAccount(parser);
						} else if (text == 'contact') {
							contact = new Contact(parser);
						} else if (text == 'product') {
							product = arrayOfCustomerAccount(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'BillingAccount consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class CustomerAccount {
        @InvocableVariable
		public String id;

		public CustomerAccount(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'CustomerAccount consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
    @InvocableVariable
	public String documentNumber;
    @InvocableVariable
	public Boolean areMore;
    @InvocableVariable
	public Account account;
    @InvocableVariable
	public Customer customer;
    @InvocableVariable
	public List<Accounts> accounts;

	public AccountManagementResponse(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'documentNumber') {
						documentNumber = parser.getText();
					} else if (text == 'areMore') {
						areMore = parser.getBooleanValue();
					} else if (text == 'account') {
						account = new Account(parser);
					} else if (text == 'customer') {
						customer = new Customer(parser);
					} else if (text == 'accounts') {
						accounts = arrayOfAccounts(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'AccountManagementResponse consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Accounts {
        @InvocableVariable
		public BillingAccount billingAccount;

		public Accounts(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'billingAccount') {
							billingAccount = new BillingAccount(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Accounts consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Contact {
        @InvocableVariable
		public List<ContactMedium> contactMedium;

		public Contact(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'contactMedium') {
							contactMedium = arrayOfContactMedium(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Contact consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static AccountManagementResponse parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new AccountManagementResponse(parser);
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
	






    private static List<Accounts> arrayOfAccounts(System.JSONParser p) {
        List<Accounts> res = new List<Accounts>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Accounts(p));
        }
        return res;
    }


    private static List<ContactMedium> arrayOfContactMedium(System.JSONParser p) {
        List<ContactMedium> res = new List<ContactMedium>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new ContactMedium(p));
        }
        return res;
    }





    private static List<CustomerAccount> arrayOfCustomerAccount(System.JSONParser p) {
        List<CustomerAccount> res = new List<CustomerAccount>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new CustomerAccount(p));
        }
        return res;
    }
}