public with sharing class BillingCycleManagementService {
    public static Boolean findByFilter(String accountId, String serviceId, Boolean triggeredByCustomer, Datetime startDate, Datetime endDate){
        // String accountId = SearchCustomerKeysFacade.getIAccountIdByServiceId(serviceId);
        // Boolean triggeredByCustomer = true;

        RetrieveBillCycleListForCustomerResponse response = RetrieveBillCycleListForCustomerFacade.findByFilters(accountId, triggeredByCustomer, startDate, endDate);

        String customerBillingCycleSpecificationid = '';
        Boolean result = false;

        for(RetrieveBillCycleListForCustomerResponse.BillingCycle bCycle : response.billingCycles.billingCycle){
            if(customerBillingCycleSpecificationid == ''){
                customerBillingCycleSpecificationid = bCycle.customerBillingCycleSpecification.id;
            }else if(customerBillingCycleSpecificationid != bCycle.customerBillingCycleSpecification.id){
                customerBillingCycleSpecificationid = bCycle.customerBillingCycleSpecification.id;
                result = true;
            }
        }

        return result;
    }
}