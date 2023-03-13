@isTest
public class TopicsAutoControllerTest {
    @isTest
    public static void testGetPicklistOptions(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        inputs.put('objectName', 'TopicsAuto__c');
        inputs.put('fieldName', 'Process__c');
        
        TopicsAutoController controller = new TopicsAutoController();
        controller.invokeMethod('getPicklistOptions', inputs, output, options);

        List<Object> processOptions = (List<Object>) output.get('options');
        System.assert(processOptions.size() > 0);
    }

    @isTest
    public static void testGetChannelList(){
        Map<String, Object> inputs = new Map<String, Object>();
        Map<String, Object> output = new Map<String, Object>();
        Map<String, Object> options = new Map<String, Object>();

        inputs.put('Channels', 'Lojas Próprias;Revenda');
        
        TopicsAutoController controller = new TopicsAutoController();
        controller.invokeMethod('getChannelList', inputs, output, options);

        List<Object> channelsList = (List<Object>) output.get('ChannelList');
        System.assert(channelsList.size() > 0);
    }    
}