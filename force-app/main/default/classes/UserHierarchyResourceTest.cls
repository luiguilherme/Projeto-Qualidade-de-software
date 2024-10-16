@IsTest
private class UserHierarchyResourceTest {
    static final String resourceUrl = (URL.getOrgDomainURL() + '/services/apexrest/User/Hierarchy');

    @IsTest 
    public static void updateHierarchyPositiveTest() {
        Profile profileTest = [
            SELECT Id 
            FROM Profile 
            WHERE Name = 'Representante'
        ];

        UserRole userRoleTest = new UserRole(
            Name = 'Telefonica Brasil'
        );
        
        insert userRoleTest;

        String operatorLogin = createOperator(profileTest.Id, userRoleTest.Id);
        String managerLogin = createManager(profileTest.Id, userRoleTest.Id);
        String supervisorLogin = createSupervisor(profileTest.Id, userRoleTest.Id);
        
        RestRequest request = new RestRequest();

        request.requestUri = resourceUrl;
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"status": "Working"}');
        RestContext.request = request;

  		RestResponse response = new RestResponse();
        
        RestContext.response = response;
        
        UserHierarchyResource.updateHierarchy(operatorLogin, managerLogin, supervisorLogin);

        User userOperator = [SELECT Id, ManagerId, SupervisorId__c FROM User WHERE Login__C = :operatorLogin];
        User userManager = [SELECT Id, ManagerId, SupervisorId__c FROM User WHERE Login__C = :managerLogin];
        User userSupervisor = [SELECT Id, ManagerId, SupervisorId__c FROM User WHERE Login__C = :supervisorLogin];
        
        Assert.isTrue(userOperator != null);
        Assert.isTrue(userManager != null);
        Assert.isTrue(userSupervisor != null);
        
        Assert.areEqual(userOperator.ManagerId, userManager.Id);
        Assert.areEqual(userOperator.SupervisorId__c, userSupervisor.Id);
    }
    
    @IsTest 
    public static void updateHierarchyNegativeTest() {
        Profile profileTest = [
            SELECT Id 
            FROM Profile 
            WHERE Name = 'Representante'
        ];

        UserRole userRoleTest = new UserRole(
            Name = 'Telefonica Brasil'
        );

        insert userRoleTest;

        String operatorLogin = createOperator(profileTest.Id, userRoleTest.Id);
        String managerLogin = createManager(profileTest.Id, userRoleTest.Id);
        String supervisorLogin = createSupervisor(profileTest.Id, userRoleTest.Id);

        RestRequest request = new RestRequest();

        request.requestUri = resourceUrl;
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"status": "Working"}');
        RestContext.request = request;

  		RestResponse response = new RestResponse();
        
        RestContext.response = response;
        
        // Error code 5000: Matrícula do Operador, Gerente e Supervisor não pode ser vazio
        UserHierarchyResource.updateHierarchy('', '', '');

        Assert.areEqual(response.statusCode, 500);

        // Error code 4044: Gerente não encontrado. Operador não encontrado. Supervisor não encontrado
        UserHierarchyResource.updateHierarchy('X0123', 'Y0456', 'Z0789');

        Assert.areEqual(response.statusCode, 500);

        // Error code 4042: Operador não encontrado
        UserHierarchyResource.updateHierarchy('X0123', managerLogin, supervisorLogin);

        Assert.areEqual(response.statusCode, 500);

        // Error code 4041: Gerente não encontrado
        UserHierarchyResource.updateHierarchy(operatorLogin, 'Y0456', supervisorLogin);

        Assert.areEqual(response.statusCode, 500);

        // Error code 4043: Supervisor não encontrado
         UserHierarchyResource.updateHierarchy(operatorLogin, managerLogin, 'Z0789');

        Assert.areEqual(response.statusCode, 500);
    }
    
	static String createOperator(Id profileId, Id roleId) {
        User userTest = new User(
            Login__C = 'A0123',
            Username = 'vivotest1operador@test.com',
            LastName = 'Teste',
            Email = 'test1@test.com',
            Alias = 'Test1',
            TimeZoneSidKey = 'Europe/London',
            LocaleSidKey = 'en_GB',
            EmailEncodingKey = 'ISO-8859-1',
            ProfileId = profileId, 
            UserRoleId = roleId, 
            LanguageLocaleKey = 'en_US'
        );

        insert userTest;

        return (userTest.Login__c);
    }
    
	static String createManager(Id profileId, Id roleId) {
        User userTest = new User(
            Login__C = 'A0456',
            Username = 'vivotest2gerente@test.com',
            LastName = 'Teste',
            Email = 'test2@test.com',
            Alias = 'Test2',
            TimeZoneSidKey = 'Europe/London',
            LocaleSidKey = 'en_GB',
            EmailEncodingKey = 'ISO-8859-1',
            ProfileId = profileId, 
            UserRoleId = roleId, 
            LanguageLocaleKey = 'en_US'
        );

        insert userTest;

        return (userTest.Login__c);
    }
    
	static String createSupervisor(Id profileId, Id roleId) {
        User userTest = new User(
            Login__C = 'A0789',
            Username = 'vivotest3supervisor@test.com',
            LastName = 'Teste',
            Email = 'test3@test.com',
            Alias = 'Test3',
            TimeZoneSidKey = 'Europe/London',
            LocaleSidKey = 'en_GB',
            EmailEncodingKey = 'ISO-8859-1',
            ProfileId = profileId, 
            UserRoleId = roleId, 
            LanguageLocaleKey = 'en_US'
        );

        insert userTest;

        return (userTest.Login__c);
    }
}