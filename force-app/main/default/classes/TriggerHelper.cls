public with sharing class TriggerHelper {
    private static void assert(sObject aObject, Set<String> aFields) {
        system.assert(Trigger.isExecuting, 'This method must be called only in trigger context.');
        system.assert(aObject != null, 'This method obligatory needs an Object to compare.');
        system.assert(aFields != null && !aFields.isEmpty(), 'This method obligatory needs a Field to compare.');
    }

    /*
        Método para retornar se algum dos campos em aFields foi alterado
        aObject => Objeto de Comparação (Trigger.New)
        aFields => Set de Campos de Comparação (API)
    */
    public static Boolean changedField(sObject aObject, Set<String> aFields){
        assert(aObject, aFields);
        for (String iField : aFields){
            Object lOldObject = (Trigger.isUpdate) ? Trigger.oldMap.get(aObject.Id).get(iField) : null;
            if ((Trigger.isInsert && aObject.get(iField) != null) || (aObject.get(iField) != lOldObject)){ 
                return true; 
            }
        }
        return false;
    }
}