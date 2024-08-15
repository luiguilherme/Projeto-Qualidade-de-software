public with sharing class PaymentInstructionsController {
    public class PaymentInstructionsFilter{
        @InvocableVariable
        public String billingAccountId;
    }

    
    public class PaymentInstructionsResponse{
        @InvocableVariable
        public String paymentMethod;
    }

    @InvocableMethod(label='Payment Instructions Controller' description='Classe utilizada para buscar meio de pagamento do cliente no Vivo Next')
    public static List<PaymentInstructionsResponse> findPaymentMethodByBillingAccountId(List<PaymentInstructionsFilter> filters){
        String paymentMethod = CustomerBillInvoceManagementService.findPaymentInstructionsByBillingAccountId(filters[0].billingAccountId);
        PaymentInstructionsResponse paymentResponse = new PaymentInstructionsResponse();
        List<PaymentInstructionsResponse> listPaymentResponse = new List<PaymentInstructionsResponse>();

        paymentResponse.paymentMethod = paymentMethod;
        listPaymentResponse.add(paymentResponse);

        return listPaymentResponse;
    }
}