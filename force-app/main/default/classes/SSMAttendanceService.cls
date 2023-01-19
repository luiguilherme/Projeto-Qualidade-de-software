public with sharing class SSMAttendanceService {
    public static Map<String, Object> getAccount(String phoneNumber, String documentNumber) {
        return (SSMAttendanceEngine.getAccount(phoneNumber, documentNumber));
    }

    public static Boolean isPartnerCommunityLicense() {
        return (SSMAttendanceEngine.isPartnerCommunityLicense());
    }
}