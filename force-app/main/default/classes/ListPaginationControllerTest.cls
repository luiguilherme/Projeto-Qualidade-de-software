@isTest
public class ListPaginationControllerTest {
    @isTest
    static void getPaginatedListTestError(){
        ListPaginationController controller = new ListPaginationController();

        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();

        Test.startTest();
        controller.invokeMethod('getPaginatedList',inputMap, outputMap, options);
        Test.stopTest();
        System.assertEquals(false, outputMap.get('success'));
    }
    
    /*@isTest
    static void getPaginatedListTest(){
        ListPaginationController controller = new ListPaginationController();
		String jsonTest = '{"CurrentPage":1,"PageSize":5,"OriginalList":[{"nome":"Teste 01","numero":"0001","item":"123"},{"nome":"Teste 02","numero":"0002","item":"123"},{"nome":"Teste 03","numero":"0003"},{"nome":"Teste 04","numero":"0004"},{"nome":"Teste 05","numero":"0005"},{"nome":"Teste 06","numero":"0006"},{"nome":"Teste 07","numero":"0007"},{"nome":"Teste 08","numero":"0008"}]}';      
            
        Map<String,Object> inputMap = (Map<String, Object>) JSON.deserializeUntyped(jsonTest);
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();

        Test.startTest();
        controller.invokeMethod('getPaginatedList',inputMap, outputMap, options);
        Test.stopTest();
        System.assertEquals(true, outputMap.get('success'));
    }*/
}