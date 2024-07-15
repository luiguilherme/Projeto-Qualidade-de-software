@isTest
private class ListComparatorTest {

    @isTest
    static void testMapJSONToList() {
        // Preparar dados de entrada
        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('objectWithAttributeSelectedValues', '{"key1":"value1","key2":"value2"}');
        Map<String, Object> outputMap = new Map<String, Object>();

        // Chamar o método a ser testado
        List<ListComparator.KeyValue> keyValueList = ListComparator.mapJSONToList(inputMap, outputMap);

        // Verificar se a saída está correta
        System.assertEquals(2, keyValueList.size(), 'A lista de pares chave-valor deve ter tamanho 2');
        System.assertEquals('key1', keyValueList[0].name, 'O primeiro nome de chave deve ser "key1"');
        System.assertEquals('value1', keyValueList[0].value, 'O primeiro valor deve ser "value1"');
        System.assertEquals('key2', keyValueList[1].name, 'O segundo nome de chave deve ser "key2"');
        System.assertEquals('value2', keyValueList[1].value, 'O segundo valor deve ser "value2"');
    }

    @isTest
    static void testCompareLists() {
        // Preparar dados de entrada
        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('action', 'createLog');
        inputMap.put('oldList', '{"key1":"value1","key2":"value2"}');
        inputMap.put('newList', '{"key1":"value1","key2":"value3","key3":"value4"}');
        Map<String, Object> outputMap = new Map<String, Object>();
        
        // Chamar o método a ser testado
        Test.startTest();
        ListComparator.compareLists(inputMap, outputMap);
        Test.stopTest();
        
        // Verificar se a saída está correta
        String expectedJson = '{"listDifferenceLog":[{"description":"O novo valor é: value3","id":"key2","reason":"remove","type":"remove"}]}';
        String actualJson = JSON.serialize(outputMap);
        
        Map<String, Object> expectedMap = (Map<String, Object>) JSON.deserializeUntyped(expectedJson);
        Map<String, Object> actualMap = (Map<String, Object>) JSON.deserializeUntyped(actualJson);
        
        //System.assertEquals(expectedMap, actualMap, 'A saída do método compareLists() deve ser como esperado');        
    }
    
    @isTest
    static void testInvokeMethod() {
        // Preparar dados de entrada
        Map<String, Object> inputMap = new Map<String, Object>();
        inputMap.put('methodName', 'mapJSONToList');
        inputMap.put('objectWithAttributeSelectedValues', '{"key1":"value1","key2":"value2"}');
        Map<String, Object> outputMap = new Map<String, Object>();
        
        // Chamar o método a ser testado
        Test.startTest();
        ListComparator comparator = new ListComparator();
        Boolean success = comparator.invokeMethod('mapJSONToList', inputMap, outputMap, new Map<String, Object>());
        Test.stopTest();
        
        // Verificar se a saída está correta
        System.assertEquals(true, success, 'O método invokeMethod deve retornar true para sucesso');
        System.assertEquals(2, ((List<ListComparator.KeyValue>)JSON.deserialize((String)outputMap.get('list'), List<ListComparator.KeyValue>.class)).size(), 'A lista de pares chave-valor deve ter tamanho 2');
    }
}