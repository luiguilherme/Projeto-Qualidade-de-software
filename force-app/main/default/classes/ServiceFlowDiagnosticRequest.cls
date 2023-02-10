public with sharing class ServiceFlowDiagnosticRequest {
	private static final String CANAL_ATENDIMENTO = 'SALES_FORCE';

	// ATRIBUTOS DA CLASSE
	//==================================================================================================================
    public String idTipificacao, instancia, canalAtendimento, usuario, token;
	public GrupoDiagnostico grupoDiagnostico;
	public transient GPSGroup gpsGroup;
	//==================================================================================================================

	// CONSTRUTORES
	//==================================================================================================================
    public ServiceFlowDiagnosticRequest(){}

	public class GrupoDiagnostico {
		public Integer id {get;set;} 
		public String nome {get;set;} 
		public Acoes acoes {get;set;} 
	}

	public class Acoes {
		public List<Acao> acao {get;set;} 
	}

	public class Acao {
		public Integer id {get;set;} 
		public String nome {get;set;} 
		public String observacao {get;set;} 
		public String tipo {get;set;} 
		public String status {get;set;} 
		public String resposta {get;set;} 
		public String informacoesAdicionais {get;set;} 
		public String tempo {get;set;} 
		public Integer timeOut {get;set;} 
	}

    public ServiceFlowDiagnosticRequest(String gpsId, String assetInstance, GPSGroup gpsGroup, String token){
		if(gpsId != null){
			User user = UserDAO.getById(UserInfo.getUserId());

			this.idTipificacao = gpsId;
			this.instancia = assetInstance;
			this.usuario = user.Alias;
		}
		if(gpsGroup != null){
			this.gpsGroup = gpsGroup;
		}
		if(token != null){
			this.token = token;
		}
    }

	//==================================================================================================================

	// MAPEAMENTO DE VALOREAS NO CONTRATO
	//==================================================================================================================
    public ServiceFlowDiagnosticRequest createRequestStructure() {
		if(this.token == null){
			return  setCanalAtendimento().setGrupoDiagnostico();
		}else{
			return this;
		}
	}

	private ServiceFlowDiagnosticRequest setCanalAtendimento(){
        this.canalAtendimento = CANAL_ATENDIMENTO;
        return this;
    }

    private ServiceFlowDiagnosticRequest setGrupoDiagnostico(){
		if(this.gpsGroup.id == null){
			return this;
		}

		ServiceFlowDiagnosticRequest.grupoDiagnostico grupoDiagnostico = new ServiceFlowDiagnosticRequest.grupoDiagnostico();
		grupoDiagnostico.id = Integer.valueOf(this.gpsGroup.id);
		grupoDiagnostico.nome = this.gpsGroup.nome;
		this.token = this.gpsGroup.token;

        ServiceFlowDiagnosticRequest.Acoes acoes = new ServiceFlowDiagnosticRequest.acoes();
		for(GPSAction gpsGroupAcao : gpsGroup.ltAction){
			ServiceFlowDiagnosticRequest.acao acao = new ServiceFlowDiagnosticRequest.acao();
			acao.id = Integer.valueOf(gpsGroupAcao.id);
			acao.nome = gpsGroupAcao.name;
			acao.tipo = gpsGroupAcao.type;
			acao.status = gpsGroupAcao.status;
			acao.resposta = gpsGroupAcao.answer;

			if(!(acao.tipo == 'MANUAL' && acao.status == 'PENDENTE')){
				if(acoes.acao == null){
					acoes.acao = new List<ServiceFlowDiagnosticRequest.Acao>{acao};
				} else {
					acoes.acao.add(acao);
				}
			}

		}
		grupoDiagnostico.acoes = acoes;

		this.grupoDiagnostico = grupoDiagnostico;
        return this;
    }
	//==================================================================================================================

	// CAST DE ENTRADA E SAIDA
	//==================================================================================================================
	public static ServiceFlowDiagnosticRequest parse(String json) {
		return (ServiceFlowDiagnosticRequest) System.JSON.deserialize(json, ServiceFlowDiagnosticRequest.class);
	}

    public String toJson() {	
		return JSON.serialize(this, true);
	}
	//==================================================================================================================
}