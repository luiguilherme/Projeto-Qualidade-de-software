@isTest
public with sharing class HDETaskDMLTest {
    
    @testSetup
    static void setupData() {  
        String profileId = [SELECT Id FROM Profile WHERE Name = 'Representante'].Id;
    
            String userRoleId = [SELECT Id FROM UserRole WHERE DeveloperName = 'AtendimentoGoldAdmPerformance'].Id;
             
            User user1 = DataFactory.createUser(profileId, userRoleId);
            user1.username = 'user1teste@gmail.com' ;
            insert user1;
            
            User user2 = DataFactory.createUser(profileId, userRoleId);
            user2.username = 'user2teste@gmail.com' ;
            insert user2;
            
            System.runAs(user1) {
                Account account1 = DataFactory.createAccount();
                insert account1;
                
                Case case1 = new Case();
                case1.AccountId = account1.Id;
                case1.Segment__c = 'Gold';
                case1.CustomerServiceReason__c = 'Acompanhamento de Técnico Fixa';
                case1.ContactPhone__c = '3132214002';
                case1.CallerPhone__c = '3132214002';
                case1.Comment__c = 'Caso Gold teste';
                case1.Protocol__c = '123456';
                case1.Status = 'A Iniciar';
                case1.SegmentProduct__c = 'Fixa';
                case1.HDEOtherProducts__c = 'Telefone Fixo Teste';
                case1.CustomerMoodRating__c = 'Não';
                case1.Origin = 'HDE';
                case1.CaseComplexityReason__c = 'Motivos de baixa Complexidade';
                case1.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('HDE - Gold Processos Escalonamento').getRecordTypeId();
                case1.OwnerId = user1.Id;
                insert case1;
            }                       
    }
    
    public static testMethod void createHDETask () {
        
        User user1 = [SELECT id FROM User WHERE username = 'user1teste@gmail.com' ] ;
        Case case1 = [SELECT id, OwnerId FROM Case WHERE segment__c = 'Gold'] ;
        
        System.runAs(user1) {
        
        	Test.startTest();
            
            Task hdeTask1 = new Task ();
            hdeTask1.WhatId = case1.Id ;
            hdeTask1.View__c = 'CRI Escalonamento Gold' ;
            hdeTask1.RecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('HDE - Tarefa').getRecordTypeId();
            hdeTask1.Subject = 'Cobrar Supervisor';
            hdeTask1.TaskListType__c = 'Cobrar Supervisor';
            hdeTask1.TaskSubtype = 'Task';
            insert hdeTask1;  
           
            Task tentativaContato1 = new Task ();
            tentativaContato1.WhatId = case1.Id ;
            tentativaContato1.Subject = 'Tentativa de Contato';
            tentativaContato1.ContactAttempt__c = 'Com sucesso - E-mail';
            tentativaContato1.TaskSubtype = 'Task';       
            insert tentativaContato1;
            
       		Test.stopTest();
       		
        }
        
        List <Task> ListaHDETask = [SELECT Id FROM Task WHERE whatId =: case1.Id] ;
        System.assert(ListaHDETask.size() == 2);
        System.debug ('A Lista HDETask possui: ' +ListaHDETask.size() + ' registros');
        
    }
    
	public static testMethod void preventCreateHDETask () {
        
        User user1 = [SELECT id FROM User WHERE username = 'user1teste@gmail.com' ] ;
        User user2 = [SELECT id FROM User WHERE username = 'user2teste@gmail.com' ] ;
        Case case1 = [SELECT id, OwnerId FROM Case WHERE segment__c = 'Gold'] ;
          
        System.runAs(user2) {
                
        	Test.startTest();      
                        
            Try {
                Task hdeTask2 = new Task ();
                hdeTask2.WhatId = case1.Id ;
                hdeTask2.View__c = 'CRI Escalonamento Gold' ;
                hdeTask2.RecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('HDE - Tarefa').getRecordTypeId();
                hdeTask2.Subject = 'Cobrar Supervisor';
                hdeTask2.TaskListType__c = 'Cobrar Supervisor';
                hdeTask2.TaskSubtype = 'Task';
                insert hdeTask2;
            
            }Catch( DmlException error) {
                system.assert(error.getMessage().contains('Somente o proprietário do Caso pode criar a Tarefa.'),+error.getMessage());
            }
            
            Try {
                Task tentativaContato2 = new Task ();
                tentativaContato2.WhatId = case1.Id ;
                tentativaContato2.Subject = 'Tentativa de Contato';
                tentativaContato2.ContactAttempt__c = 'Com sucesso - E-mail';
                tentativaContato2.TaskSubtype = 'Task';       
                insert tentativaContato2;
            
            }Catch( DmlException error) {
            	system.assert(error.getMessage().contains('Somente o proprietário do Caso pode criar a Tarefa.'),+error.getMessage());
            }
                
            Test.stopTest();  
        }
        
        List <Task> ListaHDETask = [SELECT Id, OwnerId FROM Task WHERE whatId =: case1.Id and CreatedById =: user2.Id] ;
        System.assert(ListaHDETask.size() == 0);
        System.debug ('A Lista HDETask possui: ' +ListaHDETask.size() + ' registros');
    }
    
    static testmethod void testPreventTaskDel(){

        User user1 = [SELECT id FROM User WHERE username = 'user1teste@gmail.com' ] ;
        Case case1 = [SELECT id FROM Case WHERE segment__c = 'Gold'] ;
        
        System.runAs(user1){
            
            Test.startTest();
            
            Task hdeTaskDelete = new Task ();
            hdeTaskDelete.WhatId = case1.Id ;
            hdeTaskDelete.View__c = 'CRI Escalonamento Gold' ;
            hdeTaskDelete.RecordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('HDE - Tarefa').getRecordTypeId();
            hdeTaskDelete.Subject = 'Cobrar Supervisor';
            hdeTaskDelete.TaskListType__c = 'Cobrar Supervisor';
            hdeTaskDelete.TaskSubtype = 'Task';
            insert hdeTaskDelete;  		
            
            try{
                delete hdeTaskDelete;

            }catch(DMLexception error){                       
                system.assert(error.getMessage().contains('Você não tem permissão para excluir a tarefa'),+error.getMessage());
            }
            
            Test.stopTest();
        }
        
        List <Task> ListaHDETask = [SELECT Id FROM Task WHERE whatId =: case1.Id] ;
        System.assert(ListaHDETask.size() == 1);
        System.debug ('A Lista HDETask possui: ' +ListaHDETask.size() + ' registro');
    }

    
}