public class ServiceFlowGPSResponse {

	public Integer codigoOperacao {get;set;} 
	public String mensagem {get;set;} 
	public String protocolo {get;set;} 
	public String idSS {get;set;} 
	public String status {get;set;} 
	public Erro erro {get;set;} 

	public ServiceFlowGPSResponse(){}

	public ServiceFlowGPSResponse(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'codigoOperacao') {
						codigoOperacao = parser.getIntegerValue();
					} else if (text == 'mensagem') {
						mensagem = parser.getText();
					} else if (text == 'protocolo') {
						protocolo = parser.getText();
					} else if (text == 'idSS') {
						idSS = parser.getText();
					} else if (text == 'status') {
						status = parser.getText();
					} else if (text == 'erro') {
						erro = new Erro(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'ServiceFlowGPSResponse consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Erro {
		public String descricao {get;set;} 
		public String stackTrace {get;set;} 

		public Erro(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'descricao') {
							descricao = parser.getText();
						} else if (text == 'stackTrace') {
							stackTrace = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Erro consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static ServiceFlowGPSResponse parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new ServiceFlowGPSResponse(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	
}