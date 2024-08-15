public with sharing class SearchCustomerKeysService {
	public static AccountManagementResponse findByServiceId(String serviceId) {
		return SearchCustomerKeysFacade.findByServiceId(serviceId);
    }
}