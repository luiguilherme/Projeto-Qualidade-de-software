public with sharing class GpsFlowIdRequest {
    private static final String PARAMETRO_CHAVE = 'PERMITIDO_PARA';
    private static final String CANAL_ATENDIMENTO = 'SALES_FORCE';

	// ATRIBUTOS DA CLASSE
	//==================================================================================================================
    public String canalAtendimento;
    public Parametros parametros;
    private transient String instance;
	//==================================================================================================================

	// CONSTRUTORES
	//==================================================================================================================
    public GpsFlowIdRequest(){}

    public GpsFlowIdRequest(String instance){
		this.instance = instance;
    }

   	//==================================================================================================================

    // CONTRATO
	//==================================================================================================================
    public class Parametros{
        public List<Parametro> parametro;
    }

    public class Parametro{
        public String chave;
        public String valor;
        public Parametros parametros;
    }

	//==================================================================================================================

	// MAPEAMENTO DE VALOREAS NO CONTRATO
	//==================================================================================================================
    public GpsFlowIdRequest createRequestStructure() {
		return  setCanalAtendimento().setInstance();
	}

    private GpsFlowIdRequest setCanalAtendimento(){
        this.canalAtendimento = CANAL_ATENDIMENTO;
        return this;
    }
    

    private GpsFlowIdRequest setInstance(){
        if(this.instance == null){
            return this;
        }

        GpsFlowIdRequest.parametros parametros = new GpsFlowIdRequest.parametros();
        GpsFlowIdRequest.parametro parametro = new GpsFlowIdRequest.parametro();
        parametro.chave = PARAMETRO_CHAVE;
        
        List<String> ltInstance = new List<String>();
        
		if(this.instance.contains(';')){
            ltInstance = this.instance.split(';');
		}else if(String.isNotBlank(this.instance)){
            ltInstance.add(this.instance);
		}
        
        GpsFlowIdRequest.parametros parametrosInstance = new GpsFlowIdRequest.parametros();
        for(String valor : ltInstance){
            GpsFlowIdRequest.parametro parametroInstance = new GpsFlowIdRequest.parametro();
            parametroinstance.valor = valor;

            if(parametrosInstance.parametro == null){
                parametrosInstance.parametro = new List<GpsFlowIdRequest.Parametro>{parametroInstance};
            } else {
                parametrosInstance.parametro.add(parametroInstance);
            } 
        }
        
        parametro.parametros = parametrosInstance;
        parametros.parametro = new List<GpsFlowIdRequest.Parametro>{parametro};

        this.parametros = parametros;

        return this;
    }

	//==================================================================================================================

	// CAST DE ENTRADA E SAIDA
	//==================================================================================================================
	public static GpsFlowIdRequest parse(String json) {
		return (GpsFlowIdRequest) System.JSON.deserialize(json, GpsFlowIdRequest.class);
	}

    public String toJson() {	
		return JSON.serialize(this, true);
	}
	//==================================================================================================================
}