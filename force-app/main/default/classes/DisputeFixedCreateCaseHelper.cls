global with sharing class DisputeFixedCreateCaseHelper implements vlocity_cmt.VlocityOpenInterface2 {

    global Boolean invokeMethod(String methodName, Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options){    
        switch on methodName {
            when 'validateInstaceProduct' {
                output.put('result', validateInstaceProduct(inputs));
            } 
            when 'transformToString' {
                output.put('result', transformToString(inputs));
            }
        }
        return true; 
    }

    @AuraEnabled(cacheable=true)
    public static String transformToString(Map<String, Object> inputs) {
        return String.valueOf(inputs.get('value'));
    }

    @AuraEnabled(cacheable=true)
    public static String validateInstaceProduct(Map<String, Object> inputs) {
        String instance = String.valueOf(inputs.get('instanceProduct'));

        Pattern pattern = Pattern.compile('[^\\d]');
        Matcher matcher = pattern.matcher(instance);
        Boolean hasNonDigit = matcher.find();
        System.debug(hasNonDigit);
        
        return hasNonDigit ? '' : instance;
    }
}