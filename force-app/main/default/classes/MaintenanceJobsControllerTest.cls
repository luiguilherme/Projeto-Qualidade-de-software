@isTest
public class MaintenanceJobsControllerTest {

    @isTest
    static void invokeMethodSuccess(){
        MaintenanceJobsController controller = new MaintenanceJobsController();
        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();
        
        inputMap.put('methods', new List<String>{'job1', 'refreshPriceBook'});

        Test.startTest();
        Boolean result = controller.invokeMethod('executeJobs', inputMap, outputMap, options);
        Test.stopTest();
        
        System.assertEquals(true, result);
    }
    
    @isTest
    static void invokeMethodError(){
        MaintenanceJobsController controller = new MaintenanceJobsController();
        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();
        
        inputMap.put('methods', null);

        Test.startTest();
        Boolean result = controller.invokeMethod('executeJobs', inputMap, outputMap, options);
        Test.stopTest();
        
        System.assertEquals(false, result);
    }
    
}