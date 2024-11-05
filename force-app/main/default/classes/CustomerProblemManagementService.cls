public with sharing class CustomerProblemManagementService {
	public static List<CaseAmdocs> findByCustomerId(String customerId, DateTime startDate, DateTime endDate) {

		if (String.isBlank(customerId)) {
			throw new IllegalArgumentException('O campo customerId não pode ser vazio.');
		}

		if (startDate == null) {
			throw new IllegalArgumentException('O campo de Data Inicial do Ciclo não pode ser vazio.');
		}

		if (endDate == null) {
			throw new IllegalArgumentException('O campo de Data Final do Ciclo não pode ser vazio.');
		}

		return CustomerProblemManagementFacade.findByCustomerId(customerId, startDate, endDate);
    }
}
