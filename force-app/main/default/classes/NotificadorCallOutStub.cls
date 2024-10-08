@IsTest
public with sharing class NotificadorCallOutStub implements System.StubProvider {
    private Integer responseStatusCode;
    
    public NotificadorCallOutStub(Integer responseStatusCode) {
        this.responseStatusCode = responseStatusCode;
    }
    
    public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, 
        Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames, 
        List<Object> listOfArgs) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(responseStatusCode);
        return response;
    }
}