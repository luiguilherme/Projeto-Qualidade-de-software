@RestResource(urlMapping='/prospectManagement/v1/prospects')
global without sharing class ProspectManagementService {
    
    @HttpPost
    global static void createProspect() {
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        String headerXAuth = RestContext.request.headers.get('x-Authorization');
        String documentNumber = '';
        String serviceNumber = '';
        Savepoint sp = Database.setSavepoint();
		Id userId = UserInfo.getUserId(); 
        

        try {
           String nrdocumento;
           String identifier; 
           if(String.isNotBlank(headerXAuth)){
           	String[] jwtParts = headerXAuth.split(' ');
           	String authorizationHeaderValue = jwtParts[1];
            JWTUtility.PayLoadJwtWrapper body = JWTUtility.getJWTBody(authorizationHeaderValue);
            System.debug('body'+ body);
               if(JWTUtility.isToValidate(body.iss)) {
                   nrdocumento = body.nrdocumento;
                    if (body.authentication_context != null && !body.authentication_context.isEmpty()) {
                    identifier = body.authentication_context[0].identifier;
                    }
                   System.debug('identifier'+ identifier +' '+ nrdocumento);
                if(!JWTUtility.isValidJwt(authorizationHeaderValue)) {
                    handleException(res, 'User not authorized', 'UNAUTHORIZED', 401);
                    return;
                   }
                   System.debug('identifier'+ identifier +' '+ nrdocumento);
            	}
           }
            ProspectManagementWrapper.Prospect prospect = parseRequest();            
            if (String.isBlank(prospect.documentNumber)) {
                handleException(res, 'BAD_REQUEST', 'Document number cannot be null or empty', 400);
                return;
            }
            
            if (!validateAuthorization(prospect,nrdocumento,identifier)) {
                handleException(res,'UNAUTHORIZED', 'User not authorized', 401);
                return;
            }
            
            Account account = getAccountByCPF(prospect.documentNumber);
            if (account == null) {
                account = createAccount(prospect);
                insert account;
            }
            
            Contact contact = getContactByCPF(prospect.documentNumber);
            if (contact == null) {
                contact = createContact(prospect, account.Id);
                insert contact;
            } else if (contact.AccountId != account.Id) {
                contact.AccountId = account.Id;
                update contact;
            }
            
            if (account.vlocity_cmt__PrimaryContactId__c != contact.Id) {
                account.vlocity_cmt__PrimaryContactId__c = contact.Id;
                update account;
            }
            
            createSuccessResponse(res, contact.Id, 'Prospect criado / Prospect existente.');
            
        } catch (Exception e) {
            handleException(res, 'BAD_REQUEST', 'Invalid request: ' + e.getMessage(), 400);
            Database.rollback(sp);
        }
    }

    private static ProspectManagementWrapper.Prospect parseRequest() {
        return (ProspectManagementWrapper.Prospect) JSON.deserialize(RestContext.request.requestBody.toString(),ProspectManagementWrapper.Prospect.class);
    }

    private static Account createAccount(ProspectManagementWrapper.Prospect prospect) {
		Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Consumer').getRecordTypeId();
        return new Account (RecordTypeId = recordTypeId, ExternalId__c = prospect.documentNumber, Type = prospect.clientType,Name = prospect.firstName + ' ' + prospect.lastName, DocumentNumber__c = prospect.documentNumber, DocumentType__c = prospect.documentType);
    }
    
    private static Contact createContact(ProspectManagementWrapper.Prospect prospect, Id accountId) {
        return new Contact (Email = prospect.Email, 
        Birthdate = Date.valueOf(prospect.birthDate),
        MobilePhone = prospect.mobilePhone,
        Phone = prospect.phone, 
        MotherName__c = prospect.motherName, 
        ExternalId__c = prospect.documentNumber,
        FirstName = prospect.firstName,
        LastName = prospect.lastName,
        AccountId = accountId);
    }
                    
    
    private static void createSuccessResponse(RestResponse res, String contactId, String message) {
        Map<String, Object> responseMap = new Map<String, Object>();
        Map<String, String> contactResponse = new Map<String, String>();
        contactResponse.put('id', contactId);
        contactResponse.put('message', message);
        responseMap.put('contact', contactResponse);
        
        res.responseBody = Blob.valueOf(JSON.serialize(responseMap));
        res.statusCode = 200;
    }
    
    private static boolean validateAuthorization(ProspectManagementWrapper.Prospect Prospect,String nrdocumento,String identifier) {
        String serviceNumber = '';
        String documentNumber = '';
        if(Prospect.serviceNumber != null || Prospect.documentNumber != null){
            serviceNumber =  Prospect.serviceNumber;
            documentNumber = Prospect.documentNumber;
        }
        
        if(String.isNotBlank(nrdocumento) || String.isNotBlank(identifier)){
            return validateJwtToken(documentNumber, serviceNumber, identifier, nrdocumento);
        }
        // Nao entrando nas demais validacoes, entra no cenario de usuario sistemico
        return true;
    }
    
    private static Boolean validateJwtToken(String documentNumber, String serviceNumber, String identifier, String nrdocumento){

        // caso o token venha com cpf
        if (String.isNotBlank(nrdocumento) && nrdocumento == documentNumber) {
            return true;
        }

        // caso o token venha com linha
        if (String.isNotBlank(identifier) && identifier == serviceNumber) {
            return true;
        }
        return false;
    }
    
    
    
    private static Account getAccountByCPF(String cpf) {
        //filtrar pelo recordTypeId
		Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Consumer').getRecordTypeId();
        
        List<Account> accounts = [SELECT Id, vlocity_cmt__PrimaryContactId__c FROM Account 
                                  WHERE DocumentNumber__c = :cpf AND DocumentType__c = 'CPF' AND ExternalId__c = :cpf AND RecordTypeId = :recordTypeId];
        return accounts.isEmpty() ? null : accounts[0];
    }
    
    private static Contact getContactByCPF(String cpf) {
        List<Contact> contacts = [SELECT Id, ExternalId__c, AccountId FROM Contact WHERE ExternalId__c = :cpf LIMIT 1];
        return contacts.isEmpty() ? null : contacts[0];
    }
    
    private static void handleException(RestResponse res, String errorCode, String message, Integer statusCode) {
        ProspectManagementWrapper.ResponseError error = new ProspectManagementWrapper.ResponseError();
        error.errorCode = errorCode;
        error.message = message;
        
        res.statusCode = statusCode;
        res.responseBody = Blob.valueOf(JSON.serialize(error));
    }
}