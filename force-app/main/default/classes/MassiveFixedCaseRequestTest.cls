@IsTest
public class MassiveFixedCaseRequestTest {
	
	@TestSetup
	static void setup(){
        Account lAccount = DataFactory.createAccount();
        insert lAccount;

        Account lBillingAccountFixed = DataFactory.createBillingAccount(lAccount.Id, 'Fixa');
        insert lBillingAccountFixed;

        Asset asset = DataFactory.createAsset(lAccount.Id, 'Fixa');
        insert asset;

        insert new Webservice__c(
            Name = 'MassiveFixedCallout',
            Endpoint__c  = 'https://hmlapi.telefonicabigdata.com',
            SubscriptionKey__c = 'd1ca8d57a2984db88f01c9ce7b5862e2',
			Validate__c = 15
        );
        
        WebServiceTestFactory.start().authOAuthProvider().create();
    }


	@IsTest
	static void execute(){
		Map<String, object> mapResult = new Map<string, Object>();
		String requestBody;
		Asset asset = [ SELECT  Id FROM Asset LIMIT 1];
		
        Test.startTest();
			MassiveFixedCaseCallout.execute(mapResult, asset.Id);   
			requestBody = new MassiveFixedCaseRequest(asset.Id, 'MassiveFixedCallout').createRequestStructure().toJson();
		Test.stopTest();
		System.assert(mapResult != null, 'O mapa de resposta não foi preenchido');
		System.assert(!String.isBlank(requestBody) , 'O contrato de request não foi preenchido');

	}

}