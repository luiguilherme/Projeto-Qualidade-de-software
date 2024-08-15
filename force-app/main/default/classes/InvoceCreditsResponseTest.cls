@IsTest
public with sharing class InvoceCreditsResponseTest {
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'    \"invoiceCredits\": {'+
		'        \"moreRows\": \"0\",'+
		'        \"resultsCount\": \"2\",'+
		'        \"rowCount\": \"2\",'+
		'        \"totalCount\": \"-1061109568\",'+
		'        \"totalAmount\": \"234.90\",'+
		'        \"billingSystem\": \"AMDOCS\",'+
		'        \"accountTimestamp\": \"2024051316270541290\",'+
		'        \"credits\": ['+
		'            {'+
		'                \"amount\": \"234.90\",'+
		'                \"balanceImpactCode\": \"I\",'+
		'                \"creditType\": \"\",'+
		'                \"invoiceNumber\": \"000019949\",'+
		'                \"categoryCode\": \"S\",'+
		'                \"creditId\": \"40027506332\",'+
		'                \"levelCode\": \"DEB\",'+
		'                \"noteExtract\": \"\",'+
		'                \"reason\": \"AJFUNC\",'+
		'                \"reasonDescription\": \"Acerto funcionĂ¡rio vivo\",'+
		'                \"invoiceId\": \"40275021827\",'+
		'                \"l9BillingChargeSeqNo\": \"42475498372\",'+
		'                \"l9ChargeInvoiceId\": \"40275021827\",'+
		'                \"l9EventId\": \"\",'+
		'                \"memoText\": \"Teste ajuste 30/11/23 parcial\",'+
		'                \"restrictedChargeId\": \"42475068774\",'+
		'                \"reversalReason\": \"\",'+
		'                \"restrictedInvoiceNumber\": \"\",'+
		'                \"reversalTransId\": \"\",'+
		'                \"transactionId\": \"40000072862\"'+
		'            },'+
		'            {'+
		'                \"amount\": \"331.00\",'+
		'                \"balanceImpactCode\": \"I\",'+
		'                \"creditType\": \"\",'+
		'                \"invoiceNumber\": \"000019949\",'+
		'                \"categoryCode\": \"C\",'+
		'                \"creditId\": \"40027506331\",'+
		'                \"levelCode\": \"DEB\",'+
		'                \"noteExtract\": \"\",'+
		'                \"reason\": \"CHDESC\",'+
		'                \"reasonDescription\": \"Desconhece chamada\",'+
		'                \"invoiceId\": \"40275021827\",'+
		'                \"l9BillingChargeSeqNo\": \"42475498372\",'+
		'                \"l9ChargeInvoiceId\": \"40275021827\",'+
		'                \"l9EventId\": \"\",'+
		'                \"memoText\": \"Teste ajuste 30/11/23\",'+
		'                \"restrictedChargeId\": \"42475068774\",'+
		'                \"reversalReason\": \"P2PCAN\",'+
		'                \"restrictedInvoiceNumber\": \"\",'+
		'                \"reversalTransId\": \"40000072805\",'+
		'                \"transactionId\": \"40000072776\"'+
		'            }'+
		'        ]'+
		'    }'+
		'}';
		InvoceCreditsResponse r = InvoceCreditsResponse.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		InvoceCreditsResponse.InvoiceCredits objInvoiceCredits = new InvoceCreditsResponse.InvoiceCredits(System.JSON.createParser(json));
		System.assert(objInvoiceCredits != null);
		System.assert(objInvoiceCredits.moreRows == null);
		System.assert(objInvoiceCredits.resultsCount == null);
		System.assert(objInvoiceCredits.rowCount == null);
		System.assert(objInvoiceCredits.totalCount == null);
		System.assert(objInvoiceCredits.totalAmount == null);
		System.assert(objInvoiceCredits.billingSystem == null);
		System.assert(objInvoiceCredits.accountTimestamp == null);
		System.assert(objInvoiceCredits.credits == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		InvoceCreditsResponse objInvoceCreditsResponse = new InvoceCreditsResponse(System.JSON.createParser(json));
		System.assert(objInvoceCreditsResponse != null);
		System.assert(objInvoceCreditsResponse.invoiceCredits == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		InvoceCreditsResponse.Credits objCredits = new InvoceCreditsResponse.Credits(System.JSON.createParser(json));
		System.assert(objCredits != null);
		System.assert(objCredits.amount == null);
		System.assert(objCredits.balanceImpactCode == null);
		System.assert(objCredits.creditType == null);
		System.assert(objCredits.invoiceNumber == null);
		System.assert(objCredits.categoryCode == null);
		System.assert(objCredits.creditId == null);
		System.assert(objCredits.levelCode == null);
		System.assert(objCredits.noteExtract == null);
		System.assert(objCredits.reason == null);
		System.assert(objCredits.reasonDescription == null);
		System.assert(objCredits.invoiceId == null);
		System.assert(objCredits.l9BillingChargeSeqNo == null);
		System.assert(objCredits.l9ChargeInvoiceId == null);
		System.assert(objCredits.l9EventId == null);
		System.assert(objCredits.memoText == null);
		System.assert(objCredits.restrictedChargeId == null);
		System.assert(objCredits.reversalReason == null);
		System.assert(objCredits.restrictedInvoiceNumber == null);
		System.assert(objCredits.reversalTransId == null);
		System.assert(objCredits.transactionId == null);
	}
}