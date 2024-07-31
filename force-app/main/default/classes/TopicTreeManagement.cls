@RestResource(urlMapping    ='/TopicTreeManagement/v1/*')
global with sharing class TopicTreeManagement {
    private static final String isOmniTree = RestContext.request.params.get('omnitree');
    private static final String isGpsFlow = RestContext.request.params.get('gpsFlow');    
    

    @HttpGet
    global static void getTopicTree() {  
        
        
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        getTopicTreeResponseWrapper.responseSucess responseBody = new getTopicTreeResponseWrapper.responseSucess();
        List<getTopicTreeResponseWrapper.topicTree> responseBodyItens = new List<getTopicTreeResponseWrapper.topicTree>();
        try{ 
            String headerXAuth = RestContext.request.headers.get('x-Authorization');
            if(!String.isNotBlank(headerXAuth)) {
                handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
                return;
            }
            String[] jwtParts = headerXAuth.split(' ');
            String incomingJwt = jwtParts[1];
            Boolean isValidJwt = JWTUtility.isValidJwt(incomingJwt);
            if(isValidJwt){
                String productTypeParam = RestContext.request.params.get('productType');
                List<String> productTypeList = new List<String>();
                List<String> productTypeListQuery = new List<String>();
                if(productTypeParam != null){
                    productTypeParam = productTypeParam.replace('\'',''); //Taking out '
                    productTypeParam = productTypeParam.replace(' ',''); //Taking out space
                    productTypeList = productTypeParam.split(',');
                    for(String str : productTypeList){
                        str = '\'' + str + '\'';
                        
                        productTypeListQuery.add(str);
                    }
                }
                String query = '';
                query += 'SELECT Id, Name, GPSFlow__c, Omnitree__c, ProductType__c FROM CustomerInteractionTopicTree__c';
                if(isOmniTree == 'true'){
                    query += (query.contains('WHERE') ? ' AND ' : ' WHERE ') + ' Omnitree__c != null';
                }

                if(isGpsFlow == 'true'){
                    query += (query.contains('WHERE') ? ' AND ' : ' WHERE ') + ' GPSFlow__c != null';
                }

                if(productTypeListQuery.size() > 0){
                    query += (query.contains('WHERE') ? ' AND ' : ' WHERE ') + ' ProductType__c IN '+productTypeListQuery;
                }
                List<CustomerInteractionTopicTree__c> listTopicTree = Database.Query(query);
                if(listTopicTree.size() > 0){
                    Map<String, RecordType> recordTypeMap = new Map<String, RecordType>();
                    List<RecordType> recordType = [SELECT Name, DeveloperName FROM RecordType WHERE SObjectType = 'Case'];
                    if(recordType.size() > 0) {
                        for(RecordType recType : recordType){
                            recordTypeMap.put(recType.Name.toUpperCase(), recType);
                        }
                    }
                    for(CustomerInteractionTopicTree__c topicTree : listTopicTree){
                        getTopicTreeResponseWrapper.topicTree responseList = new getTopicTreeResponseWrapper.topicTree();
                        responseList.id = topicTree.Id;
                        responseList.name = topicTree.Name;
                        responseList.gpsFlow = topicTree.GPSFlow__c;
                        responseList.omniTree = topicTree.OmniTree__c;
                        responseList.productType = topicTree.ProductType__c;

                        if(isOmniTree == 'true') {
                            if(topicTree.OmniTree__c != null) {
                                String recordTypeName = topicTree.OmniTree__c.substringBefore(' > ');

                                responseList.caseRecordTypeDevName = recordTypeMap.get(recordTypeName.toUpperCase())?.DeveloperName;
                            }
                        }
                        
                        responseBodyItens.add(responseList);     
                    }
                    responseBody.topicTree = responseBodyItens;
                    res.statusCode = 200;
                    res.responseBody = Blob.valueOf(JSON.serialize(responseBody));
                }else{
                    handleException(res, 'Could not find a match for URL', 'NOT_FOUND', 404);
                }

            }else{
                handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
           }
                   
        }catch (Exception ex) {
            handleException(res, ex.getMessage(), 'Exception', 500);
        } 
    }

    private static void handleException(RestResponse res, String errorMessage, String errorCode, Integer statusCode) {
        List<getTopicTreeResponseWrapper.responseError> bodyError = new List<getTopicTreeResponseWrapper.responseError>();
        getTopicTreeResponseWrapper.responseError errorMsg = new getTopicTreeResponseWrapper.responseError();
        errorMsg.errorCode = errorCode;
        errorMsg.message = errorMessage;
        bodyError.add(errorMsg);
        res.responseBody = Blob.valueOf(json.serialize(bodyError));
        res.statusCode = statusCode;
    }

    
}