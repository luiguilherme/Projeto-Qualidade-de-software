public with sharing class DocumentRepositoryResponse {
    public DataWrapper data;

    public class DataWrapper {
        public String protocol;
        public String cod;
        public CustomerWrapper customer;
    }

    public class CustomerWrapper {
        public String documentNumber;
        public String document;
    }
}