@isTest
public class ClusterTriggerTest {
     @testSetup 
    static void setup(){
        
         Cluster__c lCluster = ClusterTestFactory.start().create();   
         Cluster__c lClusterIsPriority = ClusterTestFactory.start().isPriority().build(); 

         
    }
    @isTest
    public static void insertClusterTest(){
        
        Cluster__c lCluster = [ SELECT Id, Priority__c FROM Cluster__c LIMIT 1];   
        
        Test.startTest();
        
        Database.update(lCluster);
        
        Test.stopTest();

    } 
    @isTest
    public static void insertClusterTestError(){
        Cluster__c fCluster = new Cluster__c();
            fCluster.Name = 'teste produto movel';
            fCluster.Type__c = 'Comercial';
            fCluster.Priority__c = 1;
            fCluster.Type__c = 'Outros';
            fCluster.Start__c = system.today();
            fCluster.End__c = system.today();
            

        Test.startTest();
        
        try{
            Database.insert(fCluster);
        } catch(Exception e){
            system.assert(e.getMessage().contains('Esta prioridade já existe. Insira um novo valor.'));
        }        
        
        
        Test.stopTest();

    } 


}