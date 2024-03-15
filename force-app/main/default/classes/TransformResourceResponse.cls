global class TransformResourceResponse implements vlocity_cmt.VlocityOpenInterface2 {

    global boolean invokeMethod(String methodName, Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options){    
        switch on methodName {
            when 'format'
            {output.put('result', formatResponse(inputs));} 
        }
        return true; 
    }

    Map<String, Object> formatResponse(Map<String, Object> inputs)
    {
        Map<String, Object> result = new Map<String, Object>();
        try {
            List<Object> resourceCharacteristic = (List<Object>) inputs.get('response');
            for(Object currentObj : resourceCharacteristic)
            {
                Map<String, Object> tempMap = (Map<String, Object>) currentObj;
                if((String) tempMap.get('name') == 'MODEL')
                {
                    String model = (String) tempMap.get('value');
                    result.put('MODEL', model.substringAfter('(').substringBeforeLast(')'));
                    result.put('DEVICE', model.substringBefore('('));
                } else
                    result.put((String) tempMap.get('name'), tempMap.get('value'));
            }
        } catch (Exception e) {
            result.put('MODEL', '---');
            result.put('DEVICE', '---');
            result.put('VENDOR', '---');
            result.put('IMEI', '---');
            return result;
        }
        return result;
    }
}