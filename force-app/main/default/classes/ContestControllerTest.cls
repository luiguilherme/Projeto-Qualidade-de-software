@isTest
public class ContestControllerTest {

    @testSetup
    static void setupTestData() {
        // Criar dados de teste aqui, se necessário
    }

    @isTest
    static void testInvokeMethod_getContestPicklists() {
        Map<String, Object> inputs = new Map<String, Object>();
        inputs.put('ProductWithdrawal', true);
        inputs.put('ImproperActivation', true);
        inputs.put('CustomerRequest', true);
        inputs.put('InternalProcedure', true);

        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        ContestController controller = new ContestController();

        Boolean result = controller.invokeMethod('getContestPicklists', inputs, output, options);

        System.assertEquals(true, result);

        System.assert(output.containsKey('result'));
        Map<String, Object> picklistResult = (Map<String, Object>)output.get('result');
        System.assert(picklistResult.containsKey('AutoPicklistValues'));
        System.assert(picklistResult.containsKey('ManualPicklistValues'));
    }

    @isTest
    static void testInvokeMethod_setContestPicklists() {

        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> boxesList = new Map<String, Object>();
        List<Object> picklistList = new List<Object>();

        Map<String, Object> item1 = new Map<String, Object>();
        item1.put('itemRule', 'Auto');
        item1.put('type', 'scoreCredit');
        item1.put('usedAmountDCA', 100.0);
        item1.put('usedAmountCAT', 50.0);

        picklistList.add(item1);
        boxesList.put('PicklistList', picklistList);
        inputs.put('BoxesList', boxesList);

        Map<String, Object> picklistOptions = new Map<String, Object>();
        picklistOptions.put('AutoPicklistValues', new List<Map<String, String>>());
        inputs.put('ContestPicklistOptions', picklistOptions);

        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        ContestController controller = new ContestController();

        Boolean result = controller.invokeMethod('setContestPicklists', inputs, output, options);

        System.assertEquals(true, result);

        List<Object> picklistResult = (List<Object>)output.get('result');
        System.assertEquals(1, picklistResult.size());
        Map<String, Object> updatedItem1 = (Map<String, Object>)picklistResult[0];
        System.assertEquals('150.0', updatedItem1.get('valorTotal'));
    }

    @isTest
    static void testInvokeMethod_getImpugnationReasonPicklist() {

        Map<String, Object> inputs = new Map<String, Object>();
        inputs.put('Concession', true);
        inputs.put('Rectification', true);
        inputs.put('CustomerRequest', true);
        inputs.put('InternalProcedure', true);

        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        ContestController controller = new ContestController();

        Boolean result = controller.invokeMethod('getImpugnationReasonPicklist', inputs, output, options);

        System.assertEquals(true, result);

        System.assert(output.containsKey('result'));
        Map<String, Object> impugnationResult = (Map<String, Object>)output.get('result');
        System.assert(impugnationResult.containsKey('ImpunationPicklistValues'));
        System.assert(impugnationResult.containsKey('NonProceedPicklistValues'));
    }
}