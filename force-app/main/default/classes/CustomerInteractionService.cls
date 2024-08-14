public class CustomerInteractionService {

	public static CustomerInteractionResponse findCustomerInteractions(String idCustomer, Date startOpeningDate, Date endOpeningDate) {

		return CustomerInteractionFacade.findCustomerInteractions(idCustomer, startOpeningDate, endOpeningDate);
		
    }

}