/*
* @author Diego Costa @ Deloitte
* @date 06/06/2022
* @description classe RequestConfiguratorFactory 
*/
public class RequestConfiguratorFactory {
    private static final String APIGW = 'APIGW';
    private static final String FOURTHPLATFORM = 'FOURTHPLATFORM';
    public static IHttpRequestConfigurator getConfigurator(Webservice__c wsConfig) {

        IHttpRequestConfigurator destinationConfigurator;
        
        if(String.isBlank(wsConfig.ServiceProvider__c))
            destinationConfigurator = new QuartaPlataformaRequestConfigurator();
        
        else if(wsConfig.ServiceProvider__c == APIGW)
            destinationConfigurator = new APIGatewayRequestConfigurator();

        else if(wsConfig.ServiceProvider__c == FOURTHPLATFORM)
            destinationConfigurator = new APIGatewayRequestConfigurator();
        return new OAuthEndUserRequestConfigurator(destinationConfigurator);
    }
}