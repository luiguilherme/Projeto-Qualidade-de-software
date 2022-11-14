public class LookupFieldComponentController {

	@AuraEnabled
	public static List<sObject> fetchLookUpValues(String searchfield, String searchKeyWord, String objectName, String fields, String tipoRegistro, 
                                                  String conditions, String addWhereKey, String addWhereValue, String addWhereIsBoolean, String addWhereIn, Boolean isAvantAppTheme) {
		String searchKey = searchKeyWord + '%';
		List<Object> campos = (List<Object>) JSON.deserializeUntyped(fields);
		List<sObject> returnList = new List<sObject> ();
		String sQuery = 'SELECT ';
		for (Integer i = 0; i<campos.size(); i++) {
			if (i == (campos.size() - 1)) {
				sQuery = sQuery + campos.get(i);
			}
			else {
				sQuery = sQuery + (campos.get(i) + ',');
			}
		} 

        if(isAvantAppTheme)
            sQuery = sQuery + ' FROM ' + objectName + ' WHERE ' + searchfield + ' = :searchKeyWord ';
        else                                             
			sQuery = sQuery + ' FROM ' + objectName + ' WHERE ' + searchfield + ' LIKE :searchKey ';        	                                              

		if (! String.isBlank(tipoRegistro)) {
			sQuery += ' AND RecordType.DeveloperName =:tipoRegistro ';
		}

		if (! String.isBlank(conditions) && conditions != null) {
			Map<String, Object> conditionsMap = (Map<String, Object>) JSON.deserializeUntyped(conditions);

			for (String key : conditionsMap.keySet()) {
				sQuery += ' AND ' + key + ' = \'' + String.valueOf(conditionsMap.get(key)) + '\' ';
			}
		}
        
        if(!String.isBlank(addWhereKey) && !String.isBlank(addWhereValue) && addWhereKey != null && addWhereValue != null){
            sQuery += ' AND ' + addWhereKey + ' = \'' + addWhereValue + '\' ';
        }

        if(!String.isBlank(addWhereKey) && !String.isBlank(addWhereIsBoolean) && addWhereKey != null && addWhereIsBoolean != null){
            sQuery += ' AND ' + addWhereKey + ' = ' + addWhereIsBoolean;
		}
		
		if(!String.isBlank(addWhereIn) && addWhereIn != null){
			sQuery += ' AND ' + addWhereIn;
		}
        
		sQuery += ' ORDER BY LastViewedDate DESC LIMIT 5';

		List<sObject> lstOfRecords = Database.query(sQuery);

		for (sObject obj : lstOfRecords)
		returnList.add(obj);
		
		return returnList;
	}
}