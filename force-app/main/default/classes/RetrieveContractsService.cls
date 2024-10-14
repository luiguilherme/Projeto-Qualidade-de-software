public with sharing class RetrieveContractsService {
    
    public static RetrieveContractsResponse findByFilter(String orderId, String sourceSystem, String contractType) {
        return RetrieveContractsFacade.findByFilters(orderId, sourceSystem, contractType);
    }

}