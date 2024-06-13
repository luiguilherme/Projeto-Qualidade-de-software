public with sharing class BillingCycleManagementController {
    public class BillingCycleFilter{
        @InvocableVariable
        public String accountId;
        @InvocableVariable
        public String serviceId;
        @InvocableVariable 
        public Boolean triggeredByCustomer; 
        @InvocableVariable
        public Datetime startDate; 
        @InvocableVariable
        public Datetime endDate;
    }

    public class BillingCycleResponse{
        @InvocableVariable
        public Boolean response;
    }

    @InvocableMethod(label='Billing Cycle Management Controller' description='Classe utilizada verificar se a data vencimento foi alterada')
    public static List<BillingCycleResponse> checkChangeOnDueDate(List<BillingCycleFilter> filterList){
        System.debug('filterList no checkChangeOnDueDate: ' + json.serialize(filterList));
        Boolean result = BillingCycleManagementService.findByFilter(filterList[0].accountId, filterList[0].serviceId, filterList[0].triggeredByCustomer, filterList[0].startDate, filterList[0].endDate);
 
        BillingCycleResponse bcr = new BillingCycleResponse();
        bcr.response = result;
        
        return new List<BillingCycleResponse> { bcr };
    }
}