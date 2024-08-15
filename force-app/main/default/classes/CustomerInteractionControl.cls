public class CustomerInteractionControl {

	public class CustomerInteractionFilter{
		@InvocableVariable
		public String idCustomer;
		@InvocableVariable
		public Date startOpeningDate;
		@InvocableVariable
		public Date endOpeningDate; 
	}
      
	@Auraenabled
    public static List<CustomerInteractionResponse.ProtocolItems> findCustomerInteractions(String idCustomer, Date startOpeningDate, Date endOpeningDate) {
        CustomerInteractionResponse customerInteractionResponse = CustomerInteractionService.findCustomerInteractions(idCustomer, startOpeningDate, endOpeningDate);
        if(customerInteractionResponse 	!= null 
										&& customerInteractionResponse.protocolItems != null 
										&& !customerInteractionResponse.protocolItems.isEmpty()) {
			
			return customerInteractionResponse.protocolItems;
		}
       
		return new List<CustomerInteractionResponse.ProtocolItems>();
    }

}