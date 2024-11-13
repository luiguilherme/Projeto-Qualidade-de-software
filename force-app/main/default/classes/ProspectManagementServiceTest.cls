@IsTest
private class ProspectManagementServiceTest {
    public static final String JWT_VALIDO ='eyJ4NXQiOiJsWkdjQmExSG90V0ZZYzRjb0xxOWlwMHBZbXciLCJraWQiOiJWaXZvQ3VzdG9tZXJEb21haW4iLCJhbGciOiJSUzI1NiJ9.eyJlbnRyeVVVSUQiOiIxNzNiNGY2MC01ZjMxLTQ2YjYtOTZlMy1mN2UzMWUzZDk2NTciLCJ2aXZvLmVuZHBvaW50IjoiVml2b0N1c3RvbWVyRG9tYWluIiwic3ViIjoiMTczYjRmNjAtNWYzMS00NmI2LTk2ZTMtZjdlMzFlM2Q5NjU3IiwibnJkb2N1bWVudG8iOiIwNTQ0MzEyOTAyMyIsImlzcyI6Imh0dHBzOlwvXC9hdXRoaG1sLnZpdm8uY29tLmJyOjQ0M1wvb2F1dGgyIiwidml2by5lbnYiOiJQUkUtUFJPRDEyIiwiYXVkIjoiMTk0MjZjNzQwMDI3NGUyMzk0ZDk1Y2QwMDI3Njg3N2IiLCJzY29wZSI6WyJvcGVuaWQiLCJDdXN0b21lci5Qcm9maWxlIl0sImRvbWFpbiI6IlZpdm9DdXN0b21lckRvbWFpbiIsImNsaWVudCI6IjE5NDI2Yzc0MDAyNzRlMjM5NGQ5NWNkMDAyNzY4NzdiIiwiZXhwIjoxNzI2ODY0NjEwLCJpYXQiOjE3MjY4NjEwMTAsImp0aSI6ImxSeW5XcXd3SnJTME8wUnpzRE9UalEiLCJhdXRoZW50aWNhdGlvbl9jb250ZXh0IjpbeyJpZGVudGlmaWVyIjoiMDU0NDMxMjkwMjMiLCJ0eXBlIjoidWlkIn1dLCJjb25zdW1lcl9pZCI6Im5vdnVtLW15dGVsY28ifQ.RBaSj85U7KJPKSy_nPI_63zQccPE9KtmfCyYcCVgbeOXtd-nMsryYwmejQiTGzeI2P1Kc0SQ_l4AWx9YjOEivJfPmxHFuBuscNGfJ2iJQ1yd-8I2t1jDbEb6EkyuaQ8DleOZJ_1IOH9r2jzwfLfQNneVTKHvWS-YM6mB93ntoTZp7Ilj6jjAgevpDFvOQf2i6KhyaYjiL4v8urgVNna8QUm5bLeXM8WxF2tjzn6eBGxSDi-92i9SG9M0zTyWGgRWJBGb43vQaNcZytDQZBcGF-VSPcaGB8bGgJgIGnZYO0GQxCypB4Bj7v-URXPMS_ppn4BtOPSxGckWa9d0q2IhNQ';
    
    @TestSetup
    static void setupTestData() {
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Consumer').getRecordTypeId();
        Account existingAccount = new Account();
        existingAccount.Type = 'Prospect';
        existingAccount.Name = 'Terceira' + ' ' + 'Conta';
        existingAccount.DocumentNumber__c = 'isso';
        existingAccount.ExternalId__c = 'isso';    
        existingAccount.DocumentType__c = 'CPF';
        existingAccount.RecordTypeId = recordTypeId;
        insert existingAccount;
        
        // Criação de um contato de teste existente com CPF para verificar a lógica de atualização
		Contact existingContact = new Contact(Email = 'teste@teste.com', Birthdate = Date.valueOf('2000-05-12'), MobilePhone = '19991284566', Phone = '19991284566', MotherName__c = 'Mae Teste', ExternalId__c = 'aquele',FirstName = 'Segundo',LastName = 'Contato',AccountId = existingAccount.Id);
        insert existingContact;
		Contact existingContact2 = new Contact(Email = 'teste@teste.com', Birthdate = Date.valueOf('2000-05-12'), MobilePhone = '19991284566', Phone = '19991284566', MotherName__c = 'Mae Teste', ExternalId__c = 'isso',FirstName = 'Segundo',LastName = 'Contato',AccountId = existingAccount.Id);
        insert existingContact2;
    }
    
    @IsTest
    static void testCreateProspectNewProspect() {
        // JSON de exemplo para a criação de um prospecto
        String jsonInput = '{"documentNumber": "teste","documentType": "CPF","clientType": "Prospect","firstName": "Contato","lastName": "Terceiro","motherName": "Maria Silva","birthDate": "2000-05-12","email": "test@teeeeste.com.br","mobilePhone": "1195442233","phone": "1195442233","serviceNumber": "24998153061"}';
        
        // Configura o contexto da requisição REST
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/prospectManagement/v1/prospects';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(jsonInput);
        RestContext.request = req;
        //req.addHeader('x-Authorization', 'Bearer ' + identifier_JWT);
        
        RestResponse res = new RestResponse();
        RestContext.response = res;
        
        // Chama o método do serviço REST
        Test.startTest();
        ProspectManagementService.createProspect();
        Test.stopTest();
        
        // Verifica o resultado da resposta
        
        // Converte a resposta em um objeto ProspectResponse para validar os resultados
        //ProspectManagementWrapper.ProspectResponse response = (ProspectManagementWrapper.ProspectResponse) JSON.deserialize(res.responseBody.toString(), ProspectManagementWrapper.ProspectResponse.class);
    }
    
    @IsTest
    static void testCreateProspectExistingProspect() {
        // Configura o contexto da requisição REST
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/prospectManagement/v1/prospects';
        req.httpMethod = 'POST';
        //req.addHeader('x-Authorization', 'Bearer ' + identifier_JWT);
        req.requestBody = Blob.valueOf('{"documentNumber": "05443129023","documentType": "CPF","clientType": "Prospect","firstName": "Contato","lastName": "Terceiro","motherName": "Maria Silva","birthDate": "2000-05-12","email": "test@teeeeste.com.br","mobilePhone": "1195442233","phone": "1195442233","serviceNumber": "24998153061"}');
        RestContext.request = req;
        
        RestResponse res = new RestResponse();
        RestContext.response = res;
        
        // Chama o método do serviço REST
        Test.startTest();
        ProspectManagementService.createProspect();
        Test.stopTest();
        
    }
        @IsTest
    	static void testCreateProspec() {
        // Configura o contexto da requisição REST
        JWTUtilityTest.setPublicTestKey();
        String jwt = JWTUtilityTest.createValidProspectJWT();
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/prospectManagement/v1/prospects';
        req.httpMethod = 'POST';
        req.addHeader('x-Authorization', 'Bearer ' + JWT_VALIDO);
        req.requestBody = Blob.valueOf('{"documentNumber": "05443129023","documentType": "CPF","clientType": "Prospect","firstName": "Contato","lastName": "Terceiro","motherName": "Maria Silva","birthDate": "2000-05-12","email": "test@teeeeste.com.br","mobilePhone": "1195442233","phone": "1195442233","serviceNumber": "05443129023"}');
        RestContext.request = req;
        
        RestResponse res = new RestResponse();
        RestContext.response = res;
        
        // Chama o método do serviço REST
        Test.startTest();
        ProspectManagementService.createProspect();
        Test.stopTest();
        
    }
    @IsTest
    static void Badrequest() {
        // Configura o contexto da requisição REST
        RestRequest req = new RestRequest();
        req.requestUri = '/services/apexrest/prospectManagement/v1/prospects';
        req.httpMethod = 'POST';
        //req.addHeader('x-Authorization', 'Bearer ' + identifier_JWT);
        //req.requestBody = Blob.valueOf('{"documentNumber": "Isso","documentType": "CPF","clientType": "Prospect","firstName": "Contato","lastName": "Terceiro","motherName": "Maria Silva","birthDate": "2000-05-12","email": "test@teeeeste.com.br","mobilePhone": "1195442233","phone": "1195442233","serviceNumber": "24998153061"}');
        RestContext.request = req;
        
        RestResponse res = new RestResponse();
        RestContext.response = res;
        
        // Chama o método do serviço REST
        Test.startTest();
        ProspectManagementService.createProspect();
        Test.stopTest();
        
    }
    
    
    
}