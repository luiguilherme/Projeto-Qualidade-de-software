public with sharing class ServiceFlowFormRequest {
    
	// ATRIBUTOS DA CLASSE
	//==================================================================================================================
    public String token, id;
    public Parametros parametros;
	public transient Map<String, Object> mapForm;
	//==================================================================================================================

	// CONSTRUTORES
	//==================================================================================================================
    public ServiceFlowFormRequest(){}

    public ServiceFlowFormRequest(String token, String id, Map<String, Object> mapForm){
		this.token = token;
		this.id = id;
		this.mapForm = mapForm;
    }

   	//==================================================================================================================

    // CONTRATO
	//==================================================================================================================    
    
    public class ServiceFlowGPSProtocolRequest {
        public String token;
    }

	public class Parametros {
		public List<Parametro> parametro {get;set;} 
	}

	public class Parametro {
		public String chave {get;set;} 
		public String valor {get;set;} 
		public String tipo {get;set;} 
		public Parametros parametros {get;set;} 
	}

	//==================================================================================================================

	// MAPEAMENTO DE VALOREAS NO CONTRATO
	//==================================================================================================================
    public ServiceFlowFormRequest createRequestStructure() {
		return  setRequestTO().setParametros();
	}

    private ServiceFlowFormRequest setRequestTO(){
        this.token = this.token;
        this.id = this.id;
        return this;
    }

	private ServiceFlowFormRequest setParametros(){
		if(this.mapForm == null ){
			return this;
		}
		
		if(this.mapForm.get('FORM_ADC_ORDERNUM_RESENDEXTRACT') != null){

			ServiceFlowFormRequest.Parametros parametrosPai = new ServiceFlowFormRequest.Parametros();
			ServiceFlowFormRequest.Parametro parametroFilho = new ServiceFlowFormRequest.Parametro();
			ServiceFlowFormRequest.Parametros parametrosSubFilho = new ServiceFlowFormRequest.Parametros();

			String ordersString = String.valueOf(mapForm.get('FORM_ADC_ORDERNUM_RESENDEXTRACT')).remove('(').remove(')');
			List<String> ltOrders = ordersString.split(',');

			if(mapForm.get('FORM_ADC_ORDERNUM_RESENDEXTRACT_VISUALIZAR') != null){
				parametroFilho.chave = 'FORM_ADC_ORDERNUM_VISUALIZAR';
				parametroFilho.valor = ltOrders[0].trim();
			}else{
				parametroFilho.chave = 'FORM_ADC_ORDERNUM_RESENDEXTRACT';
				parametroFilho.tipo = 'TEXT_LIST';

				List<ServiceFlowFormRequest.Parametro> ordersList = new List<ServiceFlowFormRequest.Parametro>();

				for(String order : ltOrders){
					ServiceFlowFormRequest.Parametro parametroSubFilho = new ServiceFlowFormRequest.Parametro();
					parametroSubFilho.valor = order.trim();
					if(parametroSubFilho.valor != ''){
						ordersList.add(parametroSubFilho);
					}
				}

				parametrosSubFilho.parametro = ordersList;
				parametroFilho.parametros = parametrosSubFilho;
			}
			
			parametrosPai.parametro = new List<ServiceFlowFormRequest.Parametro>{parametroFilho};
			this.parametros = parametrosPai;

		} else if(this.mapForm.get('SERIAL_INSTANCIA_FORM_ATEND_SEL_INST') != null){

			ServiceFlowFormRequest.Parametros parametrosPai = new ServiceFlowFormRequest.Parametros();

			ServiceFlowFormRequest.Parametro parametroFilho = new ServiceFlowFormRequest.Parametro();
			parametroFilho.chave = 'SERIAL_INSTANCIA_FORM_ATEND_SEL_INST';
			parametroFilho.tipo = 'TEXT_LIST';

			ServiceFlowFormRequest.Parametros parametrosSubFilho = new ServiceFlowFormRequest.Parametros();
			List<ServiceFlowFormRequest.Parametro> instancesList = new List<ServiceFlowFormRequest.Parametro>();

			String instancesString = String.valueOf(mapForm.get('SERIAL_INSTANCIA_FORM_ATEND_SEL_INST')).remove('(').remove(')');
			List<String> ltInstances = instancesString.split(',');

			for(String instance : ltInstances){
				ServiceFlowFormRequest.Parametro parametroSubFilho = new ServiceFlowFormRequest.Parametro();
				parametroSubFilho.valor = instance.trim();
				instancesList.add(parametroSubFilho);
			}

			parametrosSubFilho.parametro = instancesList;
			parametroFilho.parametros = parametrosSubFilho;
			parametrosPai.parametro = new List<ServiceFlowFormRequest.Parametro>{parametroFilho};
			this.parametros = parametrosPai;

		} else if(this.mapForm.get('FORM_ADC_LINHAS_SMS_INCENTIVO') != null){

			ServiceFlowFormRequest.Parametros parametrosPai = new ServiceFlowFormRequest.Parametros();

			ServiceFlowFormRequest.Parametro parametroFilho = new ServiceFlowFormRequest.Parametro();
			parametroFilho.chave = 'FORM_ADC_LINHAS_SMS_INCENTIVO';
			parametroFilho.tipo = 'TEXT_LIST';

			ServiceFlowFormRequest.Parametros parametrosSubFilho = new ServiceFlowFormRequest.Parametros();
			List<ServiceFlowFormRequest.Parametro> numberList = new List<ServiceFlowFormRequest.Parametro>();

			String numbersString = String.valueOf(mapForm.get('FORM_ADC_LINHAS_SMS_INCENTIVO')).remove('(').remove(')');
			List<String> ltNumbers = numbersString.split(',');

			for(String numberSms : ltNumbers){
				ServiceFlowFormRequest.Parametro parametroSubFilho = new ServiceFlowFormRequest.Parametro();
				parametroSubFilho.valor = numberSms.trim();
				numberList.add(parametroSubFilho);
			}

			parametrosSubFilho.parametro = numberList;
			parametroFilho.parametros = parametrosSubFilho;
			parametrosPai.parametro = new List<ServiceFlowFormRequest.Parametro>{parametroFilho};
			this.parametros = parametrosPai;

		} else if(this.mapForm.get('FORM_ACAO_RTD_ID_OFERTA') != null){
			ServiceFlowFormRequest.Parametros parametros = new ServiceFlowFormRequest.Parametros();
			ServiceFlowFormRequest.Parametro parametro = new ServiceFlowFormRequest.Parametro();
			parametro.chave = 'FORM_ACAO_RTD_ID_OFERTA';
			parametro.tipo = 'TEXT';
			parametro.valor =  String.valueOf(mapForm.get('FORM_ACAO_RTD_ID_OFERTA'));
			
			parametros.parametro = new List<ServiceFlowFormRequest.Parametro>{parametro};

			this.parametros = parametros;
			
		}  else if(this.mapForm.get('FORM_SELECAO_OFERTAS_RETENCAO_BEAN') != null){
			ServiceFlowFormRequest.Parametros parametros = new ServiceFlowFormRequest.Parametros();
			ServiceFlowFormRequest.Parametro parametro = new ServiceFlowFormRequest.Parametro();
			
			String valorJson =  String.valueOf(mapForm.get('FORM_SELECAO_OFERTAS_RETENCAO_BEAN'));
			parametros = (ServiceFlowFormRequest.Parametros) System.JSON.deserialize(valorJson,ServiceFlowFormRequest.Parametros.class);

			this.parametros = parametros;
		} else if(this.mapForm.get('FORM_SIMULA_OFERTAS_RETENCAO_BEAN') != null){
			ServiceFlowFormRequest.Parametros parametros = new ServiceFlowFormRequest.Parametros();
			ServiceFlowFormRequest.Parametro parametro = new ServiceFlowFormRequest.Parametro();
			
			String valorJson =  String.valueOf(mapForm.get('FORM_SIMULA_OFERTAS_RETENCAO_BEAN'));
			parametros = (ServiceFlowFormRequest.Parametros) System.JSON.deserialize(valorJson,ServiceFlowFormRequest.Parametros.class);

			System.debug('parametros');
			System.debug(parametros);
			this.parametros = parametros;
		} else if(this.mapForm.get('FORM_CHECKOUT_RETENCAO_BEAN') != null){
			ServiceFlowFormRequest.Parametros parametros = new ServiceFlowFormRequest.Parametros();
			ServiceFlowFormRequest.Parametro parametro = new ServiceFlowFormRequest.Parametro();
			
			String valorJson =  String.valueOf(mapForm.get('FORM_CHECKOUT_RETENCAO_BEAN'));
			parametros = (ServiceFlowFormRequest.Parametros) System.JSON.deserialize(valorJson,ServiceFlowFormRequest.Parametros.class);

			System.debug('parametros');
			System.debug(parametros);
			this.parametros = parametros;
		} else if(this.mapForm.get('FORM_ACAO_CONSULTA_REALIZADA') != null){
			ServiceFlowFormRequest.Parametros parametros = new ServiceFlowFormRequest.Parametros();
			ServiceFlowFormRequest.Parametro parametro = new ServiceFlowFormRequest.Parametro();
			parametro.chave = 'FORM_ACAO_CONSULTA_REALIZADA';
			parametro.tipo = 'BOOLEAN';
			parametro.valor =  'TRUE';
			
			parametros.parametro = new List<ServiceFlowFormRequest.Parametro>{parametro};

			this.parametros = parametros;
			
		} else if(this.mapForm.get('CELULA_EPS_FORM_ACAO_CONSULTA') != null){
			ServiceFlowFormRequest.Parametros parametrosReturn = new ServiceFlowFormRequest.Parametros();
			
			ServiceFlowFormRequest.Parametro param1 = new ServiceFlowFormRequest.Parametro();
			param1.chave = 'CELULA_EPS_FORM_ACAO_CONSULTA';
			param1.valor = 'FALSE';
			param1.tipo = 'BOOLEAN';
			
			ServiceFlowFormRequest.Parametro param2 = new ServiceFlowFormRequest.Parametro();
			param2.chave = 'TELEFONIA_FORM_ACAO_CONSULTA';
			param2.valor = 'TCC';
			param2.tipo = 'TEXT';
			
			parametrosReturn.parametro = new List<ServiceFlowFormRequest.Parametro>{param1,param2};

			this.parametros = parametrosReturn;	
		}

		return this;
	}

	//==================================================================================================================

	// CAST DE ENTRADA E SAIDA
	//==================================================================================================================
	public static ServiceFlowFormRequest parse(String json) {
		return (ServiceFlowFormRequest) System.JSON.deserialize(json, ServiceFlowFormRequest.class);
	}

    public String toJson() {	
		System.debug('TO JSON = ' + JSON.serialize(this, true));
		return JSON.serialize(this, true);
	}
	//==================================================================================================================
}