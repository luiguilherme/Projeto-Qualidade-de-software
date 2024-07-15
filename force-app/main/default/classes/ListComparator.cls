/* 
 * @Date: 18/03/2024
 * @Author: Diogo Santos
 * @Description: Valentina - Class created to transform the Attribute Selected Values field and compare whether any service was activated/deactivated
 */
global class ListComparator implements vlocity_cmt.VlocityOpenInterface2 {
    
    public class applicationException extends Exception {}
    
    global Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionMap) {

        System.debug('methodName: ' + methodName);
		System.debug('inputMap: ' + json.serialize(inputMap));
		System.debug('outputMap: ' + json.serialize(outputMap));
		System.debug('optionMap: ' + json.serialize(optionMap));

        Boolean success = true;
        String errors;
        Integer lineNumber;
        String cause;

        try {
            switch on methodName {
                when 'mapJSONToList' {
                    mapJSONToList(inputMap, outputMap); 
                }
                
                when 'compareLists' {
                    compareLists(inputMap, outputMap); 
                }
            }

        } catch(Exception e) {
            errors = e.getMessage();
            cause = JSON.serialize(e.getCause()); 
            success = false;
        }

        outputMap.put('success', success);
        outputMap.put('error', errors);
        outputMap.put('cause', cause);

        return success;
    }
    
    public static List<KeyValue> mapJSONToList(Map<String, Object> inputMap, Map<String, Object> outputMap) {
        List<KeyValue> keyValueList = new List<KeyValue>();
        // Deserialize JSON string into a map
        Object objModelAttSelectedValues = inputMap.get('objectWithAttributeSelectedValues');
		Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped((String) objModelAttSelectedValues);
        
        // Iterate over the map and add key-value pairs to the list
        for (String key : jsonMap.keySet()) {
            Object value = jsonMap.get(key);
            keyValueList.add(new KeyValue(key, String.valueOf(value)));
        }
        outputMap.put('list',JSON.serialize(keyValueList));
        
        return keyValueList;
    }

    // Method to compare two lists of objects with 'name' and 'value' attributes
    public static void compareLists(Map<String, Object> inputMap, Map<String, Object> outputMap) {
        Map<String, Object> jsonMap = new Map<String, Object>();
        String typeAction = (String) inputMap.get('action');

        String oldListJSON = (String) inputMap.get('oldList');
        jsonMap.put('objectWithAttributeSelectedValues', oldListJSON);
        List<KeyValue> oldList = mapJSONToList(jsonMap, outputMap);

        String newListJSON = (String) inputMap.get('newList');
        jsonMap.put('objectWithAttributeSelectedValues', newListJSON);
        List<KeyValue> newList = mapJSONToList(jsonMap, outputMap);

        List<KeyValue> differences = new List<KeyValue>();    
        List<ObjectModelToRequest> differencesLogRequest = new List<ObjectModelToRequest>();
        // Create a map to store the values from the old list by 'name' key
        Map<String, String> oldMap = new Map<String, String>();
        for(KeyValue item : oldList) {
            oldMap.put(item.name, item.value);
        }
        // Iterate over the new list and compare with the old list
        for(KeyValue item : newList) {
            // Check if the 'name' key exists in the old list
            if(oldMap.containsKey(item.name)) {
                String oldVal = oldMap.get(item.name);
                String newVal = item.value;
                // Compare the values
                Boolean changed = (oldVal != newVal);//<--------------------------------------------------------------Precisa mudar a condicional para != antes de subir

                if (typeAction == 'createLog' && changed) {
                    // Create a KeyValue object to represent the difference
                    ObjectModelToRequest differenceLog = new ObjectModelToRequest();
                    differenceLog.id = item.name;
                    differenceLog.description = 'O novo valor é: '+ item.value;
                    //differenceLog.note = item.value == 'A'? 'create': 'remove';
                    differenceLog.reason = item.value == 'A'? 'create': 'remove';
                    differenceLog.type = item.value == 'A'? 'create': 'remove';
                    differencesLogRequest.add(differenceLog);
                } else {
                    // Create a KeyValue object to represent the difference
                    KeyValue difference = new KeyValue(item.name, newVal, changed);
                    differences.add(difference);
                }                
            }
        }
        System.debug('122');
        System.debug(differencesLogRequest);

        System.debug('aa');
        System.debug(!differencesLogRequest.isEmpty());
        if(!differencesLogRequest.isEmpty()){
            System.debug('bb');
            System.debug(!differencesLogRequest.isEmpty());
            outputMap.put('listDifferenceLog',JSON.serialize(differencesLogRequest));
        }else {
            System.debug('cc');
            System.debug(!differences.isEmpty());
            outputMap.put('listDifferences',JSON.serialize(differences));
        }
    }

    public class KeyValue {
        public String name { get; set; }
        public String value { get; set; }
        public Boolean isChanged { get; set; }
        public KeyValue(String name, String value) {
            this.name = name;
            this.value = value;
        }

        public KeyValue(String name, String value, Boolean isChanged) {
            this.name = name;
            this.value = value;
            this.isChanged = isChanged;
        }
    }
    
    public class ObjectModelToRequest {
        public String id { get; set; }
        public String description { get; set; }
        public String note { get; set; }
        public String reason { get; set; }
        public String type { get; set; }

        public ObjectModelToRequest(){}
    }
}