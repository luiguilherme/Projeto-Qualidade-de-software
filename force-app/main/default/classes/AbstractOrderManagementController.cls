public abstract class AbstractOrderManagementController {
    public class RetrieveOrdersListFilter {
        @InvocableVariable
        public String customerAccountId;
        @InvocableVariable
        public Date startDate;
        @InvocableVariable
        public Date endDate;
        @InvocableVariable
        public String serviceId;
        @InvocableVariable
        public List<String> status;
        @InvocableVariable
        public List<String> types;
    }

    public class RetrieveOrdersListResponse {
        @InvocableVariable
        public Orders order;
    }
}