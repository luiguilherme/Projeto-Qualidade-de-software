global class FlowCustomerInteractionTopicTree implements vlocity_cmt.VlocityOpenInterface {
    global Boolean invokeMethod(String methodName, Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options)
    {
        List<Object> arguments = (List<Object>) inputs.get('arguments');  

        switch on methodName {
            when 'convertTitleCase' 
            {output.put('result', convertTitleCase(arguments));}
        }
        return true;
    }

    global static List<String> convertTitleCase(List<Object> arguments) {
        List<String> returnList = new List<String>();

        for(Object wordToConvert : arguments) {
            returnList.add(toTitleCase((String) wordToConvert));
        }

        return returnList;
    }

    private static String toTitleCase(String str) {
        if(str.trim().length() == 0) return str;
        String[] words = str.toLowerCase().normalizeSpace().split(' ');
        
        List<String> rslt = new List<String>();
        for(String word : words) {
            if(word.equals('tv')) {
                rslt.add('TV');
            } else {
                rslt.add(word.capitalize());
            }
        }
        
        return String.join(rslt, ' ');
    }
}