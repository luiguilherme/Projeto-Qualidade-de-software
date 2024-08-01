public with sharing class RealCustomerCommServiceIntegration implements CustomerCommunicationServiceIntegration {
	public static final String WEB_SERVICE = 'CommunicationSendEmail';
	
	public static HttpResponse sendEmailMessage(String payload) {
		HttpClient request = new HttpClient();
        HttpResponse response = request.post(WEB_SERVICE, payload);
		return response;
	}
}