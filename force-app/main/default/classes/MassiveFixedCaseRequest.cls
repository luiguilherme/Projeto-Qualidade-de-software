/*
*
*   Description: Classe responsável exclusivamente pelas regras de negócio de Consulta de Massiva
*
*   Author: André Luis
*   Date:   01/07/2021
*
*/

public with sharing class MassiveFixedCaseRequest {
    
	// ATRIBUTOS DA CLASSE
	//==================================================================================================================
	private transient String assetInstance, description, openDate;
    public CustomerFacingService CustomerFacingService;
    public Problem Problem;
    public NetworkProblem NetworkProblem;
    public SystemIdentification SystemIdentification;
	//==================================================================================================================

	// CONSTRUTORES
	//==================================================================================================================
    public MassiveFixedCaseRequest(){}

    public MassiveFixedCaseRequest(String assetInstance, String serviceName){
        WebService__c wsConfig = Webservice__c.getInstance(serviceName);
        this.openDate = String.valueOf(System.today().addDays(getValidateTime(wsConfig))) + 'T00:00:00Z';

		this.customerFacingService = customerFacingService;
		this.assetInstance = assetInstance;
    }

    public Integer getValidateTime(Webservice__c wsConfig){
        return Integer.valueOf(wsConfig.Validate__c)*-1;
    }
	//==================================================================================================================


	// CONTRATO
	//==================================================================================================================
    public class SystemIdentification {
        public String id;
    }

    public class ProblemHasAssociatedTroubleTicket {
        public String description;
    }

    public class Problem {
        public List<ProblemHasAssociatedTroubleTicket> ProblemHasAssociatedTroubleTicket;
        public String status;
    }

    public class CustomerFacingService {
        public String asset;
    }
    
    public class NetworkProblem {
        public String openDate;
    }
	//==================================================================================================================


	// MAPEAMENTO DE VALOREAS NO CONTRATO
	//==================================================================================================================
    public MassiveFixedCaseRequest createRequestStructure() {
		return  setCustomerFacingService()
                .setNetworkProblem()
            	.setDescription()
                .setStatus()                
                .setSystemIdentification();
	}

    private MassiveFixedCaseRequest setCustomerFacingService(){
        CustomerFacingService customerFacing = new CustomerFacingService();
        customerFacing.asset = this.assetInstance;
        this.customerFacingService = customerFacing;
        return this;
    }
    
    private MassiveFixedCaseRequest setNetworkProblem(){
        NetworkProblem networkProblem = new NetworkProblem();
        networkProblem.openDate = this.openDate;
        this.networkProblem = networkProblem;
        return this;
    }

    private MassiveFixedCaseRequest setDescription(){
        Problem problem = new Problem();
        ProblemHasAssociatedTroubleTicket descriptionProblemTA = new ProblemHasAssociatedTroubleTicket();
        descriptionProblemTA.description = 'TA';
        ProblemHasAssociatedTroubleTicket descriptionProblemTP = new ProblemHasAssociatedTroubleTicket();
        descriptionProblemTP.description = 'TP';
        problem.ProblemHasAssociatedTroubleTicket = new List<ProblemHasAssociatedTroubleTicket>();
        
        problem.ProblemHasAssociatedTroubleTicket.add(descriptionProblemTA);
        problem.ProblemHasAssociatedTroubleTicket.add(descriptionProblemTP); 
        this.problem = problem;
        return this;
    }

    private MassiveFixedCaseRequest setStatus(){
        Problem problem = new Problem();
        problem.status = 'Ativo';
        this.Problem.status = 'Ativo';
		return this;
	}

    private MassiveFixedCaseRequest setSystemIdentification(){
        SystemIdentification systemIdentification = new SystemIdentification();
        systemIdentification.id = '0';
        this.systemIdentification = systemIdentification;
		return this;
	}
	//==================================================================================================================

	// CAST DE SAIDA
	//==================================================================================================================
    public String toJson() {	
		return JSON.serialize(this, true);
	}
	//==================================================================================================================
}