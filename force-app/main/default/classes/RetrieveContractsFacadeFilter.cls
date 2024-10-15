public with sharing class RetrieveContractsFacadeFilter {

    @InvocableVariable
    public String sourceSystem;
    
    @InvocableVariable
    public String order;

    @InvocableVariable
    public String contractType;

    public RetrieveContractsFacadeFilter(String order, String sourceSystem, String contractType) {
        this.order = order;
        this.sourceSystem = sourceSystem;
        this.contractType = contractType;
    }

    public RetrieveContractsFacadeFilter() {}

}