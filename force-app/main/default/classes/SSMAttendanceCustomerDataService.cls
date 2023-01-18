/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 04/05/2022
    @description - Class Service for SSMAttendanceCustomerData
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceCustomerDataService {
    public static Map<String, Object> loadSSMAttendanceCustomerData() {
        return (SSMAttendanceCustomerDataEngine.loadSSMAttendanceCustomerData());
    }

}