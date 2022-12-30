/*
*
* @author Diego Costa @ Deloitte
* @date - 06/06/2022
* @description - Classe de retorno para a estrutura de response da API de faturas da 4P
*
*/
public class InvoiceServiceReturn {
	public class Total_amount {
		public Double value {get;set;} 
		public String currencyInvoice {get;set;} 
		public Boolean tax_included {get;set;} 

		public Total_amount(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'value') {
							value = parser.getDoubleValue();
						} else if (text == 'currency') {
							currencyInvoice = parser.getText();
						} else if (text == 'tax_included') {
							tax_included = parser.getBooleanValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Total_amount consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public String id {get;set;} 
	public String name {get;set;} 
    public String image {get;set;}
	public Customer customer {get;set;} 
	public String creation_date {get;set;} 
	public String start_date {get;set;} 
	public String end_date {get;set;} 
	public String due_date {get;set;} 
	public String payment_date {get;set;} 
	public String payment_status {get;set;} 
	public String next_invoice_date {get;set;} 
	public String download_url {get;set;} 
	public List<SecondaryDownloadUrlItem> secondary_download_urls {get; set;} 
	public Total_amount total_amount {get;set;} 
	public List<String> identifiers {get;set;} 
	public List<Billed_items_summary> billed_items_summary {get;set;} 
	public String account_id {get; set;}

	public InvoiceServiceReturn(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'id') {
						id = parser.getText();
					} else if (text == 'name') {
						name = parser.getText();
					} else if (text == 'customer') {
						customer = new Customer(parser);
					} else if (text == 'creation_date') {
						creation_date = parser.getText();
					} else if (text == 'start_date') {
						start_date = parser.getText();
					} else if (text == 'end_date') {
						end_date = parser.getText();
					} else if (text == 'due_date') {
						due_date = parser.getText();
					} else if (text == 'payment_date') {
						payment_date = parser.getText();
					} else if (text == 'payment_status') {
						payment_status = parser.getText();
					} else if (text == 'next_invoice_date') {
						next_invoice_date = parser.getText();
					} else if (text == 'download_url') {
						download_url = parser.getText();
					} else if (text == 'secondary_download_urls') {
						secondary_download_urls = arrayOfSecondaryDownloadUrl(parser);
					} else if (text == 'total_amount') {
						total_amount = new Total_amount(parser);
					} else if (text == 'identifiers') {
						identifiers = arrayOfString(parser);
					} else if (text == 'billed_items_summary') {
						billed_items_summary = arrayOfBilled_items_summary(parser);
					} else if(text == 'account_id'){
						account_id = parser.getText();
					}else {
						System.debug(LoggingLevel.WARN, 'JSON2Apex consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Customer {
		public String name {get;set;} 
		public Id_document id_document {get;set;} 

		public Customer(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();
						} else if (text == 'id_document') {
							id_document = new Id_document(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Customer consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Id_document {
		public String country {get;set;} 
		public String type_Z {get;set;} // in json: type
		public String value {get;set;} 

		public Id_document(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'country') {
							country = parser.getText();
						} else if (text == 'type') {
							type_Z = parser.getText();
						} else if (text == 'value') {
							value = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Id_document consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Amount {
		public Integer value {get;set;} 
		public String currencyInvoice {get;set;} 
		public Boolean tax_included {get;set;} 

		public Amount(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'value') {
							value = parser.getIntegerValue();
						} else if (text == 'currency') {
							currencyInvoice = parser.getText();
						} else if (text == 'tax_included') {
							tax_included = parser.getBooleanValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Amount consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Billed_items_summary {
		public String id {get;set;} 
		public Total_amount amount {get;set;} 
		public String description {get;set;} 
		public String start_date {get;set;} 
		public String end_date {get;set;} 
		public String parent_id {get;set;} 
        public String identifier {get;set;}

		public Billed_items_summary(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'amount') {
							amount = new Total_amount(parser);
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'start_date') {
							start_date = parser.getText();
						} else if (text == 'end_date') {
							end_date = parser.getText();
						} else if (text == 'parent_id') {
							parent_id = parser.getText();
                        } else if (text == 'identifier') {
							identifier = parser.getText();						
						} else {
							System.debug(LoggingLevel.WARN, 'Billed_items_summary consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class SecondaryDownloadUrlItem {
		public String name {get; set;} 
		public String url {get; set;} 
		public String mime_type {get; set;} 

		public SecondaryDownloadUrlItem(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();

						} else if (text == 'url') {
							url = parser.getText();

						} else if (text == 'mime_type') {
							mime_type = parser.getText();

						} else {
							System.debug(LoggingLevel.WARN, 'SecondaryDownloadUrlItem consuming unrecognized property: ' + text);
							
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public static List<InvoiceServiceReturn> parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return arrayOfJSON2Apex(parser);
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
	

    private static List<InvoiceServiceReturn> arrayOfJSON2Apex(System.JSONParser p) {
        List<InvoiceServiceReturn> res = new List<InvoiceServiceReturn>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new InvoiceServiceReturn(p));
        }
        return res;
    }

	private static List<String> arrayOfString(System.JSONParser p) {
        List<String> res = new List<String>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(p.getText());
        }
        return res;
    }

	private static List<Billed_items_summary> arrayOfBilled_items_summary(System.JSONParser p) {
        List<Billed_items_summary> res = new List<Billed_items_summary>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Billed_items_summary(p));
        }
        return res;
    }

    private static List<SecondaryDownloadUrlItem> arrayOfSecondaryDownloadUrl(System.JSONParser p) {
        List<SecondaryDownloadUrlItem> res = new List<SecondaryDownloadUrlItem>();
        
		if (p.getCurrentToken() == null) {
			p.nextToken();
		}

        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new SecondaryDownloadUrlItem(p));
        }

        return (res);
    }
}