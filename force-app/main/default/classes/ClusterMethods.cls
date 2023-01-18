public class ClusterMethods {
    public static void insertCluster(List<Cluster__c> listCluster){
        
        List<Decimal> uniqueValueList = new List<Decimal>();
        for(Cluster__c record : listCluster){
            uniqueValueList.add(record.Priority__c);
        }
        
        Map<Decimal,Cluster__c> uniqueValueMap = new Map<Decimal,Cluster__c>();
        for(Cluster__c record : [SELECT Priority__c FROM Cluster__c WHERE Priority__c IN :uniqueValueList]){
            uniqueValueMap.put(record.Priority__c, record);        
        }
        
        for(Cluster__c record :  listCluster){
            if(uniqueValueMap.containsKey(record.Priority__c)){
                if(trigger.isInsert || (trigger.isUpdate && record.id<>uniqueValueMap.get(record.Priority__c).id)){
                    record.addError('Esta prioridade já existe. Insira um novo valor.');
                }           
            }
        }
        
    }
    public static void updateCluster(List<Cluster__c> listCluster){
        
        List<Decimal> uniqueValueList = new List<Decimal>();
        for(Cluster__c record : listCluster){
            uniqueValueList.add(record.Priority__c);
        }
        
        Map<Decimal,Cluster__c> uniqueValueMap = new Map<Decimal,Cluster__c>();
        for(Cluster__c record : [
            SELECT Priority__c FROM Cluster__c
            WHERE Priority__c IN :uniqueValueList
        ]){
            uniqueValueMap.put(record.Priority__c, record);        
        }
        
        for(Cluster__c record :  listCluster){
            if(uniqueValueMap.containsKey(record.Priority__c)){
                if(trigger.isInsert || (trigger.isUpdate && record.id<>uniqueValueMap.get(record.Priority__c).id)){
                    record.addError('Esta prioridade já existe. Insira um novo valor.');
                }           
            }
        }
        
    }
    
    
}