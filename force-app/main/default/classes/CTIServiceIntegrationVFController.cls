global class CTIServiceIntegrationVFController {
	public String pageURL {get;set;}
    private static final String CASE_ORIGIN_GPS = 'GPS';
    private static final String CASE_ORIGIN_SALESFORCE = 'Salesforce';
    private static final String CASE_STATUS_NEW = 'New';
    private static final String OBSERVATION_NEW_LINE = ' / ';
    private static final String CASE_STATUS_CLOSED = 'Closed';
    private static final String CASE_STATUS_CONSULTING = 'Consulting';
    private static final String CASE_STATUS_IN_TRANSFER = 'InTransfer';
    private static final String CASE_STATUS_CALL_DROPPED = 'CallDropped';
    private static final String CASE_ORIGIN_CALL_DROPPED = 'CallDropped';
    private static final String CASE_SUBJECT_CALL_DROPPED = 'Ligação Caiu';
    private static final String CUSTOM_SETTING_CALL_DROPPED = 'LigacaoCaiu';
    private static final String BUSINESS_RULE_CALL_DROPPED = 'LIGACAO CAIU';
    private static final String CASE_RECORD_TYPE_CALL_DROPPED = 'CallDroped';
    private static final String CASE_RECORD_TYPE_MOBILE_CALL_DROPPED = 'CallDroped';
    private static final String CASE_STATUS_EM_ATENDIMENTO = 'Em Atendimento';
    private static final String CTI_INTEGRATION_QUEUE = 'CTIIntegrationQueue';
    private static final String CASE_CLOSURE_CALL_DROPPED = 'Informação > Atendimento > Ligação > Caiu';
    private static final String CASE_DESCRIPTION_CALL_DROPPED = 'Identificado queda da ligação durante o atendimento.';
    private static final String CASE_ORIGIN_SFA_NEXT = 'SFA Script - Next';

    public void init() {
        pageURL = ApexPages.currentPage().getHeaders().get('referer');        
    }

    @RemoteAction
    global static String getAccountId(String caseId) {
        return [SELECT Id, AccountId FROM Case WHERE Id =: caseId LIMIT 1].AccountId;
    }

    @RemoteAction
    global static Boolean sendCaseToQueue(Map<String, String> payload) {
        try {
            Case wdeCase = CaseDAO.getCasebyId(payload.get('CaseId__c'));
            List<Group> queue = GroupDAO.getQueueByName(CTI_INTEGRATION_QUEUE);
            wdeCase.OwnerId = queue[0].id;
            update wdeCase;

            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @RemoteAction
    global static Boolean updateWdeCase(Map<String, String> payload) {

        try {
            system.debug('Enter into updateWdeCase payload: ' + payload);
            Boolean methodReturn = true;
            Case wdeCase = CaseDAO.getCasebyId(payload.get('CaseId__c'));            

            String operationType = payload.get('OperationType__c');

            if(operationType == 'DirectTransfer' || operationType == 'AssistedTransfer'){

                if(operationType == 'DirectTransfer'){
                    wdeCase.Status = CASE_STATUS_IN_TRANSFER;
                }else{
                    wdeCase.Status = CASE_STATUS_CONSULTING;
                }

                if(wdeCase.TransferObservation__c != null){
                    wdeCase.TransferObservation__c = wdeCase.TransferObservation__c + OBSERVATION_NEW_LINE + payload.get('Observation__c');
                }else{
                    wdeCase.TransferObservation__c = payload.get('Observation__c');
                }
                
                wdeCase.OriginCell__c = payload.get('OriginCell__c');
                wdeCase.DestinyCell__c = payload.get('DestinyCell__c');
                wdeCase.ServiceRequestId__c = payload.get('ServiceRequestId__c');
                wdeCase.ServiceRequestStatus__c = payload.get('ServiceRequestStatus__c');

                if(payload.get('Context__c') != null && payload.get('Context__c') == 'NonGPS'){
                    wdeCase.Closure__c = payload.get('Closure__c');
                }

            } else if(operationType == 'PerformConsult'){

                wdeCase.Status = CASE_STATUS_CONSULTING;
                wdeCase.OriginCell__c = payload.get('OriginCell__c');
                wdeCase.DestinyCell__c = payload.get('DestinyCell__c');

            } else if(operationType == 'TalkToTheCustomer'){

                wdeCase.Status = wdeCase.Status == CASE_STATUS_EM_ATENDIMENTO ? CASE_STATUS_CONSULTING : CASE_STATUS_EM_ATENDIMENTO;

            } else if(operationType == 'FinalizeConsult' || operationType == 'CancelAssistedTransfer'){

                wdeCase.Status = CASE_STATUS_EM_ATENDIMENTO;

            } else if(operationType == 'FinishAssistedTransfer'){

                wdeCase.Status = CASE_STATUS_IN_TRANSFER;

            } else if(operationType == 'CallDropped'){

                Map<String,String> params = new Map<String,String>();
                User currentUser = UserDAO.getById(UserInfo.getUserId());
                Account currentAccount = AccountDAO.getAccountById(wdeCase.AccountId)[0];
				CustomerInteractionTopicTree__c palito = CustomerInteractionTopicTreeDAO.getEndFlowCustomerInteractionTopicTreeById(payload.get('selectedTopicTreeId'))[0];         
                String selectedAssetInstance = payload.get('ServiceIdentifier');

                if(wdeCase.ProtocolURA__c != null && wdeCase.ProtocolURA__c != ''){
                    params.put('PROTOCOLO', wdeCase.ProtocolURA__c);
                }
                
                if(wdeCase.CaseNumber != null && wdeCase.CaseNumber != ''){
                    params.put('NUMERO_CASO', wdeCase.CaseNumber);
                }

                if(palito.GPSId__c != null && palito.GPSId__c != ''){
                    params.put('TIPIFICACAO', palito.GPSId__c);
                }

                if(wdeCase.ServiceRequestId__c != null && wdeCase.ServiceRequestId__c != ''){
                    params.put('ID_SS', wdeCase.ServiceRequestId__c);
                }

                ServiceFlowGPSResponse ssInformation = ServiceFlowGPSCallout.createSS(BUSINESS_RULE_CALL_DROPPED, currentAccount.DocumentNumber__c, selectedAssetInstance, currentUser.Alias, params);

                wdeCase.Status = CASE_STATUS_CALL_DROPPED;
                wdeCase.Product__c = selectedAssetInstance;
                wdeCase.Protocol__c = ssInformation.protocolo;
                wdeCase.ServiceRequestId__c = ssInformation.idSS;
                wdeCase.ServiceRequestStatus__c = ssInformation.status;
                wdeCase.ComplainedAsset__c = payload.get('selectedAssetId');                
                wdeCase.Closure__c = CASE_CLOSURE_CALL_DROPPED;

                if(ssInformation.protocolo != null && ssInformation.idSS != null && ssInformation.status != null){
                    wdeCase.Protocol__c = ssInformation.protocolo;
                    wdeCase.ServiceRequestId__c = ssInformation.idSS;
                    wdeCase.ServiceRequestStatus__c = ssInformation.status;
                }else{
                    methodReturn = false;
                }
            }

            update wdeCase;

            return methodReturn;
        } catch (Exception e) {
            return false;
        }
    }
    @RemoteAction
    global static Map<String, Object> createMobileNextDisputeCase(Map<String, Object> payload) {
        Map<String, Object> response = new Map<String, Object>();
        response.put('createdCase', false);
        response.put('createdInteraction', false);
        response.put('workflow', 'createCaseOnWDECallDrop');

        try {
            Id rtypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(CASE_RECORD_TYPE_MOBILE_CALL_DROPPED).getrecordTypeId();
            String customerAccountId = CustomerInteractionDAO.getAccountIdById(String.valueOf(payload.get('CustomerInteractionId__c')));
            Case callDroppedCase = new Case();

            String serviceDefinitionId = null;

            List<ServiceDefinition__c> serviceDefinitions = [
                SELECT Id
                FROM ServiceDefinition__c
                WHERE ServiceDefinitionName__c = 'ATC-MVL-FIN-CONT-ENC-LIG-001'
                LIMIT 1
            ];

            if (serviceDefinitions.size() > 0) {
                serviceDefinitionId = serviceDefinitions[0].Id;
            }

            String currentLine = String.valueOf(payload.get('Line'));
            String productNumber = String.valueOf(payload.get('ServiceIdentifier'));
            String protocolNumber = String.valueOf(payload.get('protocolNumber'));
            
            String nextProtocolNumber = null;

            vlocity_cmt__CustomerInteraction__c serviceIdentifier = CustomerInteractionDAO.getCustomerInteractionById(String.valueOf(payload.get('CustomerInteractionId__c')));

            If (currentLine == null || String.isEmpty(currentLine) || String.isBlank(currentLine) || currentLine == '{Line}' || currentLine == '\'\'') {
                currentLine = null;
                productNumber = null;
            }

            if (protocolNumber == null || String.isEmpty(protocolNumber) || String.isBlank(protocolNumber) || protocolNumber == '{protocolNumber}' || protocolNumber == '\'\'') {
                protocolNumber = null;
            }

            callDroppedCase.AccountId = customerAccountId;
            callDroppedCase.RecordTypeId = rtypeId;
            callDroppedCase.Origin = 'CallDropped';
            callDroppedCase.CustomerInteractionId__c = payload.get('CustomerInteractionId__c') == null ? null : String.valueOf(payload.get('CustomerInteractionId__c'));
            callDroppedCase.ComplainedAsset__c = currentLine;
            callDroppedCase.Subject = 'Ligação Caiu';
            callDroppedCase.Description = 'Identificado queda da ligação durante o atendimento.';
            callDroppedCase.CallerDDD__c = serviceIdentifier.CallerDDD__c;
            callDroppedCase.CallerPhone__c = serviceIdentifier.CallerPhone__c;
            callDroppedCase.Closure__c = 'Informação > Atendimento > Ligação > Caiu';
            callDroppedCase.Product__c = productNumber;
            callDroppedCase.Protocol__c = protocolNumber;
            callDroppedCase.ProtocolURA__c = serviceIdentifier.InteractionNumber__c;
            callDroppedCase.ServiceQualificationMobile__c = 'Informação > Atendimento > Ligação > Caiu';
            callDroppedCase.ServiceDefinitionId__c = serviceDefinitionId;
            insert callDroppedCase;
            
            response.put('createdCase', true);
            response.put('caseId', callDroppedCase.Id);
            
            vlocity_cmt__CustomerInteractionTopic__c customerInteractionTopic = new vlocity_cmt__CustomerInteractionTopic__c();
            customerInteractionTopic.vlocity_cmt__AccountId__c = customerAccountId;
            customerInteractionTopic.Origin__c = CASE_ORIGIN_SFA_NEXT;
            customerInteractionTopic.TopicName__c = 'Informação > Atendimento > Ligação > Caiu';
            customerInteractionTopic.vlocity_cmt__Reason__c = 'Ligação Caiu';
            customerInteractionTopic.remarkup__c = 'Identificado queda da ligação durante o atendimento.';
            customerInteractionTopic.vlocity_cmt__CaseId__c = callDroppedCase.Id;
            customerInteractionTopic.vlocity_cmt__AssetId__c = currentLine;
            customerInteractionTopic.vlocity_cmt__CustomerInteractionId__c = String.valueOf(payload.get('CustomerInteractionId__c'));
            insert customerInteractionTopic;

            response.put('createdInteraction', true);
            response.put('customerInteractionTopicId', customerInteractionTopic.Id);
            
            response.put('error', false);

            return response;

        } catch (Exception e) {
            response.put('error', true);
            response.put('errorMessage', e.getMessage());

            return response;
        }
    }

    @RemoteAction
    global static Map<String, Object> updateMobileNextDisputeCase(Map<String, Object> payload) {
        Map<String, Object> response = new Map<String, Object>();
        response.put('updatedCase', false);
        response.put('workflow', 'updateCaseOnWDECallDrop');
        
        try {
            String caseId = String.valueOf(payload.get('CaseId__c'));

            if (caseId == null || String.isEmpty(caseId) || String.isBlank(caseId) || caseId == '{CaseId__c}' || caseId == '\'\'') {
                caseId = null;
            }

            Case wdeCase = CaseDAO.getCasebyId(caseId);

            wdeCase.Status = 'CallDropped';
            wdeCase.Closure__c = 'Informação > Atendimento > Ligação > Caiu';

            upsert wdeCase;

            response.put('updatedCase', true);
            response.put('error', false);

            return response;

        } catch (Exception e) {
            response.put('error', true);
            response.put('errorMessage', e.getMessage());

            return response;
        }
    }
    @RemoteAction
    global static Boolean setCaseOwnerAsCurrentUser(Map<String, String> payload) {

        try {
            Case wdeCase = CaseDAO.getCasebyId(payload.get('CaseId__c'));

            wdeCase.OwnerId = UserInfo.getUserId();
    
            update wdeCase;
    
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @RemoteAction
    global static Boolean createCase(Map<String, String> payload) {
        try {
            system.debug('Enter into createCase payload: ' + payload);
            Boolean methodReturn = true;            
            String customerInteractionId = payload.get('CustomerInteractionId__c');
            String accountId = CustomerInteractionDAO.getAccountIdById(customerInteractionId); 
            String serviceIdentifier = CustomerInteractionDAO.getIdentifierNumberById(customerInteractionId);
            List<Asset> selectedAsset = AssetDAO.getAssetIdByIdentifiers(serviceIdentifier, accountId);
            
            
            if (selectedAsset.size() == 0) {
                selectedAsset = AssetDAO.getAssetIdWithoutIdentifiers(accountId);
            }
            
            if (selectedAsset.size() > 0) {
                String caseId = createCase(accountId, customerInteractionId, selectedAsset[0].vlocity_cmt__ServiceIdentifier__c, selectedAsset[0].Id);
                createCustomerInteractionTopic(caseId, customerInteractionId, selectedAsset[0].Id, accountId, CASE_ORIGIN_GPS);
            } else {
                createCustomerInteractionTopic(null, customerInteractionId, null, accountId, CASE_ORIGIN_SALESFORCE);
            }
            
            return methodReturn;

        } catch (Exception e) {
            return false;
        }
    }
    private static void createCustomerInteractionTopic(String caseId, String customerInteractionId, String selectedAssetId, String accountId, String origin) {
        try {
            vlocity_cmt__CustomerInteractionTopic__c newCustomerInteractionTopic = new vlocity_cmt__CustomerInteractionTopic__c();
            newCustomerInteractionTopic.vlocity_cmt__AccountId__c = accountId;
            newCustomerInteractionTopic.vlocity_cmt__CustomerInteractionId__c = customerInteractionId;
            newCustomerInteractionTopic.vlocity_cmt__AssetId__c = selectedAssetId;
            newCustomerInteractionTopic.vlocity_cmt__CaseId__c = caseId;
            newCustomerInteractionTopic.Origin__c = origin;
            newCustomerInteractionTopic.vlocity_cmt__Reason__c = CASE_SUBJECT_CALL_DROPPED;
            newCustomerInteractionTopic.remarkup__c = CASE_DESCRIPTION_CALL_DROPPED;
            newCustomerInteractionTopic.TopicName__c = CASE_CLOSURE_CALL_DROPPED;
            
            insert newCustomerInteractionTopic;
        } catch(Exception e) {
            System.debug('Erro ao criar o palito: ' + e.getMessage());
        }
    }

    private static String createCase(String accountId, String customerInteractionId, String selectedAssetInstance, String selectedAssetId) {
        try {
        	Case newCase = new Case();
            User currentUser = UserDAO.getById(UserInfo.getUserId());
            Account currentAccount = AccountDAO.getAccountById(accountId)[0];
            GenericOptionsLists__c callDroppedServiceId = GenericOptionsLists__c.getValues(CUSTOM_SETTING_CALL_DROPPED);
            Id rtypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(CASE_RECORD_TYPE_CALL_DROPPED).getrecordTypeId();
            vlocity_cmt__CustomerInteraction__c currentInteraction = CustomerInteractionDAO.getCustomerInteractionById(customerInteractionId);

            newCase.AccountId = accountId;            
            newCase.CustomerInteractionId__c = currentInteraction.Id;
            newCase.RecordTypeId = rtypeId;
            newCase.Status = CASE_STATUS_NEW;
            newCase.Origin = CASE_ORIGIN_CALL_DROPPED;
            newCase.Product__c = selectedAssetInstance;            
            newCase.ComplainedAsset__c = selectedAssetId;
            newCase.Subject = CASE_SUBJECT_CALL_DROPPED;
            newCase.Closure__c = CASE_CLOSURE_CALL_DROPPED;            
            newCase.Description = CASE_DESCRIPTION_CALL_DROPPED;
            newCase.ProtocolURA__c = currentInteraction.InteractionNumber__c;
            newCase.CallerDDD__c = currentInteraction.CallerDDD__c;
            newCase.CallerPhone__c = currentInteraction.CallerPhone__c;
            newCase.ServiceQualificationMobile__c = CASE_CLOSURE_CALL_DROPPED;

            insert newCase;

            updateCallDroppedCase(newCase.id, currentAccount.DocumentNumber__C,selectedAssetInstance, currentUser.Alias);
        
        	return newCase.id;
        } catch(Exception e) {
            System.debug('Erro ao criar o caso: ' + e.getMessage());
            return null;
        }	        
    }
    @future(callout=true)
    private static void updateCallDroppedCase(String caseId, String cnpj, String selectedAssetInstance, String userAlias){
        try{
            Case savedCase = CaseDAO.getCasebyId(caseId);
            Map<String,String> params = new Map<String,String>();

            if(savedCase.ProtocolURA__c != null && savedCase.ProtocolURA__c != ''){
                params.put('PROTOCOLO', savedCase.ProtocolURA__c);
            }

            if(savedCase.CaseNumber != null && savedCase.CaseNumber != ''){
                params.put('NUMERO_CASO', savedCase.CaseNumber);
            }

            ServiceFlowGPSResponse ssInformation = ServiceFlowGPSCallout.createSS(BUSINESS_RULE_CALL_DROPPED, cnpj, selectedAssetInstance, userAlias, params);
            
            savedCase.Protocol__c = ssInformation.protocolo;
            savedCase.ServiceRequestId__c = ssInformation.idSS;
            savedCase.ServiceRequestStatus__c = ssInformation.status;
            savedCase.Status = CASE_STATUS_CLOSED;

            update savedCase;
        }catch(Exception e){
            System.debug('Erro ao atualizar caso de ligação caiu: '+e.getMessage());
        }
    }

    @RemoteAction
    global static Boolean closeCaseIfNonCanvas(String caseId) {

        try {
            Case wdeCase = CaseDAO.getCasebyId(caseId);

            if(wdeCase.Origin == CASE_ORIGIN_GPS && wdeCase.Closure__c != null){
                wdeCase.Status = CASE_STATUS_CLOSED;
                update wdeCase;
            }

            return true;

        } catch (Exception e) {
            return false;
        }
    }
}