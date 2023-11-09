@isTest
private class CustomVIPImplementationInvocableTest {
    @isTest static void test() {
        List<CustomVIPImplementationInvocable.IntegrationProcedureInput> requests = new List<CustomVIPImplementationInvocable.IntegrationProcedureInput>();
        CustomVIPImplementationInvocable.IntegrationProcedureInput request = new CustomVIPImplementationInvocable.IntegrationProcedureInput();
        request.recordId = 'test';
        request.procedureName = 'type_subType';
        requests.add(request);
        
        List<CustomVIPImplementationInvocableFuture.IntegrationProcedureInput> requestsAsync = new List<CustomVIPImplementationInvocableFuture.IntegrationProcedureInput>();
        CustomVIPImplementationInvocableFuture.IntegrationProcedureInput requestAsync = new CustomVIPImplementationInvocableFuture.IntegrationProcedureInput();
        requestAsync.recordId = 'test';
        requestAsync.procedureName = 'type_subType';
        requestsAsync.add(requestAsync);
        
        Test.startTest();
        CustomVIPImplementationInvocable.execute(requests);
        CustomVIPImplementationInvocableFuture.execute(requestsAsync);
        Test.stopTest();
    }
}