public class ProspectManagementWrapper {
    
    public Prospect prospect;
    
    public class Prospect {
        public string firstName;
        public String lastName;
        public String motherName;
        public String birthDate;
        public String email;
        public String mobilePhone;
        public String phone;
        public String serviceNumber;
        public String documentNumber;
        public String documentType;
        public String clientType;
        
    }
    
    public class ResponseError {
        public String errorCode;
        public String message;
    }

}