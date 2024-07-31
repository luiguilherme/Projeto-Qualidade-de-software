public with sharing class CustomerCommServiceIntegrationConfig {
    public static CustomerCommunicationServiceIntegration getService(String evironmentName) {
        return evironmentName.contains('.dev') || Test.isRunningTest()
            ? (CustomerCommunicationServiceIntegration) new MockCustomerCommServiceIntegration()
            : (CustomerCommunicationServiceIntegration) new RealCustomerCommServiceIntegration();
    }
}