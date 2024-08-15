public with sharing class WorkForceManagementService {

    public static WorkOrder findById(String id) {
        WorkOrder workOrder = WorkForceManagementFacade.findById(id);
        return workOrder;
    }
}