@isTest
public class GPSCanvasInterfaceTriggerTest {
	@testSetup 
    static void setup() {
		Account nuAcc = new Account();	
		nuAcc.Name = 'NuAcc';
		insert nuAcc;

        Case nuCase = new Case();
        nuCase.AccountId = nuAcc.Id;
		nuCase.Origin = 'URA';
        insert nuCase;
	}
    
    
	static testMethod void testTrigger() {
         Case nuCase = [Select id FROM Case Limit 1];
    		Test.startTest();
         		GPSCanvasInterface__e event = new GPSCanvasInterface__e();
         		event.CaseId__c = nuCase.Id;
        		event.AccountId__c = 'Teste';
        		event.Closure__c = 'Teste';
        		event.Context__c = 'Teste';
        		event.Description__c = 'Teste';
        		event.DestinyCell__c = 'Teste';
        		event.Observation__c = 'Teste';
        		event.OperationType__c = 'Teste';
        		event.OriginCell__c = 'Teste';
        		event.Protocol__c = 'Teste';
        		event.ServiceRequestId__c = 'Teste';
        		event.ServiceRequestStatus__c = 'Teste';
        		event.UserId__c = 'Teste';
        
        		Database.SaveResult sr = EventBus.publish(event);
                if(sr.getErrors() != null){
                	for(Database.Error err : sr.getErrors()) {
            			System.debug('Error returned: ' +
                         err.getStatusCode() +
                         ' - ' +
                         err.getMessage());   
                }
         	Test.stopTest();
     }
    }
}