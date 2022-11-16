@IsTest
public class MassiveSuspicionCaseRequestTest {
    @IsTest
    static void methodName(){
        
        Test.startTest();
        MassiveSuspicionCaseRequest request =  new MassiveSuspicionCaseRequest(null);
        request.createRequestStructure();
        request.toJson();
        MassiveSuspicionCaseRequest.parse('{}');
        Test.stopTest();
        
    }
}