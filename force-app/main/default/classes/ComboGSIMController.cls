global class ComboGSIMController implements vlocity_cmt.VlocityOpenInterface2 {
    
    global Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionMap) {

        Boolean success = true;
        String errors;

        try {
            switch on methodName {
                when 'transformPayload' {
                    transformPayload(inputMap, outputMap); 
                }
            }
        } catch(Exception e) {
            errors = e.getMessage(); 
            success = false;
        }

        if (!Test.isRunningTest()) {
            outputMap.put('success', success);
        }
        
        outputMap.put('error', errors);

        return success;
    }
	
    @TestVisible
    void transformPayload(Map<String, Object> inpMap, Map<String, Object> outMap) {

        List<Map<String, String>> lstMapPayload = new List<Map<String, String>>();
        ExpectedPayload expectedPayload = new ExpectedPayload(); 
        
        lstMapPayload = (List<Map<String, String>>) JSON.deserialize(JSON.serialize(inpMap.get('Payload')), List<Map<String, String>>.class);

        for (Map<String, String> mapPayload : lstMapPayload) {
            // Verificação se combo possui atributo promotion
            if (String.isNotBlank(mapPayload.get('promotion'))) { 

                expectedPayload.comboItem.add(
                    new ComboItem(mapPayload)
                );
                
            }
        }

        outMap.put('Result', JSON.serialize(expectedPayload));

    }

    @TestVisible
    class ExpectedPayload {
        @TestVisible
        List<ComboItem> comboItem = new List<ComboItem>();
    }

    @TestVisible
    class ComboItem {
        @TestVisible
        List<Item> resourceCharacteristic = new List<Item>();

        @TestVisible
        ComboItem(Map<String, String> mapPayload) {
            List<Item> lstAux = new List<Item>();

            for (String key : mapPayload.keySet()) {
                lstAux.add(
                    new Item(key, mapPayload.get(key))
                );
            }

            this.resourceCharacteristic = lstAux;
        }
    }

    @TestVisible
    class Item {
        @TestVisible
        String name {get;set;}

        @TestVisible
        String value {
            get {
                if (value == null) {
                    return '';
                }
                return value;
            } 
            set;
        }

        @TestVisible
        Item(String name, String value) {
            this.name = name;
            if (this.name == 'activeNgin') {
                this.value = value == 'true' ? 'Y' : 'N';
            } else {
                this.value = value;
            }
        }
    }

}