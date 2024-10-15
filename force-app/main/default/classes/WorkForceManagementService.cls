public with sharing class WorkForceManagementService {
    public static WorkOrder findById(String id) {
        if (String.isBlank(id)) {
            throw new IllegalArgumentException('O Id da Work Order não pode ser nulo ou vazio!');
        }
        return WorkForceManagementFacade.findById(id);
    }
}