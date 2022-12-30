public with sharing class CustomPermissionService {
		
    public static Map<String, Boolean> getUserPermission(){
        Map<String, Boolean> mapUserFeature = new Map<String, Boolean>();
        
        for(CustomPermission item : [SELECT DeveloperName FROM CustomPermission]) {
                mapUserFeature.put(item.DeveloperName, FeatureManagement.checkPermission(item.DeveloperName));
        }
                
        system.debug('mapUserFeature: ' + mapUserFeature);
        
        return mapUserFeature;
    }
	
	public static Map<String, Boolean> checkUserPermission(List<Object> lApiName){
        Map<String, Boolean> mapUserFeature = new Map<String, Boolean>();
        
        if(lApiName != null) {
            for(Object item : lApiName) {
                if((String)item != '') {
            		mapUserFeature.put((String)item, FeatureManagement.checkPermission((String)item)); 
                }
            }
        } 
        
        system.debug('mapUserFeature: ' + mapUserFeature); 
        
        return mapUserFeature;
    }
}