public class ServiceFlowGPSRequest {
    private static final String CANAL_ATENDIMENTO = 'SALES_FORCE_NOVA_ORG';

    public class Parametros {
		public List<Parametro> parametro;
	}

	public String canalAtendimento, regraNegocio, documento, instancia, usuario;
	public Parametros parametros;

	public class Parametro {
		public String chave;
		public String valor;
	}

    public ServiceFlowGPSRequest(String regraNegocio, String documento, String instancia, String usuario, Map<String, String> parametros){
        this.canalAtendimento = CANAL_ATENDIMENTO;
        this.regraNegocio = regraNegocio;
        this.documento = documento;
        this.instancia = instancia;
        this.usuario = usuario;

        if(parametros != null){ 
            Parametros params = new Parametros();
            params.parametro = new List<Parametro>();

            for(String key: parametros.keySet()){
                Parametro param = new Parametro();
                param.chave = key;
                param.valor = parametros.get(key);
                params.parametro.add(param);
            }

            this.parametros = params;
        }
    }

    public String toJson() {	
		return JSON.serialize(this, true);
	}
}