/*
*
*   Description: Classe útil para agrupamento das Ações do GPS
*
*   Author: Geimison Oliveira
*   Date:   23/06/2021
*
*/
global class GPSGroup {
	
    @AuraEnabled
	public String id {get; set;}

    @AuraEnabled
	public String nome {get; set;}
    
    @AuraEnabled
	public List<GPSAction> ltAction {get; set;}
    
    @AuraEnabled
	public String status {get; set;}
    
    @AuraEnabled
	public String answer {get; set;}

    @AuraEnabled
	public String token {get; set;}

    @AuraEnabled
	public String codigoOperacao {get; set;}

    @AuraEnabled
	public ResultadoAtendimento resultadoAtendimento {get; set;}

    @AuraEnabled
	public List<ResultadoAtendimento> ltResultadoAtendimento {get; set;}

    @AuraEnabled
	public List<Campo> ltText {get; set;}

    @AuraEnabled
	public List<Campo> ltNumber {get; set;}

    @AuraEnabled
	public List<Campo> ltCheckbox {get; set;}

    @AuraEnabled
	public Integer idOfLIFO {get; set;}

    @AuraEnabled
	public List<Campo> ltCombobox {get; set;}
    
    @AuraEnabled
	public InformacoesTransferencia informacoesTransferencia {get; set;}

    public class ResultadoAtendimento {
        @AuraEnabled public String id;
        @AuraEnabled public String codigo;
        @AuraEnabled public String mensagem;
    }

    public class Campo {
        @AuraEnabled public String chave;
        @AuraEnabled public String valor;
        @AuraEnabled public String tipo;
        @AuraEnabled public String isVisible;
        @AuraEnabled public Integer maxLenght;
        @AuraEnabled public Boolean readOnly;
        @AuraEnabled public List<ServiceFlowDiagnosticResponse.Parametro> ltParametro;
        @AuraEnabled public ServiceFlowDiagnosticResponse.Parametros parametros;
    }

    public class InformacoesTransferencia {
		@AuraEnabled public List<ServiceFlowDiagnosticResponse.CelulaOrigem> celulasOrigem; 
		@AuraEnabled public List<ServiceFlowDiagnosticResponse.CelulaOrigem> celulasDestino; 
	}
}