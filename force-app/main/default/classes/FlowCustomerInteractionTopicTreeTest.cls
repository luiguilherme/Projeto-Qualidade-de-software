@IsTest
public class FlowCustomerInteractionTopicTreeTest {
    @IsTest
    static void testInvoke(){
        
        Test.startTest();
        List<String> listInput = new List<String>{'TV', 'BANDA LARGA', 'LINHA TELEFÔNICA'};
        List<Object> objectList = new List<Object>((List<Object>)listInput);
        Map<String, Object> inputs = new Map<String, Object>();
        inputs.put('arguments', objectList);
        FlowCustomerInteractionTopicTree flowCustomerInteractionTopicTree = new FlowCustomerInteractionTopicTree();
        Boolean returnBoolean = flowCustomerInteractionTopicTree.invokeMethod('convertTitleCase', inputs, new Map<String, Object>(), new Map<String, Object>());
        System.assert(returnBoolean, 'Não retornou true no invokeMethod');
        Test.stopTest();
        
    }
}