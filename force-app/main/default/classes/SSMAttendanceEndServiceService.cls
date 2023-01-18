/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 05/05/2022
    @description - Class Service for SSMAttendanceEndService
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceEndServiceService {
    public static Map<String, Object> loadSSMAttendanceEndService() {
        return (SSMAttendanceEndServiceEngine.loadSSMAttendanceEndService());
    }
}