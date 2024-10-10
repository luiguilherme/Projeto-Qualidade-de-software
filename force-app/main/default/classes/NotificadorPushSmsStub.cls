@isTest
public with sharing class NotificadorPushSmsStub implements System.StubProvider {
    private Integer responseStatusCode;
    
    public NotificadorPushSmsStub(Integer responseStatusCode) {
        this.responseStatusCode = responseStatusCode;
    }

    public Object handleMethodCall(
        Object stubbedObject, String stubbedMethodName, Type returnType, 
        List<Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs
    ) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(responseStatusCode);
        return response;
    }
}