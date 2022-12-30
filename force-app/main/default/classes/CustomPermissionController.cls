global class CustomPermissionController implements vlocity_cmt.VlocityOpenInterface2 {
    
    global boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionMap){    
        
        system.debug('methodName: ' + methodName);
		system.debug('inputMap: ' + json.serialize(inputMap));
		system.debug('outputMap: ' + json.serialize(outputMap));
		system.debug('optionMap: ' + json.serialize(optionMap));
                                    
        Boolean success = true;
        String errors = 'OK';
        
        try{
            switch on methodName {
                when 'getUserPermission' {
                    getUserPermission(outputMap); 
                }
                when 'checkUserPermission' {
                    checkUserPermission(inputMap, outputMap); 
                }
            }

        } catch(Exception e) {
            errors = e.getMessage(); 
            success = false;
        }
        
        outputMap.put('Success', success);
        outputMap.put('Error', errors);
        
        return success; 
    }

    private void getUserPermission(Map<String, Object> outMap){
        outMap.put('UserPermission', CustomPermissionService.getUserPermission());
    }
    
    private void checkUserPermission(Map<String, Object> putMap, Map<String, Object> outMap){
        List<Object> lApiName;       
        
        if(putMap.containsKey('PermissionCheck') && putMap.get('PermissionCheck') != null) {
        	lApiName = (List<Object>)putMap.get('PermissionCheck');   
            
            if(lApiName.size() == 1 && lApiName[0] == null) {
            	lApiName = new List<Object>();
            }
        }
        
        outMap.put('UserPermission', CustomPermissionService.checkUserPermission(lApiName));
    }
}