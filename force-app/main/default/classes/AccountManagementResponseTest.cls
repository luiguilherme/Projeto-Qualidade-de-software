@IsTest
public with sharing class AccountManagementResponseTest {
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'   \"documentNumber\":\"35873134820\",'+
		'   \"areMore\":false,'+
		'   \"account\":{'+
		'      \"href\":\"22101560\"'+
		'   },'+
		'   \"customer\":{'+
		'      \"customerAccount\":{'+
		'         \"id\":\"105158098\"'+
		'      }'+
		'   },'+
		'   \"accounts\":['+
		'      {'+
		'         \"billingAccount\":{'+
		'            \"id\":\"1105253406\",'+
		'            \"financialAccountType\":{'+
		'               \"id\":\"1105253407\"'+
		'            },'+
		'            \"contact\":{'+
		'               \"contactMedium\":['+
		'                  {'+
		'                     \"characteristic\":{'+
		'                        \"postCode\":\"\"'+
		'                     }'+
		'                  }'+
		'               ]'+
		'            },'+
		'            \"product\":['+
		'               {'+
		'                  \"id\":\"19971502212\"'+
		'               }'+
		'            ]'+
		'         }'+
		'      },'+
		'      {'+
		'         \"billingAccount\":{'+
		'            \"id\":\"434449006\",'+
		'            \"financialAccountType\":{'+
		'               \"id\":\"1334437200\"'+
		'            },'+
		'            \"contact\":{'+
		'               \"contactMedium\":['+
		'                  {'+
		'                     \"characteristic\":{'+
		'                        \"postCode\":\"00000003\"'+
		'                     }'+
		'                  },'+
		'                  {'+
		'                     \"characteristic\":{'+
		'                        \"postCode\":\"00000003\"'+
		'                     }'+
		'                  },'+
		'                  {'+
		'                     \"characteristic\":{'+
		'                        \"postCode\":\"00000003\"'+
		'                     }'+
		'                  }'+
		'               ]'+
		'            },'+
		'            \"product\":['+
		'               {'+
		'                  \"id\":\"4575202948\"'+
		'               },'+
		'               {'+
		'                  \"id\":\"CAS-V0001PSF9T-013\"'+
		'               },'+
		'               {'+
		'                  \"id\":\"1932235905\"'+
		'               }'+
		'            ]'+
		'         }'+
		'      },'+
		'      {'+
		'         \"billingAccount\":{'+
		'            \"id\":\"456456\",'+
		'            \"financialAccountType\":{'+
		'               \"id\":\"456456\"'+
		'            },'+
		'            \"contact\":{'+
		'               \"contactMedium\":['+
		'                  {'+
		'                     \"characteristic\":{'+
		'                        \"postCode\":\"\"'+
		'                     }'+
		'                  }'+
		'               ]'+
		'            },'+
		'            \"product\":['+
		'               {'+
		'                  \"id\":\"12345678900\"'+
		'               }'+
		'            ]'+
		'         }'+
		'      },'+
		'      {'+
		'         \"billingAccount\":{'+
		'            \"id\":\"345345000\",'+
		'            \"financialAccountType\":{'+
		'               \"id\":\"1105253407\"'+
		'            },'+
		'            \"contact\":{'+
		'               \"contactMedium\":['+
		'                  {'+
		'                     \"characteristic\":{'+
		'                        \"postCode\":\"000000000\"'+
		'                     }'+
		'                  }'+
		'               ]'+
		'            },'+
		'            \"product\":['+
		'               {'+
		'                  \"id\":\"{{queryParam \'serviceId\' 41300404510}}\"'+
		'               }'+
		'            ]'+
		'         }'+
		'      },'+
		'      {'+
		'         \"billingAccount\":{'+
		'            \"id\":\"234234\",'+
		'            \"financialAccountType\":{'+
		'               \"id\":\"234234\"'+
		'            },'+
		'            \"contact\":{'+
		'               \"contactMedium\":['+
		'                  {'+
		'                     \"characteristic\":{'+
		'                        \"postCode\":\"\"'+
		'                     }'+
		'                  }'+
		'               ]'+
		'            },'+
		'            \"product\":['+
		'               {'+
		'                  \"id\":\"234234\"'+
		'               }'+
		'            ]'+
		'         }'+
		'      },'+
		'      {'+
		'         \"billingAccount\":{'+
		'            \"id\":\"123123\",'+
		'            \"financialAccountType\":{'+
		'               \"id\":\"123123\"'+
		'            },'+
		'            \"contact\":{'+
		'               \"contactMedium\":['+
		'                  {'+
		'                     \"characteristic\":{'+
		'                        \"postCode\":\"\"'+
		'                     }'+
		'                  }'+
		'               ]'+
		'            },'+
		'            \"product\":['+
		'               {'+
		'                  \"id\":\"123123\"'+
		'               }'+
		'            ]'+
		'         }'+
		'      }'+
		'   ]'+
		'}';
		AccountManagementResponse r = AccountManagementResponse.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		AccountManagementResponse.Account objAccount = new AccountManagementResponse.Account(System.JSON.createParser(json));
		System.assert(objAccount != null);
		System.assert(objAccount.href == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		AccountManagementResponse.ContactMedium objContactMedium = new AccountManagementResponse.ContactMedium(System.JSON.createParser(json));
		System.assert(objContactMedium != null);
		System.assert(objContactMedium.characteristic == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		AccountManagementResponse.Customer objCustomer = new AccountManagementResponse.Customer(System.JSON.createParser(json));
		System.assert(objCustomer != null);
		System.assert(objCustomer.customerAccount == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		AccountManagementResponse.Characteristic objCharacteristic = new AccountManagementResponse.Characteristic(System.JSON.createParser(json));
		System.assert(objCharacteristic != null);
		System.assert(objCharacteristic.postCode == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		AccountManagementResponse.BillingAccount objBillingAccount = new AccountManagementResponse.BillingAccount(System.JSON.createParser(json));
		System.assert(objBillingAccount != null);
		System.assert(objBillingAccount.id == null);
		System.assert(objBillingAccount.financialAccountType == null);
		System.assert(objBillingAccount.contact == null);
		System.assert(objBillingAccount.product == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		AccountManagementResponse.CustomerAccount objCustomerAccount = new AccountManagementResponse.CustomerAccount(System.JSON.createParser(json));
		System.assert(objCustomerAccount != null);
		System.assert(objCustomerAccount.id == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		AccountManagementResponse objAccountManagementResponse = new AccountManagementResponse(System.JSON.createParser(json));
		System.assert(objAccountManagementResponse != null);
		System.assert(objAccountManagementResponse.documentNumber == null);
		System.assert(objAccountManagementResponse.areMore == null);
		System.assert(objAccountManagementResponse.account == null);
		System.assert(objAccountManagementResponse.customer == null);
		System.assert(objAccountManagementResponse.accounts == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		AccountManagementResponse.Accounts objAccounts = new AccountManagementResponse.Accounts(System.JSON.createParser(json));
		System.assert(objAccounts != null);
		System.assert(objAccounts.billingAccount == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		AccountManagementResponse.Contact objContact = new AccountManagementResponse.Contact(System.JSON.createParser(json));
		System.assert(objContact != null);
		System.assert(objContact.contactMedium == null);
	}
}