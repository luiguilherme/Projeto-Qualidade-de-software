public class WorkOrder {
	
	public class Appointment {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public Boolean canBeAnticipated;
		@AuraEnabled
		@InvocableVariable
		public Boolean addressReference;
		@AuraEnabled
		@InvocableVariable
		public String description;
		@AuraEnabled
		@InvocableVariable
		public ValidFor deliveryTimeSlot;
		@AuraEnabled
		@InvocableVariable
		public String baseType;
		@AuraEnabled
		@InvocableVariable
		public String type;
		@AuraEnabled
		@InvocableVariable
		public String referredType;

		public Appointment(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'canBeAnticipated') {
							canBeAnticipated = parser.getBooleanValue();
						} else if (text == 'addressReference') {
							addressReference = parser.getBooleanValue();
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'deliveryTimeSlot') {
							deliveryTimeSlot = new ValidFor(parser);
						} else if (text == 'baseType') {
							baseType = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else if (text == 'referredType') {
							referredType = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Appointment consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class LogicalResourceAssociated {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String category;
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable
		public String status;
		@AuraEnabled
		@InvocableVariable
		public ValidFor validFor;

		public LogicalResourceAssociated(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'category') {
							category = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'validFor') {
							validFor = new ValidFor(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'LogicalResourceAssociated consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ContactMedium {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String mediumType;
		@AuraEnabled
		@InvocableVariable
		public Boolean preferred;
		@AuraEnabled
		@InvocableVariable
		public Characteristic characteristic;

		public ContactMedium(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'mediumType') {
							mediumType = parser.getText();
						} else if (text == 'preferred') {
							preferred = parser.getBooleanValue();
						} else if (text == 'characteristic') {
							characteristic = new Characteristic(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'ContactMedium consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class TerminalBox {
		@AuraEnabled
		@InvocableVariable
		public Integer chargerCableNumber;
		@AuraEnabled
		@InvocableVariable
		public String pairNumber;
		@AuraEnabled
		@InvocableVariable
		public String chargerSideCableNumber;
		@AuraEnabled
		@InvocableVariable
		public GeographicAddress resourceAddress;
		@AuraEnabled
		@InvocableVariable
		public String physicalLinkType;
		@AuraEnabled
		@InvocableVariable
		public ResourceSpecificationCharacteristic resourceSpecCharacteristic;

		public TerminalBox(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'chargerCableNumber') {
							chargerCableNumber = parser.getIntegerValue();
						} else if (text == 'pairNumber') {
							pairNumber = parser.getText();
						} else if (text == 'chargerSideCableNumber') {
							chargerSideCableNumber = parser.getText();
						} else if (text == 'resourceAddress') {
							resourceAddress = new GeographicAddress(parser);
						} else if (text == 'physicalLinkType') {
							physicalLinkType = parser.getText();
						} else if (text == 'resourceSpecCharacteristic') {
							resourceSpecCharacteristic = new ResourceSpecificationCharacteristic(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'TerminalBox consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Shelf {
		@AuraEnabled
		@InvocableVariable
		public Msan msan;
		@AuraEnabled
		@InvocableVariable
		public ResourceSpecificationCharacteristic dslam;

		public Shelf(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'msan') {
							msan = new Msan(parser);
						} else if (text == 'dslam') {
							dslam = new ResourceSpecificationCharacteristic(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Shelf consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class GeoJson {
		@AuraEnabled
		@InvocableVariable
		public String type;
		@AuraEnabled
		@InvocableVariable
		public List<Integer> coordinates;

		public GeoJson(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'type') {
							type = parser.getText();
						} else if (text == 'coordinates') {
							coordinates = arrayOfInteger(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'GeoJson consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class PhysicalResource {
		@AuraEnabled
		@InvocableVariable
		public List<ResourceSpecificationCharacteristic> ResourceSpecificationCharacteristic;

		public PhysicalResource(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'ResourceSpecificationCharacteristic') {
							ResourceSpecificationCharacteristic = arrayOfResourceSpecificationCharacteristic(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'PhysicalResource consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ResourceSpecificationCharacteristic {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable 
		public String value;
		@AuraEnabled
		@InvocableVariable
		public String valueType;
		@AuraEnabled
		@InvocableVariable
		public String typeOfResource;

		public ResourceSpecificationCharacteristic(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'value') {
							value = parser.getText();
						} else if (text == 'valueType') {
							valueType = parser.getText();
						} else if (text == 'typeOfResource') {
							typeOfResource = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'ResourceSpecificationCharacteristic consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class HasShelves {
		@AuraEnabled
		@InvocableVariable
		public Integer objectID;
		@AuraEnabled
		@InvocableVariable
		public Integer slotId;
		@AuraEnabled
		@InvocableVariable
		public Integer portId;
		@AuraEnabled
		@InvocableVariable
		public Integer fiberId;

		public HasShelves(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'objectID') {
							objectID = parser.getIntegerValue();
						} else if (text == 'slotId') {
							slotId = parser.getIntegerValue();
						} else if (text == 'portId') {
							portId = parser.getIntegerValue();
						} else if (text == 'fiberId') {
							fiberId = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'HasShelves consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	@AuraEnabled
	@InvocableVariable
	public String id;
	@AuraEnabled
	@InvocableVariable
	public String cancellationDate;
	@AuraEnabled
	@InvocableVariable
	public String cancellationReason;
	@AuraEnabled
	@InvocableVariable
	public String category;
	@AuraEnabled
	@InvocableVariable
	public String completionDate;
	@AuraEnabled
	@InvocableVariable
	public String description;
	@AuraEnabled
	@InvocableVariable
	public String expectedCompletionDate;
	@AuraEnabled
	@InvocableVariable
	public String externalId;
	@AuraEnabled
	@InvocableVariable
	public String orderDate;
	@AuraEnabled
	@InvocableVariable
	public String priority;
	@AuraEnabled
	@InvocableVariable
	public String requestedCompletionDate;
	@AuraEnabled
	@InvocableVariable
	public String requestedStartDate;
	@AuraEnabled
	@InvocableVariable
	public String startDate;
	@AuraEnabled
	@InvocableVariable
	public String stateChangeDate;
	@AuraEnabled
	@InvocableVariable
	public String version;
	@AuraEnabled
	@InvocableVariable
	public String orderProtocol;
	@AuraEnabled
	@InvocableVariable
	public String recentDefect;
	@AuraEnabled
	@InvocableVariable
	public List<RelatedParty> relatedParty;
	@AuraEnabled
	@InvocableVariable
	public String state;
	@AuraEnabled
	@InvocableVariable
	public List<WorkOrderItem> workOrderItem;
	@AuraEnabled
	@InvocableVariable
	public List<CharacteristicRelationship> workOrderRelationship;
	@AuraEnabled
	@InvocableVariable
	public List<RelatedChannel> relatedChannel;

	// @AuraEnabled
	// @InvocableVariable
	// public Datetime cancellationDate1;
	// @AuraEnabled
	// @InvocableVariable
	// public Datetime completionDate1;
	// @AuraEnabled
	// @InvocableVariable
	// public Datetime expectedCompletionDate1;
	// @AuraEnabled
	// @InvocableVariable
	// public Date orderDate1;
	// @AuraEnabled
	// @InvocableVariable
	// public Datetime requestedCompletionDate1;
	// @AuraEnabled
	// @InvocableVariable
	// public Datetime requestedStartDate1;
	// @AuraEnabled
	// @InvocableVariable
	// public Datetime startDate1;
	// @AuraEnabled
	// @InvocableVariable
	// public Datetime stateChangeDate1;

	public WorkOrder(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'id') {
						id = parser.getText();
					} else if (text == 'cancellationDate') {
						cancellationDate = parser.getText();
						// cancellationDate1 = parser.getDatetimeValue();
					} else if (text == 'cancellationReason') {
						cancellationReason = parser.getText();
					} else if (text == 'category') {
						category = parser.getText();
					} else if (text == 'completionDate') {
						completionDate = parser.getText();
						// completionDate1 = parser.getDatetimeValue();
					} else if (text == 'description') {
						description = parser.getText();
					} else if (text == 'expectedCompletionDate') {
						expectedCompletionDate = parser.getText();
						// expectedCompletionDate1 = parser.getDatetimeValue();
					} else if (text == 'externalId') {
						externalId = parser.getText();
					} else if (text == 'orderDate') {
						orderDate = parser.getText();
						// orderDate1 = parser.getDateValue();
					} else if (text == 'priority') {
						priority = parser.getText();
					} else if (text == 'requestedCompletionDate') {
						requestedCompletionDate = parser.getText();
						// requestedCompletionDate1 = parser.getDatetimeValue();
					} else if (text == 'requestedStartDate') {
						requestedStartDate = parser.getText();
						// requestedStartDate1 = parser.getDatetimeValue();
					} else if (text == 'startDate') {
						startDate = parser.getText();
						// startDate1 = parser.getDatetimeValue();
					} else if (text == 'stateChangeDate') {
						stateChangeDate = parser.getText();
						// stateChangeDate1 = parser.getDatetimeValue();
					} else if (text == 'version') {
						version = parser.getText();
					} else if (text == 'orderProtocol') {
						orderProtocol = parser.getText();
					} else if (text == 'recentDefect') {
						recentDefect = parser.getText();
					} else if (text == 'relatedParty') {
						relatedParty = arrayOfRelatedParty(parser);
					} else if (text == 'state') {
						state = parser.getText();
					} else if (text == 'workOrderItem') {
						workOrderItem = arrayOfWorkOrderItem(parser);
					} else if (text == 'workOrderRelationship') {
						workOrderRelationship = arrayOfCharacteristicRelationship(parser);
					} else if (text == 'relatedChannel') {
						relatedChannel = arrayOfRelatedChannel(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'WorkOrder consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class GeographicAddress {
		@AuraEnabled
		@InvocableVariable
		public String country;
		@AuraEnabled
		@InvocableVariable
		public String city;
		@AuraEnabled
		@InvocableVariable
		public String stateOrProvince;
		@AuraEnabled
		@InvocableVariable 
		public String locality;
		@AuraEnabled
		@InvocableVariable
		public String postcode;
		@AuraEnabled
		@InvocableVariable
		public String streetType;
		@AuraEnabled
		@InvocableVariable
		public String streetPrefix;
		@AuraEnabled
		@InvocableVariable
		public String streetName;
		@AuraEnabled
		@InvocableVariable
		public String streetNr;
		@AuraEnabled
		@InvocableVariable
		public String streetCode;
		@AuraEnabled
		@InvocableVariable
		public String cnl;
		@AuraEnabled
		@InvocableVariable
		public String cnlAcronym;
		@AuraEnabled
		@InvocableVariable
		public String networkOwner;
		@AuraEnabled
		@InvocableVariable 
		public String externalNetworkOwner;
		@AuraEnabled
		@InvocableVariable
		public String telephonicArea;
		@AuraEnabled
		@InvocableVariable
		public String centralOffice;
		@AuraEnabled
		@InvocableVariable
		public String microArea;
		@AuraEnabled
		@InvocableVariable
		public GeographicLocation geographicLocation;

		public GeographicAddress(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'country') {
							country = parser.getText();
						} else if (text == 'city') {
							city = parser.getText();
						} else if (text == 'stateOrProvince') {
							stateOrProvince = parser.getText();
						} else if (text == 'locality') {
							locality = parser.getText();
						} else if (text == 'postcode') {
							postcode = parser.getText();
						} else if (text == 'streetType') {
							streetType = parser.getText();
						} else if (text == 'streetPrefix') {
							streetPrefix = parser.getText();
						} else if (text == 'streetName') {
							streetName = parser.getText();
						} else if (text == 'streetNr') {
							streetNr = parser.getText();
						} else if (text == 'streetCode') {
							streetCode = parser.getText();
						} else if (text == 'cnl') {
							cnl = parser.getText();
						} else if (text == 'cnlAcronym') {
							cnlAcronym = parser.getText();
						} else if (text == 'networkOwner') {
							networkOwner = parser.getText();
						} else if (text == 'externalNetworkOwner') {
							externalNetworkOwner = parser.getText();
						} else if (text == 'telephonicArea') {
							telephonicArea = parser.getText();
						} else if (text == 'centralOffice') {
							centralOffice = parser.getText();
						} else if (text == 'microArea') {
							microArea = parser.getText();
						} else if (text == 'geographicLocation') {
							geographicLocation = new GeographicLocation(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'GeographicAddress consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Msan {
		@AuraEnabled
		@InvocableVariable
		public String objectID;
		@AuraEnabled
		@InvocableVariable
		public ResourceSpecificationCharacteristic ResourceSpecificationCharacteristic;

		public Msan(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'objectID') {
							objectID = parser.getText();
						} else if (text == 'ResourceSpecificationCharacteristic') {
							ResourceSpecificationCharacteristic = new ResourceSpecificationCharacteristic(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Msan consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Work {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String completionDate;
		@AuraEnabled
		@InvocableVariable
		public String scheduledBy;
		@AuraEnabled
		@InvocableVariable
		public String resourceId;
		@AuraEnabled
		@InvocableVariable
		public Boolean canBeAnticipated;
		@AuraEnabled
		@InvocableVariable
		public String description;
		@AuraEnabled
		@InvocableVariable
		public String expectedCompletionDate;
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable
		public String orderDate;
		@AuraEnabled
		@InvocableVariable
		public Integer percentageComplete;
		@AuraEnabled
		@InvocableVariable
		public String workPriority;
		@AuraEnabled
		@InvocableVariable
		public String workType;
		@AuraEnabled
		@InvocableVariable
		public Appointment appointment;
		@AuraEnabled
		@InvocableVariable
		public ValidFor deliveryTimeSlot;
		@AuraEnabled
		@InvocableVariable
		public Quantity quantity;
		@AuraEnabled
		@InvocableVariable
		public String state;
		@AuraEnabled
		@InvocableVariable
		public String stateReason;
		@AuraEnabled
		@InvocableVariable
		public List<WorkCharacteristic> workCharacteristic;
		@AuraEnabled
		@InvocableVariable
		public List<WorkRelationship> workRelationship;
		@AuraEnabled
		@InvocableVariable 
		public List<WorkforceEmployeeAssignment> workforceEmployeeAssignment;
		@AuraEnabled
		@InvocableVariable
		public WorkSpecification workSpecification;
		@AuraEnabled
		@InvocableVariable
		public TechnicianNote technicianNote;
		@AuraEnabled
		@InvocableVariable
		public RelatedParty contact;
		@AuraEnabled
		@InvocableVariable
		public String baseType;
		@AuraEnabled
		@InvocableVariable
		public String type;
		@AuraEnabled
		@InvocableVariable
		public String referredType;

		// @AuraEnabled
		// @InvocableVariable
		// public Datetime completionDate1;
		// @AuraEnabled
		// @InvocableVariable
		// public Datetime expectedCompletionDate1;
		// @AuraEnabled
		// @InvocableVariable
		// public Datetime orderDate1;

		public Work(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'completionDate') {
							completionDate = parser.getText();
							// completionDate1 = parser.getDatetimeValue();
						} else if (text == 'scheduledBy') {
							scheduledBy = parser.getText();
						} else if (text == 'resourceId') {
							resourceId = parser.getText();
						} else if (text == 'canBeAnticipated') {
							canBeAnticipated = parser.getBooleanValue();
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'expectedCompletionDate') {
							expectedCompletionDate = parser.getText();
							// expectedCompletionDate1 = parser.getDatetimeValue();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'orderDate') {
							orderDate = parser.getText();
							// orderDate1 = parser.getDatetimeValue();
						} else if (text == 'percentageComplete') {
							percentageComplete = parser.getIntegerValue();
						} else if (text == 'workPriority') {
							workPriority = parser.getText();
						} else if (text == 'workType') {
							workType = parser.getText();
						} else if (text == 'appointment') {
							appointment = new Appointment(parser);
						} else if (text == 'deliveryTimeSlot') {
							deliveryTimeSlot = new ValidFor(parser);
						} else if (text == 'quantity') {
							quantity = new Quantity(parser);
						} else if (text == 'state') {
							state = parser.getText();
						} else if (text == 'stateReason') {
							stateReason = parser.getText();
						} else if (text == 'workCharacteristic') {
							workCharacteristic = arrayOfWorkCharacteristic(parser);
						} else if (text == 'workRelationship') {
							workRelationship = arrayOfWorkRelationship(parser);
						} else if (text == 'workforceEmployeeAssignment') {
							workforceEmployeeAssignment = arrayOfWorkforceEmployeeAssignment(parser);
						} else if (text == 'workSpecification') {
							workSpecification = new WorkSpecification(parser);
						} else if (text == 'technicianNote') {
							technicianNote = new TechnicianNote(parser);
						} else if (text == 'contact') {
							contact = new RelatedParty(parser);
						} else if (text == 'baseType') {
							baseType = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else if (text == 'referredType') {
							referredType = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Work consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class PlacePhysicalResourceAssoc_Z {
		@AuraEnabled
		@InvocableVariable
		public String positionPhysicalResource;

		public PlacePhysicalResourceAssoc_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'positionPhysicalResource') {
							positionPhysicalResource = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'PlacePhysicalResourceAssoc_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class PhysicalResourceAssociated {
		@AuraEnabled
		@InvocableVariable
		public Integer activityName;
		@AuraEnabled
		@InvocableVariable
		public String physicalResourceSummary;
		@AuraEnabled
		@InvocableVariable
		public PhysicalResource physicalResource;
		@AuraEnabled
		@InvocableVariable
		public Shelf shelf;
		@AuraEnabled
		@InvocableVariable
		public Cabinet cabinet;
		@AuraEnabled
		@InvocableVariable
		public PhysicalDeviceAtomic physicalDeviceAtomic;
		@AuraEnabled
		@InvocableVariable
		public List<Splitter> splitter;
		@AuraEnabled
		@InvocableVariable
		public List<List<TerminalBox>> terminalBox;
		@AuraEnabled
		@InvocableVariable
		public TerminationPoint terminationPoint;

		public PhysicalResourceAssociated(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'activityName') {
							activityName = parser.getIntegerValue();
						} else if (text == 'physicalResourceSummary') {
							physicalResourceSummary = parser.getText();
						} else if (text == 'physicalResource') {
							physicalResource = new PhysicalResource(parser);
						} else if (text == 'shelf') {
							shelf = new Shelf(parser);
						} else if (text == 'cabinet') {
							cabinet = new Cabinet(parser);
						} else if (text == 'physicalDeviceAtomic') {
							physicalDeviceAtomic = new PhysicalDeviceAtomic(parser);
						} else if (text == 'splitter') {
							splitter = arrayOfSplitter(parser);
						} else if (text == 'terminalBox') {
							terminalBox = arrayOfList(parser);
						} else if (text == 'terminationPoint') {
							terminationPoint = new TerminationPoint(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'PhysicalResourceAssociated consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class WorkforceEmployeeAssignment {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String description;
		@AuraEnabled
		@InvocableVariable
		public String documentNumber;
		@AuraEnabled
		@InvocableVariable
		public String contractor;
		@AuraEnabled
		@InvocableVariable
		public String skillType;
		@AuraEnabled
		@InvocableVariable
		public WorkforceEmployee workforceEmployee;
		@AuraEnabled
		@InvocableVariable
		public String baseType;
		@AuraEnabled
		@InvocableVariable
		public String type;

		public WorkforceEmployeeAssignment(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'documentNumber') {
							documentNumber = parser.getText();
						} else if (text == 'contractor') {
							contractor = parser.getText();
						} else if (text == 'skillType') {
							skillType = parser.getText();
						} else if (text == 'workforceEmployee') {
							workforceEmployee = new WorkforceEmployee(parser);
						} else if (text == 'baseType') {
							baseType = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'WorkforceEmployeeAssignment consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class InvolvesDevice {
		@AuraEnabled
		@InvocableVariable
		public PhysicalResourceSpecAttributes physicalResourceSpecAttributes;

		public InvolvesDevice(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'physicalResourceSpecAttributes') {
							physicalResourceSpecAttributes = new PhysicalResourceSpecAttributes(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'InvolvesDevice consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class NetworkAddressAssociation {
		@AuraEnabled
		@InvocableVariable
		public NetworkMask networkMask;

		public NetworkAddressAssociation(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'networkMask') {
							networkMask = new NetworkMask(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'NetworkAddressAssociation consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class NetworkMask {
		@AuraEnabled
		@InvocableVariable
		public String networkMaskType;

		public NetworkMask(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'networkMaskType') {
							networkMaskType = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'NetworkMask consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Splitter {
		@AuraEnabled
		@InvocableVariable
		public ResourceSpecificationCharacteristic resourceSpecCharacteristic;
		@AuraEnabled
		@InvocableVariable
		public ResourceAddress_Z resourceAddress;
		@AuraEnabled
		@InvocableVariable
		public PhysicalLink physicalLink;

		public Splitter(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'resourceSpecCharacteristic') {
							resourceSpecCharacteristic = new ResourceSpecificationCharacteristic(parser);
						} else if (text == 'resourceAddress') {
							resourceAddress = new ResourceAddress_Z(parser);
						} else if (text == 'physicalLink') {
							physicalLink = new PhysicalLink(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Splitter consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class CharacteristicRelationship {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String relationshipType;
		@AuraEnabled
		@InvocableVariable
		public String baseType;
		@AuraEnabled
		@InvocableVariable
		public String type;

		public CharacteristicRelationship(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'relationshipType') {
							relationshipType = parser.getText();
						} else if (text == 'baseType') {
							baseType = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'CharacteristicRelationship consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class WorkRelationship {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String relationshipType;
		@AuraEnabled
		@InvocableVariable
		public String work;
		@AuraEnabled
		@InvocableVariable
		public List<WorkCharacteristic> workRelationshipCharacteristic;
		@AuraEnabled
		@InvocableVariable
		public String baseType;
		@AuraEnabled
		@InvocableVariable
		public String type;

		public WorkRelationship(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'relationshipType') {
							relationshipType = parser.getText();
						} else if (text == 'work') {
							work = parser.getText();
						} else if (text == 'workRelationshipCharacteristic') {
							workRelationshipCharacteristic = arrayOfWorkCharacteristic(parser);
						} else if (text == 'baseType') {
							baseType = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'WorkRelationship consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class HasCards {
		@AuraEnabled
		@InvocableVariable
		public String typeOfResource;
		@AuraEnabled
		@InvocableVariable
		public String horizontalPosition;
		@AuraEnabled
		@InvocableVariable
		public String pinPosition;
		@AuraEnabled
		@InvocableVariable
		public String verticalPosition;
		@AuraEnabled
		@InvocableVariable
		public String technology;

		public HasCards(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'typeOfResource') {
							typeOfResource = parser.getText();
						} else if (text == 'horizontalPosition') {
							horizontalPosition = parser.getText();
						} else if (text == 'pinPosition') {
							pinPosition = parser.getText();
						} else if (text == 'verticalPosition') {
							verticalPosition = parser.getText();
						} else if (text == 'technology') {
							technology = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'HasCards consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Cabinet {
		@AuraEnabled
		@InvocableVariable
		public List<HasShelves> HasShelves;
		@AuraEnabled
		@InvocableVariable
		public List<HasCards> HasCards;
		@AuraEnabled
		@InvocableVariable
		public List<ResourceSpecificationCharacteristic> resourceSpecificationCharacteristic;
		@AuraEnabled
		@InvocableVariable
		public List<List<TerminalBox>> terminalBox;

		public Cabinet(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'HasShelves') {
							HasShelves = arrayOfHasShelves(parser);
						} else if (text == 'HasCards') {
							HasCards = arrayOfHasCards(parser);
						} else if (text == 'resourceSpecificationCharacteristic') {
							resourceSpecificationCharacteristic = arrayOfResourceSpecificationCharacteristic(parser);
						} else if (text == 'terminalBox') {
							terminalBox = arrayOfList(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Cabinet consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ResourceAddress {
		@AuraEnabled
		@InvocableVariable
		public PlacePhysicalResourceAssoc_Z PlacePhysicalResourceAssoc;

		public ResourceAddress(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'PlacePhysicalResourceAssoc') {
							PlacePhysicalResourceAssoc = new PlacePhysicalResourceAssoc_Z(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'ResourceAddress consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class RelatedEntity {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable
		public String role;
		@AuraEnabled
		@InvocableVariable
		public String baseType;
		@AuraEnabled
		@InvocableVariable
		public String type;
		@AuraEnabled
		@InvocableVariable
		public String referredType;

		public RelatedEntity(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'role') {
							role = parser.getText();
						} else if (text == 'baseType') {
							baseType = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else if (text == 'referredType') {
							referredType = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'RelatedEntity consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Characteristic {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String city;
		@AuraEnabled
		@InvocableVariable
		public String contactType;
		@AuraEnabled
		@InvocableVariable
		public String country;
		@AuraEnabled
		@InvocableVariable 
		public String emailAddress;
		@AuraEnabled
		@InvocableVariable
		public String faxNumber;
		@AuraEnabled
		@InvocableVariable
		public String phoneNumber;
		@AuraEnabled
		@InvocableVariable
		public String postCode;
		@AuraEnabled
		@InvocableVariable
		public String socialNetworkId;
		@AuraEnabled
		@InvocableVariable
		public String stateOrProvince;
		@AuraEnabled
		@InvocableVariable
		public String street1;
		@AuraEnabled
		@InvocableVariable
		public String street2;
		@AuraEnabled
		@InvocableVariable
		public String baseType;
		@AuraEnabled
		@InvocableVariable
		public String type;

		public Characteristic(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'city') {
							city = parser.getText();
						} else if (text == 'contactType') {
							contactType = parser.getText();
						} else if (text == 'country') {
							country = parser.getText();
						} else if (text == 'emailAddress') {
							emailAddress = parser.getText();
						} else if (text == 'faxNumber') {
							faxNumber = parser.getText();
						} else if (text == 'phoneNumber') {
							phoneNumber = parser.getText();
						} else if (text == 'postCode') {
							postCode = parser.getText();
						} else if (text == 'socialNetworkId') {
							socialNetworkId = parser.getText();
						} else if (text == 'stateOrProvince') {
							stateOrProvince = parser.getText();
						} else if (text == 'street1') {
							street1 = parser.getText();
						} else if (text == 'street2') {
							street2 = parser.getText();
						} else if (text == 'baseType') {
							baseType = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Characteristic consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class GeographicLocation {
		@AuraEnabled
		@InvocableVariable
		public Double uncertain;
		@AuraEnabled
		@InvocableVariable
		public GeoJson geoJson;

		public GeographicLocation(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'uncertain') {
							uncertain = parser.getDoubleValue();
						} else if (text == 'geoJson') {
							geoJson = new GeoJson(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'GeographicLocation consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Quantity {
		@AuraEnabled
		@InvocableVariable
		public Integer amount;
		@AuraEnabled
		@InvocableVariable
		public String units;

		public Quantity(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'amount') {
							amount = parser.getIntegerValue();
						} else if (text == 'units') {
							units = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Quantity consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ResourceAddress_Z {
		@AuraEnabled
		@InvocableVariable
		public String country;
		@AuraEnabled
		@InvocableVariable
		public String city;
		@AuraEnabled
		@InvocableVariable
		public String stateOrProvince;
		@AuraEnabled
		@InvocableVariable
		public String locality;
		@AuraEnabled
		@InvocableVariable
		public String postcode;
		@AuraEnabled
		@InvocableVariable
		public String streetType;
		@AuraEnabled
		@InvocableVariable
		public String streetPrefix;
		@AuraEnabled
		@InvocableVariable
		public String streetName;
		@AuraEnabled
		@InvocableVariable
		public String streetNr;
		@AuraEnabled
		@InvocableVariable
		public String streetCode;
		@AuraEnabled
		@InvocableVariable
		public String cnl;
		@AuraEnabled
		@InvocableVariable
		public String cnlAcronym;
		@AuraEnabled
		@InvocableVariable
		public String networkOwner;
		@AuraEnabled
		@InvocableVariable
		public String externalNetworkOwner;
		@AuraEnabled
		@InvocableVariable
		public String telephonicArea;
		@AuraEnabled
		@InvocableVariable
		public String centralOffice;
		@AuraEnabled
		@InvocableVariable
		public String microArea;
		@AuraEnabled
		@InvocableVariable
		public GeographicLocation geographicLocation;
		@AuraEnabled
		@InvocableVariable
		public String networkTopology;

		public ResourceAddress_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'country') {
							country = parser.getText();
						} else if (text == 'city') {
							city = parser.getText();
						} else if (text == 'stateOrProvince') {
							stateOrProvince = parser.getText();
						} else if (text == 'locality') {
							locality = parser.getText();
						} else if (text == 'postcode') {
							postcode = parser.getText();
						} else if (text == 'streetType') {
							streetType = parser.getText();
						} else if (text == 'streetPrefix') {
							streetPrefix = parser.getText();
						} else if (text == 'streetName') {
							streetName = parser.getText();
						} else if (text == 'streetNr') {
							streetNr = parser.getText();
						} else if (text == 'streetCode') {
							streetCode = parser.getText();
						} else if (text == 'cnl') {
							cnl = parser.getText();
						} else if (text == 'cnlAcronym') {
							cnlAcronym = parser.getText();
						} else if (text == 'networkOwner') {
							networkOwner = parser.getText();
						} else if (text == 'externalNetworkOwner') {
							externalNetworkOwner = parser.getText();
						} else if (text == 'telephonicArea') {
							telephonicArea = parser.getText();
						} else if (text == 'centralOffice') {
							centralOffice = parser.getText();
						} else if (text == 'microArea') {
							microArea = parser.getText();
						} else if (text == 'geographicLocation') {
							geographicLocation = new GeographicLocation(parser);
						} else if (text == 'networkTopology') {
							networkTopology = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'ResourceAddress_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class WorkCharacteristic {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable
		public String valueType;
		@AuraEnabled
		@InvocableVariable
		public List<CharacteristicRelationship> characteristicRelationship;
		@AuraEnabled
		@InvocableVariable
		public String value;
		@AuraEnabled
		@InvocableVariable
		public String baseType;
		@AuraEnabled
		@InvocableVariable
		public String type;

		public WorkCharacteristic(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'valueType') {
							valueType = parser.getText();
						} else if (text == 'characteristicRelationship') {
							characteristicRelationship = arrayOfCharacteristicRelationship(parser);
						} else if (text == 'value') {
							value = parser.getText();
						} else if (text == 'baseType') {
							baseType = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'WorkCharacteristic consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ValidFor {
		@AuraEnabled
		@InvocableVariable
		public String endDateTime;
		@AuraEnabled
		@InvocableVariable
		public String startDateTime;

		// @AuraEnabled
		// @InvocableVariable
		// public Datetime endDateTime1;
		// @AuraEnabled
		// @InvocableVariable
		// public Datetime startDateTime1;

		public ValidFor(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'endDateTime') {
							endDateTime = parser.getText();
							// endDateTime1 = parser.getDatetimeValue();
						} else if (text == 'startDateTime') {
							startDateTime = parser.getText();
							// startDateTime1 = parser.getDatetimeValue();
						} else {
							System.debug(LoggingLevel.WARN, 'ValidFor consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class RelatedChannel {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable
		public String role;

		public RelatedChannel(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'role') {
							role = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'RelatedChannel consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class WorkSpecCharacteristicValue {
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable
		public Boolean value;

		public WorkSpecCharacteristicValue(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();
						} else if (text == 'value') {
							value = parser.getBooleanValue();
						} else {
							System.debug(LoggingLevel.WARN, 'WorkSpecCharacteristicValue consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class WorkforceEmployee {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable
		public List<ContactMedium> contactMedium;

		public WorkforceEmployee(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'contactMedium') {
							contactMedium = arrayOfContactMedium(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'WorkforceEmployee consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class PhysicalLink {
		@AuraEnabled
		@InvocableVariable
		public String chargerCableNumber;
		@AuraEnabled
		@InvocableVariable
		public Integer chargerSideCableNumber;
		@AuraEnabled
		@InvocableVariable
		public String distributorCableNumber;

		public PhysicalLink(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'chargerCableNumber') {
							chargerCableNumber = parser.getText();
						} else if (text == 'chargerSideCableNumber') {
							chargerSideCableNumber = parser.getIntegerValue();
						} else if (text == 'distributorCableNumber') {
							distributorCableNumber = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'PhysicalLink consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class PhysicalResourceSpecAttributes {
		@AuraEnabled
		@InvocableVariable
		public String modelNumber;
		@AuraEnabled
		@InvocableVariable
		public String partNumber;
		@AuraEnabled
		@InvocableVariable
		public String skuNumber;
		@AuraEnabled
		@InvocableVariable
		public String vendorName;
		@AuraEnabled
		@InvocableVariable
		public String status;
		@AuraEnabled
		@InvocableVariable
		public String macaddress;
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable
		public String category;

		public PhysicalResourceSpecAttributes(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'modelNumber') {
							modelNumber = parser.getText();
						} else if (text == 'partNumber') {
							partNumber = parser.getText();
						} else if (text == 'skuNumber') {
							skuNumber = parser.getText();
						} else if (text == 'vendorName') {
							vendorName = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'macaddress') {
							macaddress = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'category') {
							category = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'PhysicalResourceSpecAttributes consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class PhysicalDeviceAtomic {
		@AuraEnabled
		@InvocableVariable
		public ResourceSpecificationCharacteristic resourceSpecificationCharacteristic;
		@AuraEnabled
		@InvocableVariable
		public ResourceAddress resourceAddress;
		@AuraEnabled
		@InvocableVariable
		public String accessTecnology;
		@AuraEnabled
		@InvocableVariable
		public String model;
		@AuraEnabled
		@InvocableVariable
		public String manufacturer;
		@AuraEnabled
		@InvocableVariable
		public String networkPlatformIp;
		@AuraEnabled
		@InvocableVariable
		public String plusStaticIp;
		@AuraEnabled
		@InvocableVariable
		public Integer portSND;
		@AuraEnabled
		@InvocableVariable
		public Integer opticalTerminalCode;
		@AuraEnabled
		@InvocableVariable
		public String type;
		@AuraEnabled
		@InvocableVariable
		public String classification;
		@AuraEnabled
		@InvocableVariable
		public NetworkAddressAssociation networkAddressAssociation;

		public PhysicalDeviceAtomic(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'resourceSpecificationCharacteristic') {
							resourceSpecificationCharacteristic = new ResourceSpecificationCharacteristic(parser);
						} else if (text == 'resourceAddress') {
							resourceAddress = new ResourceAddress(parser);
						} else if (text == 'accessTecnology') {
							accessTecnology = parser.getText();
						} else if (text == 'model') {
							model = parser.getText();
						} else if (text == 'manufacturer') {
							manufacturer = parser.getText();
						} else if (text == 'networkPlatformIp') {
							networkPlatformIp = parser.getText();
						} else if (text == 'plusStaticIp') {
							plusStaticIp = parser.getText();
						} else if (text == 'portSND') {
							portSND = parser.getIntegerValue();
						} else if (text == 'opticalTerminalCode') {
							opticalTerminalCode = parser.getIntegerValue();
						} else if (text == 'type') {
							type = parser.getText();
						} else if (text == 'classification') {
							classification = parser.getText();
						} else if (text == 'networkAddressAssociation') {
							networkAddressAssociation = new NetworkAddressAssociation(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'PhysicalDeviceAtomic consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class OrderItem {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String action;
		@AuraEnabled
		@InvocableVariable
		public String provisioningCode;
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable
		public Boolean portability;
		@AuraEnabled
		@InvocableVariable
		public String status;
		@AuraEnabled
		@InvocableVariable
		public String pon;
		@AuraEnabled
		@InvocableVariable
		public LogicalResourceAssociated logicalResourceAssociated;
		@AuraEnabled
		@InvocableVariable
		public String type;
		@AuraEnabled
		@InvocableVariable
		public String referredType;

		public OrderItem(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'action') {
							action = parser.getText();
						} else if (text == 'provisioningCode') {
							provisioningCode = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'portability') {
							portability = parser.getBooleanValue();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'pon') {
							pon = parser.getText();
						} else if (text == 'logicalResourceAssociated') {
							logicalResourceAssociated = new LogicalResourceAssociated(parser);
						} else if (text == 'type') {
							type = parser.getText();
						} else if (text == 'referredType') {
							referredType = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'OrderItem consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class RelatedParty {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable
		public String documentNumber;
		@AuraEnabled
		@InvocableVariable
		public String category;
		@AuraEnabled
		@InvocableVariable
		public String role;
		@AuraEnabled
		@InvocableVariable
		public String referredType;
		@AuraEnabled
		@InvocableVariable
		public List<ContactMedium> contactMedium;

		public RelatedParty(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'documentNumber') {
							documentNumber = parser.getText();
						} else if (text == 'category') {
							category = parser.getText();
						} else if (text == 'role') {
							role = parser.getText();
						} else if (text == 'referredType') {
							referredType = parser.getText();
						} else if (text == 'contactMedium') {
							contactMedium = arrayOfContactMedium(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'RelatedParty consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class WorkSpecification {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable
		public String type;

		public WorkSpecification(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'WorkSpecification consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class TechnicianNote {
		@AuraEnabled
		@InvocableVariable
		public List<String> id;
		@AuraEnabled
		@InvocableVariable
		public List<String> author;
		@AuraEnabled
		@InvocableVariable 
		public List<String> date_Z;
		@AuraEnabled
		@InvocableVariable
		public List<String> text;

		public TechnicianNote(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String texto = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (texto == 'id') {
							id = arrayOfString(parser);
						} else if (texto == 'author') {
							author = arrayOfString(parser);
						} else if (texto == 'date') {
							date_Z = arrayOfString(parser);
						} else if (texto == 'text') {
							text = arrayOfString(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'TechnicianNote consuming unrecognized property: '+texto);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ServiceProblemAssociated {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String creationDate;

		// @AuraEnabled
		// @InvocableVariable
		// public Datetime creationDate1;
		
		public ServiceProblemAssociated(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'creationDate') {
							creationDate = parser.getText();
							// creationDate1 = parser.getDatetimeValue();
						} else {
							System.debug(LoggingLevel.WARN, 'ServiceProblemAssociated consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class PlacePhysicalResourceAssoc {
		@AuraEnabled
		@InvocableVariable
		public List<ResourceSpecificationCharacteristic> resourceSpecificationCharacteristic;

		public PlacePhysicalResourceAssoc(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'resourceSpecificationCharacteristic') {
							resourceSpecificationCharacteristic = arrayOfResourceSpecificationCharacteristic(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'PlacePhysicalResourceAssoc consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Place {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String name;
		@AuraEnabled
		@InvocableVariable
		public PlacePhysicalResourceAssoc placePhysicalResourceAssoc;
		@AuraEnabled
		@InvocableVariable
		public String type;
		@AuraEnabled
		@InvocableVariable
		public String referredType;
		@AuraEnabled
		@InvocableVariable
		public GeographicAddress geographicAddress;

		public Place(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'name') {
							name = parser.getText();
						} else if (text == 'placePhysicalResourceAssoc') {
							placePhysicalResourceAssoc = new PlacePhysicalResourceAssoc(parser);
						} else if (text == 'type') {
							type = parser.getText();
						} else if (text == 'referredType') {
							referredType = parser.getText();
						} else if (text == 'geographicAddress') {
							geographicAddress = new GeographicAddress(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Place consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class TerminationPoint {
		@AuraEnabled
		@InvocableVariable
		public Integer networkId;
		@AuraEnabled
		@InvocableVariable
		public String multicastId;
		@AuraEnabled
		@InvocableVariable
		public Integer unicastId;
		@AuraEnabled
		@InvocableVariable
		public Integer audienceId;
		@AuraEnabled
		@InvocableVariable
		public Integer clientId;
		@AuraEnabled
		@InvocableVariable
		public String ipGateway;

		public TerminationPoint(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'networkId') {
							networkId = parser.getIntegerValue();
						} else if (text == 'multicastId') {
							multicastId = parser.getText();
						} else if (text == 'unicastId') {
							unicastId = parser.getIntegerValue();
						} else if (text == 'audienceId') {
							audienceId = parser.getIntegerValue();
						} else if (text == 'clientId') {
							clientId = parser.getIntegerValue();
						} else if (text == 'ipGateway') {
							ipGateway = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'TerminationPoint consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class WorkOrderItem {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String description;
		@AuraEnabled
		@InvocableVariable
		public String action;
		@AuraEnabled
		@InvocableVariable
		public Place place;
		@AuraEnabled
		@InvocableVariable
		public List<OrderItem> orderItem;
		@AuraEnabled
		@InvocableVariable
		public List<RelatedEntity> relatedEntity;
		@AuraEnabled
		@InvocableVariable
		public String state;
		@AuraEnabled
		@InvocableVariable
		public String stateReason;
		@AuraEnabled
		@InvocableVariable
		public List<Work> work;
		@AuraEnabled
		@InvocableVariable
		public String sequence;
		@AuraEnabled
		@InvocableVariable
		public List<WorkSpecCharacteristicValue> workSpecCharacteristicValue;
		@AuraEnabled
		@InvocableVariable
		public InvolvesDevice involvesDevice;
		@AuraEnabled
		@InvocableVariable
		public ServiceProblemAssociated serviceProblemAssociated;
		@AuraEnabled
		@InvocableVariable
		public List<WorkOrderItemRelationship> workOrderItemRelationship;
		@AuraEnabled
		@InvocableVariable
		public String baseType;
		@AuraEnabled
		@InvocableVariable
		public String type;

		public WorkOrderItem(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'action') {
							action = parser.getText();
						} else if (text == 'place') {
							place = new Place(parser);
						} else if (text == 'orderItem') {
							orderItem = arrayOfOrderItem(parser);
						} else if (text == 'relatedEntity') {
							relatedEntity = arrayOfRelatedEntity(parser);
						} else if (text == 'state') {
							state = parser.getText();
						} else if (text == 'stateReason') {
							stateReason = parser.getText();
						} else if (text == 'work') {
							work = arrayOfWork(parser);
						} else if (text == 'sequence') {
							sequence = parser.getText();
						} else if (text == 'workSpecCharacteristicValue') {
							workSpecCharacteristicValue = arrayOfWorkSpecCharacteristicValue(parser);
						} else if (text == 'involvesDevice') {
							involvesDevice = new InvolvesDevice(parser);
						} else if (text == 'serviceProblemAssociated') {
							serviceProblemAssociated = new ServiceProblemAssociated(parser);
						} else if (text == 'workOrderItemRelationship') {
							workOrderItemRelationship = arrayOfWorkOrderItemRelationship(parser);
						} else if (text == 'baseType') {
							baseType = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'WorkOrderItem consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class WorkOrderItemRelationship {
		@AuraEnabled
		@InvocableVariable
		public String id;
		@AuraEnabled
		@InvocableVariable
		public String relationshipType;
		@AuraEnabled
		@InvocableVariable
		public String baseType;
		@AuraEnabled
		@InvocableVariable
		public String type;
		@AuraEnabled
		@InvocableVariable
		public PhysicalResourceAssociated physicalResourceAssociated;

		public WorkOrderItemRelationship(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'relationshipType') {
							relationshipType = parser.getText();
						} else if (text == 'baseType') {
							baseType = parser.getText();
						} else if (text == 'type') {
							type = parser.getText();
						} else if (text == 'physicalResourceAssociated') {
							physicalResourceAssociated = new PhysicalResourceAssociated(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'WorkOrderItemRelationship consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static WorkOrder parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new WorkOrder(parser);
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
	
    private static List<ContactMedium> arrayOfContactMedium(System.JSONParser p) {
        List<ContactMedium> res = new List<ContactMedium>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new ContactMedium(p));
        }
        return res;
    }

    private static List<WorkforceEmployeeAssignment> arrayOfWorkforceEmployeeAssignment(System.JSONParser p) {
        List<WorkforceEmployeeAssignment> res = new List<WorkforceEmployeeAssignment>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new WorkforceEmployeeAssignment(p));
        }
        return res;
    }

    private static List<Integer> arrayOfInteger(System.JSONParser p) {
        List<Integer> res = new List<Integer>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(p.getIntegerValue());
        }
        return res;
    }

    private static List<OrderItem> arrayOfOrderItem(System.JSONParser p) {
        List<OrderItem> res = new List<OrderItem>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new OrderItem(p));
        }
        return res;
    }

    private static List<WorkCharacteristic> arrayOfWorkCharacteristic(System.JSONParser p) {
        List<WorkCharacteristic> res = new List<WorkCharacteristic>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new WorkCharacteristic(p));
        }
        return res;
    }

    private static List<ResourceSpecificationCharacteristic> arrayOfResourceSpecificationCharacteristic(System.JSONParser p) {
        List<ResourceSpecificationCharacteristic> res = new List<ResourceSpecificationCharacteristic>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new ResourceSpecificationCharacteristic(p));
        }
        return res;
    }

    private static List<Work> arrayOfWork(System.JSONParser p) {
        List<Work> res = new List<Work>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Work(p));
        }
        return res;
    }

    private static List<RelatedChannel> arrayOfRelatedChannel(System.JSONParser p) {
        List<RelatedChannel> res = new List<RelatedChannel>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new RelatedChannel(p));
        }
        return res;
    }

	private static List<WorkRelationship> arrayOfWorkRelationship(System.JSONParser p) {
        List<WorkRelationship> res = new List<WorkRelationship>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new WorkRelationship(p));
        }
        return res;
    }

    private static List<Splitter> arrayOfSplitter(System.JSONParser p) {
        List<Splitter> res = new List<Splitter>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Splitter(p));
        }
        return res;
    }

	private static List<List<TerminalBox>> arrayOfList(System.JSONParser p) {
        List<List<TerminalBox>> res = new List<List<TerminalBox>>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(arrayOfTerminalBox(p));
        }
        return res;
    }

    private static List<CharacteristicRelationship> arrayOfCharacteristicRelationship(System.JSONParser p) {
        List<CharacteristicRelationship> res = new List<CharacteristicRelationship>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new CharacteristicRelationship(p));
        }
        return res;
    }

    private static List<HasShelves> arrayOfHasShelves(System.JSONParser p) {
        List<HasShelves> res = new List<HasShelves>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new HasShelves(p));
        }
        return res;
    }

    private static List<HasCards> arrayOfHasCards(System.JSONParser p) {
        List<HasCards> res = new List<HasCards>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new HasCards(p));
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

    private static List<RelatedParty> arrayOfRelatedParty(System.JSONParser p) {
        List<RelatedParty> res = new List<RelatedParty>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new RelatedParty(p));
        }
        return res;
    }

    private static List<TerminalBox> arrayOfTerminalBox(System.JSONParser p) {
        List<TerminalBox> res = new List<TerminalBox>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new TerminalBox(p));
        }
        return res;
    }

    private static List<WorkSpecCharacteristicValue> arrayOfWorkSpecCharacteristicValue(System.JSONParser p) {
        List<WorkSpecCharacteristicValue> res = new List<WorkSpecCharacteristicValue>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new WorkSpecCharacteristicValue(p));
        }
        return res;
    }

    private static List<WorkOrderItemRelationship> arrayOfWorkOrderItemRelationship(System.JSONParser p) {
        List<WorkOrderItemRelationship> res = new List<WorkOrderItemRelationship>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new WorkOrderItemRelationship(p));
        }
        return res;
    }

    private static List<WorkOrderItem> arrayOfWorkOrderItem(System.JSONParser p) {
        List<WorkOrderItem> res = new List<WorkOrderItem>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new WorkOrderItem(p));
        }
        return res;
    }

    private static List<RelatedEntity> arrayOfRelatedEntity(System.JSONParser p) {
        List<RelatedEntity> res = new List<RelatedEntity>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new RelatedEntity(p));
        }
        return res;
    }



}