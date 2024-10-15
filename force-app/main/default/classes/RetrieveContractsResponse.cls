public class RetrieveContractsResponse {

	@InvocableVariable
	public String protocol;

	@InvocableVariable
	public String order;

	@InvocableVariable
	public String smpContract;

	@InvocableVariable
	public String landlineContract;

	@InvocableVariable
	public String mobileContract;

	
	public static RetrieveContractsResponse parse(String json) {
		return (RetrieveContractsResponse) System.JSON.deserialize(json, RetrieveContractsResponse.class);
	}
}