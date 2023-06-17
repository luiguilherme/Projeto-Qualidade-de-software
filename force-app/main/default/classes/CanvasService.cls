public with sharing class CanvasService {
    private static final Map<String, CanvasServiceInterface> serviceMap = new Map<String, CanvasServiceInterface>{
        'Account-Consumer'                            => new CanvasHybrisOrderService()
    };

    private Id recordId;
    private CanvasServiceInterface service;

    public CanvasService(Id recordId) {
        this.recordId = recordId;
        Schema.DescribeSObjectResult describe = recordId.getSobjectType().getDescribe();
        String objectTypeName = describe.getName();
        String recordTypeName = getRecordTypeName(recordId, describe);

        System.debug('CanvasService: ' + objectTypeName + '-' + recordTypeName);
        this.service = serviceMap.get(objectTypeName + '-' + recordTypeName);
        System.debug('Service: ' + this.service);
    }

    public String getConnectedAppName(){
        return service.getConnectedAppName();
    }

    public Map<String,Object> getParameters(){
        return service.getParameters(recordId);
    }

    private String getRecordTypeName(Id recordId, Schema.DescribeSObjectResult describe){
        String query = 'SELECT Id, RecordTypeId' +
                        ' FROM    ' + describe.getName() + 
                        ' WHERE   Id = \'' + recordId + '\'' +
                        ' LIMIT 1';
        System.debug('CanvasService.getRecordTypeName - query: ' + query);
        SObject obj = Database.query(query);
        System.debug('CanvasService.getRecordTypeName - obj: ' + obj);

        Map<Id, Schema.RecordTypeInfo> rtMap = describe.getRecordTypeInfosById();
        
        return rtMap.get((String)obj.get('RecordTypeId')).getDeveloperName();
    }
}