@IsTest 
public class HDECaseDetailServiceTest {
	@TestSetup
    static void setup() {
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

        System.runAs(userAgent) {
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

    @IsTest 
    static void createCaseDetailTest() {
        Case caseSource = [
            SELECT 
                Id 
            FROM 
                Case 
            WHERE 
                Status LIKE 'A Iniciar' AND 
                CustomerServiceReason__c LIKE 'Análise de Cobertura'
            LIMIT
            	1
        ];
        
        List<CaseDetail__c> ltCaseDetail = [
            SELECT 
                Id 
            FROM 
                CaseDetail__c 
            WHERE 
                Case__c = :caseSource.Id
        ];
        
		System.assertEquals(1, ltCaseDetail.size());
    }
}