public with sharing class ServiceFlowProtocolRequest {
    
	// ATRIBUTOS DA CLASSE
	//==================================================================================================================
    public String token;
    public Campos campos;
	public transient GPSGroup gpsGroup;
	//==================================================================================================================

	// CONSTRUTORES
	//==================================================================================================================
    public ServiceFlowProtocolRequest(){}

    public ServiceFlowProtocolRequest(GPSGroup gpsGroup){
		this.token = gpsGroup.token;
		this.gpsGroup = gpsGroup;
    }

   	//==================================================================================================================

    // CONTRATO
	//==================================================================================================================s
    public class Campo{
        public String chave;
        public String valor;
        public String tipo;
    }

	public class Campos{
		public List<Campo> campo;
	}

    public class ServiceFlowGPSProtocolRequest {
        public String token;
        public List<Campo> campos;
    }

	//==================================================================================================================

	// MAPEAMENTO DE VALOREAS NO CONTRATO
	//==================================================================================================================
    public ServiceFlowProtocolRequest createRequestStructure() {
		return  setRequestTO().setCampos();
	}

    private ServiceFlowProtocolRequest setRequestTO(){
        this.token = this.token;
        return this;
    }

	private ServiceFlowProtocolRequest setCampos(){
		if(this.gpsGroup == null){
			return this;
		}

		ServiceFlowProtocolRequest.Campos campos = new ServiceFlowProtocolRequest.Campos();

		if(gpsGroup.ltNumber != null && !gpsGroup.ltNumber.isEmpty()){
			for(GPSGroup.Campo gpsGroupCampo : gpsGroup.ltNumber){
				ServiceFlowProtocolRequest.Campo campo = new ServiceFlowProtocolRequest.Campo();
				campo.chave = gpsGroupCampo.chave;
				campo.valor = gpsGroupCampo.valor;
				campo.tipo = gpsGroupCampo.tipo;
				if(campos.campo == null){
					campos.campo = new List<ServiceFlowProtocolRequest.Campo>{campo};
				} else {
					campos.campo.add(campo);
				}
			}
		}

		if(gpsGroup.ltText != null && !gpsGroup.ltText.isEmpty()){
			for(GPSGroup.Campo gpsGroupCampo : gpsGroup.ltText){
				ServiceFlowProtocolRequest.Campo campo = new ServiceFlowProtocolRequest.Campo();
				campo.chave = gpsGroupCampo.chave;
				campo.valor = gpsGroupCampo.valor;
				campo.tipo = gpsGroupCampo.tipo;
				if(campos.campo == null){
					campos.campo = new List<ServiceFlowProtocolRequest.Campo>{campo};
				} else {
					campos.campo.add(campo);
				}
			}
		}

		if(gpsGroup.ltCheckbox != null && !gpsGroup.ltCheckbox.isEmpty()){
			for(GPSGroup.Campo gpsGroupCampo : gpsGroup.ltCheckbox){
				ServiceFlowProtocolRequest.Campo campo = new ServiceFlowProtocolRequest.Campo();
				campo.chave = gpsGroupCampo.chave;
				campo.valor = gpsGroupCampo.valor;
				campo.tipo = gpsGroupCampo.tipo;
				if(campos.campo == null){
					campos.campo = new List<ServiceFlowProtocolRequest.Campo>{campo};
				} else {
					campos.campo.add(campo);
				}
			}
		}
		if(gpsGroup.ltCombobox != null && !gpsGroup.ltCombobox.isEmpty()){
			for(GPSGroup.Campo gpsGroupCampo : gpsGroup.ltCombobox){
				ServiceFlowProtocolRequest.Campo campo = new ServiceFlowProtocolRequest.Campo();
				campo.chave = gpsGroupCampo.chave;
				campo.valor = gpsGroupCampo.valor;
				campo.tipo = gpsGroupCampo.tipo;
				if(campos.campo == null){
					campos.campo = new List<ServiceFlowProtocolRequest.Campo>{campo};
				} else {
					campos.campo.add(campo);
				}
	
			}
		}
		this.campos = campos;
		return this;
	}
	//==================================================================================================================

	// CAST DE ENTRADA E SAIDA
	//==================================================================================================================
	public static ServiceFlowProtocolRequest parse(String json) {
		return (ServiceFlowProtocolRequest) System.JSON.deserialize(json, ServiceFlowProtocolRequest.class);
	}

    public String toJson() {	
		System.debug('##THIS = ' + JSON.serialize(this, true));	
		return JSON.serialize(this, true);
	}
	//==================================================================================================================
}