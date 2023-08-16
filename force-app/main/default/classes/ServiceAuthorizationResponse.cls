public with sharing class ServiceAuthorizationResponse {
    public String status;
    public String message;

    public static ServiceAuthorizationResponse parse(String json) {
        ServiceAuthorizationResponse responseParsed = (ServiceAuthorizationResponse) System.JSON.deserialize(json, ServiceAuthorizationResponse.class);
        return responseParsed;
    }
}