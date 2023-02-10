/**  
 * @description classe de serviço da classe InvoiceHistory
 */
public with sharing class InvoiceHistoryService {

    public static List<InvoiceServiceReturn> getListInvoiceHistory(String userId){
        ServiceResponse serviceResponseObj = InvoiceHistoryEngine.callIntegration(userId); 
        return InvoiceHistoryEngine.deserializeInvoiceServiceReturn(serviceResponseObj);
    }

    public class InvoiceHistoryException extends Exception{}
}