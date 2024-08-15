@IsTest
public class CustomerInteractionResponseTest {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'  \"protocolItems\": ['+
		'    {'+
		'      \"idProtocolItem\": 0,'+
		'      \"protocol\": {'+
		'        \"protocolNumber\": 0,'+
		'        \"submissionStatus\": \"string\",'+
		'        \"smsClassification\": 0,'+
		'        \"openingDate\": \"2022-11-09T15:05:21.000Z\",'+
		'        \"closingDate\": \"2022-11-09T15:05:21.000Z\",'+
		'        \"protocolType\": \"string\",'+
		'        \"protocolStatus\": \"string\"'+
		'      },'+
		'      \"network\": {'+
		'        \"geographicAreaCode\": 0,'+
		'        \"networkNumber\": 0,'+
		'        \"digitNetwork\": 0'+
		'      },'+
		'      \"itemProtocol\": {'+
		'        \"description\": \"string\",'+
		'        \"status\": \"string\",'+
		'        \"subStatus\": \"string\",'+
		'        \"openingDate\": \"2022-11-09T15:05:21.000Z\",'+
		'        \"closingDate\": \"2022-11-09T15:05:21.000Z\"'+
		'      },'+
		'      \"sourceSystem\": {'+
		'        \"systemName\": \"string\"'+
		'      },'+
		'      \"relatedProtocol\": {'+
		'        \"protocolNumber\": 0'+
		'      },'+
		'      \"channelName\": \"string\",'+
		'      \"creationDate\": \"2024-05-22\",'+
		'      \"endDate\": \"2024-05-22\",'+
		'      \"protocolId\": \"string\",'+
		'      \"externalSystem\": \"string\",'+
		'      \"notesX9\": \"string\",'+
		'      \"individual\": {'+
		'        \"id\": \"string\",'+
		'        \"email\": \"string\"'+
		'      },'+
		'      \"items\": ['+
		'        {'+
		'          \"caseId\": \"string\",'+
		'          \"p2pIndicator\": true,'+
		'          \"reasonLevel1\": \"string\",'+
		'          \"reasonLevel2\": \"string\",'+
		'          \"result\": \"string\",'+
		'          \"workId\": \"string\",'+
		'          \"workType\": \"string\"'+
		'        }'+
		'      ]'+
		'    }'+
		'  ]'+
		'}';
		CustomerInteractionResponse r = CustomerInteractionResponse.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CustomerInteractionResponse.ProtocolItems objProtocolItems = new CustomerInteractionResponse.ProtocolItems(System.JSON.createParser(json));
		System.assert(objProtocolItems != null);
		System.assert(objProtocolItems.idProtocolItem == null);
		System.assert(objProtocolItems.protocol == null);
		System.assert(objProtocolItems.network == null);
		System.assert(objProtocolItems.itemProtocol == null);
		System.assert(objProtocolItems.sourceSystem == null);
		System.assert(objProtocolItems.relatedProtocol == null);
		System.assert(objProtocolItems.channelName == null);
		System.assert(objProtocolItems.creationDate == null);
		System.assert(objProtocolItems.endDate == null);
		System.assert(objProtocolItems.protocolId == null);
		System.assert(objProtocolItems.externalSystem == null);
		System.assert(objProtocolItems.notesX9 == null);
		System.assert(objProtocolItems.individual == null);
		System.assert(objProtocolItems.items == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CustomerInteractionResponse.ItemProtocol objItemProtocol = new CustomerInteractionResponse.ItemProtocol(System.JSON.createParser(json));
		System.assert(objItemProtocol != null);
		System.assert(objItemProtocol.description == null);
		System.assert(objItemProtocol.status == null);
		System.assert(objItemProtocol.subStatus == null);
		System.assert(objItemProtocol.openingDate == null);
		System.assert(objItemProtocol.closingDate == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CustomerInteractionResponse.Individual objIndividual = new CustomerInteractionResponse.Individual(System.JSON.createParser(json));
		System.assert(objIndividual != null);
		System.assert(objIndividual.id == null);
		System.assert(objIndividual.email == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CustomerInteractionResponse.Network objNetwork = new CustomerInteractionResponse.Network(System.JSON.createParser(json));
		System.assert(objNetwork != null);
		System.assert(objNetwork.geographicAreaCode == null);
		System.assert(objNetwork.networkNumber == null);
		System.assert(objNetwork.digitNetwork == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CustomerInteractionResponse.RelatedProtocol objRelatedProtocol = new CustomerInteractionResponse.RelatedProtocol(System.JSON.createParser(json));
		System.assert(objRelatedProtocol != null);
		System.assert(objRelatedProtocol.protocolNumber == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CustomerInteractionResponse.Items objItems = new CustomerInteractionResponse.Items(System.JSON.createParser(json));
		System.assert(objItems != null);
		System.assert(objItems.caseId == null);
		System.assert(objItems.p2pIndicator == null);
		System.assert(objItems.reasonLevel1 == null);
		System.assert(objItems.reasonLevel2 == null);
		System.assert(objItems.result == null);
		System.assert(objItems.workId == null);
		System.assert(objItems.workType == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CustomerInteractionResponse objCustomerInteractionResponse = new CustomerInteractionResponse(System.JSON.createParser(json));
		System.assert(objCustomerInteractionResponse != null);
		System.assert(objCustomerInteractionResponse.protocolItems == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CustomerInteractionResponse.Protocol objProtocol = new CustomerInteractionResponse.Protocol(System.JSON.createParser(json));
		System.assert(objProtocol != null);
		System.assert(objProtocol.protocolNumber == null);
		System.assert(objProtocol.submissionStatus == null);
		System.assert(objProtocol.smsClassification == null);
		System.assert(objProtocol.openingDate == null);
		System.assert(objProtocol.closingDate == null);
		System.assert(objProtocol.protocolType == null);
		System.assert(objProtocol.protocolStatus == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		CustomerInteractionResponse.SourceSystem objSourceSystem = new CustomerInteractionResponse.SourceSystem(System.JSON.createParser(json));
		System.assert(objSourceSystem != null);
		System.assert(objSourceSystem.systemName == null);
	}
}