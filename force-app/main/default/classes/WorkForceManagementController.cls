public without sharing class WorkForceManagementController {

    public class WorkForceManagementFilter {
        @InvocableVariable
        public String id;
    }

    public class Response{
        @InvocableVariable
        public WorkOrderObject workOrderObject;
    }

    @InvocableMethod(label='Work Order Management Controller' description='Classe utilizada para a busca de atividades de campo a partir de um id')
    public static List<Response> findById(List<WorkForceManagementFilter> filters) {
        List<WorkOrderItemObject> woItens = new List<WorkOrderItemObject>();
        
        WorkOrder workOrder = WorkForceManagementService.findById(filters[0].id);

        System.debug('workOrder: ' + workOrder != null ? JSON.serialize(workOrder) : 'null');

        List<Response> workOrders = new List<Response>();
        Response response = new Response();

        if (workOrder != null && workOrder.workOrderItem != null) {
            for (WorkOrder.WorkOrderItem item : workOrder.workOrderItem) {
                WorkOrderItemObject woItem = new WorkOrderItemObject();
                woItem.id = item.id;
                woItem.state = item.state;
                woItem.stateReason = item.stateReason;
                woItem.country = item.place.geographicAddress.country;
                woItem.city = item.place.geographicAddress.city;
                woItem.stateOrProvince = item.place.geographicAddress.stateOrProvince;
                woItem.locality = item.place.geographicAddress.locality;
                woItem.postcode = item.place.geographicAddress.postcode;
                woItem.streetType = item.place.geographicAddress.streetType;
                woItem.streetPrefix = item.place.geographicAddress.streetPrefix;
                woItem.streetName = item.place.geographicAddress.streetName;
                woItem.streetNr = item.place.geographicAddress.streetNr;
                woItem.streetCode = item.place.geographicAddress.streetCode;
                woItem.cnl = item.place.geographicAddress.cnl;
                woItem.networkOwner = item.place.geographicAddress.networkOwner;
                woItem.externalNetworkOwner = item.place.geographicAddress.externalNetworkOwner;
                woItem.telephonicArea = item.place.geographicAddress.telephonicArea;
                woItem.centralOffice = item.place.geographicAddress.centralOffice;
                woItem.microArea = item.place.geographicAddress.microArea;

                for(WorkOrder.Work work: item.work) {
                    woItem.workSpecification = work.workSpecification.name;
                    woItem.appointmentId = work.appointment.id;
                    woItem.appointmentDescription = work.appointment.description;

                    String stringStartDateTime = work.appointment.deliveryTimeSlot.startDateTime;
                    String stringEndDateTime = work.appointment.deliveryTimeSlot.endDateTime;
                    Datetime dtStartDateTime = Datetime.valueOf(stringStartDateTime.replace('T', ' '));
                    Datetime dtEndDateTime = Datetime.valueOf(stringEndDateTime.replace('T', ' '));

                    woItem.appointmentStartDateTime = dtStartDateTime;
                    woItem.appointmentEndDateTime = dtEndDateTime;
                    woItem.appointmentState = work.state;
                }

                woItens.add(woItem);
            }

            WorkOrderObject wo = new WorkOrderObject();
            wo.id = workOrder.id;
            wo.orderProtocol = workOrder.orderProtocol;

            String stringOrderDate = workOrder.orderDate;
            Date dOrderDate = Date.valueOf(stringOrderDate);

            wo.orderDate = dOrderDate;

            for(WorkOrder.RelatedParty party: workOrder.relatedParty) {
                wo.documentNumber = party.documentNumber;
                wo.name = party.name;
            }

            String stringComplitionDate = workOrder.completionDate;
            Datetime dtComplitionDate = String.isNotBlank(stringComplitionDate) ? Datetime.valueOf(stringComplitionDate.replace('T', ' ')) : null;
            String stringCancellationDate = workOrder.cancellationDate;
            Datetime dtCancellationDate = String.isNotBlank(stringCancellationDate) ? Datetime.valueOf(stringCancellationDate.replace('T', ' ')) : null;

            wo.completionDate = dtComplitionDate;
            wo.cancellationDate = dtCancellationDate;
            wo.category = workOrder.category;
            wo.items = woItens;

            response.workOrderObject = wo;
        }

        workOrders.add(response);

        return workOrders;
    }

}