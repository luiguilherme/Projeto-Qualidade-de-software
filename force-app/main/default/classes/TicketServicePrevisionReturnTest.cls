@IsTest
public class TicketServicePrevisionReturnTest {

	static testMethod void testParse() {
		String json = '{'+
		'	\"workOrder\": {'+
		'		\"WorkOrderComprisedOf\": [{'+
		'				\"WorkOrderItemInvolvesWork\": [{'+
		'						\"WorkRequiresAppointment\": {'+
		'							\"appointmentIsAssociatedWithCalendarEntry\": {'+
		'								\"timePeriod\": {'+
		'									\"endDateTime\": \"2021-06-11T16:04:00.0-03:00\"'+
		'								}'+
		'							}'+
		'						},'+
		'						\"ID\": \"137974005\",'+
		'						\"status\": \"Agendado\"'+
		'					}'+
		'				],'+
		'				\"ID\": \"8-GXSOYND:C0015198EA\",'+
		'				\"status\": \"Agendada\"'+
		'			}'+
		'		],'+
		'		\"Id\": \"8-GXSOYND\"'+
		'	}'+
		'}';
		TicketServicePrevisionReturn r = TicketServicePrevisionReturn.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		TicketServicePrevisionReturn.WorkRequiresAppointment objWorkRequiresAppointment = new TicketServicePrevisionReturn.WorkRequiresAppointment(System.JSON.createParser(json));
		System.assert(objWorkRequiresAppointment != null);
		System.assert(objWorkRequiresAppointment.appointmentIsAssociatedWithCalendarEntry == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		TicketServicePrevisionReturn.AppointmentIsAssociatedWithCalendarEntry objAppointmentIsAssociatedWithCalendarEntry = new TicketServicePrevisionReturn.AppointmentIsAssociatedWithCalendarEntry(System.JSON.createParser(json));
		System.assert(objAppointmentIsAssociatedWithCalendarEntry != null);
		System.assert(objAppointmentIsAssociatedWithCalendarEntry.timePeriod == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		TicketServicePrevisionReturn.WorkOrder objWorkOrder = new TicketServicePrevisionReturn.WorkOrder(System.JSON.createParser(json));
		System.assert(objWorkOrder != null);
		System.assert(objWorkOrder.WorkOrderComprisedOf == null);
		System.assert(objWorkOrder.Id == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		TicketServicePrevisionReturn objTicketServicePrevisionReturn = new TicketServicePrevisionReturn(System.JSON.createParser(json));
		System.assert(objTicketServicePrevisionReturn != null);
		System.assert(objTicketServicePrevisionReturn.workOrder == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		TicketServicePrevisionReturn.TimePeriod objTimePeriod = new TicketServicePrevisionReturn.TimePeriod(System.JSON.createParser(json));
		System.assert(objTimePeriod != null);
		System.assert(objTimePeriod.endDateTime == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		TicketServicePrevisionReturn.WorkOrderComprisedOf objWorkOrderComprisedOf = new TicketServicePrevisionReturn.WorkOrderComprisedOf(System.JSON.createParser(json));
		System.assert(objWorkOrderComprisedOf != null);
		System.assert(objWorkOrderComprisedOf.WorkOrderItemInvolvesWork == null);
		System.assert(objWorkOrderComprisedOf.ID == null);
		System.assert(objWorkOrderComprisedOf.status == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		TicketServicePrevisionReturn.WorkOrderItemInvolvesWork objWorkOrderItemInvolvesWork = new TicketServicePrevisionReturn.WorkOrderItemInvolvesWork(System.JSON.createParser(json));
		System.assert(objWorkOrderItemInvolvesWork != null);
		System.assert(objWorkOrderItemInvolvesWork.WorkRequiresAppointment == null);
		System.assert(objWorkOrderItemInvolvesWork.ID == null);
		System.assert(objWorkOrderItemInvolvesWork.status == null);
	}
}