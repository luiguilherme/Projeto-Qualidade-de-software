/*  
* @description: Methods executed by PersonAccount Triggers  
*/
public without sharing class ServiceTransaction implements Queueable  {
	private static ServiceTransaction instance = new ServiceTransaction();      
	public ServiceTransaction__c serviceTransaction;	
	private Boolean saveLogFile = false;
	private String sRequest = '';
	private String sResponse = '';

	public List<ServiceTransaction__c> serviceTransactionList = new List<ServiceTransaction__c> ();

	public static ServiceTransaction getInstance() {
		return instance;
	}

	public String create(ServiceTransactionOperations operation) {
		String messageId = '';//FourthPlatform.generateUUID();já

		serviceTransaction = new ServiceTransaction__c(
		                                               Name = messageId,
		                                               Operation__c = operation.name(),
		                                               OperationStatus__c = 'In Progress',
		                                               StartDate__c = DateTime.now()
		);
		return messageId;
	}

	public void create(ServiceTransactionOperations operation, String status, String name, String message, Id recordTypeId) {

        this.saveLogFile = true;
        
		 serviceTransaction = new ServiceTransaction__c(
                 Name = name + DateTime.now().format('YYYY-MM-dd HH:mm:ss'),
                 Operation__c = operation.name(),
                 OperationStatus__c = status,
                 StartDate__c = DateTime.now(),
                 SFException__c = message, 
                 EndDate__c = DateTime.now()
             	 //RecordTypeId = recordTypeId             	 
			);

	}
    
    public void create(ServiceTransactionOperations operation, String endpoint, String name) {

		serviceTransaction = new ServiceTransaction__c(
		                                               Name = name,
		                                               Operation__c = operation.name(),
		                                               OperationStatus__c = 'In Progress',
		                                               Endpoint__c = endpoint,
		                                               StartDate__c = DateTime.now()
		);

	}
      
	public void setRequest(Object request) {
		serviceTransaction.Request__c = JSON.serializePretty(request);
		if (serviceTransaction.Request__c.length() > 131072) {
			saveLogFile = true;
			sRequest = JSON.serializePretty(request);
			serviceTransaction.Request__c = 'Conteudo excede o tamanho limite do campo, para vizualiza-lo acesse o arquivo de log anexo.';
		}
	}

	public void setResponse(Object response) {
		serviceTransaction.Response__c = response.toString();
		if (serviceTransaction.Response__c.length() > 131072) {
			saveLogFile = true;
			sResponse = JSON.serializePretty(response);
			serviceTransaction.Response__c = 'Conteudo excede o tamanho limite do campo, para vizualiza-lo acesse o arquivo de log anexo.';
		}
	}

	public void setHeader(Object header) {
		serviceTransaction.HTTP_Header__c = JSON.serializePretty(header).left(131072);
	}

	public void setStatusCode(String statusCode) {
		serviceTransaction.HTTPStatusCode__c = statusCode;
	}

	public void complete() {
		serviceTransaction.EndDate__c = DateTime.now();
		serviceTransaction.OperationStatus__c = 'Succeeded';
	}
    public void fail() {
		serviceTransaction.EndDate__c = DateTime.now();
		serviceTransaction.OperationStatus__c = 'Failed';
	}
      
    public void begin() {
		serviceTransaction.EndDate__c = DateTime.now();
        serviceTransaction.AppKey__c = 'Key Crypt';
		serviceTransaction.OperationStatus__c = 'Succeeded';
	}
    public void finish() {
		serviceTransaction.EndDate__c = DateTime.now();
        serviceTransaction.AppKey__c = 'Key Crypt';
		serviceTransaction.OperationStatus__c = 'Failed';
	}
    public void completeInstante() {
		serviceTransaction.EndDate__c = DateTime.now();
        serviceTransaction.AppKey__c = 'APP';
		serviceTransaction.OperationStatus__c = 'Succeeded';
	}
    public void failLogs() {
		serviceTransaction.EndDate__c = DateTime.now();
        serviceTransaction.AppKey__c = 'logsFailed';
		serviceTransaction.OperationStatus__c = 'Failed';
	}
      
    public void beginProcess() {
		serviceTransaction.EndDate__c = DateTime.now();
        serviceTransaction.AppKey__c = 'Key Crypt';
		serviceTransaction.OperationStatus__c = 'Succeeded';
	}
    public void finishBatch() {
		serviceTransaction.EndDate__c = DateTime.now();
        serviceTransaction.AppKey__c = 'finalizatebatch';
		serviceTransaction.OperationStatus__c = 'Failed';
	}
      
    public void init() {
		serviceTransaction.EndDate__c = DateTime.now();
		serviceTransaction.OperationStatus__c = 'Succeeded';
	}
    public void finishs() {
		serviceTransaction.EndDate__c = DateTime.now();
		serviceTransaction.OperationStatus__c = 'Failed';
	}

	public void timeout() {
		serviceTransaction.EndDate__c = DateTime.now();
		serviceTransaction.OperationStatus__c = 'Timeout';
	}
    public void partialLog() {
		serviceTransaction.EndDate__c = DateTime.now();
		serviceTransaction.OperationStatus__c = 'Failed';
	}

	public void timeRunning() {
		serviceTransaction.EndDate__c = DateTime.now();
		serviceTransaction.OperationStatus__c = 'Timeout';
	}

	public void transact() {
		serviceTransaction.EndDate__c = DateTime.now();
		serviceTransaction.OperationStatus__c = 'Transacted';
	}

	public void delay() {
		serviceTransaction.Delayed__c = true;
	}
	public Boolean isDelayed(Double timeout) {
		if (serviceTransaction.StartDate__c == null) {
			return false;
		} else {
			Double result = (DateTime.now().getTime() - serviceTransaction.StartDate__c.getTime());
			return(result > timeout);
		}
	}

	public Boolean isSuccessful() {
		return serviceTransaction.OperationStatus__c.equalsIgnoreCase('Succeeded');
	}

	public Boolean isInProgress() {
		return serviceTransaction.OperationStatus__c.equalsIgnoreCase('In Progress');
	}

	public void commitSync() {
		commitTransactions();
	}

	public void commitAsync() {
		system.enqueueJob(this);
	}

	public void execute(QueueableContext context) {
		commitTransactions();
	}

	public void addToList() {
		serviceTransactionList.add(serviceTransaction);
	}
/*
	public void setServiceTransactionList(List<ServiceTransaction__c> svcTransactions) {

		if (svcTransactions != null && !svcTransactions.isEmpty()) {
			serviceTransactionList.addAll(svcTransactions);
		}
	}
*/
	public void commitTransactionsList() {
		//Schema.SObjectField f = ServiceTransaction__c.Name;
		if (serviceTransactionList.size() == 0) {
			system.debug('no serviceTransactionList');
		}
		List<Database.upsertResult> results = Database.upsert(serviceTransactionList, ServiceTransaction__c.Name, false);

		for (Integer index = 0; index<results.size(); index++) {
			if (!results[index].isSuccess()) {
				system.debug('Error to create servicetransaction');
			}
		}
	}

	public void commitTransactions() {

		purgeLogTransaction();

		Database.upsertResult result = Database.upsert(serviceTransaction, ServiceTransaction__c.Name, false);
		if (saveLogFile && result.isSuccess()) {
			//saveContentDocument(result.getId());
		}

	}
	public void purgeLogTransaction() {

		List<ServiceTransaction__c> listST = [SELECT Id FROM ServiceTransaction__c WHERE CreatedDate < LAST_N_DAYS : 30 LIMIT 5000];
		List<String> lstLinkedEntityIds = new List<String> ();
		List<ContentDocument> lstContentDocument = new List<ContentDocument> ();


		for (ServiceTransaction__c st : listST) {
			lstLinkedEntityIds.add(st.Id);
		}

		if (lstLinkedEntityIds.size()> 0) {
			List<ContentDocumentLink> lstcdl = [SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN :lstLinkedEntityIds];

			for (ContentDocumentLink cdl : lstcdl) {
				lstContentDocument.add(new ContentDocument(Id = cdl.ContentDocumentId));
			}
			Database.delete(lstContentDocument);
		}

		Database.delete(listST);

	}
}