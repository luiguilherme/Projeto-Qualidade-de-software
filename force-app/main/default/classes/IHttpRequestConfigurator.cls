/*
* @author Diego Costa @ Deloitte
* @date 06/06/2022
* @description interface da classe IHttpRequestConfigurator 
*/
public interface IHttpRequestConfigurator {
    HttpRequest configure(HttpRequest request, Webservice__c wsConfig);
}