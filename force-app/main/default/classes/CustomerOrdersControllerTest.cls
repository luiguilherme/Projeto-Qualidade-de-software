@isTest
public class CustomerOrdersControllerTest {
    @isTest
    public static void getOrdersTest(){
        
        Map<String,Object> inputMap = new Map<String,Object> ();
        
        Map<String,Object> outputMap = new Map<String,Object> ();
        Map<String,Object> options = new Map<String,Object> ();
        
        Account acc = new Account();
        acc.Name = 'acc Test';
        insert(acc);
        Id accountId = acc.Id;
        
        String lineNumber = '(11) 99877-1542';
        String orderNumber = '00004211';
        String protocolNumber = '';
        Decimal page  = 0;
        Integer numRecords = 5;
        String initialDate = '2022-01-17 00:00:00';
        String endDate = '2022-05-17 00:00:00';
        
        inputMap.put('AccountId', accountId);
        inputMap.put('LineNumber', lineNumber);
        inputMap.put('OrderNumber', orderNumber);
        inputMap.put('Page', page);
        inputMap.put('NumRecords', numRecords);
        inputMap.put('InitialDate', initialDate);
        inputMap.put('EndDate', endDate);
        
        CustomerOrdersController c = new CustomerOrdersController();
        c.invokeMethod('getOrders', inputMap, outputMap, options);
        System.debug(' getOrdersWithOrderNumberAndLineNumberTest outputMap: ' + outputMap);    
    }
}