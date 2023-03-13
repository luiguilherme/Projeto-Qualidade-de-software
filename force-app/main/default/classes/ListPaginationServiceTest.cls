@isTest
public class ListPaginationServiceTest {
    @isTest
    static void getPaginatedListIf(){
        String jsonInput = '[{"nome":"Teste 01","numero":"0001"},{"nome":"Teste 02","numero":"0002"},{"nome":"Teste 03","numero":"0003"},{"nome":"Teste 04","numero":"0004"},{"nome":"Teste 05","numero":"0005"},{"nome":"Teste 06","numero":"0006"},{"nome":"Teste 07","numero":"0007"},{"nome":"Teste 08","numero":"0008"}]';
        Integer pageSize = 5;
        Integer page = 1;

        Test.startTest();
        ListPaginationService.getPaginatedList(jsonInput, pageSize, page);
        Test.stopTest();
        System.assertEquals(5, pageSize);
    }
    @isTest
    static void getPaginatedListElse(){
        String jsonInput = '[{"nome":"Teste 01","numero":"0001"},{"nome":"Teste 02","numero":"0002"},{"nome":"Teste 03","numero":"0003"},{"nome":"Teste 04","numero":"0004"},{"nome":"Teste 05","numero":"0005"},{"nome":"Teste 06","numero":"0006"},{"nome":"Teste 07","numero":"0007"},{"nome":"Teste 08","numero":"0008"}]';
        Integer pageSize = 20;
        Integer page = 1;

        Test.startTest();
        String result = ListPaginationService.getPaginatedList(jsonInput, pageSize, page);
        Test.stopTest();
        System.debug('RESULT' +JSON.serializePretty(JSON.deserializeUntyped(result)));
        List<Object> ListResults = (List<Object>) JSON.deserializeUntyped(result);
        System.assertEquals(8 ,ListResults.size());
    }
}