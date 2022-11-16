@IsTest
public class CreditAnalysisRequestTest {
	
	@TestSetup
	static void setup(){
        AccountTestFactory.start().startPersonAccount().create();
	}


	@IsTest
	static void execute(){
		Map<String, object> mapResult = new Map<string, Object>();
		String requestBody;
		List<Account> accList = [ SELECT    
							Id,
							Name,
							DocumentNumber__c,
							UserId__c,
							vlocity_cmt__PrimaryContactId__r.MotherName__c,
							vlocity_cmt__PrimaryContactId__r.Birthdate,
							CreditScoreDate__c,
							RecordTypeId,
							vlocity_cmt__CreditScore__c
						FROM 
						Account];
		Test.startTest();
			CreditAnalysisCallout.execute(mapResult, accList[0], 'canal', 'canal', UserInfo.getUserId());
			requestBody = new CreditAnalysisRequest(accList[0], 'canal', 'canal', UserInfo.getUserId()).createRequestStructure().toJson();
		Test.stopTest();
		System.assert(mapResult != null, 'O mapa de resposta não foi preenchido');
		System.assert(!String.isBlank(requestBody) , 'O contrato de request não foi preenchido');

	}



	static testMethod void testParse() {
		String json = '{'+
		'  \"performAnalysisCreditRequest\": {'+
		'    \"individual\": {'+
		'      \"legalName\": \"João de Jesus\",'+
		'      \"motherName\": \"Maria de Jesus\",'+
		'      \"birthDate\": \"2008-09-28T22:49:45\"'+
		'    },'+
		'    \"individualIdentification\": {'+
		'      \"nationalIdentilyCardNr\": \"11111111122\",'+
		'      \"documentType\": \"CPF\"'+
		'    },'+
		'    \"geographicAddress\": {'+
		'      \"stateOrProvinceAbbreviation\": \"SP\"'+
		'    },'+
		'    \"policyApplication\": {'+
		'      \"userId\": \"A123456\"'+
		'    },'+
		'    \"salesChannel\": {'+
		'      \"salesCode\": \"\",'+
		'      \"salesChannel\": \"Lojas\",'+
		'      \"salesSector\": \"\",'+
		'      \"salesDepartment\": \"\",'+
		'      \"salesGroup\": \"\",'+
		'      \"SalesChannelName\": \"SF-Vendas Diretas\",'+
		'      \"salesChannelAbbreviation\": \"\"'+
		'    },'+
		'    \"geographicArea\": {'+
		'      \"code\": \"11\"'+
		'    },'+
		'    \"customerOrder\": {'+
		'      \"customerOrderType\": \"PR\",'+
		'      \"orderType\": \"PR\",'+
		'      \"statusOrder\": \"\"'+
		'    },'+
		'    \"organizationIdentification\": ['+
		'      {'+
		'        \"documentNumber\": \"\",'+
		'        \"documentType\": \"CNPJ\"'+
		'      }'+
		'    ],'+
		'    \"seller\": {'+
		'      \"nationalIdentilyCardNr\": \"\",'+
		'      \"documentType\": \"\"'+
		'    },'+
		'    \"customerCreditProfile\": {'+
		'      \"creditScore\": \"\"'+
		'    },'+
		'    \"lines\": {'+
		'      \"line\": ['+
		'        {'+
		'          \"geographicArea\": {'+
		'            \"code\": \"11\"'+
		'          },'+
		'          \"network\": {'+
		'            \"networkNumber\": \"\"'+
		'          },'+
		'          \"service\": {'+
		'            \"isServiceEnabled\": \"AC\"'+
		'          },'+
		'          \"product\": {'+
		'            \"productStatus\": \"AS\"'+
		'          },'+
		'          \"customerOrder\": {'+
		'            \"customerOrderType\": \"PR\",'+
		'            \"orderType\": \"\",'+
		'            \"statusOrder\": \"DO\"'+
		'          }'+
		'        }'+
		'      ]'+
		'    },'+
		'    \"companyInfo\": {'+
		'      \"organizationIdentifications\": {'+
		'        \"organizationIdentification\": ['+
		'          {'+
		'            \"documentNumber\": \"\",'+
		'            \"documentType\": \"CNPJ\"'+
		'          }'+
		'        ]'+
		'      },'+
		'      \"organizationName\": {'+
		'        \"tradingName\": \"\"'+
		'      },'+
		'      \"foundationDate\": {'+
		'        \"establishDate\": \"2003-08-08T21:18:37-03:00\"'+
		'      },'+
		'      \"businessAssociates\": {'+
		'        \"businessAssociate\": ['+
		'          {'+
		'            \"individual\": {'+
		'              \"legalName\": \"João de Jesus\",'+
		'              \"motherName\": \"Maria de Jesus\",'+
		'              \"birthDate\": \"2008-09-28T22:49:45\"'+
		'            },'+
		'            \"individualIdentification\": {'+
		'              \"nationalIdentilyCardNr\": \"11111111122\",'+
		'              \"documentType\": \"CPF\"'+
		'            }'+
		'          }'+
		'        ]'+
		'      },'+
		'      \"urbanPropertyAddress\": {'+
		'        \"stateOrProvinceAbbreviation\": \"SP\",'+
		'        \"streetNr\": \"\",'+
		'        \"streetName\": \"\",'+
		'        \"streetSuffix\": \"\",'+
		'        \"postcode\": \"\",'+
		'        \"municipalityname\": \"\",'+
		'        \"nameState\": \"\",'+
		'        \"nameCity\": \"\"'+
		'      },'+
		'      \"quantityOfSubsidiary\": {'+
		'        \"parameterQuantity\": 3'+
		'      },'+
		'      \"quantityOfBusinessAssociates\": {'+
		'        \"parameterQuantity\": 2'+
		'      }'+
		'    },'+
		'    \"productType\": {'+
		'      \"items\": {'+
		'        \"item\": ['+
		'          {'+
		'            \"type\": \"\"'+
		'          }'+
		'        ]'+
		'      }'+
		'    },'+
		'    \"urbanPropertyAddress\": {'+
		'      \"stateOrProvinceAbbreviation\": \"SP\",'+
		'      \"streetNr\": \"\",'+
		'      \"streetName\": \"\",'+
		'      \"streetSuffix\": \"\",'+
		'      \"postcode\": \"\",'+
		'      \"municipalityname\": \"\",'+
		'      \"nameState\": \"\",'+
		'      \"nameCity\": \"\"'+
		'    }'+
		'  }'+
		'}';
		CreditAnalysisRequest obj = CreditAnalysisRequest.parse(json);
		System.assert(obj != null);
	}
}