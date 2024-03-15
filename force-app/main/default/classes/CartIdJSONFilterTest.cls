@isTest
public class CartIdJSONFilterTest {

    @isTest
    static void testExtractCartId() {
        // Cria um JSON de exemplo em uma única linha
        String jsonInput = '{"accountId":"0017600000dlbVEAAY","cartConfiguration":{},"cartGroupId":"a3U76000000FjFQEA0","cartId":"80176000002H7n5AAC","cartType":"Order","groupCartId":"80176000002H7n6AAC","groupCartName":"Vivo Pré Turbo Giga 15 Dias 2023-12-27T21:00:10.827Z","targetOfferId":"01u760000053wNKAAY","userIntent":"Keep","assetIds":["02i76000009PoMVAA0","02i76000009PoMVAA0"]}';

        // Chama o método extractCartId da classe CartIdJSONFilter
        List<String> jsonInputs = new List<String>{ jsonInput };
        List<CartIdJSONFilter.CartIdResult> results = CartIdJSONFilter.extractCartId(jsonInputs);

        // Verifica se o resultado é o esperado
        System.assertEquals(1, results.size());
        System.assertEquals('80176000002H7n5AAC', results[0].cartIdFilter);
    }
}