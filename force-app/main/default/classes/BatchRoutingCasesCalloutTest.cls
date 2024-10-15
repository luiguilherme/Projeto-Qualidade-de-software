@IsTest
private class BatchRoutingCasesCalloutTest {
    @TestSetup
    static void makeData() {
        List<Case> ltCases = new List<Case>();
        List<Account> ltAccount = new List<Account>();
        List<Asset> ltAsset = new List<Asset>();
        
        String recType = 'HDE - Gold Processos Escalonamento';
        String recordTypeDeveloperName = Schema.SObjectType.Case.getRecordTypeInfosByName().get(recType).getDeveloperName();
        
        Profile profile = [
            SELECT 
                Id, 
                Name 
            FROM 
                Profile 
            WHERE 
                Name LIKE 'Representante' 
            LIMIT 1
        ];
        
        UserRole role = [
            SELECT 
                Id, 
                Name 
            FROM 
                UserRole 
            WHERE 
                DeveloperName LIKE 'AtendimentoGoldAdmProcessos' 
            LIMIT 1
        ];

        User userAgent = DataFactory.createUser(profile.Id, role.Id);
        
        insert userAgent;

        User thisUser = [
            SELECT 
                Id 
            FROM 
                User 
            WHERE 
                Id = :UserInfo.getUserId()
        ];
        
        System.runAs(thisUser) {
            Account accountObj1 = new Account();
            
            accountObj1.Name = 'Validate Test 1';
            accountObj1.vlocity_cmt__CustomerValue__c = 'Gold';
            
            ltAccount.add(accountObj1);

            insert ltAccount;

            Asset assetObj1 = new Asset();

            assetObj1.AccountId = accountObj1.Id;
            assetObj1.Name = 'Validate Test';

            ltAsset.add(assetObj1);

            insert ltAsset;       

            Case oldCase1 = DataFactory.createCase(recordTypeDeveloperName, 'Test Case 1', 'add old case test');
            
            oldCase1.AccountId = accountObj1.Id;
            oldCase1.ComplainedAsset__c = assetObj1.Id;
            oldCase1.Priority = 'High';
            oldCase1.Segment__c	 = 'Gold';
            oldCase1.CustomerServiceReason__c = 'Agenda técnica não cumprida';
            oldCase1.OwnerId = userAgent.Id;

            ltCases.add(oldCase1);

            insert ltCases;
        }
    }
    
    @IsTest
    static void executeTest() {
        List<Case> ltCase = [
            SELECT 
                Id, 
                Status, 
                Protocol__c, 
                RecordTypeId, 
                RecordType.Name, 
                RecordType.DeveloperName, 
                AccountId, 
                ComplainedAsset__c, 
                Description, 
                Priority,Segment__c, 
                ServiceReason__c, 
                CustomerServiceReason__c, 
                IsHDE__c, 
                CreatedById, 
                OwnerId, 
                View__c 
            FROM 
                Case 
            WHERE 
                Subject LIKE 'Test Case%'
        ];

        Map<Id, String> casesWithPriorities = new Map<Id, String>();
        
        for (Case item : ltCase) {
            casesWithPriorities.put(item.Id, item.Priority);
        }

        Test.startTest();
            BatchRoutingCasesCallout testBatch = new BatchRoutingCasesCallout(ltCase, casesWithPriorities);
            
            ID batchProcessId = Database.executeBatch(testBatch, 1);
        Test.stopTest();

        AsyncApexJob aaj = [
            SELECT 
                Id, 
                Status, 
                JobItemsProcessed, 
                TotalJobItems, 
                NumberOfErrors 
            FROM 
                AsyncApexJob 
            WHERE 
                ID = :batchProcessId
        ];
        
        System.assertEquals(aaj.Status, 'Completed', 'Job Status not Completed.');  
    }
}