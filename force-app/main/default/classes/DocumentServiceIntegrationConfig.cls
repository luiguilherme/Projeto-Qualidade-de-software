public with sharing class DocumentServiceIntegrationConfig
{
    public static DocumentServiceIntegration getService()
    {
        return Util.getEnvironmentName().contains('.dev') || Test.isRunningTest()
            ? (DocumentServiceIntegration) new MockDocumentServiceIntegration()
            : (DocumentServiceIntegration) new RealDocumentServiceIntegration();
    }
}