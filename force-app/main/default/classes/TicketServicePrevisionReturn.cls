/* 
	API Documentation
	https://wikicorp.telefonica.com.br/pages/viewpage.action?pageId=149980155
  * @date 31/05/2021
*/

public class TicketServicePrevisionReturn {

	public class WorkRequiresAppointment {
		public AppointmentIsAssociatedWithCalendarEntry appointmentIsAssociatedWithCalendarEntry {get;set;} 

		public WorkRequiresAppointment(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'appointmentIsAssociatedWithCalendarEntry') {
							appointmentIsAssociatedWithCalendarEntry = new AppointmentIsAssociatedWithCalendarEntry(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'WorkRequiresAppointment consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
public class AppointmentIsAssociatedWithCalendarEntry {
		public TimePeriod timePeriod {get;set;} 

		public AppointmentIsAssociatedWithCalendarEntry(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'timePeriod') {
							timePeriod = new TimePeriod(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'AppointmentIsAssociatedWithCalendarEntry consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class WorkOrder {
		public List<WorkOrderComprisedOf> WorkOrderComprisedOf {get;set;} 
		public String Id {get;set;} 

		public WorkOrder(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'WorkOrderComprisedOf') {
							WorkOrderComprisedOf = arrayOfWorkOrderComprisedOf(parser);
						} else if (text == 'Id') {
							Id = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'WorkOrder consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public WorkOrder workOrder {get;set;} 

	public TicketServicePrevisionReturn(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'workOrder') {
						workOrder = new WorkOrder(parser);
					}
				}
			}
		}
	}
	
	public class TimePeriod {
		public String endDateTime {get;set;} 

		public TimePeriod(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'endDateTime') {
							endDateTime = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'TimePeriod consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class WorkOrderComprisedOf {
		public List<WorkOrderItemInvolvesWork> WorkOrderItemInvolvesWork {get;set;} 
		public String ID {get;set;} 
		public String status {get;set;} 

		public WorkOrderComprisedOf(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'WorkOrderItemInvolvesWork') {
							WorkOrderItemInvolvesWork = arrayOfWorkOrderItemInvolvesWork(parser);
						} else if (text == 'ID') {
							ID = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'WorkOrderComprisedOf consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class WorkOrderItemInvolvesWork {
		public WorkRequiresAppointment WorkRequiresAppointment {get;set;} 
		public String ID {get;set;} 
		public String status {get;set;} 

		public WorkOrderItemInvolvesWork(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'WorkRequiresAppointment') {
							WorkRequiresAppointment = new WorkRequiresAppointment(parser);
						} else if (text == 'ID') {
							ID = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'WorkOrderItemInvolvesWork consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public static TicketServicePrevisionReturn parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new TicketServicePrevisionReturn(parser);
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

    private static List<WorkOrderComprisedOf> arrayOfWorkOrderComprisedOf(System.JSONParser p) {
        List<WorkOrderComprisedOf> res = new List<WorkOrderComprisedOf>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new WorkOrderComprisedOf(p));
        }
        return res;
    }

    private static List<WorkOrderItemInvolvesWork> arrayOfWorkOrderItemInvolvesWork(System.JSONParser p) {
        List<WorkOrderItemInvolvesWork> res = new List<WorkOrderItemInvolvesWork>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new WorkOrderItemInvolvesWork(p));
        }
        return res;
    }
}