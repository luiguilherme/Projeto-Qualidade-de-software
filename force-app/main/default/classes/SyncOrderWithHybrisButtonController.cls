global with sharing class SyncOrderWithHybrisButtonController implements vlocity_cmt.VlocityOpenInterface {
    
    @AuraEnabled
    public static Map<String, Object> syncHybrisOrderStatus(String recordId){
        try {
            return OrderHybrisService.syncOrderStatusWithHybris(recordId);
        } catch (Exception e) {
            throw new AuraHandledException(System.Label.HybrisContactAdmin);
        }
    }
    
	public Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
			
		Boolean result = true;
		String recordId;	
		try{
			
            if(methodName.equals('syncHybrisOrderStatus')){
				recordId = (String) inputMap.get('OrderIssuedId');
                
                Map<String, Object> resultado = syncHybrisOrderStatus(recordId);
				System.debug('Executei o syncHybrisOrderStatus com o resultado ' + resultado);
            }                               
			
		} catch(Exception e){
            
			result = false;
            
		}

		return result;

    }
}