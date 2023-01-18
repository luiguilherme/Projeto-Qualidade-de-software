public with sharing class StaticResourceDAO {
    
    public static List<StaticResource> getByDescription(String description){
        return [SELECT    
                    Name,
                    Description
                FROM 
                    StaticResource
                WHERE 
                    Description =: description];
    }
}