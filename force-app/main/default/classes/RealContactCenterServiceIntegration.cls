public with sharing class RealContactCenterServiceIntegration implements ContactCenterServiceIntegration
{
    public static final String WEB_SERVICE = 'CreateOpenMediaInteractionGenesys';

    public static HttpResponse createOpenMediaInteraction(String payload)
    {
        HttpClient client = new HttpClient();
        HttpResponse response = client.post(WEB_SERVICE, payload);
        return response;
    }
}