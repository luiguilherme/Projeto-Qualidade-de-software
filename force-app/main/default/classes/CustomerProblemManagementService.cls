public with sharing class CustomerProblemManagementService {
	public static List<CaseAmdocs> findByCustomerId(String customerId, DateTime startDate, DateTime endDate) {
		return CustomerProblemManagementFacade.findByCustomerId(customerId, startDate, endDate);
    }
}