public with sharing class CanvasService {
    private static final Map<String, CanvasServiceInterface> serviceMap = new Map<String, CanvasServiceInterface>{
        'Asset-'                                => new CanvasHybrisOrderService(),
        'Asset-Movel'                           => new CanvasHybrisOrderService(),
        'Asset-Fixa'                            => new CanvasHybrisOrderService()    
    };

    private List<String> ListRecordId;
    private CanvasServiceInterface service;

    public CanvasService(Id recordId, List<String> listRecordId) {
        this.ListRecordId = listRecordId;
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

    public Map<String,Object> getParameters(string tipoOferta){
        return service.getParameters(ListRecordId, tipoOferta);
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
        System.debug('erick ' + obj.get('RecordTypeId'));
        if(obj.isSet('RecordTypeId')){
            if(obj.get('RecordTypeId') != null){
                return rtMap.get((String)obj.get('RecordTypeId')).getDeveloperName();
            } 
        } 
        
        return '';
    }
}