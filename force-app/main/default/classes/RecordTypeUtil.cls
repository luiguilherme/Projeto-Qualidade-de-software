/**
 * Nova Implementação
 * Pontos positivos:
 * - Evita usar Schema.getGlobalDescribe que não é performatico para orgs com grande quantidade de metadados
 * - Mantem no cache da requisição para acessar os recordtypes de um mesmo objeto varias vezes com apenas uma vez busca
 * - Os metodos que não necessitam realizar a instanciação para obter o SObjectType são ainda mais perfomaticos
 * Pontos negativos:
 * - Consumo de memoria pode ser um problema para requisições com processamentos maiores, com mais objetos envolvidos
 */
public without sharing class RecordTypeUtil {

    /**
     * Armazena em cache todos os recordtypeinfo com o developername como chave
     * para cada objeto consultado durante uma mesma execução
    */
    private static Map<String, Map<String, RecordTypeInfo>> recordTypeInfoMapByDevName = new Map<String, Map<String, RecordTypeInfo>>();
  
    /**
     * Armazena em cache todos os recordtypeinfo com o recordTypeId como chave
     * para cada objeto consultado durante uma mesma execução
    */
    private static Map<String, Map<Id, RecordTypeInfo>> recordTypeInfoMapById = new Map<String, Map<Id, RecordTypeInfo>>();
  
    /**
     * Caso não queira armazenar para novo acesso durante a requisição basta trocar o valor para false
    */
    public static Boolean cacheRTInfo = true;
  
    /**
     * Cuidado, caso o objeto ou recordtype não exista, pode gerar exception
    */
    public static Id getByDevName(String objectName, String recordTypeDeveloperName) {
        try {
  
          return getRTInfoMapFrom(SchemaUtils.getSObjectTypeByName(objectName)).get(recordTypeDeveloperName).getRecordTypeId();
  
        } catch(Exception e){
          System.debug(e.getStackTraceString());
          return null;
        }
    }
  
    /**
     * Cuidado, caso o objeto ou recordtype não exista, pode gerar exception
    */
    public static String getDevNameById(String objectName, Id recordTypeId) {
        try{
  
          return getRTInfoIdMapFrom(SchemaUtils.getSObjectTypeByName(objectName)).get(recordTypeId).getDeveloperName();
  
        } catch(Exception e){
          System.debug(e.getStackTraceString());
          return null;
        }
    }
  
    /**
     * Retorna map de RecordTypeInfo com base no sobjectType recebido, usando o DeveloperName como chave
    */
    public static Map<String,RecordTypeInfo> getRTInfoMapFrom(SObjectType sObjectType) {
        if (sObjectType==null) { return null; }
  
        String sObjectNameKey = sObjectType.getDescribe().getName();
  
        if(!recordTypeInfoMapByDevName.containsKey(sObjectNameKey)){
            Map<String, RecordTypeInfo> mapRTInfo = sObjectType.getDescribe().getRecordTypeInfosByDeveloperName();
  
            if(!cacheRTInfo){
              return mapRTInfo;
            }
  
            recordTypeInfoMapByDevName.put(sObjectNameKey, mapRTInfo);
        }
  
        return recordTypeInfoMapByDevName.get(sObjectNameKey);
    }
  
  
    /**
     * Retorna map de RecordTypeInfo com base no sobjectType recebido, usando o Id do RecordType como chave
    */
    public static Map<Id,RecordTypeInfo> getRTInfoIdMapFrom(SObjectType sObjectType) {
        if (sObjectType==null) { return null; }
  
        String sObjectNameKey = sObjectType.getDescribe().getName();
  
        if(!recordTypeInfoMapById.containsKey(sObjectNameKey)){
            Map<Id, RecordTypeInfo> mapRTInfo = sObjectType.getDescribe().getRecordTypeInfosById();
  
            if(!cacheRTInfo){
              return mapRTInfo;
            }
  
            recordTypeInfoMapById.put(sObjectNameKey, mapRTInfo);
        }
  
        return recordTypeInfoMapById.get(sObjectNameKey);
    }
  
    /**
     * Retorna map de RecordType com base no sobjectType recebido, usando o DeveloperName como chave
    */
    public static Map<String,RecordType> getRecordTypeMapFrom(SObjectType sObjectType) {
        if (sObjectType==null) { return null; }
  
        String sObjectNameKey = sObjectType.getDescribe().getName();
  
        Map<String, RecordType> rtMap = new Map<String,RecordType>();
  
        for(RecordTypeInfo rtInfo : getRTInfoMapFrom(sObjectType).values()){
          rtMap.put(rtInfo.getDeveloperName(),
                      new RecordType(Id = rtInfo.getRecordTypeId(),
                                      Name = rtInfo.getName(),
                                      DeveloperName = rtInfo.getDeveloperName()
                                    )
                    );
        }
  
        return rtMap;
    }
  
  
  }