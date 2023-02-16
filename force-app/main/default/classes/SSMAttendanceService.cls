public with sharing class SSMAttendanceService {
    public static Map<String, Object> fetchAttendanceOperationalInformations() {
        return (SSMAttendanceEngine.fetchAttendanceOperationalInformations());
    }

    public static Map<String, Object> getAccount(String phoneNumber, String documentNumber) {
        return (SSMAttendanceEngine.getAccount(phoneNumber, documentNumber));
    }
}
