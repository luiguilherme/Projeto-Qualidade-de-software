@isTest
public with sharing class PurgeServiceTransactionBatchTest {
    @TestSetup
    public static void setup() {
        insert new ServiceTransaction__c(
            Name = 'Service transaction Test'
        );
    }

    @isTest
    public static void testBatch() {
        Test.startTest();
        	PurgeServiceTransactionBatch.start();
        Test.stopTest();

        List<ServiceTransaction__c> sts = [
			SELECT 
				Id 
			FROM 
				ServiceTransaction__c
		];

		System.debug(sts);
		System.assert(sts.isEmpty());
    }
}