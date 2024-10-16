@RestResource(urlMapping='/CaseManagement/v1/*')
global with sharing class CaseManagement {
    private static UUIDService service;
    private static final String CUSTOMER_INTERACTION_STATUS = 'Completed';
    private static final String CUSTOMER_INTERACTION_TYPE = 'Mobile App';
    private static final String CUSTOMER_INTERACTION_TOPIC_PROCESS_NAME = 'Palitagem Automática';

    @HttpPost
    global static void createCase() {
        RestResponse res = RestContext.response;
        SavePoint savePointdml;
        try {
            String headerXAuth = RestContext.request.headers.get('x-Authorization');
            res.addHeader('Content-Type', 'application/json');       

            if(!String.isNotBlank(headerXAuth)){
                handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
                return;
            } 
 
            String[] jwtParts = headerXAuth.split(' ');
            String authorizationHeaderValue = jwtParts[1];
            //Validação do JWT.
            if (JWTUtility.isValidJwt(authorizationHeaderValue)) {
                //Conversão do JSON recebido na classe apex CreateCaseRequestWrapper.
                Blob requestBody = RestContext.request.requestBody;
                String requestBodyString = requestBody.toString();
                CreateCaseRequestWrapper requestWrapper = (CreateCaseRequestWrapper)JSON.deserialize(requestBodyString, CreateCaseRequestWrapper.class);
                //UUID e CPF da requisição que serão utilizados na validação do UUID.
                String UUID = JWTUtility.getJWTBody(authorizationHeaderValue).sub;
                String CPF = requestWrapper.accountRef.documentNumber;

                service = new UUIDService(UUID, CPF);
                //Validação do UUID.
                if (service.uuIDIsValid()) {    
                    //Criação do savePoint do banco de dados para rollback no caso de algum erro na execução posterior.
                    savePointDml = Database.setSavepoint();

                    Account thisAccount = [SELECT Id, Name, vlocity_cmt__PrimaryContactId__c FROM Account WHERE DocumentNumber__c =: requestWrapper.accountRef.documentNumber];

                    //Criação do asset associado ao caso.
                    List<Asset> newAssets = MergeAssetController.createAssets(String.valueOf(thisAccount.Id),  requestWrapper.accountRef.documentNumber, requestWrapper.AssetRef.payload);

                    String recordTypeDevName = requestWrapper.caseRef.recordTypeDevName;
                    Map<String, Schema.RecordTypeInfo> recordTypesCase = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName();
                    Id recordTypeIdCase = recordTypesCase.get(recordTypeDevName).getRecordTypeId();
                    String recordTypeNameCase = recordTypesCase.get(recordTypeDevName).getName();

                    // Cria Posicionamento do Caso (vlocity_cmt__CustomerInteraction__c)
                    vlocity_cmt__CustomerInteraction__c newCustomerInteraction = buildCustomerInteraction(thisAccount, newAssets[0], requestWrapper.caseRef, recordTypeNameCase);
                    Insert newCustomerInteraction; 


                    //Criação dos registros que devem ser inseridos na Salesforce rebendo os dados do JSON do chamado.
                    Case newCase = new Case();
                    //Inserção do recordType do caso de acordo com o recordType recebido na requisição.
                    Contact caseContact = [SELECT Id FROM Contact WHERE ExternalId__c =: requestWrapper.accountRef.documentNumber];
                    newCase.ContactId = caseContact.Id;
                    newCase.RecordTypeId = recordTypeIdCase;
                    newCase.Status = requestWrapper.caseRef.status;
                    newCase.ContactPhone__c = requestWrapper.caseRef.contactPhone;
                    newCase.Protocol__c = requestWrapper.caseRef.protocol;
                    newCase.Description = requestWrapper.caseRef.description;
                    newCase.ServiceReason__c  = requestWrapper.caseRef.serviceReason;
                    newCase.CustomerInteractionTopicTree__c = requestWrapper.caseRef.topicTreeId;
                    newCase.Origin = requestWrapper.caseRef.origin;
                    newCase.OmniChannel__c = true;
                    newCase.AccountId = thisAccount.Id;
                    newCase.ComplainedAsset__c = newAssets[0].Id;
                    newCase.CustomerInteractionId__c = newCustomerInteraction.Id;
                    Insert newCase;

                    CaseDetail__c newCaseDetail = new CaseDetail__c();
                    //Inserção do recordType do caso de acordo com o recordType recebido na requisição.
                    String recordTypeDevNameCaseDetail = requestWrapper.CaseDetailRef.recordTypeDevName;
                    Map<String, Schema.RecordTypeInfo> recordTypesCaseDetail = Schema.SObjectType.CaseDetail__c.getRecordTypeInfosByDeveloperName();
                    Id recordTypeIdCaseDetail = recordTypesCaseDetail.get(recordTypeDevNameCaseDetail).getRecordTypeId();
                    newCaseDetail.RecordTypeId = recordTypeIdCaseDetail;
                    newCaseDetail.OrderNumber__c = requestWrapper.caseDetailRef.orderNumber;
                    newCaseDetail.CEP__c = requestWrapper.caseDetailRef.cep;
                    newCaseDetail.Street__c = requestWrapper.caseDetailRef.street;
                    newCaseDetail.AddresNumber__c = requestWrapper.caseDetailRef.addresNumber;
                    //Caso o campo esteja nulo, assinala false como padrão, caso não, assinala o valor do campo do json.
                    newCaseDetail.haveAddressNumber__c = requestWrapper.caseDetailRef.haveAddressNumber ?? false;
                    newCaseDetail.WithoutComplement__c = requestWrapper.caseDetailRef.withoutComplement ?? false;
                    newCaseDetail.Complement__c = requestWrapper.caseDetailRef.complement;
                    newCaseDetail.ReferencePoint__c = requestWrapper.caseDetailRef.referencePoint;
                    newCaseDetail.Neighborhood__c = requestWrapper.caseDetailRef.neighborhood;
                    newCaseDetail.City__c = requestWrapper.caseDetailRef.city;
                    newCaseDetail.State__c = requestWrapper.caseDetailRef.state;
                    newCaseDetail.ModifyBillingAddress__c = requestWrapper.caseDetailRef.modifyBillingAddress ?? false;
                    if(requestWrapper.caseDetailRef.firstDateOption != null) {
                        newCaseDetail.DateOption1__c = Date.valueOf(requestWrapper.caseDetailRef.firstDateOption);
                    }
                    newCaseDetail.Case__c = newCase.Id;
                    newCaseDetail.PeriodOption1__c = requestWrapper.caseDetailRef.firstPeriodOption;
                    if(requestWrapper.caseDetailRef.secondDateOption != null) {
                        newCaseDetail.DateOption2__c = Date.valueOf(requestWrapper.caseDetailRef.secondDateOption);
                    }
                    newCaseDetail.PeriodOption2__c = requestWrapper.caseDetailRef.secondPeriodOption;
                    Insert newCaseDetail;

                    //Lista de arquivos associados ao caso.
                    List<FileLink__c> fileLinksList = new List<FileLink__c>();
                    if(requestWrapper.fileLinksRef != null) {
                        for(CreateCaseRequestWrapper.FileLinksRef fileLink: requestWrapper.fileLinksRef) {
                            FileLink__c newFileLink = new FileLink__c();
                            newFileLink.IDGedoc__c = fileLink.idGedoc;
                            newFileLink.FileDescription__c = fileLink.fileDescription;
                            newFileLink.Case__c = newCase.Id;
    
                            fileLinksList.add(newFileLink);
                        }
                        Insert fileLinksList;
                    }


                    CustomerInteractionTopicTree__c customerInteractionTopicTreeRec = CustomerInteractionTopicTreeDAO.getById(newCase.CustomerInteractionTopicTree__c);

                    // Cria Palito do Caso (vlocity_cmt__CustomerInteractionTopic__c)
                    vlocity_cmt__CustomerInteractionTopic__c newInteractionTopic = buildCustomerInteractionTopic(newCustomerInteraction, thisAccount, newAssets[0], newCase, customerInteractionTopicTreeRec, recordTypeNameCase);
                    Insert newInteractionTopic;


                    //Sucesso, faz a criação do responseWrapper que deve ser retornado.
                    res.statuscode = 200;
                    CaseManagement.ResponseWrapper responseWrapper = new CaseManagement.ResponseWrapper();
                    responseWrapper.caseRef = new CaseRef();
                    responseWrapper.caseRef.id = String.valueOf(newCase.Id);
                    responseWrapper.caseDetailRef = new CaseDetailRef();
                    responseWrapper.caseDetailRef.id = String.valueOf(newCaseDetail.Id);
                    responseWrapper.fileLinksRef = new List<CaseManagement.FileLinksRef>();
                    responseWrapper.assetRef = new AssetRef();
                    responseWrapper.assetRef.id = String.valueOf(newAssets[0].Id);
                    for(FileLink__c fileLink: fileLinksList) {
                        CaseManagement.FileLinksRef newFileLink = new CaseManagement.FileLinksRef();
                        newFileLink.id = String.valueOf(fileLink.Id);
                        responseWrapper.fileLinksRef.add(newFileLink);
                    }
                    res.responseBody = Blob.valueOf(JSON.serialize(responseWrapper)); 
                } else {
                    //Caso o UUID não seja válido.
                    handleException(res, 'Forbidden', 'Forbidden', 403);
                }
            } else {
                //Caso o JWT não seja válido.
                handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
            }
            
        } catch (Exception e) {
            //Lidar com erros que podem ocorrer durante a execução.
            Database.rollback(savePointDml);
            handleException(res, e.getMessage(), 'Exception', 500);
        }
    }

    private static vlocity_cmt__CustomerInteraction__c buildCustomerInteraction(Account accountRec, Asset assetRec, CreateCaseRequestWrapper.CaseRef caseRef, String recordTypeNameCase) {
        vlocity_cmt__CustomerInteraction__c newCustomerInteraction = new vlocity_cmt__CustomerInteraction__c();
        newCustomerInteraction.Name = accountRec.Name;
        newCustomerInteraction.vlocity_cmt__AccountId__c = accountRec.Id;
        newCustomerInteraction.vlocity_cmt__ContactId__c = accountRec.vlocity_cmt__PrimaryContactId__c;
        newCustomerInteraction.vlocity_cmt__Status__c = CUSTOMER_INTERACTION_STATUS;
        newCustomerInteraction.vlocity_cmt__Type__c = CUSTOMER_INTERACTION_TYPE;
        newCustomerInteraction.IdentifierNumber__c = assetRec.Name;
        newCustomerInteraction.InteractionNumber__c = caseRef.protocol;
        newCustomerInteraction.Origin__c = caseRef.origin;
        newCustomerInteraction.Subject__c = recordTypeNameCase;
        return newCustomerInteraction;
    }

    private static vlocity_cmt__CustomerInteractionTopic__c buildCustomerInteractionTopic(vlocity_cmt__CustomerInteraction__c customerInteractionRec, Account accountRec, Asset assetRec, Case caseRec, CustomerInteractionTopicTree__c customerInteractionTopicTreeRec, String recordTypeNameCase) {
        vlocity_cmt__CustomerInteractionTopic__c newInteractionTopic = new vlocity_cmt__CustomerInteractionTopic__c();
        newInteractionTopic.vlocity_cmt__CustomerInteractionId__c = customerInteractionRec.Id;
        newInteractionTopic.vlocity_cmt__AccountId__c = accountRec.Id;
        newInteractionTopic.vlocity_cmt__AssetId__c	= assetRec.Id;
        newInteractionTopic.vlocity_cmt__CaseId__c = caseRec.Id;
        newInteractionTopic.vlocity_cmt__Reason__c = recordTypeNameCase;
        newInteractionTopic.vlocity_cmt__ProcessName__c = CUSTOMER_INTERACTION_TOPIC_PROCESS_NAME;
        newInteractionTopic.Origin__c = caseRec.Origin;
        newInteractionTopic.TopicName__c = caseRec.ServiceReason__c;
        newInteractionTopic.ServiceTree__c = customerInteractionTopicTreeRec.ServiceTree__c;
        return newInteractionTopic;
    }

    @HttpGet
    global static void getCases(){
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        try {
            String headerXAuth = RestContext.request.headers.get('x-Authorization');
            
            res.addHeader('Content-Type', 'application/json');
            if(String.isBlank(headerXAuth)){
                handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
                return;
            }
            String[] jwtParts = headerXAuth.split(' ');
            String authorizationHeaderValue = jwtParts[1];

            if(!JWTUtility.isValidJwt(authorizationHeaderValue)) {
                handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
                return;
            }
            //Conversão do JSON recebido na classe apex CreateCaseRequestWrapper.
            Blob requestBody = RestContext.request.requestBody;
            List<String> urlParts = RestContext.request.requestURI.split('/');
            String urlLastPart = urlParts[urlParts.size() - 1];
            List<String> urlPartsWithParameters = urlLastPart.split('\\?');
            String urlLastPartWithoutParameter = urlPartsWithParameters.get(0);
            Boolean isId = urlLastPartWithoutParameter.length() == 18; 
            String UUID = JWTUtility.getJWTBody(authorizationHeaderValue).sub;
            String CPF;
            if(isId) {
                Case[] selectedCase = [SELECT Id, Account.DocumentNumber__c FROM Case WHERE Id = :urlLastPartWithoutParameter];
                if(selectedCase.size() > 0){
                    CPF = selectedCase[0].Account.DocumentNumber__c;
                }
                
            } else {
                CPF = req.params.get('documentNumber');
            }
            service = new UUIDService(UUID, CPF);

            if(!service.uuIDIsValid()) {
                handleException(res, 'Forbidden', 'Forbidden', 403);
                return;
            }
            List<GetCasesRequestWrapper.Cases> responseBodyItens = new List<GetCasesRequestWrapper.Cases>();
            if(isId){
                String caseId = urlLastPartWithoutParameter;
                String query = '';
                Case[] caseReferenceList = [SELECT Id,ComplainedAsset__c,ComplainedAsset__r.MainProductDescription__c,ComplainedAsset__r.Name,ContactPhone__c,CustomerInteractionTopicTree__c,CustomerInteractionTopicTree__r.Name,StatusOmniChannel__c,Protocol__c,ContactPhone,Origin,RecordType.DeveloperName,RecordType.Name,CreatedDate,Status,account.DocumentNumber__c, Description FROM Case WHERE Id = :caseId];
                GetCasesRequestWrapper.Cases responseWrapperReturn = new GetCasesRequestWrapper.Cases();
                if(caseReferenceList.size() > 0){
                    Case caseReference = caseReferenceList[0];

                    responseWrapperReturn = buildCase(caseReference);
                   
                    res.responseBody = Blob.valueOf(Json.serialize(responseWrapperReturn));
                    res.statusCode = 200;
                
                }else{
                    res.statusCode = 404;
                }  
            } else {
                GetCasesRequestWrapper responseBody = new GetCasesRequestWrapper();
                String orderStatus = RestContext.request.params.get('orderStatus');
                Boolean isPrePaid = service.isPrePaid(); 
                String query = 'SELECT Id,ComplainedAsset__c,ComplainedAsset__r.MainProductDescription__c,ComplainedAsset__r.Name,ContactPhone__c,CustomerInteractionTopicTree__c,CustomerInteractionTopicTree__r.Name,StatusOmniChannel__c,Protocol__c,ContactPhone,Origin,RecordType.Name,RecordType.DeveloperName,CreatedDate,Status,account.DocumentNumber__c,Description FROM case';                query += buildQueryParameters(isPrePaid);
                List<Case> listCases = Database.query(query);
                if(listCases.size() > 0){
                    List<Case> listTodoMundoOrdenado = new List<Case>();
                    if (orderStatus != null) {
                        listTodoMundoOrdenado = orderByStatus(listCases, orderStatus);
                    }else{
                        listTodoMundoOrdenado.addAll(listCases);
                        
                    }
                    for(Case cases : listTodoMundoOrdenado){
                        GetCasesRequestWrapper.Cases responseWrapperReturn = buildCase(cases);
                        responseBodyItens.add(responseWrapperReturn);
                    }
                    responseBody.Cases = responseBodyItens;
                    res.responseBody = Blob.valueOf(Json.serialize(responseBody));
                    res.statusCode = 200;

                }else{
                    List<GetCasesRequestWrapper.returnEmpty> responseWrapperReturnEmpty = new List<GetCasesRequestWrapper.returnEmpty>();
                    res.responseBody = Blob.valueOf(Json.serialize(responseWrapperReturnEmpty));
                    res.statusCode = 200;
                }
            }
        } catch (Exception e) {
            handleException(res, e.getMessage(), 'Exception', 500);
        }
    }

    @HttpPatch
    global static void updateCase(){
        CaseManagementUpdateCase.updateCase();
    }

    private static List<Case> orderByStatus(List<Case> caseWithoutOrder, String orderStatus){
        List<Case> listNewOrder = new List<Case>();
        orderStatus = orderStatus.replaceAll('\'', '');
        List<String> listOrder = orderStatus.split(',');
        for(String status: listOrder){
            status = status.trim();
            for(Case caseItem : caseWithoutOrder){
                if(caseItem.StatusOmniChannel__c == status){
                    listNewOrder.add(caseItem);
                }
            }
        }

        for(Case caseItemRestos : caseWithoutOrder){
            if(!listNewOrder.contains(caseItemRestos)){
                listNewOrder.add(caseItemRestos);
            }
        }

        return listNewOrder;
        
    }

    private static GetCasesRequestWrapper.Cases buildCase(Case cases) {
        List<Case> caseList = new List<Case>();
        caseList.add(cases);

        List < CaseComment__c > caseCommentList = getCaseCommentsByCaseId(caseList);
        Map<Id, List<CaseComment__c>> mapCaseComment = new Map<Id, List<CaseComment__c>>();

        if (!caseCommentList.isEmpty()) {  
            for (CaseComment__c caseComment : caseCommentList) {
                if (!mapCaseComment.containsKey(caseComment.ParentId__c)) {
                    mapCaseComment.put(caseComment.ParentId__c, new List<CaseComment__c>());
                }
                mapCaseComment.get(caseComment.ParentId__c).add(caseComment);
            }
        }

        List<CaseDetail__c> caseDetailList = getCaseDetailByCaseId(caseList);
        GetCasesRequestWrapper.caseDetailRef details = new GetCasesRequestWrapper.caseDetailRef();
        if(caseDetailList.size() > 0){
            //details.RecordTypeId = rtDetail.Id;
            details.orderNumber = caseDetailList[0].OrderNumber__c;
            details.cep = caseDetailList[0].CEP__c;
            details.street = caseDetailList[0].Street__c;
            details.addresNumber = caseDetailList[0].AddresNumber__c;
            details.haveAddressNumber = caseDetailList[0].haveAddressNumber__c;
            details.withoutComplement = caseDetailList[0].WithoutComplement__c;
            details.complement = caseDetailList[0].Complement__c;
            details.referencePoint = caseDetailList[0].ReferencePoint__c;
            details.neighborhood = caseDetailList[0].Neighborhood__c;
            details.city = caseDetailList[0].City__c;
            details.state = caseDetailList[0].State__c;
            details.modifyBillingAddress = caseDetailList[0].ModifyBillingAddress__c;
            details.firstDateOption = String.valueOf(caseDetailList[0].DateOption1__c);
            details.firstPeriodOption = caseDetailList[0].PeriodOption1__c;
            details.secondDateOption = String.valueOf(caseDetailList[0].DateOption2__c);
            details.secondPeriodOption = caseDetailList[0].PeriodOption2__c;
            details.scheduledDate = String.valueOf(caseDetailList[0].ScheduledDate__c);
            details.scheduledPeriod = caseDetailList[0].ScheduledPeriod__c;
        }

        GetCasesRequestWrapper.Cases responseList = new GetCasesRequestWrapper.Cases();
        responseList.assetRef = new GetCasesRequestWrapper.AssetRef();
        responseList.assetRef.displayName = String.valueOf(cases.ComplainedAsset__r.MainProductDescription__c);
        responseList.assetRef.Id = String.valueOf(cases.ComplainedAsset__r.Name);
        responseList.topicTree = new GetCasesRequestWrapper.TopicTree();
        responseList.topicTree.id = cases.CustomerInteractionTopicTree__c;
        responseList.topicTree.name = cases.CustomerInteractionTopicTree__r.Name;
        responseList.caseId = cases.id;
        responseList.omniChannelStatus = cases.StatusOmniChannel__c;
        responseList.contactPhone = cases.ContactPhone__c;
        responseList.protocol = cases.Protocol__c;
        responseList.recordTypeDevName = cases.RecordType.DeveloperName;
        responseList.recordTypeName = cases.RecordType.Name;
        responseList.createDate = String.valueOf(cases.CreatedDate); 
        responseList.origin = cases.Origin;
        responseList.Status = cases.Status;
        responseList.description = cases.Description;            
        responseList.caseCommentRef = new GetCasesRequestWrapper.CaseCommentRef();
        responseList.caseCommentRef.totalUnreadComments =  mapCaseComment.containsKey(cases.Id) ? mapCaseComment.get(cases.Id).size() :0;
        responseList.caseDetailRef =  details;
        return responseList;
        

    }

    private static String buildQueryParameters(Boolean isPrePaid) {
        String queryParameters = '';
        Integer recordsLimit = RestContext.request.params.get('recordsLimit') != null ? Integer.valueOf(RestContext.request.params.get('recordsLimit')) : 10;
        Integer offSet = RestContext.request.params.get('offSet') != null ? Integer.valueOf(RestContext.request.params.get('offSet')) : 0;
        String documentNumber = RestContext.request.params.get('documentNumber');
        String filterStatus = RestContext.request.params.get('filterStatus');
        String initCreatedDate = RestContext.request.params.get('initCreatedDate');
        String finalCreatedDate = RestContext.request.params.get('finalCreatedDate');
        String filterTopicTree = RestContext.request.params.get('topicTreeId');

 
        if (documentNumber != null) {
            if (isPrePaid) {
                queryParameters += ' WHERE ComplainedAsset__r.Account.DocumentNumber__c = \'' + documentNumber + '\' ';
            } else {
                queryParameters += ' WHERE Account.DocumentNumber__c = \'' + documentNumber + '\' ';
            }  
        }
    
        if(filterStatus != null) {
            queryParameters += (queryParameters.contains('WHERE') ? ' AND ' : ' WHERE ') + ' StatusOmniChannel__c IN (' + filterStatus + ')';
        }

        if(initCreatedDate != null ) {
            queryParameters += (queryParameters.contains('WHERE') ? ' AND ' : ' WHERE ') + 'CreatedDate >= '+ initCreatedDate ;
        }
        
        if(finalCreatedDate != null ) {
            queryParameters += (queryParameters.contains('WHERE') ? ' AND ' : ' WHERE ') + 'CreatedDate <= '+ finalCreatedDate;
        }

        if(filterTopicTree != null ) {
            queryParameters += (queryParameters.contains('WHERE') ? ' AND ' : ' WHERE ') + 'CustomerInteractionTopicTree__c  = \'' + filterTopicTree + '\' ';
        }

            
        queryParameters += ' LIMIT ' + recordsLimit + ' OFFSET ' + offSet;  

        return queryParameters;
    }

    public static string formatDateTimeToSoql(DateTime dtime) {
        return string.valueOf(dtime).split(' ')[0] + 'T' + string.valueOf(dtime).split(' ')[1] + '.000Z';
    }

    public static List<CaseComment__c> getCaseCommentsByCaseId(List<Case>  cases){
        List<Id> caseIds = new List<Id>();
        for (Case c : cases) {
            caseIds.add(c.Id);
        }
        return [
            SELECT Id, ParentId__c, ViewDatetime__c
            FROM CaseComment__c
            WHERE ParentId__c IN :caseIds
            AND ViewDatetime__c = null
            ORDER BY CreatedDate ASC
        ];
    }
    
    public static List<CaseDetail__c> getCaseDetailByCaseId(List<Case>  cases){
        List<Id> caseIds = new List<Id>();
        for (Case c : cases) {
            caseIds.add(c.Id);
        }
        return [
            SELECT Id,Case__c,Street__c,CEP__c,AddresNumber__c,haveAddressNumber__c,WithoutComplement__c,Complement__c,ReferencePoint__c,Neighborhood__c,City__c,State__c,ModifyBillingAddress__c,DateOption1__c,
            PeriodOption1__c,DateOption2__c,PeriodOption2__c,ScheduledDate__c,ScheduledPeriod__c,OrderNumber__c
            FROM CaseDetail__c
            WHERE Case__c IN :caseIds
        ];
    }
    
    public static void handleException(RestResponse res, String errorMessage, String errorCode, Integer statusCode) {
        List<CreateCaseRequestWrapper.ResponseError> errors = new List<CreateCaseRequestWrapper.ResponseError>();
        CreateCaseRequestWrapper.ResponseError error = new CreateCaseRequestWrapper.ResponseError();
        error.message = errorMessage;
        error.errorCode = errorCode;
        errors.add(error);
        
        res.responseBody = Blob.valueOf(JSON.serialize(errors));
        res.statusCode = statusCode;
    }

    public static Map<Integer, String> getParamsUrl(){
        String url = RestContext.request.requestURI;
        List<String> urlSplit = url.split('/');
        Map<Integer, String> mapParams = new Map<Integer, String>();
        for(Integer i = 0; i < urlSplit.size(); i++){
            mapParams.put(i, urlSplit.get(i));
        }
        return mapParams;
    }

    public class AssetRef {
        public String id;
    }

    public class CaseRef {
        public String id;
    }

    public class CaseDetailRef {
        public String id;
    }

    public class FileLinksRef {
        public String id;
    }

    public class ResponseWrapper {
        public AssetRef assetRef;
        public CaseRef caseRef;
        public CaseDetailRef caseDetailRef;
        public List<FileLinksRef> fileLinksRef;
    }

}