/*
*   Classe responsável por páginar lista
*	Criação: Carlos Davi - 08/12/2022
*	Alteração:
*/
global class ListPaginationController implements vlocity_cmt.VlocityOpenInterface2 {

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
                when 'getPaginatedList' {
                    getPaginatedList(inputMap, outputMap); 
                }
            }

        } catch(Exception e) {
            errors = e.getMessage(); 
            lineNumber = e.getLineNumber(); 
            cause = JSON.serialize(e.getCause()); 

            success = false;
        }

        outputMap.put('success', success);
        outputMap.put('error', errors);
        outputMap.put('lineNumber', lineNumber);
        outputMap.put('cause', cause);

        return success;
    }

    private void getPaginatedList(Map<String, Object> inpMap, Map<String, Object> outMap) {
        
        String jsonInput = String.valueof(inpMap.get('OriginalList'));
        Integer pageSize = Integer.valueOf(inpMap.get('PageSize'));
        Integer page = Integer.valueOf(inpMap.get('CurrentPage'));
        
        String result = ListPaginationService.getPaginatedList(jsonInput, pageSize, page);

        outMap.put('ListView', result);
    }
}