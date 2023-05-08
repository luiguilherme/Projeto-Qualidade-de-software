@isTest
private class OrderIssuedTriggerTest {
    private static final String CHECKED_VALID_STATUS = 'Pedido Recebido';
    private static final String END_ORDER_ACTION_STATUS = 'Pedido Concluído';
    
    @TestSetup
    static void setup(){
        List<OrderIssued__c> lOrders = new List<OrderIssued__c>();
        lOrders.add(DataFactory.createOrderIssued(''));
        lOrders.add(DataFactory.createOrderIssued('ERROR'));
        lOrders.add(DataFactory.createOrderIssued('SUCCESS'));
        lOrders.add(DataFactory.createOrderIssued('ERROR', 'CHECKED_VALID'));
                
        OrderIssued__c createOrderIssuedError = new OrderIssued__c();
          createOrderIssuedError.Status__c = 'CHECKED_VALID';
            createOrderIssuedError.StatusCode__c = 'ERROR';
            createOrderIssuedError.OrderStatus__c = 'CHECKED_VALID';
            createOrderIssuedError.HybrisOrder__c = 'OrderIssError';
        lOrders.add(createOrderIssuedError);        

        OrderIssued__c createOrderIssuedUpdateStatusCodeErrorToSuccess = new OrderIssued__c();
          createOrderIssuedUpdateStatusCodeErrorToSuccess.Status__c = 'CHECKED_VALID';
            createOrderIssuedUpdateStatusCodeErrorToSuccess.StatusCode__c = 'SUCCESS';
            createOrderIssuedUpdateStatusCodeErrorToSuccess.OrderStatus__c = 'CHECKED_VALID';
            createOrderIssuedUpdateStatusCodeErrorToSuccess.HybrisOrder__c = 'updStatErrToSuc';
        lOrders.add(createOrderIssuedUpdateStatusCodeErrorToSuccess);        
        
        OrderIssued__c createOrderIssuedUpdateStatusCodeSuccessToError = new OrderIssued__c();
          createOrderIssuedUpdateStatusCodeSuccessToError.Status__c = 'CHECKED_VALID';
            createOrderIssuedUpdateStatusCodeSuccessToError.StatusCode__c = 'ERROR';
            createOrderIssuedUpdateStatusCodeSuccessToError.OrderStatus__c = 'CHECKED_VALID';
            createOrderIssuedUpdateStatusCodeSuccessToError.HybrisOrder__c = 'updStatSucToErr';
            lOrders.add(createOrderIssuedUpdateStatusCodeSuccessToError);        
        
         OrderIssued__c createOrderIssuedUpdateStatusCodeSuccessToErrore = new OrderIssued__c();
          createOrderIssuedUpdateStatusCodeSuccessToErrore.Status__c = 'CHECKED_VALID';
            createOrderIssuedUpdateStatusCodeSuccessToErrore.StatusCode__c = 'ERROR';
            createOrderIssuedUpdateStatusCodeSuccessToErrore.OrderStatus__c = 'CHECKED_VALID';
            createOrderIssuedUpdateStatusCodeSuccessToErrore.HybrisOrder__c = 'updStatSucToEr';
            lOrders.add(createOrderIssuedUpdateStatusCodeSuccessToErrore);        

        OrderIssued__c createOrderIssuedUpdateStatusSameStatusCode = new OrderIssued__c();
            createOrderIssuedUpdateStatusSameStatusCode.Status__c = 'CHECKED_VALID';
            createOrderIssuedUpdateStatusSameStatusCode.StatusCode__c = 'ERROR';
            createOrderIssuedUpdateStatusSameStatusCode.OrderStatus__c = 'CHECKED_VALID';
            createOrderIssuedUpdateStatusSameStatusCode.HybrisOrder__c = 'updSameStatCode';
        lOrders.add(createOrderIssuedUpdateStatusSameStatusCode);        

        OrderIssued__c createOrderIssuedUpdateNoChanges = new OrderIssued__c();
            createOrderIssuedUpdateNoChanges.Status__c = 'CHECKED_VALID';
            createOrderIssuedUpdateNoChanges.StatusCode__c = 'ERROR';
            createOrderIssuedUpdateNoChanges.OrderStatus__c = 'CHECKED_VALID';
            createOrderIssuedUpdateNoChanges.HybrisOrder__c = 'updNoChanges';
        lOrders.add(createOrderIssuedUpdateNoChanges);        
                
        OrderIssued__c createOrderIssuedUpdateStatusDifferentStatusCode = new OrderIssued__c();
            createOrderIssuedUpdateStatusDifferentStatusCode.Status__c = 'CHECKED_VALID';
            createOrderIssuedUpdateStatusDifferentStatusCode.StatusCode__c = 'ERROR';
            createOrderIssuedUpdateStatusDifferentStatusCode.OrderStatus__c = 'CHECKED_VALID';
            createOrderIssuedUpdateStatusDifferentStatusCode.HybrisOrder__c = 'updDiffStCode';
        lOrders.add(createOrderIssuedUpdateStatusDifferentStatusCode);        
                
        insert lOrders;
    }

  @isTest
    public static void createOrderIssued(){

        OrderIssued__c nOrderIssued = [SELECT Status__c, StatusCode__c, HybrisOrder__c, OrderStatus__c FROM OrderIssued__c WHERE StatusCode__c = '' LIMIT 1];
        Test.startTest();
            OrderIssued__c Order4Test = [SELECT Id, Status__c, OrderStatus__c, HybrisOrder__c FROM OrderIssued__c WHERE ID = :nOrderIssued.id LIMIT 1];
        Test.stopTest();

        System.assertEquals(nOrderIssued.HybrisOrder__c, Order4Test.HybrisOrder__c, 'This test verifies if the Hybris orders Ids are the same.');
        System.assertEquals(CHECKED_VALID_STATUS, Order4Test.OrderStatus__c, 'In this scenario, OrderStatus__c MUST be equal Status__c.');
    }

    @isTest
    public static void createOrderIssuedError(){
        
        OrderIssued__c nOrderIssued = [SELECT Status__c, StatusCode__c, HybrisOrder__c, OrderStatus__c FROM OrderIssued__c WHERE HybrisOrder__c = 'OrderIssError' LIMIT 1];
        Test.startTest();
            OrderIssued__c Order4Test = [SELECT Id, Status__c, OrderStatus__c, HybrisOrder__c FROM OrderIssued__c WHERE HybrisOrder__c = :nOrderIssued.HybrisOrder__c LIMIT 1];
        Test.stopTest();
        
        System.assertEquals(nOrderIssued.HybrisOrder__c, Order4Test.HybrisOrder__c, 'This test verifies if the Hybris order,s Ids are the same');
        System.assertEquals(CHECKED_VALID_STATUS+' com erro', Order4Test.OrderStatus__C, 'This scenario should update the OrderStatus__C with Status__c +" com erro" ');
    }

    @isTest
    public static void createOrderIssuedUpdateStatusCodeErrorToSuccess(){
        
        OrderIssued__c nOrderIssued = [SELECT Status__c, StatusCode__c, HybrisOrder__c, OrderStatus__c FROM OrderIssued__c WHERE HybrisOrder__c = 'updStatErrToSuc' LIMIT 1];
        Test.startTest();
            nOrderIssued.StatusCode__c = 'SUCCESS';
            update nOrderIssued;
            OrderIssued__c Order4Test = [SELECT Id, Status__c, OrderStatus__c, HybrisOrder__c FROM OrderIssued__c WHERE HybrisOrder__c = :nOrderIssued.HybrisOrder__c LIMIT 1];
        Test.stopTest();
        
        System.assertEquals(nOrderIssued.HybrisOrder__c, Order4Test.HybrisOrder__c, 'This test verifies if the Hybris order,s Ids are the same');
        System.assertEquals(CHECKED_VALID_STATUS, Order4Test.OrderStatus__C, 'This scenario should update the OrderStatus__C with Status__c +" com erro" ');
    }

    @isTest
    public static void createOrderIssuedUpdateStatusCodeSuccessToError(){
        
        OrderIssued__c nOrderIssued = [SELECT Status__c, StatusCode__c, HybrisOrder__c, OrderStatus__c FROM OrderIssued__c WHERE HybrisOrder__c = 'updStatSucToErr' LIMIT 1];
        Test.startTest();
            nOrderIssued.StatusCode__c = 'ERROR';
            update nOrderIssued;
            OrderIssued__c Order4Test = [SELECT Id, Status__c, OrderStatus__c, HybrisOrder__c FROM OrderIssued__c WHERE HybrisOrder__c = :nOrderIssued.HybrisOrder__c LIMIT 1];
        Test.stopTest();
        
        System.assertEquals(nOrderIssued.HybrisOrder__c, Order4Test.HybrisOrder__c, 'This test verifies if the Hybris order,s Ids are the same');
        System.assertEquals(CHECKED_VALID_STATUS + ' com erro', Order4Test.OrderStatus__C, 'This scenario should update the OrderStatus__C with Status__c +" com erro" ');
    }

    @isTest
    public static void createOrderIssuedUpdateStatusSameStatusCode(){
         
        OrderIssued__c nOrderIssued = [SELECT Status__c, StatusCode__c, HybrisOrder__c, OrderStatus__c FROM OrderIssued__c WHERE HybrisOrder__c = 'updSameStatCode' LIMIT 1];
        Test.startTest();
            nOrderIssued.Status__c = 'END_ORDER_ACTION';
            nOrderIssued.StatusCode__c = 'ERROR';
            update nOrderIssued;
            OrderIssued__c Order4Test = [SELECT Id, Status__c, OrderStatus__c, HybrisOrder__c FROM OrderIssued__c WHERE HybrisOrder__c = :nOrderIssued.HybrisOrder__c LIMIT 1];
        Test.stopTest();
        
        System.assertEquals(nOrderIssued.HybrisOrder__c, Order4Test.HybrisOrder__c, 'This test verifies if the Hybris order,s Ids are the same');
        System.assertEquals(END_ORDER_ACTION_STATUS + ' com erro', Order4Test.OrderStatus__C, 'This scenario should update the OrderStatus__C with Status__c +" com erro" ');
    }

    @isTest
    public static void createOrderIssuedUpdateStatusDifferentStatusCode(){
        
        OrderIssued__c nOrderIssued = [SELECT Status__c, StatusCode__c, HybrisOrder__c, OrderStatus__c FROM OrderIssued__c WHERE HybrisOrder__c = 'updDiffStCode' LIMIT 1];
        Test.startTest();
            nOrderIssued.Status__c = 'END_ORDER_ACTION';
            nOrderIssued.StatusCode__c = 'SUCCESS';
            update nOrderIssued;
            OrderIssued__c Order4Test = [SELECT Id, Status__c, OrderStatus__c, HybrisOrder__c FROM OrderIssued__c WHERE HybrisOrder__c = :nOrderIssued.HybrisOrder__c LIMIT 1];
        Test.stopTest();
        
        System.assertEquals(nOrderIssued.HybrisOrder__c, Order4Test.HybrisOrder__c, 'This test verifies if the Hybris order,s Ids are the same');
        System.assertEquals(END_ORDER_ACTION_STATUS, Order4Test.OrderStatus__C, 'This scenario should update the OrderStatus__C with Status__c +" com erro" ');
    }

    @isTest
    public static void createOrderIssuedUpdateNoChanges(){
        
        OrderIssued__c nOrderIssued = [SELECT Status__c, StatusCode__c, HybrisOrder__c, OrderStatus__c FROM OrderIssued__c WHERE HybrisOrder__c = 'updNoChanges' LIMIT 1];
        Test.startTest();
            nOrderIssued.Status__c = 'CHECKED_VALID';
            nOrderIssued.StatusCode__c = 'ERROR';
            update nOrderIssued;
            OrderIssued__c Order4Test = [SELECT Id, Status__c, OrderStatus__c, HybrisOrder__c FROM OrderIssued__c WHERE HybrisOrder__c = :nOrderIssued.HybrisOrder__c LIMIT 1];
        Test.stopTest();
        
        System.assertEquals(nOrderIssued.HybrisOrder__c, Order4Test.HybrisOrder__c, 'This test verifies if the Hybris order,s Ids are the same');
        System.assertEquals(CHECKED_VALID_STATUS + ' com erro', Order4Test.OrderStatus__C, 'This scenario should update the OrderStatus__C with Status__c +" com erro" ');
    }
}