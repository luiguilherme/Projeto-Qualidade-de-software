@isTest
private class PrioritizeCaseTest {
    @TestSetup
    static void makeData(){
        Profile profile = [
            SELECT 
                Id, 
                Name 
            FROM 
                Profile 
            WHERE 
                Name LIKE 'Representante' 
            LIMIT 
                1
        ];
        
        UserRole role = [
            SELECT 
                Id, 
                Name 
            FROM 
                UserRole 
            WHERE 
                DeveloperName LIKE 'AtendimentoVivoVAdmProcessos' 
            LIMIT 
                1
        ];

        User userAgent = DataFactory.createUser(profile.Id, role.Id);
        
        insert userAgent;

        User thisUser = [
            SELECT 
                Id 
            FROM 
                User 
            WHERE 
                Id = :userAgent.Id
        ];

        System.runAs(thisUser) {
            Id userId = UserInfo.getUserId();
            String developerName = 'VivoVProcessesEscalation';
            Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(developerName).getRecordTypeId();
            
            Account accountObj = new Account();
                
            accountObj.Name = 'Validate Test 1';
            accountObj.vlocity_cmt__CustomerValue__c = 'Gold';

            insert accountObj;

            Case caseNew = new Case(
                Status = 'A Iniciar', 
                RecordTypeId = recordTypeId,
                Priority = 'Medium',
                CriticalComment__c = '',
                CustomerServiceReason__c = 'Análise de Cobertura',
                HDEOtherProducts__c = 'SIMCard',
                SegmentProduct__c = 'OtherProduct',
                AccountId = accountObj.Id
            );

            insert caseNew;
        }
    }

    @isTest 
    static void updatePriorityCase() {
		Object objRetorno;
        
        PrioritizeCase prioritizeCase = new PrioritizeCase();
        
        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();
        
        Case caseUpdate = [
            SELECT 
                Id,
                CriticalComment__c,
                Status,
                Priority 
            FROM 
                CASE 
            WHERE 
                Status LIKE 'A Iniciar' AND 
                CustomerServiceReason__c LIKE 'Análise de Cobertura'
        ];

        Test.startTest();
            inputMap.put('PriorityDet', 'Teste Priorização');
            inputMap.put('CaseIdBlock', caseUpdate.Id);

            prioritizeCase.invokeMethod('updatePriorityCase', inputMap, outputMap, options); 
                        
            System.assertEquals(true, outputMap.get('Success'));
        Test.stopTest();
    }
    
    @isTest 
    static void updatePriorityCaseError(){
		Object objRetorno;
        
        PrioritizeCase prioritizeCase = new PrioritizeCase();
        
        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();
        
        Test.startTest();
            inputMap.put('PriorityDet', 'Teste Priorização');
            inputMap.put('CaseIdBlock', 'testeId');

            prioritizeCase.invokeMethod('updatePriorityCase', inputMap, outputMap, options); 
                        
            System.assertEquals(false, outputMap.get('Success')); 
        Test.stopTest();
    }
}