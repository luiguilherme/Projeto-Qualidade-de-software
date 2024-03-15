@isTest
public class BulkReplaceFlowParametersTest {
    @isTest
    static void testBulkReplaceFlowParameters() {
        // Cria um JSON de exemplo em uma única linha
        String jsonInput = '{"accountId":"0017600000dlbVEAAY","cartId":"80176000002HCXgAAO","cartType":"Order","selectType":"createOrder","timestamp":"2024-01-27T19:38:15.287Z","userID":"00576000001Zf6FAAS","cartGroupId":"a3U76000000FkFLEA0","groupCartId":"80176000002HCXhAAO","targetOfferId":"01u76000000y3Z4AAI","groupCartName":"Vivo Pré Turbo Giga 15 Dias 2024-01-27T19:38:15.287Z","userIntent":"Keep"}';

        // Chama o método extractCartId da classe CartIdJSONFilter
        List<String> jsonInputs = new List<String>{ jsonInput };
        List<BulkReplaceFlowParameters.Result> results = BulkReplaceFlowParameters.bulkReplaceParameters(jsonInputs);

        // Verifica se o resultado é o esperado
        System.assertEquals(1, results.size());
        System.assertEquals('80176000002HCXgAAO', results[0].cartId);
    }
}