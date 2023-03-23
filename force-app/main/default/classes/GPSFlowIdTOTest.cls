@IsTest
public class GPSFlowIdTOTest {
	
	static testMethod void testParse() {
		String json = '{'+
		'    \"tipificacoes\": {'+
		'        \"tipificacao\": ['+
		'            {'+
		'                \"id\": 30349,'+
		'                \"descricao\": \"Receber por e-mail\",'+
		'                \"hierarquia\": \"Solicitação > 2° Via > Fatura > Receber por e-mail\"'+
		'            },'+
		'            {'+
		'                \"id\": 30390,'+
		'                \"descricao\": \"PP4299_RA_ClienteRetido_2\",'+
		'                \"hierarquia\": \"Solicitação > Atendimento > PP4299 > PP4299_RA_ClienteRetido_2\"'+
		'            },'+
		'            {'+
		'                \"id\": 29802,'+
		'                \"descricao\": \"Teste TALC\",'+
		'                \"hierarquia\": \"Informação > Nível 2 > Nível 3 > Teste TALC\"'+
		'            }'+
		'        ]'+
		'    }'+
		'}';
		GPSFlowIdTO r = GPSFlowIdTO.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		GPSFlowIdTO objGPSFlowIdTO = new GPSFlowIdTO(System.JSON.createParser(json));
		System.assert(objGPSFlowIdTO != null);
		System.assert(objGPSFlowIdTO.tipificacoes == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		GPSFlowIdTO.Tipificacao objTipificacao = new GPSFlowIdTO.Tipificacao(System.JSON.createParser(json));
		System.assert(objTipificacao != null);
		System.assert(objTipificacao.id == null);
		System.assert(objTipificacao.descricao == null);
		System.assert(objTipificacao.hierarquia == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		GPSFlowIdTO.Tipificacoes objTipificacoes = new GPSFlowIdTO.Tipificacoes(System.JSON.createParser(json));
		System.assert(objTipificacoes != null);
		System.assert(objTipificacoes.tipificacao == null);
	}
}