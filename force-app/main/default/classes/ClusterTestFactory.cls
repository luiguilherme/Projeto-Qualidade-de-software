public class ClusterTestFactory {
     private Cluster__c fCluster;
    
    public ClusterTestFactory( Cluster__c aCluster ){
        fCluster = aCluster;
    }
    
    public static ClusterTestFactory start(){
        return new ClusterTestFactory (
            new Cluster__c(
                Name = 'Cluster Test',
                Type__c = 'Comercial',
                Priority__c = 1,
                Start__c = system.today(),
                End__c = system.today()
            ) );
    }
    public ClusterTestFactory isPriority(){
        fCluster.Name = 'teste produto movel';
        fCluster.Type__c = 'Comercial';
        fCluster.Priority__c = 1;
        fCluster.Type__c = 'Movel';
        fCluster.Start__c = system.today();
        fCluster.End__c = system.today();

        return this;
    }
    
   
    public Cluster__c create() {
        insert fCluster;
        return fCluster;
    }
    	public Cluster__c build() {
		return fCluster;
	}
    

}