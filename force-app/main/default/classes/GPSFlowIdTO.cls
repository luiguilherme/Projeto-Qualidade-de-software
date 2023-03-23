public class GPSFlowIdTO {

	public Tipificacoes tipificacoes {get;set;} 

	public GPSFlowIdTO(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'tipificacoes') {
						tipificacoes = new Tipificacoes(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'GPSFlowIdTO consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Tipificacao {
		public Integer id {get;set;} 
		public String descricao {get;set;} 
		public String hierarquia {get;set;} 

		public Tipificacao(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'descricao') {
							descricao = parser.getText();
						} else if (text == 'hierarquia') {
							hierarquia = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Tipificacao consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Tipificacoes {
		public List<Tipificacao> tipificacao {get;set;} 

		public Tipificacoes(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'tipificacao') {
							tipificacao = arrayOfTipificacao(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Tipificacoes consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static GPSFlowIdTO parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new GPSFlowIdTO(parser);
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
	





    private static List<Tipificacao> arrayOfTipificacao(System.JSONParser p) {
        List<Tipificacao> res = new List<Tipificacao>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Tipificacao(p));
        }
        return res;
    }


}