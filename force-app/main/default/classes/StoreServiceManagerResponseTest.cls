@isTest
public with sharing class StoreServiceManagerResponseTest {
    @IsTest
    public static void parseStoreServiceManagerResponseTest() {
        // RootEntity
        String jsonRootEntity = '{"id":"012345","description":"Test RootEntity","name":"RootEntity","type":"Root"}';

        StoreServiceManagerResponse.RootEntity responseRootEntity = (StoreServiceManagerResponse.RootEntity) 
            JSON.deserialize(jsonRootEntity, StoreServiceManagerResponse.RootEntity.class);

        System.assertEquals('012345', responseRootEntity.id); 
        System.assertEquals('Test RootEntity', responseRootEntity.description); 
        System.assertEquals('RootEntity', responseRootEntity.name); 
        System.assertEquals('Root', responseRootEntity.type); 

        // SalesAgent
        String jsonSalesAgent = (
                '{"id":"123","status":"Active","pauseReason":{"id":"012345","description":"Test Pause Reason",' + 
                '"name":"RootEntity","type":"Root"}}'
            );

        StoreServiceManagerResponse.SalesAgent responseSalesAgent = (StoreServiceManagerResponse.SalesAgent) 
            JSON.deserialize(jsonSalesAgent, StoreServiceManagerResponse.SalesAgent.class);

        System.assertEquals('123', responseSalesAgent.id); 
        System.assertEquals('Active', responseSalesAgent.status); 
        System.assertEquals('012345', responseSalesAgent.pauseReason.id); 
        System.assertEquals('Test Pause Reason', responseSalesAgent.pauseReason.description); 
        System.assertEquals('RootEntity', responseSalesAgent.pauseReason.name); 
        System.assertEquals('Root', responseSalesAgent.pauseReason.type); 
    
        // Customer
        String jsonCustomer = (
                '{"individualIdentification":{"nationalIdentilyCardNr":"23456","documentType":"Test"},"name":' + 
                '"Teste Customer","segment":{"id":"012345","description":"Test Segment","name":"RootEntity",' + 
                '"type":"Root"},"specialNeeds":true,"priority":0}'
            );

        StoreServiceManagerResponse.Customer responseCustomer = (StoreServiceManagerResponse.Customer) 
            JSON.deserialize(jsonCustomer, StoreServiceManagerResponse.Customer.class);

        System.assertEquals('23456', responseCustomer.individualIdentification.nationalIdentilyCardNr); 
        System.assertEquals('Test', responseCustomer.individualIdentification.documentType); 
        System.assertEquals('Teste Customer', responseCustomer.name); 
        System.assertEquals('012345', responseCustomer.segment.id); 
        System.assertEquals('Test Segment', responseCustomer.segment.description); 
        System.assertEquals('RootEntity', responseCustomer.segment.name); 
        System.assertEquals('Root', responseCustomer.segment.type); 
        System.assertEquals(true, responseCustomer.specialNeeds);
        System.assertEquals(0, responseCustomer.priority);

        // Ticket
        String jsonTicket = (
                '{"id":"1111","customer":{"individualIdentification":{"nationalIdentilyCardNr":"23456",' + 
                '"documentType":"Test"},"name":"Teste Customer 2","segment":{"id":"012345","description":' + 
                '"Test Segment 2","name":"RootEntity","type":"Root"},"specialNeeds":true,"priority":0},' + 
                '"createBy":"date created by","createAt":"date at","duration":{"amount":"test amount"},' + 
                '"geographicArea":{"code":"BR test"},"network":{"networkNumber":"network Number test"},' +
                '"interaction":{"id":"123","name":"interaction 123","businessLine":{"id":"0123454321",' + 
                '"description":"Test RootEntity businessLine","name":"RootEntity","type":"Root"}}}'
            );

        StoreServiceManagerResponse.Ticket responseTicket = (StoreServiceManagerResponse.Ticket) 
            JSON.deserialize(jsonTicket, StoreServiceManagerResponse.Ticket.class);

        System.assertEquals('1111', responseTicket.id); 
        System.assertEquals('23456', responseTicket.customer.individualIdentification.nationalIdentilyCardNr); 
        System.assertEquals('Test', responseTicket.customer.individualIdentification.documentType); 
        System.assertEquals('Teste Customer 2', responseTicket.customer.name); 
        System.assertEquals('012345', responseTicket.customer.segment.id); 
        System.assertEquals('Test Segment 2', responseTicket.customer.segment.description); 
        System.assertEquals('RootEntity', responseTicket.customer.segment.name); 
        System.assertEquals('Root', responseTicket.customer.segment.type);
        System.assertEquals(true, responseTicket.customer.specialNeeds);
        System.assertEquals(0, responseTicket.customer.priority);
        System.assertEquals('date created by', responseTicket.createBy);
        System.assertEquals('date at', responseTicket.createAt);
        System.assertEquals('test amount', responseTicket.duration.amount);
        System.assertEquals('BR test', responseTicket.geographicArea.code);
        System.assertEquals('network Number test', responseTicket.network.networkNumber);
        System.assertEquals('123', responseTicket.interaction.id);
        System.assertEquals('interaction 123', responseTicket.interaction.name);
        System.assertEquals('0123454321', responseTicket.interaction.businessLine.id); 
        System.assertEquals('Test RootEntity businessLine', responseTicket.interaction.businessLine.description); 
        System.assertEquals('RootEntity', responseTicket.interaction.businessLine.name); 
        System.assertEquals('Root', responseTicket.interaction.businessLine.type); 

        // PointOfService
        String jsonPointOfService = (
                '{"id":307,"segment":{"name":"Segmento"},"name":"Shopping Morumbi",' + 
                '"attendant":{"id":22},"workPosition":[{"ID":"01","status":"Empty",' + 
                '"queue":"Fila 1","attendant":{"id": "096"}},{"ID":"02","status":"Empty",' + 
                '"queue":"Fila 2","attendant":{"id": "097"}},{"ID":"03","status":"Empty",' + 
                '"queue":"Fila 3","attendant":{"id": "098"}}]}'
            );

        StoreServiceManagerResponse.PointOfService responsePointOfService = (StoreServiceManagerResponse.PointOfService) 
            JSON.deserialize(jsonPointOfService, StoreServiceManagerResponse.PointOfService.class);

        System.assertEquals(307, responsePointOfService.id); 
        System.assertEquals('Shopping Morumbi', responsePointOfService.name); 
        System.assertEquals(null, responsePointOfService.segment.id); 
        System.assertEquals(null, responsePointOfService.segment.description); 
        System.assertEquals('Segmento', responsePointOfService.segment.name); 
        System.assertEquals(null, responsePointOfService.segment.type); 
        System.assertEquals('22', responsePointOfService.attendant.id); 
        System.assertEquals(null, responsePointOfService.attendant.status); 
        System.assertEquals(null, responsePointOfService.attendant.pauseReason); 
        System.assertEquals(3, responsePointOfService.workPosition.size());
        System.assertEquals('01', responsePointOfService.workPosition[0].id);
        System.assertEquals('Empty', responsePointOfService.workPosition[0].status);
        System.assertEquals('Fila 1', responsePointOfService.workPosition[0].queue);
        System.assertEquals('096', responsePointOfService.workPosition[0].attendant.id);

        // Attendance
        String jsonAttendance = (
                '{\"ticket\":{\"id\":\"01\",\"customer\":{\"individualIdentification\":' + 
                '{\"nationalIdentilyCardNr\":\"45678932103\",\"documentType\":\"CPF\"},' + 
                '\"name\":\"Maria Augusta Silva\",\"segment\":{\"id\":\"string\",\"description\":' + 
                '\"string\",\"name\":\"string\",\"type\":\"string\"},\"specialNeeds\":false,' + 
                '\"priority\":2},\"createBy\":\"A123410\",\"createAt\":\"14:16:22\",\"duration\":' + 
                '{\"amount\":\"00:05:50\"},\"geographicArea\":{\"code\":\"11\"},\"network\":' + 
                '{\"networkNumber\":\"988887654\"},\"interaction\":{\"id\":\"string\",\"name\":' + 
                '\"string\",\"businessLine\":{\"id\":\"string\",\"description\":\"string\",' + 
                '\"name\":\"string\",\"type\":\"string\"}}},\"workPosition\":{\"id\":\"01\",' + 
                '\"status\":\"Empty\",\"queue\":\"MS\",\"attendant\":{\"id\":\"78965412365\",' + 
                '\"status\":\"ALOCADO\",\"pauseReason\":{\"id\":\"string\",\"description\":' + 
                '\"string\",\"name\":\"string\",\"type\":\"string\"}}},\"interactions\":' + 
                '[{\"id\":\"string\",\"name\":\"string\",\"businessLine\":{\"id\":\"string\",' + 
                '\"description\":\"string\",\"name\":\"string\",\"type\":\"string\"}}],' + 
                '\"displayAlert\":true,\"status\":\"OPEN\",\"notes\":\"O cliente solicitou o cancelamento\"}'
            );

        StoreServiceManagerResponse.Attendance responseAttendance = (StoreServiceManagerResponse.Attendance) 
            JSON.deserialize(jsonAttendance, StoreServiceManagerResponse.Attendance.class);

        System.assertNotEquals(null, responseAttendance.ticket);
        System.assertNotEquals(null, responseAttendance.workPosition);
        System.assertEquals(1, responseAttendance.interactions.size());
        System.assertEquals(true, responseAttendance.displayAlert);
        System.assertEquals('OPEN', responseAttendance.status);
        System.assertEquals('O cliente solicitou o cancelamento', responseAttendance.notes);

        // OperationalInformations
        String jsonOperationalInformations = (
                '{"attendantPauseOptions":[{"id":"2","name":"Banheiro"},{"id":"19","name":"Almoco"}],' + 
                '"businessLines":[{"id":"1","description":"Móvel","name":"MOVEL"},{"id":"2","description":' + 
                '"Fixa","name":"FIXA"}],"quittingReasons":[{"id":"QR1","description":' + 
                '"Retornará em outro horário / dia"},{"id":"QR2","description":"Cliente desistiu da compra"}],' + 
                '"interactions":[{"id":"705","name":"Alteração Cadastral - TV","businessLine":{"name":"TV"}},' + 
                '{"id":"728","name":"Cancelamento - Fixa","businessLine":{"name":"FIXA"}}]}'
            );

        StoreServiceManagerResponse.OperationalInformations responseOperationalInformations = (StoreServiceManagerResponse.OperationalInformations) 
            JSON.deserialize(jsonOperationalInformations, StoreServiceManagerResponse.OperationalInformations.class);

        System.assertEquals(2, responseOperationalInformations.attendantPauseOptions.size());
        System.assertEquals(2, responseOperationalInformations.businessLines.size());
        System.assertEquals(2, responseOperationalInformations.quittingReasons.size());
        System.assertEquals(2, responseOperationalInformations.interactions.size());

        // ItemPicklistValue
        String jsonItemPicklistValue = '{"label":"Mostrar","value":"Valor"}';

        StoreServiceManagerTO.ItemPicklistValue responseItemPicklistValue = (StoreServiceManagerTO.ItemPicklistValue) 
            JSON.deserialize(jsonItemPicklistValue, StoreServiceManagerTO.ItemPicklistValue.class);

        System.assertEquals('Mostrar', responseItemPicklistValue.label);
        System.assertEquals('Valor', responseItemPicklistValue.value);
    }
}