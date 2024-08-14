public with sharing class CustomerProblemManagementController {

    public class Filter {
        @InvocableVariable
        public String customerId;
        @InvocableVariable
        public Date startDate;
        @InvocableVariable
        public Date endDate;
    }

    @InvocableMethod(label='Customer Management Controller' description='Utilizado para buscar os Casos de um cliente Amdocs')
    public static List<List<CaseAmdocs>> findByCustomerId(List<Filter> filter) {
        List<CaseAmdocs> problems = CustomerProblemManagementService.findByCustomerId(filter[0].customerId, filter[0].startDate, filter[0].endDate);
        return new List<List<CaseAmdocs>> { problems };
    }
}