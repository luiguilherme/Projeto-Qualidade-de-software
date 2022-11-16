@IsTest
public class CreditAnalysisResponseTest {
	
	static testMethod void testParse() {
		String json = '{'+
		'  \"performAnalysisCreditResponse\": {'+
		'    \"customerCreditProfile\": {'+
		'      \"ID\": \"\",'+
		'      \"creditScore\": 99999'+
		'    },'+
		'    \"parameter\": {'+
		'      \"parameter\": \"99\"'+
		'    },'+
		'    \"result\": {'+
		'      \"code\": 0,'+
		'      \"description\": \"\"'+
		'    },'+
		'    \"legalRepresentativeAssignee\": {'+
		'      \"parameter\": \"\"'+
		'    }'+
		'  }'+
		'}';
		CreditAnalysisResponse obj = CreditAnalysisResponse.parse(json);
		System.assert(obj != null);
	}
}