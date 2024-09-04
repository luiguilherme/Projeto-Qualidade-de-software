/**
 * @description       : Gerenciamento de dependentes via API REST, 
 *                      incluindo operações CRUD para contatos e relacionamentos com assets.
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@RestResource(urlMapping='/productUserManagement/v1/productUsers/*')
global with sharing class ProductUserManagement {
    
    @HttpPatch
    global static void patchProductUser() {
         RestResponse res = RestContext.response;
         JSONGenerator generator = JSON.createGenerator(true);
         GetProductUserResponseWrapper.Response response = new GetProductUserResponseWrapper.Response();

        try {
            String headerXAuth = RestContext.request.headers.get('x-Authorization');
            res.addHeader('Content-Type', 'application/json');
            
            if (String.isBlank(headerXAuth)) {
                handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
            }
    
            String[] jwtParts = headerXAuth.split(' ');
            String authorizationHeaderValue = jwtParts.size() > 1 ? jwtParts[1] : '';

            if (!JWTUtility.isValidJwt(authorizationHeaderValue)) {
                handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
            }

            String cpfTitular = (JWTUtility.getJWTBody(authorizationHeaderValue) != null) ? JWTUtility.getJWTBody(authorizationHeaderValue).nrdocumento : null;
            System.debug('CPF jwt -> ' + cpfTitular);
            
            // Verifica se o CPF do JWT foi extraído corretamente
            if (String.isBlank(cpfTitular)) {
                System.debug('JWT foi extraído corretamente  -> ' + cpfTitular);
                handleException(res, 'NOT_FOUND', 'This operation was not found', 404);
            }
            
            // Consulta a conta com base no CPF extraído
            List<Account> isValidAccount = [SELECT Id, ExternalId__c FROM Account WHERE ExternalId__c = :cpfTitular];
            System.debug('isValidAccount -> ' + isValidAccount);

            String jsonRequestStr = RestContext.request.requestBody.toString();
            GetProductUserResponseWrapper req = GetProductUserResponseWrapper.parse(jsonRequestStr);
    		Map<String, Object> jsonResponse = new Map<String, Object>();

            String isCPFandPhoneDelete = req.assetPartyRelationDelete.Product;
            Boolean isDelete = req.assetPartyRelationDelete.isDeleteProduct;
            
            // Verifica se a conta existe e se o CPF no request é válido
            if (!isValidAccount.isEmpty() && req.contactRef != null && !String.isBlank(req.contactRef.userCPF)) {
                if ((isCPFandPhoneDelete == '' || isCPFandPhoneDelete == null) && !isDelete) {
                    Set<String> setRecordContact = new Set<String>{req.contactRef.userCPF};
                    updateContactFields(setRecordContact, req);
        			jsonResponse.put('assetPartyRelationshipRefResponse', req.assetPartyRelationshipRef);
                    jsonResponse.put('contactRefResponse', req.contactRef);

                    String jsonOutput = JSON.serialize(jsonResponse);
                    res.responseBody = Blob.valueOf(jsonOutput); 
                    res.statusCode = 200;
                }
            } else {
               	List<AssetPartyRelationShip__c> consultAssetPartyRelation = [SELECT Id, Name, SourceParty__c FROM AssetPartyRelationShip__c WHERE Name = :isCPFandPhoneDelete AND SourceParty__c != null];
                if (!consultAssetPartyRelation.isEmpty()) {
                    System.debug('Verifica se há dependentes e se é necessário deletar ' + consultAssetPartyRelation);
                    if (isDelete) {
                        jsonResponse.put('assetPartyRelationDeleteResponse', req.AssetPartyRelationDelete);
                        String jsonOutput = JSON.serialize(jsonResponse);
                        res.responseBody = Blob.valueOf(jsonOutput);
                        res.statusCode = 200;
                        delete consultAssetPartyRelation;
                    } else {
                        handleException(res, 'BAD_REQUEST', 'invalid request', 400);
                    }
                } else {
                    handleException(res, 'NOT_FOUND', 'This operation was not found', 404);
                }
            }
        } catch (Exception e) {
            generator.writeObject(res);
            handleException(res, 'INTERNAL_SERVER_ERROR', 'Internal Server Error', 500);
            System.debug(generator.getAsString());
        }
    }

    /**
     * @description: Atualiza ou cria novos contatos e relaciona-os com assets.
     * @param existingContactIds: Conjunto de IDs de contatos existentes.
     * @param req: Objeto de requisição contendo os detalhes do contato e relacionamento.
    **/
    
    public static void updateContactFields(Set<String> existingContactIds, GetProductUserResponseWrapper req) {
        List<Contact> contactsToUpdate = new List<Contact>();
        List<Contact> contactsToCreate = new List<Contact>();
        List<vlocity_cmt__Party__c> newRecordParty = new List<vlocity_cmt__Party__c>();
        List<AssetPartyRelationShip__c> upsertPartyRelations = new List<AssetPartyRelationShip__c>();		
        Map<String, Contact> cpfToContactMap = new Map<String, Contact>();		
        Set<String> contactIds = new Set<String>();
        String recordTypeIdContact = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('ConsumerContact').getRecordTypeId();
        
        //POPULANDO OS MAPAS COM VALORES EXISTENTES
        if (!existingContactIds.isEmpty()) {
            List<Contact> existingContacts = getContacts(existingContactIds);
            for (Contact contact : existingContacts) { 
                cpfToContactMap.put(contact.ExternalId__c, contact);
            }
        }

        for (String cpf : existingContactIds) { 
            if (cpfToContactMap.containsKey(cpf)) {
                Contact contact = cpfToContactMap.get(cpf);
                contact.FirstName = req.contactRef.firstName;
                contact.LastName = req.contactRef.lastName;
                contact.ContactEmail__c = req.contactRef.contactEmail != null ? req.contactRef.contactEmail : '';
                contact.AssistantPhone = req.contactRef.assistantPhone;
                contact.Nickname__c = req.contactRef.nickName;
                contact.MotherName__c = req.contactRef.motherName;
                contact.RecordTypeId = recordTypeIdContact;
                contact.Birthdate = (String.isBlank(req.contactRef.birthdate) || req.contactRef.birthdate == null) ? null : Date.valueOf(req.contactRef.birthdate);         
                if (contact.vlocity_cmt__PartyId__c == null) {
                    createPartyAndAssetRelation(contact, req);
                    System.debug(' CONTATO ANTIGO: se passou aqui criou o registro de party e AssetPartyRelationShip');
                }
                contactsToUpdate.add(contact);  
                System.debug('atualizando o contato. ' + contactsToUpdate);
            } else {
                Contact newContact = new Contact( ExternalId__c = cpf, FirstName = req.contactRef.firstName, LastName = req.contactRef.lastName, RecordTypeId = recordTypeIdContact, ContactEmail__c = req.contactRef.contactEmail, 
                                                    AssistantPhone = req.contactRef.assistantPhone, Nickname__c = req.contactRef.nickName,  MotherName__c = req.contactRef.motherName , 
                                                    Birthdate = String.isEmpty(req.contactRef.birthdate) ? null : Date.valueOf(req.contactRef.birthdate));
                contactsToCreate.add(newContact);
                System.debug('CENARIOS 3 -> CPF não existe e telefone não existe, REGISTRO NOVO.' + contactsToCreate);
            }
        }

        List<Contact> lstIsValidAssetPartyRelation = new List<Contact>();
        //OPERAÇÕES DML
        if (!contactsToUpdate.isEmpty()) { 
            upsert contactsToUpdate;
            lstIsValidAssetPartyRelation.addAll(contactsToUpdate);
        }

        if(!contactsToCreate.isEmpty()){
           upsert contactsToCreate;
           lstIsValidAssetPartyRelation.addAll(contactsToCreate);
        }

        String cpfHolder = req.assetPartyRelationshipRef.product;
        String cpfHolderAndDependents = cpfHolder.length() >= 24 ? cpfHolder.substring(cpfHolder.length() - 24) : cpfHolder;
        String phoneTitular = cpfHolder.length() >= 11 ? cpfHolder.substring(cpfHolder.length() - 11) : cpfHolder;
        System.debug('cpfHolderAndDependents -> ' + cpfHolderAndDependents);

        for (Contact contacts : lstIsValidAssetPartyRelation) {  
            contactIds.add(contacts.Id); 
            System.debug('contactIds ' + contactIds);
        }

        if (!contactIds.isEmpty()) { 
            List<vlocity_cmt__Party__c> cmtParties = getPartyById(contactIds);
            Map<Id, vlocity_cmt__Party__c> partyMap = new Map<Id, vlocity_cmt__Party__c>();
            for (vlocity_cmt__Party__c party : cmtParties) {
                if(party.vlocity_cmt__ContactId__c != null){
                   partyMap.put(party.vlocity_cmt__ContactId__c, party);
                   System.debug('partyMap ' + partyMap);
                }
            }

            // Obtenha os registros de Asset relacionados ao CPF do titular e dos dependentes
            List<Asset> assetRecord = getAssetByExternalId(cpfHolderAndDependents);
            if (!assetRecord.isEmpty()) {
                // Mapeie os IDs dos contatos para os IDs dos Partys
                Map<Id, Id> contactToPartyMap = new Map<Id, Id>();
                for (Id contactId : contactIds) {
                    if (partyMap.containsKey(contactId)) {
                        contactToPartyMap.put(contactId, partyMap.get(contactId).Id);
                    }
                }
                
                // Verifique se já existem relações AssetPartyRelationShip__c para os contatos e o asset
                List<AssetPartyRelationShip__c> existingRelations = [
                    SELECT SourceParty__c 
                    FROM AssetPartyRelationShip__c 
                    WHERE SourceParty__c IN :contactToPartyMap.values()
                    AND TargetAsset__c = :assetRecord[0].Id
                    AND Role__c = :req.assetPartyRelationshipRef.role
                ];
            
                // Crie um conjunto de IDs de SourceParty para relacionamentos existentes
                Set<Id> existingSourcePartyIds = new Set<Id>();
                for (AssetPartyRelationShip__c relation : existingRelations) {
                    existingSourcePartyIds.add(relation.SourceParty__c);
                }
            
                // Adicione novos relacionamentos para contatos que não têm um existente
                for (Id contactId : contactIds) {
                    Id partyId = contactToPartyMap.get(contactId);
                    if (partyId != null && !existingSourcePartyIds.contains(partyId)) {
                        AssetPartyRelationShip__c newRelation = new AssetPartyRelationShip__c(
                            Name = req.assetPartyRelationshipRef.product,SourceParty__c = partyId,TargetAsset__c = assetRecord[0].Id,
                            Role__c = req.assetPartyRelationshipRef.role,approvedByOwner__c = req.assetPartyRelationshipRef.approvedByOwner
                        );
                        upsertPartyRelations.add(newRelation);
                        System.debug('Nova relação adicionada: ' + newRelation);
                    } else {
                        System.debug('Relação já existe para o contato: ' + contactId);
                        break;
                    }
                }
            }
        }

        if (!upsertPartyRelations.isEmpty()) { 
            upsert upsertPartyRelations; 
            System.debug('upsertPartyRelations ' + upsertPartyRelations);
        }
    }


    public static void createPartyAndAssetRelation(Contact contact, GetProductUserResponseWrapper req) {
        List<Contact> updateContact = new List<Contact>();
        List<vlocity_cmt__Party__c> insertNewParty = new List<vlocity_cmt__Party__c>();
        vlocity_cmt__Party__c newParty = new vlocity_cmt__Party__c( Name = contact.FirstName + ' ' + contact.LastName,vlocity_cmt__ContactId__c = contact.Id);
        insertNewParty.add(newParty);
        System.debug('insertNewParty ' + insertNewParty);
        if (!insertNewParty.isEmpty()) {
            insert insertNewParty;
            System.debug('insertNewParty ' + insertNewParty);
        }

        contact.vlocity_cmt__PartyId__c = newParty.Id;
        updateContact.add(contact);
        if (!updateContact.isEmpty()) {
            update updateContact;
            System.debug('updateContact ' + updateContact);
        }
    
        String cpfHolder = req.assetPartyRelationshipRef.product;
        String cpfHolderAndDependents = cpfHolder.length() >= 24 ? cpfHolder.substring(cpfHolder.length() - 24) : cpfHolder;
        System.debug('cpfHolderAndDependents -> ' + cpfHolderAndDependents);

        List<Asset> assetRecord = getAssetByExternalId(cpfHolderAndDependents);
        List<AssetPartyRelationShip__c> newPartyRelationShip = new List<AssetPartyRelationShip__c>();
        if (!assetRecord.isEmpty()) {
            System.debug('assetRecord ' + assetRecord);
            AssetPartyRelationShip__c newRelation = new AssetPartyRelationShip__c( 
                SourceParty__c = newParty.Id, TargetAsset__c = assetRecord[0].Id,  Name = req.assetPartyRelationshipRef.product,
                Role__c = req.assetPartyRelationshipRef.role, approvedByOwner__c = req.assetPartyRelationshipRef.approvedByOwner);
            newPartyRelationShip.add(newRelation);
            System.debug('newPartyRelationShip ' + newPartyRelationShip);
        }

        if (!newPartyRelationShip.isEmpty()) {
            upsert newPartyRelationShip;
            System.debug('newPartyRelationShip ' + newPartyRelationShip);
        }
    }
    
    public static List<AssetPartyRelationShip__c> isvalidAssetPartyRelation( Set<String> phoneNumber) {
        return [SELECT Id, Name, SourceParty__c FROM AssetPartyRelationShip__c WHERE  TargetAsset__r.PhoneNumber__c = :phoneNumber];
    }
    public static List<Contact> getContacts(Set<String> externalID) {
        return [SELECT Id, FirstName, LastName, ExternalId__c, AssistantPhone, AccountId, Account.ExternalId__c, vlocity_cmt__PartyId__c FROM Contact WHERE ExternalId__c IN :externalID];
    }
    public static List<vlocity_cmt__Party__c> getPartyById(Set<String> contactId) {
        return [SELECT Id, vlocity_cmt__ContactId__c, CreatedDate, vlocity_cmt__ContactId__r.AssistantPhone FROM vlocity_cmt__Party__c WHERE vlocity_cmt__ContactId__c IN :contactId Limit 1];
    }

    public static List<Asset> getAssetByExternalId(String externalId) {
        return [SELECT Id, Account.ExternalId__c, ContactId, PhoneNumber__c FROM Asset WHERE ExternalId__c = :externalId ];
    }
    private static void handleException(RestResponse res, String errorCode, String message, Integer statusCode) {
        res.statusCode = statusCode;
        res.responseBody = Blob.valueOf(
            JSON.serialize(new Map<String, Object>{
                'errorCode' => errorCode,
                'message' => message
            })
        );
    }
    
    public class responseError {
        public String errorCode{ get; set; }
        public String message{ get; set; }
    }
}