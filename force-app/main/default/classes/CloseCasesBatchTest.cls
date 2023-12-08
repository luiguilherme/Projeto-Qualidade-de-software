@isTest
private class CloseCasesBatchTest {

    @testSetup
    static void setupTestData() {
        List<Case> testCases = new List<Case>();
        for(Integer i = 0; i < 3; i++) {
            Case newCase = new Case(
                Subject = 'Caso de Teste ' + i,
                Status = 'Em Atendimento',
                RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('DisputeInvoiceCase').getRecordTypeId()
            );
            testCases.add(newCase);
        }
        for(Integer i = 3; i < 6; i++) {
            Case newCase = new Case(
                Subject = 'Caso de Teste ' + i,
                Status = 'InTransfer',
                RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('DisputeInvoiceCase').getRecordTypeId()
            );
            testCases.add(newCase);
        }
        for(Integer i = 6; i < 9; i++) {
            Case newCase = new Case(
                Subject = 'Caso de Teste ' + i,
                Status = 'Consulting',
                RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('DisputeInvoiceCase').getRecordTypeId()
            );
            testCases.add(newCase);
        }
        insert testCases;
        
        for (Case c : testCases) {
    		Test.setCreatedDate(c.Id, DateTime.now().addDays(-1));
		}

        List<DisputedItem__c> disputedItems = new List<DisputedItem__c>();
        for (Case c : testCases) {
            DisputedItem__c newItem = new DisputedItem__c(
                Name = 'Item Contestado para ' + c.Subject,
                CaseId__c = c.Id, 
                Status__c = 'InAnalisys'
            );
            disputedItems.add(newItem);
        }
        insert disputedItems;

        List<vlocity_cmt__CustomerInteraction__c> customerInteractions = new List<vlocity_cmt__CustomerInteraction__c>();
        List<vlocity_cmt__CustomerInteractionTopic__c> interactionTopics = new List<vlocity_cmt__CustomerInteractionTopic__c>();
        for (Case c : testCases) {
            vlocity_cmt__CustomerInteraction__c newInteraction = new vlocity_cmt__CustomerInteraction__c(
                vlocity_cmt__Status__c = 'In Progress'
            );
            customerInteractions.add(newInteraction);
        }
        insert customerInteractions;
        
        for (Integer i = 0; i < customerInteractions.size(); i++) {
            vlocity_cmt__CustomerInteraction__c interaction = customerInteractions[i];
            Case relatedCase = testCases[i];

            vlocity_cmt__CustomerInteractionTopic__c topic = new vlocity_cmt__CustomerInteractionTopic__c(
                vlocity_cmt__CustomerInteractionId__c = interaction.Id,
                vlocity_cmt__CaseId__c = relatedCase.Id
            );
            interactionTopics.add(topic);
        }
        insert interactionTopics;
    }

    @isTest
    static void testBatchWithNoMatchingCases() {
        delete [SELECT Id FROM Case];

        Test.startTest();

        CloseCasesBatch batch = new CloseCasesBatch();
        Database.executeBatch(batch);
        Test.stopTest();

        List<Case> updatedCases = [SELECT Id, Status FROM Case];
        System.assert(updatedCases.isEmpty(), 'Nenhum Caso deve ser atualizado');
    }
    
    @isTest
    static void testBatchWithMatchingCases() {
        Test.startTest();
        CloseCasesBatch.start();
        Test.stopTest();
   		List<Case> updatedCases = [SELECT Status FROM Case];
        for (Case c : updatedCases) {
            if (c.Status == 'InTransfer' || c.Status == 'Consulting') {
                System.assertEquals('TransferInterrupted', c.Status, 'Status do Caso deve ser TransferInterrupted');
            } else if (c.Status == 'Em Atendimento') {
                System.assertEquals('InterruptedFlow', c.Status, 'Status do Caso deve ser InterruptedFlow');
            }
        }

		List<vlocity_cmt__CustomerInteraction__c> updatedInteractions = [SELECT Id, vlocity_cmt__Status__c FROM vlocity_cmt__CustomerInteraction__c];
        System.assert(updatedInteractions.size() > 0, 'Nenhuma Customer Interaction foi atualizada');
        for (vlocity_cmt__CustomerInteraction__c interaction : updatedInteractions) {
            System.assertEquals('Interrupted', interaction.vlocity_cmt__Status__c, 'Status da Customer Interaction não foi atualizado para Interrupted');
        }

		List<DisputedItem__c> updatedItems = [SELECT Id, Status__c FROM DisputedItem__c];
        System.assert(updatedItems.size() > 0, 'Nenhum Item Contestado atualizado');
        for (DisputedItem__c item : updatedItems) {
            System.assertEquals('Closed', item.Status__c, 'Status do Item Contestado não foi atualizado para Closed');
        }
    }
}