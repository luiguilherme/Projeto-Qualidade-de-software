public class ServiceFlowDiagnosticResponse {

	public class Parametros {
		@AuraEnabled
		public List<Parametro> parametro {get;set;} 
		public Parametros(){}
		public Parametros(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'parametro') {
							parametro = arrayOfParametro(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Parametros consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class Parametro {
		@AuraEnabled
		public String chave {get;set;}
		@AuraEnabled 
		public String valor {get;set;} 

		public Parametro(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'chave') {
							chave = parser.getText();
						} else if (text == 'valor') {
							valor = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Parametro consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class Rotinas {
		public List<Rotina> rotina {get;set;} 

		public Rotinas(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'rotina') {
							rotina = arrayOfRotina(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Rotinas consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Rotina {
		public String id {get;set;} 
		public String nome {get;set;} 
		public List<Formularios> formularios {get;set;} 

		public Rotina(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'nome') {
							nome = parser.getText();
						} else if (text == 'formularios') {
							formularios = arrayOfFormularios(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Rotina consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class ResultadoAtendimento {
		public Integer id {get;set;} 
		public String codigo {get;set;} 
		public String mensagem {get;set;} 
		public List<AtributoAdicional> informacoesAdicionais {get;set;} 
		public Campos campos {get;set;} 
		public Rotinas rotinas {get;set;} 

		public ResultadoAtendimento(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'codigo') {
							codigo = parser.getText();
						} else if (text == 'mensagem') {
							mensagem = parser.getText();
						} else if (text == 'informacoesAdicionais') {
							informacoesAdicionais = arrayOfAtributoAdicional(parser);
						} else if (text == 'campos') {
							campos = new Campos(parser);
						} else if (text == 'rotinas') {
							rotinas = new Rotinas(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'ResultadoAtendimento consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class ResultadosAtendimento {
		public List<ResultadoAtendimento> resultadoAtendimento {get;set;} 

		public ResultadosAtendimento(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'resultadoAtendimento') {
							resultadoAtendimento = arrayOfResultadoAtendimento(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'ResultadosAtendimento consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class AtributoAdicional {
		public String chave {get;set;} 
		public String valor {get;set;} 

		public AtributoAdicional(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'chave') {
							chave = parser.getText();
						} else if (text == 'valor') {
							valor = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'AtributoAdicional consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class GrupoDiagnostico {
		public Integer id {get;set;} 
		public String nome {get;set;} 
		public Pai pai {get;set;} 
		public Acoes acoes {get;set;} 

		public GrupoDiagnostico(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'nome') {
							nome = parser.getText();
						} else if (text == 'pai') {
							pai = new Pai(parser);
						} else if (text == 'acoes') {
							acoes = new Acoes(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'GrupoDiagnostico consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class Pai {
		public Integer id {get;set;} 
		public String nome {get;set;}
		public Pai pai {get;set;} 
		public Acoes acoes {get;set;} 

		public Pai(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'nome') {
							nome = parser.getText();
						} else if (text == 'pai') {
							pai = new Pai(parser);
						} else if (text == 'acoes') {
							acoes = new Acoes(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Pai consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class Campo {
		public String chave {get;set;} 
		public String valor {get;set;} 
		public String tipo {get;set;} 
		public Integer maxLenght {get;set;} 
		public Boolean readOnly {get;set;} 
		public Parametros parametros {get;set;}



		public Campo(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'chave') {
							chave = parser.getText();
						} else if (text == 'valor') {
							tipo = parser.getText();
						} else if (text == 'tipo') {
							tipo = parser.getText();
						} else if (text == 'maxLenght') {
							maxLenght = parser.getIntegerValue();
						} else if (text == 'readOnly') {
							readOnly = parser.getBooleanValue();
						} else if (text == 'parametros') {
							parametros = new Parametros(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Campo consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class Campos {
		public List<Campo> campo {get;set;} 

		public Campos(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'campo') {
							campo = arrayOfCampo(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Campos consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
    
    public class CelulasDestino {
		public List<CelulaOrigem> celulaDestino {get;set;} 

		public CelulasDestino(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'celulaDestino') {
							celulaDestino = arrayOfCelulaOrigem(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'CelulasDestino consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class CelulasOrigem {
		public List<CelulaOrigem> celulaOrigem {get;set;} 

		public CelulasOrigem(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'celulaOrigem') {
							celulaOrigem = arrayOfCelulaOrigem(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'CelulasOrigem consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class CelulaOrigem {
		@AuraEnabled public String nomeCelula {get;set;} 
		@AuraEnabled public Boolean transferenciaComEspera {get;set;} 
		@AuraEnabled public Boolean transferenciaDireta {get;set;} 
		@AuraEnabled public String idCelulaGenesys {get;set;} 
		@AuraEnabled public Boolean celulaNaoGPS {get;set;} 

		public CelulaOrigem(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'nomeCelula') {
							nomeCelula = parser.getText();
						} else if (text == 'transferenciaComEspera') {
							transferenciaComEspera = parser.getBooleanValue();
						} else if (text == 'transferenciaDireta') {
							transferenciaDireta = parser.getBooleanValue();
						} else if (text == 'idCelulaGenesys') {
							idCelulaGenesys = parser.getText();
						} else if (text == 'celulaNaoGPS') {
							celulaNaoGPS = parser.getBooleanValue();
						} else {
							System.debug(LoggingLevel.WARN, 'CelulaOrigem consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}



	public String codigoOperacao {get;set;} 
	public String token {get;set;} 
	public GrupoDiagnostico grupoDiagnostico {get;set;} 
	public ResultadoAtendimento resultadoAtendimento {get;set;} 
	public String status {get;set;} 
	public Formularios formularios {get;set;} 
	public String protocolo {get;set;} 
	public Parametros parametros {get;set;}
	public Campos campos {get;set;}
	public ResultadosAtendimento resultadosAtendimento {get;set;}
	public InformacoesTransferencia informacoesTransferencia {get;set;}  

	public ServiceFlowDiagnosticResponse(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'codigoOperacao') {
						codigoOperacao = parser.getText();
					}else if (text == 'token') {
						token = parser.getText();
					} else if (text == 'grupoDiagnostico') {
						grupoDiagnostico = new GrupoDiagnostico(parser);
					} else if (text == 'resultadoAtendimento') {
						resultadoAtendimento = new ResultadoAtendimento(parser);
					} else if (text == 'status') {
						status = parser.getText();
					} else if (text == 'formularios') {
						formularios = new Formularios(parser);
					} else if (text == 'protocolo') {
						protocolo = parser.getText();
					} else if (text == 'parametros') {
						parametros = new Parametros(parser);
					} else if (text == 'campos') {
						campos = new Campos(parser);
					} else if (text == 'resultadosAtendimento') {
						resultadosAtendimento = new ResultadosAtendimento(parser);
					} else if (text == 'informacoesTransferencia') {
						informacoesTransferencia = new InformacoesTransferencia(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'ServiceFlowDiagnosticResponse consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Acoes {
		public List<Acao> acao {get;set;} 

		public Acoes(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'acao') {
							acao = arrayOfAcao(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Acoes consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Formularios {
		public String id {get;set;} 
		public String label {get;set;} 
		public List<Formulario> formulario {get;set;} 

		public Formularios(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'formulario') {
							formulario = arrayOfFormulario(parser);
						}else if (text == 'id') {
							id = parser.getText();
						} else if (text == 'label') {
							label = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Formularios consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class Formulario {
		public String id {get;set;} 
		public String label {get;set;} 

		public Formulario(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getText();
						} else if (text == 'label') {
							label = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Formulario consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public class InformacoesTransferencia {
		public CelulasOrigem celulasOrigem {get;set;} 
		public CelulasDestino celulasDestino {get;set;} 

		public InformacoesTransferencia(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'celulasOrigem') {
							celulasOrigem = new CelulasOrigem(parser);
						} else if (text == 'celulasDestino') {
							celulasDestino = new CelulasDestino(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'InformacoesTransferencia consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class AtributosAdicionais {
		public List<AtributoAdicional> atributoAdicional {get;set;} 

		public AtributosAdicionais(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'atributoAdicional') {
							atributoAdicional = arrayOfAtributoAdicional(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'AtributosAdicionais consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Midia {
		public String tipo {get;set;} 
		public String url {get;set;} 

		public Midia(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'tipo') {
							tipo = parser.getText();
						} else if (text == 'url') {
							url = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Midia consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}


	public class Acao {
		public Integer id {get;set;} 
		public String nome {get;set;} 
		public String observacao {get;set;} 
		public String tipo {get;set;} 
		public String status {get;set;} 
		public String resposta {get;set;} 
		public String informacoesAdicionais {get;set;} 
		public String erro {get;set;} 
		public String tempo {get;set;} 
		public Integer timeOut {get;set;} 
		public Midia midia {get;set;}
		public AtributosAdicionais atributosAdicionais {get;set;} 
		public Formulario formulario {get;set;} 

		public Acao(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'id') {
							id = parser.getIntegerValue();
						} else if (text == 'nome') {
							nome = parser.getText();
						} else if (text == 'observacao') {
							observacao = parser.getText();
						} else if (text == 'tipo') {
							tipo = parser.getText();
						} else if (text == 'status') {
							status = parser.getText();
						} else if (text == 'resposta') {
							resposta = parser.getText();
						} else if (text == 'informacoesAdicionais') {
							informacoesAdicionais = parser.getText();
						} else if (text == 'erro') {
							erro = parser.getText();
						} else if (text == 'tempo') {
							tempo = parser.getText();
						} else if (text == 'timeOut') {
							timeOut = parser.getIntegerValue();
						} else if (text == 'atributosAdicionais') {
							atributosAdicionais = new AtributosAdicionais(parser);
						} else if (text == 'formulario') {
							formulario = new Formulario(parser);
						} else if (text == 'midia') {
							midia = new Midia(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Acao consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public static ServiceFlowDiagnosticResponse parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new ServiceFlowDiagnosticResponse(parser);
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
	
    private static List<Rotina> arrayOfRotina(System.JSONParser p) {
        List<Rotina> res = new List<Rotina>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Rotina(p));
        }
        return res;
    }

	private static List<Formularios> arrayOfFormularios(System.JSONParser p) {
        List<Formularios> res = new List<Formularios>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Formularios(p));
        }
        return res;
    }


    private static List<Campo> arrayOfCampo(System.JSONParser p) {
        List<Campo> res = new List<Campo>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Campo(p));
        }
        return res;
    }

    private static List<Acao> arrayOfAcao(System.JSONParser p) {
        List<Acao> res = new List<Acao>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Acao(p));
        }
        return res;
    }

    private static List<AtributoAdicional> arrayOfAtributoAdicional(System.JSONParser p) {
        List<AtributoAdicional> res = new List<AtributoAdicional>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new AtributoAdicional(p));
        }
        return res;
    }

    private static List<Parametro> arrayOfParametro(System.JSONParser p) {
        List<Parametro> res = new List<Parametro>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Parametro(p));
        }
        return res;
    }

    private static List<Formulario> arrayOfFormulario(System.JSONParser p) {
        List<Formulario> res = new List<Formulario>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Formulario(p));
        }
        return res;
    }

	private static List<ResultadoAtendimento> arrayOfResultadoAtendimento(System.JSONParser p) {
        List<ResultadoAtendimento> res = new List<ResultadoAtendimento>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new ResultadoAtendimento(p));
        }
        return res;
    }

	private static List<CelulaOrigem> arrayOfCelulaOrigem(System.JSONParser p) {
        List<CelulaOrigem> res = new List<CelulaOrigem>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new CelulaOrigem(p));
        }
        return res;
    }

}