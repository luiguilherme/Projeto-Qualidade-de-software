global with sharing class PurgeServiceTransactionBatch implements Database.Batchable<sObject> {
    private GeneralParam__c param;

	global static void start() {
        GeneralParam__c param = GeneralParam__c.getInstance();

		Integer batchSize = ((param.BatchSizePurgeServiceTransaction__c != null) 
			? Integer.valueOf(param.BatchSizePurgeServiceTransaction__c) 
			: 1
		);

		Database.executeBatch(new PurgeServiceTransactionBatch(), batchSize);
	}
	
	global static void start(Integer batchSize) {
		Database.executeBatch(new PurgeServiceTransactionBatch(), batchSize);
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		this.param = GeneralParam__c.getInstance();

		Integer daysOfPurge = ((this.param.DaysPurgeSeviceTransaction__c != null) 
			? Integer.valueOf(this.param.DaysPurgeSeviceTransaction__c) 
			: 1
		);
	
		String query = ('SELECT Id FROM ServiceTransaction__c WHERE CreatedDate < LAST_N_DAYS : ' + daysOfPurge);

		if (Test.isRunningTest()) {
			query = 'SELECT Id FROM ServiceTransaction__c';
		}
	
		return (Database.getQueryLocator(query));
	}
	
	global void execute(Database.BatchableContext BC, List<ServiceTransaction__c> scope) {
		List<String> lstLinkedEntityIds = new List<String>();
		List<ContentDocument> lstContentDocument = new List<ContentDocument>();
	
		for (ServiceTransaction__c st : scope) {
			lstLinkedEntityIds.add(st.Id);
		}
	
		if (lstLinkedEntityIds.size() > 0) {
			List<ContentDocumentLink> lstcdl = [
				SELECT 
					Id, 
					LinkedEntityId, 
					ContentDocumentId 
				FROM 
					ContentDocumentLink 
				WHERE 
					LinkedEntityId IN :lstLinkedEntityIds
			];
	
			for (ContentDocumentLink cdl : lstcdl) {
				lstContentDocument.add(new ContentDocument(
					Id = cdl.ContentDocumentId
				));
			}

			Database.delete(lstContentDocument);
		}
	
		Database.delete(scope);
	}
	
	global void finish(Database.BatchableContext BC) {
	}
}