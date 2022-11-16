public class CollectionUtil {


    public static void loadSet(Set<String> setString, String fieldKey, List<SObject> lstSObj) {
        String key = null;

        for(SObject sObj : lstSObj) {
            key = (String) sObj.get(fieldKey);

            setString.add(key);
        }
    }

    public static void loadSet(Set<Id> setIds, String fieldKey, List<SObject> lstSObj) {
        Id key = null;

        for(SObject sObj : lstSObj) {
            key = (Id) sObj.get(fieldKey);
            setIds.add(key);
        }
    }

    public static void loadList(List<String> listString, String fieldKey, List<SObject> lstSObj) {
        String key = null;

        for(SObject sObj : lstSObj) {
            key = (String) sObj.get(fieldKey);

            listString.add(key);
        }
    }

    public static void loadList(List<Id> listIds, String keyField, List<SObject> lstSObj) {
        Id key = null;

        for(SObject sObj : lstSObj) {
            key = (Id) sObj.get(keyField);

            listIds.add(key);
        }
    }

    public static void loadMapKeyCustom(Map<String,List<SObject>> mapSObj, String fieldKeyInit, String separetor,String fieldKeyEnd, List<SObject> lstSObj) {

        for(SObject sObj : lstSObj){
            String key = (String) sObj.get(fieldKeyInit) + separetor + (String) sObj.get(fieldKeyEnd);

            if(mapSObj.containsKey(key)){
                List<SObject> lstSObjAux = mapSObj.get(key);
                lstSObjAux.add(sObj);
                mapSObj.put(key,lstSObjAux);
                continue;
            }

            mapSObj.put(key, new List<SObject>{sObj});
        }
    }


    public static void loadMap(Map<Id, SObject> mapSObj, String fieldKey, List<SObject> lstSObj) {
        Map<Object, SObject> mapAux = loadMapObject(fieldKey, lstSObj);

        for(Object chave : mapAux.keySet()){
            mapSObj.put((Id)chave, mapAux.get(chave));
        }
    }

    public static void loadMap(Map<String, SObject> mapSObj, String fieldKey, List<SObject> lstSObj) {
        Map<Object, SObject> mapAux = loadMapObject(fieldKey, lstSObj);

        for(Object chave : mapAux.keySet()){
            mapSObj.put((String)chave, mapAux.get(chave));
        }
    }



    public static void loadMap(Map<String, String> mapObj, String fieldKey, String fieldValue, List<SObject> lstSObj){
        Map<Object, Object> mapAux = loadMapObject(fieldKey, fieldValue, lstSObj);

        for(Object key : mapAux.keySet()){
            mapObj.put((String)key, (String)mapAux.get(key));
        }
    }

    private static Map<Object, SObject> loadMapObject(String keyField, List<SObject> lstSObj){
        Map<Object, SObject> mapSObj = new Map<Object, SObject>();
        String parentField = null;
        String parentSObject = null;
        Object key = null;

        for(SObject obj : lstSobj)
        {
            if(keyField.indexOf('.') > 0){
                List<String> arrObjetoCampo = keyField.split('\\.');
                parentSObject = arrObjetoCampo.get(0);
                parentField = arrObjetoCampo.get(1);
            }

            key = (parentSObject == null ? obj.get(keyField) : obj.getSObject(parentSObject).get(parentField));
            mapSObj.put(key, obj);
        }

        return mapSObj;
    }

    private static Map<Object, Object> loadMapObject(String fieldKey, String fieldValue, List<SObject> lstSObj){
        Map<Object, Object> mapSObj = new Map<Object, Object>();
        Object key = null;
        Object value = null;
        String parentField = null;
        String parentSObject = null;
        String parentField2 = null;
        String parentSObject2 = null;


        for(SObject obj : lstSObj)
        {
            if(fieldKey.indexOf('.') > 0){
                List<String> arrFieldParent = fieldKey.split('\\.');
                parentSObject = arrFieldParent.get(0);
                parentField = arrFieldParent.get(1);
            }

            if(fieldValue.indexOf('.') > 0){
                List<String> arrFieldParent2 = fieldValue.split('\\.');
                parentSObject2 = arrFieldParent2.get(0);
                parentField2 = arrFieldParent2.get(1);
            }

            key = (parentSObject == null ? obj.get(fieldKey) : obj.getSObject(parentSObject).get(parentField));
            value = (parentSObject2 == null ? obj.get(fieldValue) : obj.getSObject(parentSObject2).get(parentField2));
            mapSObj.put(key, value);
        }

        return mapSObj;
    }

    public static void AuraException(String message){
        AuraHandledException auraException = new AuraHandledException(message);
        auraException.setMessage(message);
        throw auraException;
    }
   
    public static List<String> stringForList(String stringValue){
        List<String> lstStringValue = new List<String>();

        if(stringValue.contains(';')){
            lstStringValue = stringValue.split(';');
        }else{
            lstStringValue.add(stringValue);
        }

        return lstStringValue;
    }

    public static void loadMap(Map<Id,List<SObject>> mapListRecordsForId, String fieldName, List<SObject> lstRecords){

        for(SObject sObj : lstRecords){
           
            if(!mapListRecordsForId.containsKey((Id) sObj.get(fieldName))){
                mapListRecordsForId.put((Id) sObj.get(fieldName),new List<Asset>());
            }

            List<SObject> lst = mapListRecordsForId.get((Id) sObj.get(fieldName));
            lst.add(sObj);
            mapListRecordsForId.put((Id) sObj.get(fieldName), lst);
        } 
    }
}