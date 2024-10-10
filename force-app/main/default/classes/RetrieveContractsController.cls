public without sharing class RetrieveContractsController {
    
    @InvocableMethod(label = 'Retrieve Contract Controller' description = 'Classe utilizada para a busca de contrato do cliente no GEDOC')
    public static List<RetrieveContractsResponse> findContractsByParams(List<RetrieveContractsFacadeFilter> filter) {
        List<RetrieveContractsResponse> filteredContracts = new List<RetrieveContractsResponse>();

        RetrieveContractsResponse response = RetrieveContractsService.findByFilter(
            filter[0].order,
            filter[0].sourceSystem,
            filter[0].contractType
        );

        if (response != null) {
            filteredContracts.add(response);
        }

        return filteredContracts;
    }

}