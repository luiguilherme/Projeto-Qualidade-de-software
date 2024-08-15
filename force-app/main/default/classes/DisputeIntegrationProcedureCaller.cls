public class DisputeIntegrationProcedureCaller {

    public static final String STATUS_SUCCESS = 'SUCCESS';
	public static final String STATUS_ERROR = 'ERROR';
    
	public class Input {
		
        public Input() {}
        
        public Input(String integrationProcedureName, String caseId, String disputedItemId) {
            this.integrationProcedureName = integrationProcedureName;
            this.caseId = caseId;
            this.disputedItemId = disputedItemId;
        }
        
        @InvocableVariable
        public String integrationProcedureName;

        @InvocableVariable
        public String caseId;
        
        @InvocableVariable
        public String disputedItemId;
    }
    
    public class Output {
		
        public Output() {}

        public Output(String question, String answer, String additionalInformation) {
			this.status = STATUS_SUCCESS;
            this.question = question;
            this.answer = answer;
            this.additionalInformation = additionalInformation;
        }
		
		public Output(String error, String question) {
			this.status = STATUS_ERROR;
			this.error = error;
            this.question = question;
            this.answer = 'Não';
        }

		@InvocableVariable
		public String status;
	
        @InvocableVariable
        public String question;

        @InvocableVariable
        public String answer;

        @InvocableVariable
        public String additionalInformation;
		
		@InvocableVariable
		public String error;
    }
    
    @InvocableMethod(label='DisputeIntegrationProcedureCaller' description='Para os cenários do fluxo de contestação de fatura, efetua uma chamada para uma Integration Procedure e devolve o resultado do processamento')
    public static List<Output> execute(List<Input> inputs) {
        List<Output> outputs = new List<Output>();
        
        String integrationProcedureName = inputs != null && !inputs.isEmpty() ? inputs.get(0).integrationProcedureName : null;
        String caseId = inputs != null && !inputs.isEmpty() ? inputs.get(0).caseId : null;
        String disputedItemId = inputs != null && !inputs.isEmpty() ? inputs.get(0).disputedItemId : null;
        
        if (String.isBlank(integrationProcedureName)) {
            throw new InvalidIntegrationProcedureParamException('É necessário informar o nome da Integration Procedure, Type_SubType.');
        }
        
        if (String.isBlank(caseId)) {
            throw new InvalidIntegrationProcedureParamException('É necessário informar o Id do caso.');
        }
		
		if (String.isBlank(disputedItemId)) {
			throw new InvalidIntegrationProcedureParamException('É necessário informar o Id do item contestado.');
		}
        
        Map <String, Object> integrationProcedureInputs = new Map <String, Object> ();
        Map <String, Object> integrationProcedureOptions = new Map <String, Object> ();

        integrationProcedureInputs.put('CaseId', caseId);
		integrationProcedureInputs.put('DisputedItemId', disputedItemId);

        System.debug('Pegou Inputs:' + integrationProcedureInputs);

        Map <String, Object> integrationProcedureOutput = (Map<String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(integrationProcedureName, integrationProcedureInputs, integrationProcedureOptions);

		System.debug('Pegou Output:' + integrationProcedureOutput);
		
        String error = String.isBlank((String) integrationProcedureOutput.get('Error')) ? (String) integrationProcedureOutput.get('error') : (String) integrationProcedureOutput.get('Error');
    
        if (String.isBlank(error)) {
            outputs.add(new Output(
                (String) integrationProcedureOutput.get('Question'), 
                (String) integrationProcedureOutput.get('Answer'),
                (String) integrationProcedureOutput.get('AdditionalInformation')));
        } else {
            outputs.add(new Output(
				(String) integrationProcedureOutput.get('Error'),
				(String) integrationProcedureOutput.get('Question')));
		}

        return outputs;
    }
    
    public class InvalidIntegrationProcedureParamException extends Exception {}
}