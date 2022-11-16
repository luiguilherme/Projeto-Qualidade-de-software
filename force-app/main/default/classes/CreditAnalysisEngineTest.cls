@IsTest
public with sharing class CreditAnalysisEngineTest {
    @TestSetup
	static void setup(){
        AccountTestFactory.start().startPersonAccount().create();
        insert new GeneralParam__c(CreditConsultationExpiration__c = '24');
	}

    @IsTest
    static void executeCreditAnalysis(){
        Map<String, object> mapResult = new Map<string, Object>();
		List<Account> accList = [ SELECT    
							Id,
							Name,
							DocumentNumber__c,
							UserId__c,
							vlocity_cmt__PrimaryContactId__r.MotherName__c,
							vlocity_cmt__PrimaryContactId__r.Birthdate,
							CreditScoreDate__c,
							RecordTypeId,
							vlocity_cmt__CreditScore__c
						FROM 
						Account];
        Test.startTest();
           mapResult =  CreditAnalysisEngine.executeCreditAnalysis(accList[0]);
        Test.stopTest();
        System.debug(mapResult);
        System.assert(mapResult != null , 'O objeto de resultado não foi preenchido');
    }
}