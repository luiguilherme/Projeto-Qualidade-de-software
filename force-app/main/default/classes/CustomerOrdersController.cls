global with sharing class CustomerOrdersController implements vlocity_cmt.VlocityOpenInterface2 {

     global Object invokeMethod(String methodName, Map<String,Object> inputMap,
                                Map<String,Object> outMap, Map<String,Object> options) {
        Boolean success = true;
        String errors = 'OK';
        try{
            switch on methodName {
                when 'getOrders' {
                    getOrders(inputMap, outMap, options); 
                }
            }

        } catch(Exception e) {
            errors = e.getMessage();
            success = false;
        }
        outMap.put('success', success);
        outMap.put('error', errors);

        return success;
    }
    
    public void getOrders(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        
        //GetParameters
        Id accountId = (Id) inputMap.get('AccountId');
        String initialDate =  (String) inputMap.get('InitialDate');        
        String endDate =  (String) inputMap.get('EndDate');
        String protocolNumber = (String) inputMap.get('ProtocolNumber');
        String lineNumber = (String) inputMap.get('LineNumber');
        String orderNumber = (String) inputMap.get('OrderNumber');
        Decimal page = (Decimal) inputMap.get('Page');
        Integer numRecords = (Integer) inputMap.get('NumRecords');
        Id recordTypeIdFilter = (Id) inputMap.get('RecordTypeIdFilter');
        
        //Set Default Query     
        String query;
        String queryTemplate = setQueryTemplate();
        String queryWhere = setQueryWhere();
        String subQuery = setSubQuery();
        String queryFields = setQueryFields();
        
        //Conditional Query

        if(hasParameter(initialDate) && hasParameter(endDate)){
            Datetime initialDateTimeQuery = formatDate('Inital', initialDate);
            Datetime endDateTimeQuery = formatDate('end', endDate);
            
            queryWhere += 'and CreatedDate >= :initialDateTimeQuery and CreatedDate <= :endDateTimeQuery ';            
        }
        
        if(hasParameter(orderNumber)){
            queryWhere += 'and OrderNumber = :orderNumber ';
        }
        
        if(hasParameter(lineNumber)){
            queryWhere += 'and Id in (select OrderId from OrderItem where vlocity_cmt__SubscriptionId__r.vlocity_cmt__ServiceIdentifier__c = :lineNumber) ';
        }
        
        if(hasParameter(protocolNumber)){
            queryWhere += 'and Id in (select vlocity_cmt__OrderId__c from vlocity_cmt__CustomerInteractionTopic__c where vlocity_cmt__CustomerInteractionId__r.InteractionNumber__c = :protocolNumber) ';
        }
        
        if(hasParameter(recordTypeIdFilter)){
            queryWhere += 'and RecordTypeId != :recordTypeIdFilter ';
        }
        
        String queryLimit = 'order by CreatedDate desc limit '+ numRecords + ' offset '+ page;
        
        //execute Query
        List<Object> queryParameters = new List<Object> {queryFields, subQuery, queryWhere, queryLimit};
        query = String.format(queryTemplate,queryParameters);
        
        List<Order> orderList = Database.query(query);       
        
        //get Total Pages
        queryParameters = new List<Object> {'count()','', queryWhere,''};
        query = String.format(queryTemplate,queryParameters);
                
        Integer totalSize = Database.countQuery(query);
        system.debug('totalsize:' + totalSize);
        
        Decimal totalPages = (TotalSize / (Decimal) numRecords);
        totalPages = totalPages.round(System.RoundingMode.UP);
        
        //set Response
        outputMap.put('Orders',orderList);
        outputMap.put('TotalPages',totalPages);

    }
    
    public static String setQueryTemplate(){
		return 'select {0}{1} from Order where {2}{3}';
    }
    
    public static String setQueryWhere(){
        return 'accountid = :AccountId ';
    }
    
    public static String setSubQuery(){
        String subQuery = ',(select vlocity_cmt__ServiceIdentifier__c from OrderItems where vlocity_cmt__SubscriptionId__r.vlocity_cmt__ServiceIdentifier__c != \'\' ';
        subQuery += 'limit 1)';
        
        return subQuery;
    }
    
    public static String setQueryFields(){
        return 'CreatedDate,Id,OrderNumber,toLabel(Status),toLabel(Type),accountid,CreatedBy.Alias';
    }
    
    public static DateTime formatDate(String dateType, String dateInput){
        Datetime formatedDate = DateTime.valueOfGmt((dateInput).replaceAll('/','-'));
        if( dateType == 'end'){
            formatedDate = formatedDate.addHours(23);
            formatedDate = formatedDate.addMinutes(59);
            formatedDate = formatedDate.addSeconds(59);
        }
        return formatedDate;
    }
    
    public static Boolean hasParameter(String parameter){
        return (parameter != '' && parameter != 'null');
    }
    
}