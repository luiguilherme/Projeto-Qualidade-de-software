/*
 * Autor: Leandro Alexandrino - Deloitte
 * Criado em: 10/03/2022
*/
@isTest
public class OrderItemControllerTest {

    @TestSetup
    static void setup(){ 
        //Account
        Account account = new Account();
        account.name = 'testAccount';
        insert account;

        //Order
        Order order = new Order();
        order.AccountId = account.Id;
        order.EffectiveDate = Date.today();
        order.Status = 'Draft';
        order.Pricebook2Id = test.getStandardPricebookId();
        insert order;

		//Product2
        Product2 product = new Product2();
        product.Name = 'Produto 1';
        product.ProductCode = '0001';
        insert product;
        
        //PricebookEntry
        PricebookEntry pbe = new PricebookEntry();
        pbe.UnitPrice = 10;
        pbe.Product2Id = product.Id;
        pbe.Pricebook2Id = test.getStandardPricebookId();
        insert pbe;
        
        //OrderItem
        OrderItem orderItem = new OrderItem();
        orderItem.Quantity = 1;
        orderItem.OrderId = order.Id;
        orderItem.PricebookEntryId = pbe.Id;
        orderItem.Product2Id = product.Id;
        orderItem.UnitPrice = 10;
        insert orderItem;
    }
    
    @isTest
    static void setFieldsForAllItemsInOrder() {
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();
        
        Map<String,Object> fields = new Map<String, Object>();
        fields.put('Description','TESTE');

        Order o = [SELECT Id FROM Order LIMIT 1];
        inputs.put('OrderId',o.Id);
        inputs.put('fields',fields);
        
        OrderItemController c = new OrderItemController();
        c.invokeMethod('setFieldsForAllItemsInOrder', inputs, output, options);
        System.debug(output);
    }
}