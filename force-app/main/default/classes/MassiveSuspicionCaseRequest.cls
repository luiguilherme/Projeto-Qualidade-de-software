/*
*
*   Description: Classe responsável exclusivamente pelas regras de negócio de Consulta de Massiva
*
*   Author: André Luis
*   Date:   01/07/2021
*
*/
public with sharing class MassiveSuspicionCaseRequest {
    
	// ATRIBUTOS DA CLASSE
	//==================================================================================================================
	private transient String assetId;
    public CustomerFacingService customerFacingService;
	//==================================================================================================================

	// CONSTRUTORES
	//==================================================================================================================
    public MassiveSuspicionCaseRequest(){}

    public MassiveSuspicionCaseRequest(String assetId){
		this.customerFacingService = customerFacingService;
		this.assetId = assetId;
    }
	//==================================================================================================================


	// CONTRATO
	//==================================================================================================================s
    public class CustomerFacingService {
        public String asset;
    }

	//==================================================================================================================


	// MAPEAMENTO DE VALOREAS NO CONTRATO
	//==================================================================================================================
    public MassiveSuspicionCaseRequest createRequestStructure() {
		return  setCustomerFacingService();
	}

    private MassiveSuspicionCaseRequest setCustomerFacingService(){
        CustomerFacingService customerFacingService = new CustomerFacingService();
        customerFacingService.asset = this.assetId;
        this.customerFacingService = customerFacingService;
        return this;
    }
	//==================================================================================================================

	// CAST DE ENTRADA E SAIDA
	//==================================================================================================================
	public static MassiveSuspicionCaseRequest parse(String json) {
		return (MassiveSuspicionCaseRequest) System.JSON.deserialize(json, MassiveSuspicionCaseRequest.class);
	}

    public String toJson() {	
		System.debug('##THIS = ' + JSON.serialize(this, true));	
		return JSON.serialize(this, true);
	}
	//==================================================================================================================
}