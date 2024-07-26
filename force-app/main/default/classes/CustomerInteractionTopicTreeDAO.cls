public class CustomerInteractionTopicTreeDAO {
    public static List<CustomerInteractionTopicTree__c> getEndFlowCustomerInteractionTopicTreeById(Id serviceId) {    
        return [
            SELECT
                Id,
                Name,
                GpsId__c,
                Instance__c,
                GPSFlow__c,
				ProductType__c
            FROM
                CustomerInteractionTopicTree__c
            WHERE
            	Type__c = 'Palito'				
            AND
               	Id =: serviceId
        ];
    }
    
    public static CustomerInteractionTopicTree__c getCustomerInteractionTopicTreeToFillProdutoOutrosFixa() {    
        return [
            SELECT 
                Id 
            FROM 
                CustomerInteractionTopicTree__c 
            WHERE 
                Name = 'NDA'
            LIMIT 1
        ];
    }
    
    public static List<CustomerInteractionTopicTree__c> getServiceFlowBySegment(Set<String> setOperatorSegment, String pageReference) {    

        List<String> segments = new List<String>(setOperatorSegment);
        String query = '';
        query += 'SELECT Id, Name, GpsId__c, ProductType__c, OperatorSegment__c, Instance__c FROM CustomerInteractionTopicTree__c';        
        query += ' WHERE Active__c = true AND GpsId__c != null AND VisibleTo__c INCLUDES (\'' + pageReference + '\') ';
        
        if(!segments.isEmpty() && segments != null){
            query += ' AND OperatorSegment__c ';
            if(segments.size() > 1){
                query += 'INCLUDES (\'' + String.join(segments, '\',\'') + '\')';
            } else {
                query += 'INCLUDES (\'' + segments[0] + '\') ';
            }
		}else {
            return new List<CustomerInteractionTopicTree__c>();
        }

        query +=' ORDER BY Name';

        return Database.Query(query);

    }
}