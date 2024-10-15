public with sharing class OpenMediaInteractionPayload
{
    public String action;
    public String agent;
    public String priority;
    public String caseId;
    public String protocolNumber;
    public CustomerWrapper customer;
    public CustomerInteractionWrapper customerInteraction;
    public ProductWrapper product;
    public PolicyApplicationWrapper policyApplication;
    public EmployeeIdentificationWrapper employeeIdentification;
    public ContactMediumWrapper contactMedium;
    public GeographicAreaWrapper geographicArea;
    public UrbanPropertyAddressWrapper urbanPropertyAddress;
    public GeographicAddressWrapper geographicAddress;

    public class CustomerWrapper
    {
        public String documentNumber;
        public String documentType;
        public String customerId;
        public String customerSegment;
        public String customerSubSegment;
        public String customerRank;
    }

    public class CustomerInteractionWrapper
    {
        public String interactionReason;
        public String interactionDetail;
    }

    public class ProductWrapper
    {
        public String id;
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
        public String employeeData;
    }

    public class ContactMediumWrapper
    { 
        public String phoneNumber;
        public String whatsappNumber;
        public String emailAddress;
    }

    public class GeographicAreaWrapper
    {
        public String code;
    }

    public class UrbanPropertyAddressWrapper
    {
        public String nameCity;
        public String postalCode;
    }

    public class GeographicAddressWrapper
    {
        public String stateOrProvinceAbbreviation;
    }
}
