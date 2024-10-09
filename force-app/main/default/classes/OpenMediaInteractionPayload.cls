public with sharing class OpenMediaInteractionPayload
{
    public String action;
    public String caseId;
    public String protocolNumber;
    public CustomerWrapper customer;
    public CustomerInteractionWrapper customerInteraction;
    public EmployeeIdentificationWrapper employeeIdentification;
    public ProductWrapper product;
    public PolicyApplicationWrapper policyApplication;

    public class CustomerWrapper
    {
        public String documentNumber;
        public String documentType;
        public String customerId;
        public String customerSegment;
        public String customerRank;
    }

    public class CustomerInteractionWrapper
    {
        public String interactionReason;
        public String interactionDetail;
    }

    public class ProductWrapper
    {
        public ProductCharacteristicWrapper productCharacteristic;
        public ProductSpecificationWrapper productSpecification;
    }

    public class ProductCharacteristicWrapper
    {
        public String type;
        public String subType;
        public String technology;
    }

    public class ProductSpecificationWrapper
    {
        public String name;
    }

    public class PolicyApplicationWrapper
    {
        public String systemId;
        public String systemIdInteraction;
    }

    public class EmployeeIdentificationWrapper 
    {
        public String employeeNr;
    }

}