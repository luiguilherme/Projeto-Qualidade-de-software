@IsTest
public class RetrieveContractsResponseTest {
	
	static testMethod void testParse() {
		String json = '{'+
		'  \"protocol\": \"string\",'+
		'  \"order\": \"string\",'+
		'  \"smpContract\": \"string\",'+
		'  \"landlineContract\": \"string\",'+
		'  \"mobileContract\": \"string\"'+
		'}';
		RetrieveContractsResponse obj = RetrieveContractsResponse.parse(json);
		System.assert(obj != null);
	}
}