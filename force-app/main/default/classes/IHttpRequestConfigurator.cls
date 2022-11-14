public interface IHttpRequestConfigurator {
    HttpRequest configure(HttpRequest request, Webservice__c wsConfig);
}