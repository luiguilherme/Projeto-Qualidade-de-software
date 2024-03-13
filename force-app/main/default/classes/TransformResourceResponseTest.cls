@isTest
private class TransformResourceResponseTest
{
    @isTest
    static void invokeMethodTest()
    {
        String jsonString = '{"response":[{"name":"DATE","value":"2022-11-10T12:52:51"},{"name":"MODEL","value":"IPHONE XR (A2105)"},{"name":"VENDOR","value":"APPLE"},{"name":"ORIGIN","value":"DT"},{"name":"MSISDN","value":"5511975514545"},{"name":"IMEI","value":"45464646531321564564132132"}]}';
        TransformResourceResponse TRR = new TransformResourceResponse();

        Test.startTest();
        Boolean result = TRR.invokeMethod('format', (Map<String, Object>)JSON.deserializeUntyped(jsonString), new Map<String, Object>(), new Map<String, Object>());
        System.assert(result);
        Test.stopTest();
    } 

    @isTest
    static void invokeMethodEmptyTest()
    {
        String jsonString = '{"response":""}';
        TransformResourceResponse TRR = new TransformResourceResponse();

        Test.startTest();
        Boolean result = TRR.invokeMethod('format', (Map<String, Object>)JSON.deserializeUntyped(jsonString), new Map<String, Object>(), new Map<String, Object>());
        System.assert(result);
        Test.stopTest();
    } 
}