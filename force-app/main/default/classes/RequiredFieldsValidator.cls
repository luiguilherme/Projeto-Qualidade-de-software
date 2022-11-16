public without sharing class RequiredFieldsValidator {
    public static void validateFields(Map<String, Object> mapResult, sObject Context, String usedIn){
        List<RequiredFieldsMapping__mdt> requiredFields;
        String sObjectDevName, recordTypeDevName;
        
        
        sObjectDevName = Context.getSObjectType().getDescribe().getName();
        recordTypeDevName = RecordTypeUtil.getDevNameById(sObjectDevName, (Id)Context.get('RecordTypeId'));
        requiredFields = RequiredFieldsMappingDAO.get(sObjectDevName, RecordtypeDevName, usedIn);
        
        if(requiredFields.isEmpty()){
            mapResult.put('success', 'Metadado de campos obrigatórios não encontrado');
            return;
        }

        List<String> fields = new List<String>();
        for(RequiredFieldsMapping__mdt requiredField : requiredFields ){
            if(Context.get(requiredField.ApiName__c) == null){
                fields.add(requiredField.ErrorMessage__c);
            }
        }
        if(!fields.isEmpty()){
            mapResult.put('RequiredFields', fields);
            return;
        }

        if(mapResult.isEmpty()){
            mapResult.put('success', 'Campos validados com sucesso');
        }
    }
}