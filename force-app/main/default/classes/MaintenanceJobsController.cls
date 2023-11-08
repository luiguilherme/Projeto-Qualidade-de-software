/**
 * @description       : Classe responsável por chamar Maintenance Jobs
 * @author            : carlosaraujo@deloitte.com
 * @group             : 
 * @last modified on  : 12-06-2023
**/
global class MaintenanceJobsController implements vlocity_cmt.VlocityOpenInterface2 {
    
    global Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionMap) {
        Boolean success = true;
        String errors; 

        try {
            switch on methodName {
                when 'executeJobs' {
                    executeJobs(inputMap, outputMap); 
                }
            }
        } catch(Exception e) {
            errors = e.getMessage(); 
            success = false;
        }

        outputMap.put('success', success);
        outputMap.put('error', errors);

        return success;
    }

    global void executeJobs(Map<String, Object> inpMap, Map<String, Object> outMap) {

        vlocity_cmt.TelcoAdminConsoleController controllerClass = new vlocity_cmt.TelcoAdminConsoleController();
        List<String> methods = (List<String>) JSON.deserialize(JSON.serialize(inpMap.get('methods')), List<String>.class);
        Map<String, Object> input;
        Pricebook2 pb;

        if (methods.contains('refreshPriceBook')) {
            if (!Test.isRunningTest()) {
                pb = [SELECT Id FROM Pricebook2 WHERE IsStandard = true LIMIT 1];
            } else {
                pb = new Pricebook2(Id = Test.getStandardPricebookId()); 
            }
        }

        for (String method : methods) {
            
            input = new Map<String, Object>{'methodName' => method};
                
            if (method == 'refreshPriceBook') {
                input.put('priceBookId', pb.Id);
            }
            
            controllerClass.setParameters(JSON.serialize(input));
            
            if (!Test.isRunningTest()) {
                controllerClass.invokeMethod();
            }
            
        }
        
    }

}