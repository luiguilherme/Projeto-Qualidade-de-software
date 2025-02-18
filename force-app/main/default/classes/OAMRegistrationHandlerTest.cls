/*
* @author Diego Costa @Deloitte
* @description: funcionalidade Classe de Teste para OAMRegistrationHandler
* @data: 10/06/2022
*/
@isTest
private class OAMRegistrationHandlerTest {
    
    // Setup
    @testSetup 
    static void setup(){
        User adminUser = [SELECT Id FROM User WHERE (Profile.Name='Administrador do sistema' OR Profile.Name='System Administrator') AND UserRoleId != null AND ISACTIVE = true LIMIT 1];
        
        FeatureFlag__c featureFlag = new FeatureFlag__c();
		featureFlag.Name = 'OAMRegistrationHandler';
		featureFlag.Application__c = 'OAMRegistrationHandler';
		featureFlag.Active__c = true ;
		insert featureFlag;

        Account acc = DataFactory.createAccount();
        acc.ownerId = adminUser.Id;
        insert acc;

        Contact lContact = new Contact();
        lContact.FirstName = 'Contato';
        lContact.AccountId = acc.Id;
        lContact.LastName = 'teste';
        lContact.UserIdentifier__c = 'teste@salesforce.com.br.test' + new OAMRegistrationHandler().getSandboxName();
        insert lContact;

        Contact lContact2 = new Contact();
        lContact2.FirstName = 'Contato';
        lContact2.AccountId = acc.Id;
        lContact2.LastName = 'teste';
        lContact2.UserIdentifier__c = 'teste@salesforce.com.br.test' + new OAMRegistrationHandler().getSandboxName();
        lContact2.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('PartnerContact').getrecordTypeId();

        insert lContact2;
        
        AdabasSite__c sobjectAdabasSite = new AdabasSite__c();
        sobjectAdabasSite.AdabasCode__c = '1';
        sobjectAdabasSite.CNPJ__c = '123123123000122';
        sobjectAdabasSite.Name = 'Loja Morumbi';
        insert sobjectAdabasSite;       
    }
    
    //INTERNO
    static testMethod void testCreateAndUpdateUserInterno() {
        Test.StartTest();
        OAMRegistrationHandler handler = new OAMRegistrationHandler();
        Auth.UserData sampleData = new Auth.UserData('testId', 'Nome', 'Sobrenome',
                                                     'Nome Sobrenome', 'testuser@example.org', null, 'teste@salesforce.com.br.test', 'pt-BR', 'facebook',
                                                     null, new Map<String, String>{'aud' => 'oamIdToken.aud',
                                                         'iat' => 'oamIdToken.iat',
                                                         'exp' => 'oamIdToken.exp',
                                                         'network_id' => 'oamIdToken.network_id',
                                                         'employee_number' => '1234444',
                                                         'phone_number' => '345533443434', 
                                                         'profile_name' => 'AdministracaoSistema',
                                                         'CNPJ' => '',
                                                         'active' => '1',
                                                         'role' => 'TelefonicaBrasil',
                                                         'sub' => 'teste@salesforce.com.br',
                                                         'adabas' => '1',
                                                         'canal_atendimento' => 'Call Center',
                                                         'site' => '1',
                                                         'escritorio_vendas' => 'L111-MORUMBI',
                                                         'permission_sets' => ''});
        User u = handler.createUser(null, sampleData);
        User uid = u;
        
        sampleData = new Auth.UserData('testId', 'Nome', 'Sobrenome',
                                       'Nome Sobrenome', 'testuser@example.org', null, 'teste@salesforce.com.br.test', 'pt-BR', 'facebook',
                                       null, new Map<String, String>{'aud' => 'oamIdToken.aud',
                                           'iat' => 'oamIdToken.iat',
                                           'exp' => 'oamIdToken.exp',
                                           'network_id' => 'oamIdToken.network_id',
                                           'employee_number' => '12344444',
                                           'phone_number' => '3455334543434', 
                                           'profile_name' => 'AdministracaoSistema',
                                           'CNPJ' => '',
                                           'active' => '1',
                                           'role' => 'TelefonicaBrasil',
                                           'sub' => 'teste@salesforce.com.br',
                                           'adabas' => '1',
                                           'canal_atendimento' => 'Call Center',
                                           'site' => '1',
                                           'escritorio_vendas' => 'L111-MORUMBI',
                                           'permission_sets' => ''});
        
        handler.updateUser(uid.id, null, sampleData);
        Test.StopTest();
        User updatedUser = [SELECT userName, email, firstName, lastName, alias, center__c, store__c FROM user WHERE id=:uid.id];
        System.assertEquals('teste@salesforce.com.br.test' + new OAMRegistrationHandler().getSandboxName(), updatedUser.userName);
        System.assertEquals('testuser@example.org', updatedUser.email);
        System.assertEquals('Sobrenome', updatedUser.lastName);
        System.assertEquals('Nome', updatedUser.firstName);
        System.assertEquals('teste@sa', updatedUser.alias);
        System.assertEquals('111L', updatedUser.center__c);
        System.assertEquals('MORUMBI', updatedUser.store__c);
    } 
    
    // PARCEIRO
    static testMethod void testCreateAndUpdateUserUsuarioParceiro() {
        
       
        User adminUser = [Select Id, UserRoleId From User Where (Profile.Name='Administrador do sistema' OR Profile.Name='System Administrator') AND UserRoleId != null AND ISACTIVE = true Limit 1];
        System.runAs(adminUser){
            Test.StartTest();
            OAMRegistrationHandler handler = new OAMRegistrationHandler();
            Auth.UserData sampleData = new Auth.UserData('testId', 'Nome', 'Sobrenome',
                                                         'Nome Sobrenome', 'teste2@salesforce.com.br.test', null, 'teste2@salesforce.com.br.test', 'pt-BR', 'facebook',
                                                         null, new Map<String, String>{'aud' => 'oamIdToken.aud',
                                                             'iat' => 'oamIdToken.iat',
                                                             'exp' => 'oamIdToken.exp',
                                                             'network_id' => 'oamIdToken.network_id',
                                                             'employee_number' => '1234444',
                                                             'phone_number' => '345533443434', 
                                                             'profile_name' => 'AliadoExterno',
                                                             'CNPJ' => '112233445566',
                                                             'active' => '1',
                                                             'role' => 'VendasAliado',
                                                             'adabas' => '1',
                                                             'canal_atendimento' => 'Call Center',
                                                             'site' => '1',
                                                             'escritorio_vendas' => 'L111-MORUMBI',
                                                             'sub' => 'teste@salesforce.com.br',
                                                             'permission_sets' => ''});
            User u = handler.createUser(null, sampleData);
            User uid = u;
            
            sampleData = new Auth.UserData('testId', 'Nome', 'Sobrenome',
                                           'Nome Sobrenome', 'teste2@salesforce.com.br.test', null, 'teste2@salesforce.com.br.test', 'pt-BR', 'facebook',
                                           null, new Map<String, String>{'aud' => 'oamIdToken.aud',
                                               'iat' => 'oamIdToken.iat',
                                               'exp' => 'oamIdToken.exp',
                                               'network_id' => 'oamIdToken.network_id',
                                               'employee_number' => '1234444',
                                               'phone_number' => '345533443434', 
                                               'profile_name' => 'AliadoExterno',
                                               'CNPJ' => '112233445566',
                                               'active' => '1',
                                               'role' => 'VendasAliado',
                                               'sub' => 'teste@salesforce.com.br',
                                               'adabas' => '1',
                                               'canal_atendimento' => 'Lojas Revendas',
                                               'site' => '1',
                                               'escritorio_vendas' => 'L111-MORUMBI',
                                               'permission_sets' => ''});
            handler.updateUser(uid.id, null, sampleData);
            Test.StopTest();
            User updatedUser = [SELECT userName, email, firstName, lastName, alias FROM user WHERE id=:uid.id];
            System.assertEquals('teste2@salesforce.com.br.test' + new OAMRegistrationHandler().getSandboxName(), updatedUser.userName);
            System.assertEquals('teste2@salesforce.com.br.test', updatedUser.email);
            System.assertEquals('Sobrenome', updatedUser.lastName);
            System.assertEquals('Nome', updatedUser.firstName);
            System.assertEquals('teste2@s', updatedUser.alias); 

            List<GroupMember> lstGroupMember = [SELECT Id, UserOrGroupId FROM GroupMember WHERE UserOrGroupId =: updatedUser.Id];
            //System.assert( !lstGroupMember.isEmpty() ); 
        }
    }
        
    // PARCEIRO 2 (throw)
    static testMethod void testCreateAndUpdateUserUsuarioParceiroThrow() {
        
        User adminUser = [Select Id, UserRoleId From User Where (Profile.Name='Administrador do sistema' OR Profile.Name='System Administrator') AND UserRoleId != null AND ISACTIVE = true Limit 1];
        
        System.runAs(adminUser){
            Test.StartTest();
            
            OAMRegistrationHandler handler = new OAMRegistrationHandler();
            Auth.UserData sampleData = new Auth.UserData('testId', 'Nome', null,
                                                         'Nome', 'null@test.com', null, 'teste2@salesforce.com.br.test', 'pt-BR', 'facebook',
                                                         null, new Map<String, String>{'aud' => 'oamIdToken.aud',
                                                             'iat' => 'oamIdToken.iat',
                                                             'exp' => 'oamIdToken.exp',
                                                             'network_id' => 'oamIdToken.network_id',
                                                             'employee_number' => '1234444',
                                                             'phone_number' => '345533443434', 
                                                             'profile_name' => 'AliadoExterno',
                                                             'CNPJ' => '112233445566',
                                                             'active' => '1',
                                                             'role' => 'MasterTelefonicaBrasil',
                                                             'adabas' => '1',
                                                             'canal_atendimento' => 'Loja Revendas',
                                                             'site' => '1',
                                                             'escritorio_vendas' => 'L111-MORUMBI',
                                                             'sub' => '',
                                                             'permission_sets' => ''});
            try{
                User u = handler.createUser(null, sampleData);
            } 
            catch (exception e) {
                System.debug('e: ' + e);
                System.assert(e.getMessage().contains('Campo obrigatório de lastName não informado no response.'));
            }
            sampleData.lastName= 'teste';
            sampleData.attributeMap.put('profile_name',null);
            try{
                User u = handler.createUser(null, sampleData);
            } 
            catch (exception e) {
                System.assert(e.getMessage().contains('Campo obrigatório de perfil não informado no response'));
            }
            sampleData.attributeMap.put('profile_name','Aliado');
            sampleData.attributeMap.put('role',null);
            try{
                User u = handler.createUser(null, sampleData);
            } 
            catch (exception e) {
                System.assert(e.getMessage().contains('Campo obrigatório de papel não informado no response'));
            }
            sampleData.attributeMap.put('role','');
            try{
                User u = handler.createUser(null, sampleData);
            } 
            catch (exception e) {
                System.debug('e: ' + e);
                System.assert(e.getMessage().contains('Papel informado não encontrado no SalesForce.'));
            }
            sampleData.attributeMap.put('role','VendasAliadoPaPSupervisor');
            try{
                User u = handler.createUser(null, sampleData);
            } 
            catch (exception e) {
                System.assert(e.getMessage().contains('Papel informado não encontrado no SalesForce.'));
            }
            sampleData.username = '';
            try{
                User u = handler.createUser(null, sampleData);
            } 
            catch (exception e) {
                System.assert(e.getMessage().contains('Campo obrigatório de Sub (Username) não informado no response'));
            }
            sampleData.username = 'teste2@salesforce.com.br.test';
            
            sampleData.attributeMap.put('CNPJ','');
            sampleData.email = 'teste2@salesforce.com.br';
            sampleData.username = 'teste@salesforce.com.br';
            sampleData.attributeMap.put('CNPJ','213445555');
            sampleData.username = 'teste2@salesforce.com.br.test';
            sampleData.email = 'teste2@salesforce.com.br.test';
            sampleData.attributeMap.put('permission_sets','erropermission');
            try{
                User u = handler.createUser(null, sampleData);
            } 
            catch (exception e) {
                System.assert(e.getMessage().contains('Erro desconhecido'));
            }
        }
        Test.StopTest();
    }
	
    static testMethod void testCreateAndUpdateOfficaToEmpty() {
        Test.StartTest();
        OAMRegistrationHandler handler = new OAMRegistrationHandler();
        Auth.UserData sampleData = new Auth.UserData('testId', 'Nome', 'Sobrenome',
                                                     'Nome Sobrenome', 'testuser@example.org', null, 'teste@salesforce.com.br.test', 'pt-BR', 'facebook',
                                                     null, new Map<String, String>{'aud' => 'oamIdToken.aud',
                                                         'iat' => 'oamIdToken.iat',
                                                         'exp' => 'oamIdToken.exp',
                                                         'network_id' => 'oamIdToken.network_id',
                                                         'employee_number' => '1234444',
                                                         'phone_number' => '345533443434', 
                                                         'profile_name' => 'AdministracaoSistema',
                                                         'CNPJ' => '',
                                                         'active' => '1',
                                                         'role' => 'TelefonicaBrasil',
                                                         'sub' => 'teste@salesforce.com.br',
                                                         'adabas' => '1',
                                                         'canal_atendimento' => 'Call Center',
                                                         'site' => '1',
                                                         'escritorio_vendas' => 'L111-MORUMBI',
                                                         'permission_sets' => ''});
        User u = handler.createUser(null, sampleData);
        User uid = u;
        
        sampleData = new Auth.UserData('testId', 'Nome', 'Sobrenome',
                                       'Nome Sobrenome', 'testuser@example.org', null, 'teste@salesforce.com.br.test', 'pt-BR', 'facebook',
                                       null, new Map<String, String>{'aud' => 'oamIdToken.aud',
                                           'iat' => 'oamIdToken.iat',
                                           'exp' => 'oamIdToken.exp',
                                           'network_id' => 'oamIdToken.network_id',
                                           'employee_number' => '12344444',
                                           'phone_number' => '3455334543434', 
                                           'profile_name' => 'AdministracaoSistema',
                                           'CNPJ' => '',
                                           'active' => '1',
                                           'role' => 'TelefonicaBrasil',
                                           'sub' => 'teste@salesforce.com.br',
                                           'adabas' => '1',
                                           'canal_atendimento' => 'Call Center',
                                           'site' => '1',
                                           'escritorio_vendas' => '0',
                                           'permission_sets' => ''});
        
        handler.updateUser(uid.id, null, sampleData);
        Test.StopTest();
        User updatedUser = [SELECT userName, email, firstName, lastName, alias, center__c, store__c, office__c FROM user WHERE id=:uid.id];
        System.assertEquals('0', updatedUser.office__c);
        System.assertEquals(null, updatedUser.center__c);
        System.assertEquals(null, updatedUser.store__c);
    }	
}