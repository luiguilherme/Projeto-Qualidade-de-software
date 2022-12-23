@isTest
public class CustomPermissionControllerTest {
    
	@isTest 
    static void getUserPermission(){
		Object objRetorno;
        
        CustomPermissionController controller = new CustomPermissionController();
        
        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();
        
        Test.startTest();
        
        controller.invokeMethod('getUserPermission', inputMap, outputMap, options); 
 		               
        System.assertEquals(true, outputMap.get('Success'));
        
        Test.stopTest();
    }
    
    @isTest 
    static void checkUserPermission(){
		Object objRetorno;
        
        CustomPermissionController controller = new CustomPermissionController();
        
        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();
        
        Test.startTest();
        
        List<String> lPermissionCheck = new List<String>();
        
        lPermissionCheck.add('EnablePrepaid');
        lPermissionCheck.add('ListProtocol');
        lPermissionCheck.add('Hybris');
        
        inputMap.put('PermissionCheck', lPermissionCheck);
        
        controller.invokeMethod('checkUserPermission', inputMap, outputMap, options); 
 		               
        System.assertEquals(true, outputMap.get('Success'));
        
        Test.stopTest();
    }
}