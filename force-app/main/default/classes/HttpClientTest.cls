@IsTest
public class HttpClientTest {
    @IsTest
    static void testValidHeaders() {
        // Cria um objeto Webservice__c com headers válidos
        Webservice__c wsConfig = new Webservice__c();
        wsConfig.Headers__c = 'Authorization:Bearer 1234567890123456;Content-Type:application/json';

        // Cria um objeto HttpRequest
        HttpRequest request = new HttpRequest();

        // Chama o método setRequestHeaders
        HttpClient.setRequestHeaders(wsConfig, request);

        // Verifica se os headers foram definidos corretamente
        Assert.areEqual('Bearer 1234567890123456', request.getHeader('Authorization'));
        Assert.areEqual('application/json', request.getHeader('Content-Type'));
    }

    @IsTest
    static void testInvalidHeaders() {
        // Cria um objeto Webservice__c com headers inválidos
        Webservice__c wsConfig = new Webservice__c();
        wsConfig.Headers__c = 'Authorization Bearer 1234567890123456; Content-Type application/json';

        // Cria um objeto HttpRequest
        HttpRequest request = new HttpRequest();

        // Chama o método setRequestHeaders
        HttpClient.setRequestHeaders(wsConfig, request);

        // Verifica se nenhum header foi definido e se um log de erro foi gerado
        Assert.areEqual(null, request.getHeader('Authorization'));
        Assert.areEqual(null, request.getHeader('Content-Type'));
    }
}