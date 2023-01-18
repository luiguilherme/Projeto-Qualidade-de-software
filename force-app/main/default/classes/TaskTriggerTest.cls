@isTest
public with sharing class TaskTriggerTest {

    @testSetup 
    static void setup(){

        UserRole userR = new UserRole();
        userR.Name = 'GoldFixa';
        Database.insert(userR);
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Representante'];
        User u = new User(Alias = 'SysAdmin', Email='stdstdteste@teste.com',
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                          LocaleSidKey='en_US', ProfileId = p.Id,UserRoleId = userR.Id,
                          TimeZoneSidKey='America/Sao_Paulo', UserName='stdteste@teste.com');
        Database.insert(u);
        System.runAs(u){

            Account account1 = DataFactory.createAccount();
            insert account1;

            //Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('EmailTrigger').getRecordTypeId();
            
            Case case1 = new Case();
            case1.RecordTypeId = [Select Id,SobjectType,Name From RecordType WHERE Name ='HDE - Acionamento E-mail' and SobjectType ='Case'  limit 1].Id;
            case1.Origin = 'HDE';
            case1.Subject = 'TestCase';
            //case1.Segment__c = 'Gold';
            case1.AccountId = account1.Id;
            case1.HDEOtherProducts__c = 'TV';
            insert case1;
            
            Task task1 = new Task();
            //task1.AccountId = account1.Id;
            task1.WhatId = case1.Id;
            task1.RecordTypeId = [Select Id,SobjectType,Name From RecordType WHERE Name ='HDE - Tarefa' and SobjectType ='Task'  limit 1].Id;
            task1.Subject = 'Cobrar Gerente';
            task1.View__c = 'CRI E-mail V';
            //task1.IsHDE__c = TRUE;
            //task1.RecordType.DeveloperName = 'HDETask';
            task1.Status = 'Aberto';
            insert task1;


        }

    }

    static testmethod void testPreventTaskDel(){

        User u = [SELECT id FROM User WHERE UserName = 'stdteste@teste.com' LIMIT 1];

        System.runAs(u){

            Task taskRecord = [SELECT Id FROM Task WHERE IsHDE__c = TRUE LIMIT 1];

            try{
                delete taskRecord;

            }catch(DMLexception e){
                system.assert(e.getMessage().contains('Você não tem permissão para excluir a tarefa'),'Você não tem permissão para excluir a tarefa');                       
            }
        }
    }
}