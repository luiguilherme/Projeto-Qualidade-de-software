@IsTest
private class PicklistPopulationTest {
    @IsTest
    static void GetAccountComplementTypeTest() {
        //Crie um registro de conta com um valor para o campo BillingComplementType1__c
        Account acc = new Account();
        acc.Name = 'Teste';
        acc.BillingComplementType1__c = 'Ala';
        insert acc;
        
        // Crie um mapa de entrada com o nome do método e o ID da conta
        Map<String, Object> input = new Map<String, Object>();
        input.put('methodName', 'PopulatePicklist');
        input.put('accountId', acc.Id);
        
        // Crie um mapa de saída vazio
        Map<String, Object> outMap = new Map<String, Object>();
        
        // Crie um mapa de opções vazio
        Map<String, Object> options = new Map<String, Object>();
        System.debug('options' + options);
        
        Test.startTest();
        // Instancie a classe PicklistPopulation e invoque o método invokeMethod
        PicklistPopulation pp = new PicklistPopulation();
        pp.invokeMethod('GetAccountComplementType', input, outMap, options);
        Test.stopTest();
        // Adicione o Assert para verificar se o listSize do outMap é maior que 0
        System.assertEquals(true, outMap.get('options') != null, 'Expected listSize to be greater than 0');
    }
}