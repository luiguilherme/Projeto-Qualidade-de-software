public class InvoceCreditsResponse {
	public class InvoiceCredits {
        @AuraEnabled
        @InvocableVariable
		public String moreRows;
        @AuraEnabled
        @InvocableVariable
		public String resultsCount;
        @AuraEnabled
        @InvocableVariable
		public String rowCount;
        @AuraEnabled
        @InvocableVariable
		public String totalCount;
        @AuraEnabled
        @InvocableVariable
		public String totalAmount;
        @AuraEnabled
        @InvocableVariable
		public String billingSystem;
        @AuraEnabled
        @InvocableVariable
		public String accountTimestamp;
        @AuraEnabled
        @InvocableVariable
		public List<Credits> credits;

		public InvoiceCredits(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'moreRows') {
							moreRows = parser.getText();
						} else if (text == 'resultsCount') {
							resultsCount = parser.getText();
						} else if (text == 'rowCount') {
							rowCount = parser.getText();
						} else if (text == 'totalCount') {
							totalCount = parser.getText();
						} else if (text == 'totalAmount') {
							totalAmount = parser.getText();
						} else if (text == 'billingSystem') {
							billingSystem = parser.getText();
						} else if (text == 'accountTimestamp') {
							accountTimestamp = parser.getText();
						} else if (text == 'credits') {
							credits = arrayOfCredits(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'InvoiceCredits consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	@AuraEnabled
    @InvocableVariable
	public InvoiceCredits invoiceCredits;

	public InvoceCreditsResponse(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'invoiceCredits') {
						invoiceCredits = new InvoiceCredits(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'InvoceCreditsResponse consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Credits {
        @AuraEnabled
        @InvocableVariable
		public String amount;
        @AuraEnabled
        @InvocableVariable
		public String balanceImpactCode;
        @AuraEnabled
        @InvocableVariable
		public String creditType;
        @AuraEnabled
        @InvocableVariable
		public String invoiceNumber;
        @AuraEnabled
        @InvocableVariable
		public String categoryCode;
        @AuraEnabled
        @InvocableVariable
		public String creditId;
        @AuraEnabled
        @InvocableVariable
		public String levelCode;
        @AuraEnabled
        @InvocableVariable
		public String noteExtract;
        @AuraEnabled
        @InvocableVariable
		public String reason;
        @AuraEnabled
        @InvocableVariable
		public String reasonDescription;
        @AuraEnabled
        @InvocableVariable
		public String invoiceId;
        @AuraEnabled
        @InvocableVariable
		public String l9BillingChargeSeqNo;
        @AuraEnabled
        @InvocableVariable
		public String l9ChargeInvoiceId;
        @AuraEnabled
        @InvocableVariable
		public String l9EventId;
        @AuraEnabled
        @InvocableVariable
		public String memoText;
        @AuraEnabled
        @InvocableVariable
		public String restrictedChargeId;
        @AuraEnabled
        @InvocableVariable
		public String reversalReason;
        @AuraEnabled
        @InvocableVariable
		public String restrictedInvoiceNumber;
        @AuraEnabled
        @InvocableVariable
		public String reversalTransId;
        @AuraEnabled
        @InvocableVariable
		public String transactionId;

		public Credits(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'amount') {
							amount = parser.getText();
						} else if (text == 'balanceImpactCode') {
							balanceImpactCode = parser.getText();
						} else if (text == 'creditType') {
							creditType = parser.getText();
						} else if (text == 'invoiceNumber') {
							invoiceNumber = parser.getText();
						} else if (text == 'categoryCode') {
							categoryCode = parser.getText();
						} else if (text == 'creditId') {
							creditId = parser.getText();
						} else if (text == 'levelCode') {
							levelCode = parser.getText();
						} else if (text == 'noteExtract') {
							noteExtract = parser.getText();
						} else if (text == 'reason') {
							reason = parser.getText();
						} else if (text == 'reasonDescription') {
							reasonDescription = parser.getText();
						} else if (text == 'invoiceId') {
							invoiceId = parser.getText();
						} else if (text == 'l9BillingChargeSeqNo') {
							l9BillingChargeSeqNo = parser.getText();
						} else if (text == 'l9ChargeInvoiceId') {
							l9ChargeInvoiceId = parser.getText();
						} else if (text == 'l9EventId') {
							l9EventId = parser.getText();
						} else if (text == 'memoText') {
							memoText = parser.getText();
						} else if (text == 'restrictedChargeId') {
							restrictedChargeId = parser.getText();
						} else if (text == 'reversalReason') {
							reversalReason = parser.getText();
						} else if (text == 'restrictedInvoiceNumber') {
							restrictedInvoiceNumber = parser.getText();
						} else if (text == 'reversalTransId') {
							reversalTransId = parser.getText();
						} else if (text == 'transactionId') {
							transactionId = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Credits consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public static InvoceCreditsResponse parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new InvoceCreditsResponse(parser);
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

    private static List<Credits> arrayOfCredits(System.JSONParser p) {
        List<Credits> res = new List<Credits>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Credits(p));
        }
        return res;
    }
}