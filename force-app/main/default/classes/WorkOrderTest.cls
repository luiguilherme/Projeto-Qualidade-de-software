@isTest
public with sharing class WorkOrderTest {

    @isTest
    static void testParse() {
		String json = '{'+
		'  \"id\": \"1135616108\",'+
		'  \"cancellationDate\": \"2024-05-21T17:23:11.800Z\",'+
		'  \"cancellationDate1\": \"2024-05-21T17:23:11.800Z\",'+
		'  \"cancellationReason\": \"string\",'+
		'  \"category\": \"string\",'+
		'  \"completionDate\": \"2024-05-21T17:23:11.800Z\",'+
		'  \"description\": \"string\",'+
		'  \"expectedCompletionDate\": \"2024-05-21T17:23:11.800Z\",'+
		'  \"externalId\": \"string\",'+
		'  \"orderDate\": \"2024-05-21T17:23:11.800Z\",'+
		'  \"priority\": \"string\",'+
		'  \"requestedCompletionDate\": \"2024-05-21T17:23:11.800Z\",'+
		'  \"requestedStartDate\": \"2024-05-21T17:23:11.800Z\",'+
		'  \"startDate\": \"2024-05-21T17:23:11.800Z\",'+
		'  \"stateChangeDate\": \"2024-05-21T17:23:11.800Z\",'+
		'  \"version\": \"string\",'+
		'  \"orderProtocol\": \"string\",'+
		'  \"recentDefect\": \"string\",'+
		'  \"relatedParty\": ['+
		'    {'+
		'      \"id\": \"string\",'+
		'      \"name\": \"string\",'+
		'      \"documentNumber\": \"string\",'+
		'      \"category\": \"Residencial, SOHO\",'+
		'      \"role\": \"string\",'+
		'      \"@referredType\": \"Customer\",'+
		'      \"contactMedium\": ['+
		'        {'+
		'          \"id\": \"string\",'+
		'          \"mediumType\": \"mobilePhone\",'+
		'          \"preferred\": true,'+
		'          \"characteristic\": {'+
		'            \"id\": \"string\",'+
		'            \"city\": \"string\",'+
		'            \"contactType\": \"string\",'+
		'            \"country\": \"string\",'+
		'            \"emailAddress\": \"string\",'+
		'            \"faxNumber\": \"string\",'+
		'            \"phoneNumber\": \"string\",'+
		'            \"postCode\": \"string\",'+
		'            \"socialNetworkId\": \"string\",'+
		'            \"stateOrProvince\": \"string\",'+
		'            \"street1\": \"string\",'+
		'            \"street2\": \"string\",'+
		'            \"@baseType\": \"string\",'+
		'            \"@type\": \"string\"'+
		'          }'+
		'        }'+
		'      ]'+
		'    }'+
		'  ],'+
		'  \"state\": \"Encerrada\",'+
		'  \"workOrderItem\": ['+
		'    {'+
		'      \"id\": \"string\",'+
		'      \"description\": \"string\",'+
		'      \"action\": \"add\",'+
		'      \"place\": {'+
		'        \"id\": \"string\",'+
		'        \"name\": \"string\",'+
		'        \"placePhysicalResourceAssoc\": {'+
		'          \"resourceSpecificationCharacteristic\": ['+
		'            {'+
		'              \"id\": \"string\",'+
		'              \"name\": \"string\",'+
		'              \"value\": \"string\",'+
		'              \"valueType\": \"string\",'+
		'              \"typeOfResource\": \"string\"'+
		'            }'+
		'          ]'+
		'        },'+
		'        \"@type\": \"string\",'+
		'        \"@referredType\": \"geographicAddress\",'+
		'        \"geographicAddress\": {'+
		'          \"country\": \"BR\",'+
		'          \"city\": \"CURITIBA\",'+
		'          \"stateOrProvince\": \"PR\",'+
		'          \"locality\": \"JARDIM BOTANICO\",'+
		'          \"postcode\": \"80210010\",'+
		'          \"streetType\": \"AVENIDA\",'+
		'          \"streetPrefix\": \"DOUTOR\",'+
		'          \"streetName\": \"DARIO LOPES DOS SANTOS\",'+
		'          \"streetNr\": \"2197\",'+
		'          \"streetCode\": \"123456\",'+
		'          \"cnl\": \"41000\",'+
		'          \"cnlAcronym\": \"CTA\",'+
		'          \"networkOwner\": \"VIVO2\",'+
		'          \"externalNetworkOwner\": \"FIBRASIL\",'+
		'          \"telephonicArea\": \"VM\",'+
		'          \"centralOffice\": \"BE\",'+
		'          \"microArea\": \"AIJ\",'+
		'          \"geographicLocation\": {'+
		'            \"uncertain\": 89.44,'+
		'            \"geoJson\": {'+
		'              \"type\": \"Point\",'+
		'              \"coordinates\": ['+
		'                0,'+
		'                0'+
		'              ]'+
		'            }'+
		'          }'+
		'        }'+
		'      },'+
		'      \"orderItem\": ['+
		'        {'+
		'          \"id\": \"string\",'+
		'          \"action\": \"string\",'+
		'          \"provisioningCode\": \"string\",'+
		'          \"name\": \"string\",'+
		'          \"portability\": true,'+
		'          \"status\": \"Aberto\",'+
		'          \"pon\": \"V0001NOEW6\",'+
		'          \"logicalResourceAssociated\": {'+
		'            \"id\": \"string\",'+
		'            \"category\": \"string\",'+
		'            \"name\": \"string\",'+
		'            \"status\": \"string\",'+
		'            \"validFor\": {'+
		'              \"endDateTime\": \"1985-04-12T23:20:50.52Z\",'+
		'              \"startDateTime\": \"1985-04-12T23:20:50.52Z\"'+
		'            }'+
		'          },'+
		'          \"@type\": \"string\",'+
		'          \"@referredType\": \"string\"'+
		'        }'+
		'      ],'+
		'      \"relatedEntity\": ['+
		'        {'+
		'          \"id\": \"string\",'+
		'          \"name\": \"string\",'+
		'          \"role\": \"string\",'+
		'          \"@baseType\": \"string\",'+
		'          \"@type\": \"string\",'+
		'          \"@referredType\": \"string\"'+
		'        }'+
		'      ],'+
		'      \"state\": \"Agendada, Pendente, Encerrada, Cancelada, Execucao\",'+
		'      \"stateReason\": \"Triagem\",'+
		'      \"work\": ['+
		'        {'+
		'          \"id\": \"string\",'+
		'          \"completionDate\": \"2024-05-21T17:23:11.801Z\",'+
		'          \"scheduledBy\": \"string\",'+
		'          \"resourceId\": \"string\",'+
		'          \"canBeAnticipated\": true,'+
		'          \"description\": \"string\",'+
		'          \"expectedCompletionDate\": \"2024-05-21T17:23:11.801Z\",'+
		'          \"name\": \"string\",'+
		'          \"orderDate\": \"2024-05-21T17:23:11.801Z\",'+
		'          \"percentageComplete\": 0,'+
		'          \"workPriority\": \"string\",'+
		'          \"workType\": \"string\",'+
		'          \"appointment\": {'+
		'            \"id\": \"string\",'+
		'            \"canBeAnticipated\": false,'+
		'            \"addressReference\": false,'+
		'            \"description\": \"string\",'+
		'            \"deliveryTimeSlot\": {'+
		'              \"endDateTime\": \"1985-04-12T23:20:50.52Z\",'+
		'              \"startDateTime\": \"1985-04-12T23:20:50.52Z\"'+
		'            },'+
		'            \"@baseType\": \"string\",'+
		'            \"@type\": \"string\",'+
		'            \"@referredType\": \"string\"'+
		'          },'+
		'          \"deliveryTimeSlot\": {'+
		'            \"endDateTime\": \"1985-04-12T23:20:50.52Z\",'+
		'            \"startDateTime\": \"1985-04-12T23:20:50.52Z\"'+
		'          },'+
		'          \"quantity\": {'+
		'            \"amount\": 1,'+
		'            \"units\": \"string\"'+
		'          },'+
		'          \"state\": \"Encerrado\",'+
		'          \"stateReason\": \"Aberta Massiva\",'+
		'          \"workCharacteristic\": ['+
		'            {'+
		'              \"id\": \"string\",'+
		'              \"name\": \"string\",'+
		'              \"valueType\": \"string\",'+
		'              \"characteristicRelationship\": ['+
		'                {'+
		'                  \"id\": \"string\",'+
		'                  \"relationshipType\": \"string\",'+
		'                  \"@baseType\": \"string\",'+
		'                  \"@type\": \"string\"'+
		'                }'+
		'              ],'+
		'              \"value\": \"string\",'+
		'              \"@baseType\": \"string\",'+
		'              \"@type\": \"string\"'+
		'            }'+
		'          ],'+
		'          \"workRelationship\": ['+
		'            {'+
		'              \"id\": \"string\",'+
		'              \"relationshipType\": \"string\",'+
		'              \"work\": \"string\",'+
		'              \"workRelationshipCharacteristic\": ['+
		'                {'+
		'                  \"id\": \"string\",'+
		'                  \"name\": \"string\",'+
		'                  \"valueType\": \"string\",'+
		'                  \"characteristicRelationship\": ['+
		'                    {'+
		'                      \"id\": \"string\",'+
		'                      \"relationshipType\": \"string\",'+
		'                      \"@baseType\": \"string\",'+
		'                      \"@type\": \"string\"'+
		'                    }'+
		'                  ],'+
		'                  \"value\": \"string\",'+
		'                  \"@baseType\": \"string\",'+
		'                  \"@type\": \"string\"'+
		'                }'+
		'              ],'+
		'              \"@baseType\": \"string\",'+
		'              \"@type\": \"string\"'+
		'            }'+
		'          ],'+
		'          \"workforceEmployeeAssignment\": ['+
		'            {'+
		'              \"id\": \"string\",'+
		'              \"description\": \"string\",'+
		'              \"documentNumber\": \"string\",'+
		'              \"contractor\": \"string\",'+
		'              \"skillType\": \"string\",'+
		'              \"workforceEmployee\": {'+
		'                \"id\": \"string\",'+
		'                \"name\": \"string\",'+
		'                \"contactMedium\": ['+
		'                  {'+
		'                    \"id\": \"string\",'+
		'                    \"mediumType\": \"mobilePhone\",'+
		'                    \"preferred\": true,'+
		'                    \"characteristic\": {'+
		'                      \"id\": \"string\",'+
		'                      \"city\": \"string\",'+
		'                      \"contactType\": \"string\",'+
		'                      \"country\": \"string\",'+
		'                      \"emailAddress\": \"string\",'+
		'                      \"faxNumber\": \"string\",'+
		'                      \"phoneNumber\": \"string\",'+
		'                      \"postCode\": \"string\",'+
		'                      \"socialNetworkId\": \"string\",'+
		'                      \"stateOrProvince\": \"string\",'+
		'                      \"street1\": \"string\",'+
		'                      \"street2\": \"string\",'+
		'                      \"@baseType\": \"string\",'+
		'                      \"@type\": \"string\"'+
		'                    }'+
		'                  }'+
		'                ]'+
		'              },'+
		'              \"@baseType\": \"string\",'+
		'              \"@type\": \"string\"'+
		'            }'+
		'          ],'+
		'          \"workSpecification\": {'+
		'            \"id\": \"string\",'+
		'            \"name\": \"IN_3P, TT_TV, AL_RL, IN_LNPTV\",'+
		'            \"type\": \"INSTALLATION\"'+
		'          },'+
		'          \"technicianNote\": {'+
		'            \"id\": ['+
		'              \"afa9-3d90aaa8da0f\"'+
		'            ],'+
		'            \"author\": ['+
		'              \"Mr. N. Bene\"'+
		'            ],'+
		'            \"date\": ['+
		'              \"2020-11-20T08:00:00Z\"'+
		'            ],'+
		'            \"text\": ['+
		'              \"This is important\"'+
		'            ]'+
		'          },'+
		'          \"contact\": {'+
		'            \"id\": \"string\",'+
		'            \"name\": \"string\",'+
		'            \"documentNumber\": \"string\",'+
		'            \"category\": \"Residencial, SOHO\",'+
		'            \"role\": \"string\",'+
		'            \"@referredType\": \"Customer\",'+
		'            \"contactMedium\": ['+
		'              {'+
		'                \"id\": \"string\",'+
		'                \"mediumType\": \"mobilePhone\",'+
		'                \"preferred\": true,'+
		'                \"characteristic\": {'+
		'                  \"id\": \"string\",'+
		'                  \"city\": \"string\",'+
		'                  \"contactType\": \"string\",'+
		'                  \"country\": \"string\",'+
		'                  \"emailAddress\": \"string\",'+
		'                  \"faxNumber\": \"string\",'+
		'                  \"phoneNumber\": \"string\",'+
		'                  \"postCode\": \"string\",'+
		'                  \"socialNetworkId\": \"string\",'+
		'                  \"stateOrProvince\": \"string\",'+
		'                  \"street1\": \"string\",'+
		'                  \"street2\": \"string\",'+
		'                  \"@baseType\": \"string\",'+
		'                  \"@type\": \"string\"'+
		'                }'+
		'              }'+
		'            ]'+
		'          },'+
		'          \"@baseType\": \"string\",'+
		'          \"@type\": \"string\",'+
		'          \"@referredType\": \"string\"'+
		'        }'+
		'      ],'+
		'      \"sequence\": \"1/1\",'+
		'      \"workSpecCharacteristicValue\": ['+
		'        {'+
		'          \"name\": \"string\",'+
		'          \"value\": true'+
		'        }'+
		'      ],'+
		'      \"involvesDevice\": {'+
		'        \"physicalResourceSpecAttributes\": {'+
		'          \"modelNumber\": \"string\",'+
		'          \"partNumber\": \"string\",'+
		'          \"skuNumber\": \"string\",'+
		'          \"vendorName\": \"string\",'+
		'          \"status\": \"string\",'+
		'          \"macaddress\": \"string\",'+
		'          \"name\": \"string\",'+
		'          \"category\": \"string\"'+
		'        }'+
		'      },'+
		'      \"serviceProblemAssociated\": {'+
		'        \"id\": \"string\",'+
		'        \"creationDate\": \"2024-05-21T17:23:11.801Z\"'+
		'      },'+
		'      \"workOrderItemRelationship\": ['+
		'        {'+
		'          \"id\": \"string\",'+
		'          \"relationshipType\": \"string\",'+
		'          \"@baseType\": \"ResourceSpecification\",'+
		'          \"@type\": \"PhysicalResourceSpecification\",'+
		'          \"physicalResourceAssociated\": {'+
		'            \"activityName\": 0,'+
		'            \"physicalResourceSummary\": \"string\",'+
		'            \"physicalResource\": {'+
		'              \"ResourceSpecificationCharacteristic\": ['+
		'                {'+
		'                  \"id\": \"string\",'+
		'                  \"name\": \"string\",'+
		'                  \"value\": \"string\",'+
		'                  \"valueType\": \"string\",'+
		'                  \"typeOfResource\": \"string\"'+
		'                }'+
		'              ]'+
		'            },'+
		'            \"shelf\": {'+
		'              \"msan\": {'+
		'                \"objectID\": \"string\",'+
		'                \"ResourceSpecificationCharacteristic\": {'+
		'                  \"id\": \"string\",'+
		'                  \"name\": \"string\",'+
		'                  \"value\": \"string\",'+
		'                  \"valueType\": \"string\",'+
		'                  \"typeOfResource\": \"string\"'+
		'                }'+
		'              },'+
		'              \"dslam\": {'+
		'                \"id\": \"string\",'+
		'                \"name\": \"string\",'+
		'                \"value\": \"string\",'+
		'                \"valueType\": \"string\",'+
		'                \"typeOfResource\": \"string\"'+
		'              }'+
		'            },'+
		'            \"cabinet\": {'+
		'              \"HasShelves\": ['+
		'                {'+
		'                  \"objectID\": 0,'+
		'                  \"slotId\": 0,'+
		'                  \"portId\": 0,'+
		'                  \"fiberId\": 0'+
		'                }'+
		'              ],'+
		'              \"HasCards\": ['+
		'                {'+
		'                  \"typeOfResource\": \"string\",'+
		'                  \"horizontalPosition\": \"string\",'+
		'                  \"pinPosition\": \"string\",'+
		'                  \"verticalPosition\": \"string\",'+
		'                  \"technology\": \"string\"'+
		'                }'+
		'              ],'+
		'              \"resourceSpecificationCharacteristic\": ['+
		'                {'+
		'                  \"id\": \"string\",'+
		'                  \"name\": \"string\",'+
		'                  \"value\": \"string\",'+
		'                  \"valueType\": \"string\",'+
		'                  \"typeOfResource\": \"string\"'+
		'                }'+
		'              ],'+
		'              \"terminalBox\": ['+
		'                ['+
		'                  {'+
		'                    \"chargerCableNumber\": 0,'+
		'                    \"pairNumber\": \"string\",'+
		'                    \"chargerSideCableNumber\": \"string\",'+
		'                    \"resourceAddress\": {'+
		'                      \"country\": \"BR\",'+
		'                      \"city\": \"CURITIBA\",'+
		'                      \"stateOrProvince\": \"PR\",'+
		'                      \"locality\": \"JARDIM BOTANICO\",'+
		'                      \"postcode\": \"80210010\",'+
		'                      \"streetType\": \"AVENIDA\",'+
		'                      \"streetPrefix\": \"DOUTOR\",'+
		'                      \"streetName\": \"DARIO LOPES DOS SANTOS\",'+
		'                      \"streetNr\": \"2197\",'+
		'                      \"streetCode\": \"123456\",'+
		'                      \"cnl\": \"41000\",'+
		'                      \"cnlAcronym\": \"CTA\",'+
		'                      \"networkOwner\": \"VIVO2\",'+
		'                      \"externalNetworkOwner\": \"FIBRASIL\",'+
		'                      \"telephonicArea\": \"VM\",'+
		'                      \"centralOffice\": \"BE\",'+
		'                      \"microArea\": \"AIJ\",'+
		'                      \"geographicLocation\": {'+
		'                        \"uncertain\": 89.44,'+
		'                        \"geoJson\": {'+
		'                          \"type\": \"Point\",'+
		'                          \"coordinates\": ['+
		'                            0,'+
		'                            0'+
		'                          ]'+
		'                        }'+
		'                      }'+
		'                    },'+
		'                    \"physicalLinkType\": \"string\",'+
		'                    \"resourceSpecCharacteristic\": {'+
		'                      \"id\": \"string\",'+
		'                      \"name\": \"string\",'+
		'                      \"value\": \"string\",'+
		'                      \"valueType\": \"string\",'+
		'                      \"typeOfResource\": \"string\"'+
		'                    }'+
		'                  }'+
		'                ]'+
		'              ]'+
		'            },'+
		'            \"physicalDeviceAtomic\": {'+
		'              \"resourceSpecificationCharacteristic\": {'+
		'                \"id\": \"string\",'+
		'                \"name\": \"string\",'+
		'                \"value\": \"string\",'+
		'                \"valueType\": \"string\",'+
		'                \"typeOfResource\": \"string\"'+
		'              },'+
		'              \"resourceAddress\": {'+
		'                \"PlacePhysicalResourceAssoc\": {'+
		'                  \"positionPhysicalResource\": \"string\"'+
		'                }'+
		'              },'+
		'              \"accessTecnology\": \"string\",'+
		'              \"model\": \"string\",'+
		'              \"manufacturer\": \"string\",'+
		'              \"networkPlatformIp\": \"string\",'+
		'              \"plusStaticIp\": \"string\",'+
		'              \"portSND\": 0,'+
		'              \"opticalTerminalCode\": 0,'+
		'              \"type\": \"string\",'+
		'              \"classification\": \"string\",'+
		'              \"networkAddressAssociation\": {'+
		'                \"networkMask\": {'+
		'                  \"networkMaskType\": \"string\"'+
		'                }'+
		'              }'+
		'            },'+
		'            \"splitter\": ['+
		'              {'+
		'                \"resourceSpecCharacteristic\": {'+
		'                  \"id\": \"string\",'+
		'                  \"name\": \"string\",'+
		'                  \"value\": \"string\",'+
		'                  \"valueType\": \"string\",'+
		'                  \"typeOfResource\": \"string\"'+
		'                },'+
		'                \"resourceAddress\": {'+
		'                  \"country\": \"BR\",'+
		'                  \"city\": \"CURITIBA\",'+
		'                  \"stateOrProvince\": \"PR\",'+
		'                  \"locality\": \"JARDIM BOTANICO\",'+
		'                  \"postcode\": \"80210010\",'+
		'                  \"streetType\": \"AVENIDA\",'+
		'                  \"streetPrefix\": \"DOUTOR\",'+
		'                  \"streetName\": \"DARIO LOPES DOS SANTOS\",'+
		'                  \"streetNr\": \"2197\",'+
		'                  \"streetCode\": \"123456\",'+
		'                  \"cnl\": \"41000\",'+
		'                  \"cnlAcronym\": \"CTA\",'+
		'                  \"networkOwner\": \"VIVO2\",'+
		'                  \"externalNetworkOwner\": \"FIBRASIL\",'+
		'                  \"telephonicArea\": \"VM\",'+
		'                  \"centralOffice\": \"BE\",'+
		'                  \"microArea\": \"AIJ\",'+
		'                  \"geographicLocation\": {'+
		'                    \"uncertain\": 89.44,'+
		'                    \"geoJson\": {'+
		'                      \"type\": \"Point\",'+
		'                      \"coordinates\": ['+
		'                        0,'+
		'                        0'+
		'                      ]'+
		'                    }'+
		'                  },'+
		'                  \"networkTopology\": \"string\"'+
		'                },'+
		'                \"physicalLink\": {'+
		'                  \"chargerCableNumber\": \"string\",'+
		'                  \"chargerSideCableNumber\": 0,'+
		'                  \"distributorCableNumber\": \"string\"'+
		'                }'+
		'              }'+
		'            ],'+
		'            \"terminalBox\": ['+
		'              ['+
		'                {'+
		'                  \"chargerCableNumber\": 0,'+
		'                  \"pairNumber\": \"string\",'+
		'                  \"chargerSideCableNumber\": \"string\",'+
		'                  \"resourceAddress\": {'+
		'                    \"country\": \"BR\",'+
		'                    \"city\": \"CURITIBA\",'+
		'                    \"stateOrProvince\": \"PR\",'+
		'                    \"locality\": \"JARDIM BOTANICO\",'+
		'                    \"postcode\": \"80210010\",'+
		'                    \"streetType\": \"AVENIDA\",'+
		'                    \"streetPrefix\": \"DOUTOR\",'+
		'                    \"streetName\": \"DARIO LOPES DOS SANTOS\",'+
		'                    \"streetNr\": \"2197\",'+
		'                    \"streetCode\": \"123456\",'+
		'                    \"cnl\": \"41000\",'+
		'                    \"cnlAcronym\": \"CTA\",'+
		'                    \"networkOwner\": \"VIVO2\",'+
		'                    \"externalNetworkOwner\": \"FIBRASIL\",'+
		'                    \"telephonicArea\": \"VM\",'+
		'                    \"centralOffice\": \"BE\",'+
		'                    \"microArea\": \"AIJ\",'+
		'                    \"geographicLocation\": {'+
		'                      \"uncertain\": 89.44,'+
		'                      \"geoJson\": {'+
		'                        \"type\": \"Point\",'+
		'                        \"coordinates\": ['+
		'                          0,'+
		'                          0'+
		'                        ]'+
		'                      }'+
		'                    }'+
		'                  },'+
		'                  \"physicalLinkType\": \"string\",'+
		'                  \"resourceSpecCharacteristic\": {'+
		'                    \"id\": \"string\",'+
		'                    \"name\": \"string\",'+
		'                    \"value\": \"string\",'+
		'                    \"valueType\": \"string\",'+
		'                    \"typeOfResource\": \"string\"'+
		'                  }'+
		'                }'+
		'              ]'+
		'            ],'+
		'            \"terminationPoint\": {'+
		'              \"networkId\": 0,'+
		'              \"multicastId\": \"string\",'+
		'              \"unicastId\": 0,'+
		'              \"audienceId\": 0,'+
		'              \"clientId\": 0,'+
		'              \"ipGateway\": \"string\"'+
		'            }'+
		'          }'+
		'        }'+
		'      ],'+
		'      \"@baseType\": \"string\",'+
		'      \"@type\": \"string\"'+
		'    }'+
		'  ],'+
		'  \"workOrderRelationship\": ['+
		'    {'+
		'      \"id\": \"string\",'+
		'      \"relationshipType\": \"string\",'+
		'      \"@baseType\": \"ResourceSpecification\",'+
		'      \"@type\": \"string\"'+
		'    }'+
		'  ],'+
		'  \"relatedChannel\": ['+
		'    {'+
		'      \"id\": \"AMDOCS, SIEBEL, GPS\",'+
		'      \"name\": \"string\",'+
		'      \"role\": \"CRM, Atendimento\"'+
		'    }'+
		'  ]'+
		'}';

		WorkOrder r = WorkOrder.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.Appointment objAppointment = new WorkOrder.Appointment(System.JSON.createParser(json));
		System.assert(objAppointment != null);
		System.assert(objAppointment.id == null);
		System.assert(objAppointment.canBeAnticipated == null);
		System.assert(objAppointment.addressReference == null);
		System.assert(objAppointment.description == null);
		System.assert(objAppointment.deliveryTimeSlot == null);
		System.assert(objAppointment.baseType == null);
		System.assert(objAppointment.type == null);
		System.assert(objAppointment.referredType == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.LogicalResourceAssociated objLogicalResourceAssociated = new WorkOrder.LogicalResourceAssociated(System.JSON.createParser(json));
		System.assert(objLogicalResourceAssociated != null);
		System.assert(objLogicalResourceAssociated.id == null);
		System.assert(objLogicalResourceAssociated.category == null);
		System.assert(objLogicalResourceAssociated.name == null); 
		System.assert(objLogicalResourceAssociated.status == null);
		System.assert(objLogicalResourceAssociated.validFor == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.ContactMedium objContactMedium = new WorkOrder.ContactMedium(System.JSON.createParser(json));
		System.assert(objContactMedium != null);
		System.assert(objContactMedium.id == null);
		System.assert(objContactMedium.mediumType == null);
		System.assert(objContactMedium.preferred == null);
		System.assert(objContactMedium.characteristic == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.TerminalBox objTerminalBox = new WorkOrder.TerminalBox(System.JSON.createParser(json));
		System.assert(objTerminalBox != null);
		System.assert(objTerminalBox.chargerCableNumber == null);
		System.assert(objTerminalBox.pairNumber == null);
		System.assert(objTerminalBox.chargerSideCableNumber == null);
		System.assert(objTerminalBox.resourceAddress == null);
		System.assert(objTerminalBox.physicalLinkType == null);
		System.assert(objTerminalBox.resourceSpecCharacteristic == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.Shelf objShelf = new WorkOrder.Shelf(System.JSON.createParser(json));
		System.assert(objShelf != null);
		System.assert(objShelf.msan == null);
		System.assert(objShelf.dslam == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.GeoJson objGeoJson = new WorkOrder.GeoJson(System.JSON.createParser(json));
		System.assert(objGeoJson != null);
		System.assert(objGeoJson.type == null);
		System.assert(objGeoJson.coordinates == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.PhysicalResource objPhysicalResource = new WorkOrder.PhysicalResource(System.JSON.createParser(json));
		System.assert(objPhysicalResource != null);
		System.assert(objPhysicalResource.ResourceSpecificationCharacteristic == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.ResourceSpecificationCharacteristic objResourceSpecificationCharacteristic = new WorkOrder.ResourceSpecificationCharacteristic(System.JSON.createParser(json));
		System.assert(objResourceSpecificationCharacteristic != null);
		System.assert(objResourceSpecificationCharacteristic.id == null);
		System.assert(objResourceSpecificationCharacteristic.name == null);
		System.assert(objResourceSpecificationCharacteristic.value == null);
		System.assert(objResourceSpecificationCharacteristic.valueType == null);
		System.assert(objResourceSpecificationCharacteristic.typeOfResource == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.HasShelves objHasShelves = new WorkOrder.HasShelves(System.JSON.createParser(json));
		System.assert(objHasShelves != null);
		System.assert(objHasShelves.objectID == null);
		System.assert(objHasShelves.slotId == null);
		System.assert(objHasShelves.portId == null);
		System.assert(objHasShelves.fiberId == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder objWorkOrder = new WorkOrder(System.JSON.createParser(json));
		System.assert(objWorkOrder != null);
		System.assert(objWorkOrder.id == null);
		System.assert(objWorkOrder.cancellationDate == null);
		System.assert(objWorkOrder.cancellationReason == null);
		System.assert(objWorkOrder.category == null);
		System.assert(objWorkOrder.completionDate == null);
		System.assert(objWorkOrder.description == null);
		System.assert(objWorkOrder.expectedCompletionDate == null);
		System.assert(objWorkOrder.externalId == null);
		System.assert(objWorkOrder.orderDate == null);
		System.assert(objWorkOrder.priority == null);
		System.assert(objWorkOrder.requestedCompletionDate == null);
		System.assert(objWorkOrder.requestedStartDate == null);
		System.assert(objWorkOrder.startDate == null);
		System.assert(objWorkOrder.stateChangeDate == null);
		System.assert(objWorkOrder.version == null);
		System.assert(objWorkOrder.orderProtocol == null);
		System.assert(objWorkOrder.recentDefect == null);
		System.assert(objWorkOrder.relatedParty == null);
		System.assert(objWorkOrder.state == null);
		System.assert(objWorkOrder.workOrderItem == null);
		System.assert(objWorkOrder.workOrderRelationship == null);
		System.assert(objWorkOrder.relatedChannel == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.GeographicAddress objGeographicAddress = new WorkOrder.GeographicAddress(System.JSON.createParser(json));
		System.assert(objGeographicAddress != null);
		System.assert(objGeographicAddress.country == null);
		System.assert(objGeographicAddress.city == null);
		System.assert(objGeographicAddress.stateOrProvince == null);
		System.assert(objGeographicAddress.locality == null);
		System.assert(objGeographicAddress.postcode == null);
		System.assert(objGeographicAddress.streetType == null);
		System.assert(objGeographicAddress.streetPrefix == null);
		System.assert(objGeographicAddress.streetName == null);
		System.assert(objGeographicAddress.streetNr == null);
		System.assert(objGeographicAddress.streetCode == null);
		System.assert(objGeographicAddress.cnl == null);
		System.assert(objGeographicAddress.cnlAcronym == null);
		System.assert(objGeographicAddress.networkOwner == null);
		System.assert(objGeographicAddress.externalNetworkOwner == null);
		System.assert(objGeographicAddress.telephonicArea == null);
		System.assert(objGeographicAddress.centralOffice == null);
		System.assert(objGeographicAddress.microArea == null);
		System.assert(objGeographicAddress.geographicLocation == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.Msan objMsan = new WorkOrder.Msan(System.JSON.createParser(json));
		System.assert(objMsan != null);
		System.assert(objMsan.objectID == null);
		System.assert(objMsan.ResourceSpecificationCharacteristic == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.Work objWork = new WorkOrder.Work(System.JSON.createParser(json));
		System.assert(objWork != null);
		System.assert(objWork.id == null);
		System.assert(objWork.completionDate == null);
		System.assert(objWork.scheduledBy == null);
		System.assert(objWork.resourceId == null);
		System.assert(objWork.canBeAnticipated == null);
		System.assert(objWork.description == null);
		System.assert(objWork.expectedCompletionDate == null);
		System.assert(objWork.name == null);
		System.assert(objWork.orderDate == null);
		System.assert(objWork.percentageComplete == null);
		System.assert(objWork.workPriority == null);
		System.assert(objWork.workType == null);
		System.assert(objWork.appointment == null);
		System.assert(objWork.deliveryTimeSlot == null);
		System.assert(objWork.quantity == null);
		System.assert(objWork.state == null);
		System.assert(objWork.stateReason == null);
		System.assert(objWork.workCharacteristic == null);
		System.assert(objWork.workRelationship == null);
		System.assert(objWork.workforceEmployeeAssignment == null);
		System.assert(objWork.workSpecification == null);
		System.assert(objWork.technicianNote == null);
		System.assert(objWork.contact == null);
		System.assert(objWork.baseType == null);
		System.assert(objWork.type == null);
		System.assert(objWork.referredType == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.PlacePhysicalResourceAssoc_Z objPlacePhysicalResourceAssoc_Z = new WorkOrder.PlacePhysicalResourceAssoc_Z(System.JSON.createParser(json));
		System.assert(objPlacePhysicalResourceAssoc_Z != null);
		System.assert(objPlacePhysicalResourceAssoc_Z.positionPhysicalResource == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.PhysicalResourceAssociated objPhysicalResourceAssociated = new WorkOrder.PhysicalResourceAssociated(System.JSON.createParser(json));
		System.assert(objPhysicalResourceAssociated != null);
		System.assert(objPhysicalResourceAssociated.activityName == null);
		System.assert(objPhysicalResourceAssociated.physicalResourceSummary == null);
		System.assert(objPhysicalResourceAssociated.physicalResource == null);
		System.assert(objPhysicalResourceAssociated.shelf == null);
		System.assert(objPhysicalResourceAssociated.cabinet == null);
		System.assert(objPhysicalResourceAssociated.physicalDeviceAtomic == null);
		System.assert(objPhysicalResourceAssociated.splitter == null);
		System.assert(objPhysicalResourceAssociated.terminalBox == null);
		System.assert(objPhysicalResourceAssociated.terminationPoint == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.WorkforceEmployeeAssignment objWorkforceEmployeeAssignment = new WorkOrder.WorkforceEmployeeAssignment(System.JSON.createParser(json));
		System.assert(objWorkforceEmployeeAssignment != null);
		System.assert(objWorkforceEmployeeAssignment.id == null);
		System.assert(objWorkforceEmployeeAssignment.description == null);
		System.assert(objWorkforceEmployeeAssignment.documentNumber == null);
		System.assert(objWorkforceEmployeeAssignment.contractor == null);
		System.assert(objWorkforceEmployeeAssignment.skillType == null);
		System.assert(objWorkforceEmployeeAssignment.workforceEmployee == null);
		System.assert(objWorkforceEmployeeAssignment.baseType == null);
		System.assert(objWorkforceEmployeeAssignment.type == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.InvolvesDevice objInvolvesDevice = new WorkOrder.InvolvesDevice(System.JSON.createParser(json));
		System.assert(objInvolvesDevice != null);
		System.assert(objInvolvesDevice.physicalResourceSpecAttributes == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.NetworkAddressAssociation objNetworkAddressAssociation = new WorkOrder.NetworkAddressAssociation(System.JSON.createParser(json));
		System.assert(objNetworkAddressAssociation != null);
		System.assert(objNetworkAddressAssociation.networkMask == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.NetworkMask objNetworkMask = new WorkOrder.NetworkMask(System.JSON.createParser(json));
		System.assert(objNetworkMask != null);
		System.assert(objNetworkMask.networkMaskType == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.Splitter objSplitter = new WorkOrder.Splitter(System.JSON.createParser(json));
		System.assert(objSplitter != null);
		System.assert(objSplitter.resourceSpecCharacteristic == null);
		System.assert(objSplitter.resourceAddress == null);
		System.assert(objSplitter.physicalLink == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.CharacteristicRelationship objCharacteristicRelationship = new WorkOrder.CharacteristicRelationship(System.JSON.createParser(json));
		System.assert(objCharacteristicRelationship != null);
		System.assert(objCharacteristicRelationship.id == null);
		System.assert(objCharacteristicRelationship.relationshipType == null);
		System.assert(objCharacteristicRelationship.baseType == null);
		System.assert(objCharacteristicRelationship.type == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.WorkRelationship objWorkRelationship = new WorkOrder.WorkRelationship(System.JSON.createParser(json));
		System.assert(objWorkRelationship != null);
		System.assert(objWorkRelationship.id == null);
		System.assert(objWorkRelationship.relationshipType == null);
		System.assert(objWorkRelationship.work == null);
		System.assert(objWorkRelationship.workRelationshipCharacteristic == null);
		System.assert(objWorkRelationship.baseType == null);
		System.assert(objWorkRelationship.type == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.HasCards objHasCards = new WorkOrder.HasCards(System.JSON.createParser(json));
		System.assert(objHasCards != null);
		System.assert(objHasCards.typeOfResource == null);
		System.assert(objHasCards.horizontalPosition == null);
		System.assert(objHasCards.pinPosition == null);
		System.assert(objHasCards.verticalPosition == null);
		System.assert(objHasCards.technology == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.Cabinet objCabinet = new WorkOrder.Cabinet(System.JSON.createParser(json));
		System.assert(objCabinet != null);
		System.assert(objCabinet.HasShelves == null);
		System.assert(objCabinet.HasCards == null);
		System.assert(objCabinet.resourceSpecificationCharacteristic == null);
		System.assert(objCabinet.terminalBox == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.ResourceAddress objResourceAddress = new WorkOrder.ResourceAddress(System.JSON.createParser(json));
		System.assert(objResourceAddress != null);
		System.assert(objResourceAddress.PlacePhysicalResourceAssoc == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.RelatedEntity objRelatedEntity = new WorkOrder.RelatedEntity(System.JSON.createParser(json));
		System.assert(objRelatedEntity != null);
		System.assert(objRelatedEntity.id == null);
		System.assert(objRelatedEntity.name == null);
		System.assert(objRelatedEntity.role == null);
		System.assert(objRelatedEntity.baseType == null);
		System.assert(objRelatedEntity.type == null);
		System.assert(objRelatedEntity.referredType == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.Characteristic objCharacteristic = new WorkOrder.Characteristic(System.JSON.createParser(json));
		System.assert(objCharacteristic != null);
		System.assert(objCharacteristic.id == null);
		System.assert(objCharacteristic.city == null);
		System.assert(objCharacteristic.contactType == null);
		System.assert(objCharacteristic.country == null);
		System.assert(objCharacteristic.emailAddress == null);
		System.assert(objCharacteristic.faxNumber == null);
		System.assert(objCharacteristic.phoneNumber == null);
		System.assert(objCharacteristic.postCode == null);
		System.assert(objCharacteristic.socialNetworkId == null);
		System.assert(objCharacteristic.stateOrProvince == null);
		System.assert(objCharacteristic.street1 == null);
		System.assert(objCharacteristic.street2 == null);
		System.assert(objCharacteristic.baseType == null);
		System.assert(objCharacteristic.type == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.GeographicLocation objGeographicLocation = new WorkOrder.GeographicLocation(System.JSON.createParser(json));
		System.assert(objGeographicLocation != null);
		System.assert(objGeographicLocation.uncertain == null);
		System.assert(objGeographicLocation.geoJson == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.Quantity objQuantity = new WorkOrder.Quantity(System.JSON.createParser(json));
		System.assert(objQuantity != null);
		System.assert(objQuantity.amount == null);
		System.assert(objQuantity.units == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.ResourceAddress_Z objResourceAddress_Z = new WorkOrder.ResourceAddress_Z(System.JSON.createParser(json));
		System.assert(objResourceAddress_Z != null);
		System.assert(objResourceAddress_Z.country == null);
		System.assert(objResourceAddress_Z.city == null);
		System.assert(objResourceAddress_Z.stateOrProvince == null);
		System.assert(objResourceAddress_Z.locality == null);
		System.assert(objResourceAddress_Z.postcode == null);
		System.assert(objResourceAddress_Z.streetType == null);
		System.assert(objResourceAddress_Z.streetPrefix == null);
		System.assert(objResourceAddress_Z.streetName == null);
		System.assert(objResourceAddress_Z.streetNr == null);
		System.assert(objResourceAddress_Z.streetCode == null);
		System.assert(objResourceAddress_Z.cnl == null);
		System.assert(objResourceAddress_Z.cnlAcronym == null);
		System.assert(objResourceAddress_Z.networkOwner == null);
		System.assert(objResourceAddress_Z.externalNetworkOwner == null);
		System.assert(objResourceAddress_Z.telephonicArea == null);
		System.assert(objResourceAddress_Z.centralOffice == null);
		System.assert(objResourceAddress_Z.microArea == null);
		System.assert(objResourceAddress_Z.geographicLocation == null);
		System.assert(objResourceAddress_Z.networkTopology == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.WorkCharacteristic objWorkCharacteristic = new WorkOrder.WorkCharacteristic(System.JSON.createParser(json));
		System.assert(objWorkCharacteristic != null);
		System.assert(objWorkCharacteristic.id == null);
		System.assert(objWorkCharacteristic.name == null);
		System.assert(objWorkCharacteristic.valueType == null);
		System.assert(objWorkCharacteristic.characteristicRelationship == null);
		System.assert(objWorkCharacteristic.value == null);
		System.assert(objWorkCharacteristic.baseType == null);
		System.assert(objWorkCharacteristic.type == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.ValidFor objValidFor = new WorkOrder.ValidFor(System.JSON.createParser(json));
		System.assert(objValidFor != null);
		System.assert(objValidFor.endDateTime == null);
		System.assert(objValidFor.startDateTime == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.RelatedChannel objRelatedChannel = new WorkOrder.RelatedChannel(System.JSON.createParser(json));
		System.assert(objRelatedChannel != null);
		System.assert(objRelatedChannel.id == null);
		System.assert(objRelatedChannel.name == null);
		System.assert(objRelatedChannel.role == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.WorkSpecCharacteristicValue objWorkSpecCharacteristicValue = new WorkOrder.WorkSpecCharacteristicValue(System.JSON.createParser(json));
		System.assert(objWorkSpecCharacteristicValue != null);
		System.assert(objWorkSpecCharacteristicValue.name == null);
		System.assert(objWorkSpecCharacteristicValue.value == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.WorkforceEmployee objWorkforceEmployee = new WorkOrder.WorkforceEmployee(System.JSON.createParser(json));
		System.assert(objWorkforceEmployee != null);
		System.assert(objWorkforceEmployee.id == null);
		System.assert(objWorkforceEmployee.name == null);
		System.assert(objWorkforceEmployee.contactMedium == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.PhysicalLink objPhysicalLink = new WorkOrder.PhysicalLink(System.JSON.createParser(json));
		System.assert(objPhysicalLink != null);
		System.assert(objPhysicalLink.chargerCableNumber == null);
		System.assert(objPhysicalLink.chargerSideCableNumber == null);
		System.assert(objPhysicalLink.distributorCableNumber == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.PhysicalResourceSpecAttributes objPhysicalResourceSpecAttributes = new WorkOrder.PhysicalResourceSpecAttributes(System.JSON.createParser(json));
		System.assert(objPhysicalResourceSpecAttributes != null);
		System.assert(objPhysicalResourceSpecAttributes.modelNumber == null);
		System.assert(objPhysicalResourceSpecAttributes.partNumber == null);
		System.assert(objPhysicalResourceSpecAttributes.skuNumber == null);
		System.assert(objPhysicalResourceSpecAttributes.vendorName == null);
		System.assert(objPhysicalResourceSpecAttributes.status == null);
		System.assert(objPhysicalResourceSpecAttributes.macaddress == null);
		System.assert(objPhysicalResourceSpecAttributes.name == null);
		System.assert(objPhysicalResourceSpecAttributes.category == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.PhysicalDeviceAtomic objPhysicalDeviceAtomic = new WorkOrder.PhysicalDeviceAtomic(System.JSON.createParser(json));
		System.assert(objPhysicalDeviceAtomic != null);
		System.assert(objPhysicalDeviceAtomic.resourceSpecificationCharacteristic == null);
		System.assert(objPhysicalDeviceAtomic.resourceAddress == null);
		System.assert(objPhysicalDeviceAtomic.accessTecnology == null);
		System.assert(objPhysicalDeviceAtomic.model == null);
		System.assert(objPhysicalDeviceAtomic.manufacturer == null);
		System.assert(objPhysicalDeviceAtomic.networkPlatformIp == null);
		System.assert(objPhysicalDeviceAtomic.plusStaticIp == null);
		System.assert(objPhysicalDeviceAtomic.portSND == null);
		System.assert(objPhysicalDeviceAtomic.opticalTerminalCode == null);
		System.assert(objPhysicalDeviceAtomic.type == null);
		System.assert(objPhysicalDeviceAtomic.classification == null);
		System.assert(objPhysicalDeviceAtomic.networkAddressAssociation == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.OrderItem objOrderItem = new WorkOrder.OrderItem(System.JSON.createParser(json));
		System.assert(objOrderItem != null);
		System.assert(objOrderItem.id == null);
		System.assert(objOrderItem.action == null);
		System.assert(objOrderItem.provisioningCode == null);
		System.assert(objOrderItem.name == null);
		System.assert(objOrderItem.portability == null);
		System.assert(objOrderItem.status == null);
		System.assert(objOrderItem.pon == null);
		System.assert(objOrderItem.logicalResourceAssociated == null);
		System.assert(objOrderItem.type == null);
		System.assert(objOrderItem.referredType == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.RelatedParty objRelatedParty = new WorkOrder.RelatedParty(System.JSON.createParser(json));
		System.assert(objRelatedParty != null);
		System.assert(objRelatedParty.id == null);
		System.assert(objRelatedParty.name == null);
		System.assert(objRelatedParty.documentNumber == null);
		System.assert(objRelatedParty.category == null);
		System.assert(objRelatedParty.role == null);
		System.assert(objRelatedParty.referredType == null);
		System.assert(objRelatedParty.contactMedium == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.WorkSpecification objWorkSpecification = new WorkOrder.WorkSpecification(System.JSON.createParser(json));
		System.assert(objWorkSpecification != null);
		System.assert(objWorkSpecification.id == null);
		System.assert(objWorkSpecification.name == null);
		System.assert(objWorkSpecification.type == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.TechnicianNote objTechnicianNote = new WorkOrder.TechnicianNote(System.JSON.createParser(json));
		System.assert(objTechnicianNote != null);
		System.assert(objTechnicianNote.id == null);
		System.assert(objTechnicianNote.author == null);
		System.assert(objTechnicianNote.date_Z == null);
		System.assert(objTechnicianNote.text == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.ServiceProblemAssociated objServiceProblemAssociated = new WorkOrder.ServiceProblemAssociated(System.JSON.createParser(json));
		System.assert(objServiceProblemAssociated != null);
		System.assert(objServiceProblemAssociated.id == null);
		System.assert(objServiceProblemAssociated.creationDate == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.PlacePhysicalResourceAssoc objPlacePhysicalResourceAssoc = new WorkOrder.PlacePhysicalResourceAssoc(System.JSON.createParser(json));
		System.assert(objPlacePhysicalResourceAssoc != null);
		System.assert(objPlacePhysicalResourceAssoc.resourceSpecificationCharacteristic == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.Place objPlace = new WorkOrder.Place(System.JSON.createParser(json));
		System.assert(objPlace != null);
		System.assert(objPlace.id == null);
		System.assert(objPlace.name == null);
		System.assert(objPlace.placePhysicalResourceAssoc == null);
		System.assert(objPlace.type == null);
		System.assert(objPlace.referredType == null);
		System.assert(objPlace.geographicAddress == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.TerminationPoint objTerminationPoint = new WorkOrder.TerminationPoint(System.JSON.createParser(json));
		System.assert(objTerminationPoint != null);
		System.assert(objTerminationPoint.networkId == null);
		System.assert(objTerminationPoint.multicastId == null);
		System.assert(objTerminationPoint.unicastId == null);
		System.assert(objTerminationPoint.audienceId == null);
		System.assert(objTerminationPoint.clientId == null);
		System.assert(objTerminationPoint.ipGateway == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.WorkOrderItem objWorkOrderItem = new WorkOrder.WorkOrderItem(System.JSON.createParser(json));
		System.assert(objWorkOrderItem != null);
		System.assert(objWorkOrderItem.id == null);
		System.assert(objWorkOrderItem.description == null);
		System.assert(objWorkOrderItem.action == null);
		System.assert(objWorkOrderItem.place == null);
		System.assert(objWorkOrderItem.orderItem == null);
		System.assert(objWorkOrderItem.relatedEntity == null);
		System.assert(objWorkOrderItem.state == null);
		System.assert(objWorkOrderItem.stateReason == null);
		System.assert(objWorkOrderItem.work == null);
		System.assert(objWorkOrderItem.sequence == null);
		System.assert(objWorkOrderItem.workSpecCharacteristicValue == null);
		System.assert(objWorkOrderItem.involvesDevice == null);
		System.assert(objWorkOrderItem.serviceProblemAssociated == null);
		System.assert(objWorkOrderItem.workOrderItemRelationship == null);
		System.assert(objWorkOrderItem.baseType == null);
		System.assert(objWorkOrderItem.type == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		WorkOrder.WorkOrderItemRelationship objWorkOrderItemRelationship = new WorkOrder.WorkOrderItemRelationship(System.JSON.createParser(json));
		System.assert(objWorkOrderItemRelationship != null);
		System.assert(objWorkOrderItemRelationship.id == null);
		System.assert(objWorkOrderItemRelationship.relationshipType == null);
		System.assert(objWorkOrderItemRelationship.baseType == null);
		System.assert(objWorkOrderItemRelationship.type == null);
		System.assert(objWorkOrderItemRelationship.physicalResourceAssociated == null);
	}
}