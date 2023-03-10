global with sharing class TopicsAutoController implements vlocity_cmt.VlocityOpenInterface2 {
    global Object invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> optionsMap) {
        Boolean success = true;
        String errors = 'OK';
        
        try{
            switch on methodName {
                when 'getPicklistOptions' {
                    getPicklistOptions(inputMap, outMap, optionsMap);
                }
                when 'getChannelList' {
                    getChannelList(inputMap, outMap, optionsMap);
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
    
    public void getPicklistOptions(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> optionsMap) {
        String objectApiName = (String) inputMap.get('objectName');
        String objectFieldName = (String) inputMap.get('fieldName');
        
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        
        Schema.SObjectField sField;
        Schema.SObjectType sObjType = gd.get(objectApiName);
        Schema.DescribeSObjectResult objectResult = sobjType.getDescribe();
        
        Map<String,Schema.SObjectField> fieldsMap = objectResult.fields.getMap();
        sField = fieldsMap.get(objectFieldName);		
        
        List<Schema.PicklistEntry> picklistValues = sField.getDescribe().getPicklistValues();

        List<Map<String, String>> options = new List<Map<String, String>>();
        //Map<String, Object> finalMap = new Map<String, Object>();
        
        for (Schema.PicklistEntry pe: picklistValues) {
            Map<String, String> mapValues = new Map<String, String>();
            mapValues.put('value', pe.getLabel());
            mapValues.put('label', pe.getValue());
            
            options.add(mapValues);	
        }
        
        outputMap.put('options', options);

        //return listValuesTranslated;
    }

    public void getChannelList(Map<String,Object> inputMap, Map<String,Object> outputMap, Map<String,Object> options) {
        Map<String, String> mapChannel;
        List<Map<String, String>> lstChannels = new List<Map<String, String>>();
        String strChannel = (String) inputMap.get('Channels');
        
        List<String> channels = strChannel.split(';');

        for (String channel : channels) {
            mapChannel = new Map<String, String>();
            mapChannel.put('Channel', channel);

            lstChannels.add(mapChannel);
        }

        outputMap.put('ChannelList', lstChannels);
    }
}