@isTest
public class CustomerInteractionControllerTest {
    @isTest
    static void getHierarchyProtocolsError(){
        CustomerInteractionController controller = new CustomerInteractionController();

        Map<String,Object> inputMap = new Map<String,Object>();
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();

        Test.startTest();
        controller.invokeMethod('getHierarchyProtocols',inputMap, outputMap, options);
        Test.stopTest();
        System.assertEquals(false, outputMap.get('success'));

    }
    @isTest
    static void getHierarchyProtocols(){
        CustomerInteractionController controller = new CustomerInteractionController();
        String jsonTest = '{"protocolItems":[{"relatedProtocol":{"protocolNumber":0},"sourceSystem":{"systemName":"Call Center"},"itemProtocol":{"closingDate":"2022-11-21","openingDate":"2022-11-21","subStatus":"FECHADO IMEDIATO","status":"FECHADO","description":"VIVO/Canais Eletrônicos/Meus Créditos/Histórico de e-mails enviados"},"network":{"digitNetwork":5,"networkNumber":0,"geographicAreaCode":0},"protocol":{"protocolStatus":"Conclu¡do","protocolType":null,"closingDate":"2022-10-31","openingDate":"2022-10-31","smsClassification":"Informacao","submissionStatus":null,"protocolNumber":20223819417084},"idProtocolItem":20131000004999064},{"relatedProtocol":{"protocolNumber":0},"sourceSystem":{"systemName":"Call Center"},"itemProtocol":{"closingDate":"2022-11-17","openingDate":"2022-11-17","subStatus":"FECHADO IMEDIATO","status":"FECHADO","description":"VIVO/Canais Eletrônicos/Meus Créditos/Histórico de e-mails enviados"},"network":{"digitNetwork":5,"networkNumber":0,"geographicAreaCode":0},"protocol":{"protocolStatus":"Conclu¡do","protocolType":null,"closingDate":"2022-10-31","openingDate":"2022-10-31","smsClassification":"Informacao","submissionStatus":null,"protocolNumber":20223819417084},"idProtocolItem":20131000004998390},{"relatedProtocol":{"protocolNumber":0},"sourceSystem":{"systemName":"Call Center"},"itemProtocol":{"closingDate":"2022-11-04","openingDate":"2022-11-04","subStatus":"FECHADO IMEDIATO","status":"FECHADO","description":"VENDAS/SERVIÇOS LOJA/NOVO CADASTRO"},"network":{"digitNetwork":5,"networkNumber":0,"geographicAreaCode":0},"protocol":{"protocolStatus":"Conclu¡do","protocolType":null,"closingDate":"2022-10-31","openingDate":"2022-10-31","smsClassification":"Informacao","submissionStatus":null,"protocolNumber":20223819417084},"idProtocolItem":20131000004996996},{"relatedProtocol":{"protocolNumber":0},"sourceSystem":{"systemName":"Call Center"},"itemProtocol":{"closingDate":"2022-11-03","openingDate":"2022-11-03","subStatus":"FECHADO IMEDIATO","status":"FECHADO","description":"VENDAS/SERVIÇOS LOJA/NOVO CADASTRO"},"network":{"digitNetwork":5,"networkNumber":0,"geographicAreaCode":0},"protocol":{"protocolStatus":"Conclu¡do","protocolType":null,"closingDate":"2022-10-31","openingDate":"2022-10-31","smsClassification":"Informacao","submissionStatus":null,"protocolNumber":20223819417084},"idProtocolItem":20131000004996890},{"relatedProtocol":{"protocolNumber":0},"sourceSystem":{"systemName":"Call Center"},"itemProtocol":{"closingDate":"2022-11-03","openingDate":"2022-11-03","subStatus":"FECHADO IMEDIATO","status":"FECHADO","description":"VIVO/Canais Eletrônicos/Meus Créditos/Histórico de e-mails enviados"},"network":{"digitNetwork":5,"networkNumber":0,"geographicAreaCode":0},"protocol":{"protocolStatus":"Conclu¡do","protocolType":null,"closingDate":"2022-10-31","openingDate":"2022-10-31","smsClassification":"Informacao","submissionStatus":null,"protocolNumber":20223819417084},"idProtocolItem":20131000004996864}]}';
        
        Map<String, Object> inputMap = (Map<String, Object>) JSON.deserializeUntyped(jsonTest);
        Map<String,Object> outputMap  = new Map<String,Object>();
        Map<String,Object> options  = new Map<String,Object>();

        Test.startTest();
        controller.invokeMethod('getHierarchyProtocols',inputMap, outputMap, options);
        Test.stopTest();
        System.assertEquals(true, outputMap.get('success'));
    }
}