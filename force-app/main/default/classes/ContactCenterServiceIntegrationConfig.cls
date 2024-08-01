public with sharing class ContactCenterServiceIntegrationConfig
{
    public static ContactCenterServiceIntegration getService(String environmentName)
    {
        return environmentName.contains('.dev') || Test.isRunningTest()
            ? (ContactCenterServiceIntegration) new MockContactCenterServiceIntegration()
            : (ContactCenterServiceIntegration) new RealContactCenterServiceIntegration();
    }
}