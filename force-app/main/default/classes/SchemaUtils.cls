public class SchemaUtils {

    public static Map<String, SObjectType> sObjectTypeMap = new Map<String, SObjectType>();

    public static DescribeSObjectResult getDescribeBySObjectName(String sObjectTypeName){

        if(!sObjectTypeMap.containsKey(sObjectTypeName)){
            sObjectTypeMap.put(sObjectTypeName, getSObjectTypeByName(sObjectTypeName));
        }

        return sObjectTypeMap.get(sObjectTypeName).getDescribe();

    }

    public static SObjectType getSObjectTypeByName(String sObjectName){

        return ((SObject)(Type.forName('Schema.'+sObjectName).newInstance())).getSObjectType();

    }
}