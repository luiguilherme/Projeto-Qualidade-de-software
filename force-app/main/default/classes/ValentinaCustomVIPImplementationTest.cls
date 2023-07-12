/*
 * Autor: Otávio Fonseca - Deloitte
 * Criado em: 24/03/2022
*/
@isTest
public class ValentinaCustomVIPImplementationTest {
    @TestSetup
    static void setup(){
        Account account = new Account(Name='Teste');
        Insert account;
        
        Order ord = new Order();
        ord.AccountId = account.Id;
        ord.EffectiveDate = Date.today();
        ord.Status = 'Draft';
        Insert ord;
        
        vlocity_cmt__OrchestrationPlan__c  orcPlan = new vlocity_cmt__OrchestrationPlan__c (
            vlocity_cmt__AccountId__c = account.Id,
            vlocity_cmt__OrderId__c  = ord.Id
        );
        Insert orcPlan;
        
        vlocity_cmt__ItemImplementation__c itemImp = new vlocity_cmt__ItemImplementation__c ();
        itemImp.Name = 'Teste';
        Insert itemImp;
        
        vlocity_cmt__OrchestrationPlanDefinition__c orcPlanDef = new vlocity_cmt__OrchestrationPlanDefinition__c ();
        Insert orcPlanDef;
        
        vlocity_cmt__OrchestrationItemDefinition__c orcItemDef = new vlocity_cmt__OrchestrationItemDefinition__c ();
        orcItemDef.vlocity_cmt__itemImplementationId__c = itemImp.Id;
        orcItemDef.vlocity_cmt__OrchestrationPlanDefinitionId__c = orcPlanDef.Id;
        Insert orcItemDef;
        
        vlocity_cmt__System__c sys = new vlocity_cmt__System__c(
            name = 'System Teste',
            vlocity_cmt__URL__c = 'www.teste.com.br'
        );
        Insert sys;
        
        vlocity_cmt__SystemInterface__c systemInterface = new vlocity_cmt__SystemInterface__c(
            name = 'SIGAN_UpdateMSISDN',
            vlocity_cmt__SystemId__c = sys.Id,
            vlocity_cmt__Implementation__c = 'ValentinaCustomVIPImplementation',
            vlocity_cmt__Path__c = 'val_CalloutSIGAN'
        );
        Insert systemInterface;
        
        vlocity_cmt__OrchestrationItem__c item = new vlocity_cmt__OrchestrationItem__c(
            name = 'OK',
            vlocity_cmt__OrchestrationPlanId__c = orcPlan.Id,
            vlocity_cmt__AttributesEncodingStyle__c = 'Structure',
            vlocity_cmt__EndOfSequence__c = true,
            vlocity_cmt__ItemImplementationId__c = itemImp.Id,
            vlocity_cmt__OrchestrationItemDefinitionId__c = orcItemDef.Id,
            vlocity_cmt__OrchestrationItemType__c = 'Callout',
            vlocity_cmt__OrchestrationPlanDefinitionId__c = orcPlanDef.Id,
            vlocity_cmt__Scope__c = 'Swimlane',
            vlocity_cmt__SystemInterfaceId__c = systemInterface.Id
        );
        Insert item;

        item = new vlocity_cmt__OrchestrationItem__c(
            name = 'NOK',
            vlocity_cmt__OrchestrationPlanId__c = orcPlan.Id,
            vlocity_cmt__AttributesEncodingStyle__c = 'Structure',
            vlocity_cmt__EndOfSequence__c = true,
            vlocity_cmt__ItemImplementationId__c = itemImp.Id,
            vlocity_cmt__OrchestrationItemDefinitionId__c = orcItemDef.Id,
            vlocity_cmt__OrchestrationItemType__c = 'Callout',
            vlocity_cmt__OrchestrationPlanDefinitionId__c = orcPlanDef.Id,
            vlocity_cmt__Scope__c = 'Swimlane',
            vlocity_cmt__SystemInterfaceId__c = systemInterface.Id
        );
        Insert item;        
    }

    @isTest
    public static void testExecuteItem(){
        String path = 'val_CalloutSIGAN';

        Map <String, Object> oInputs = new Map <String, Object> ();
        Map <String, Object> oOutputs = new Map <String, Object> ();

        vlocity_cmt__OrchestrationItem__c item = [SELECT Id, Name, vlocity_cmt__FulfilmentRequestLineId__c, vlocity_cmt__SystemInterfaceId__c FROM vlocity_cmt__OrchestrationItem__c WHERE Name = 'OK' LIMIT 1];

        oInputs.put('orchestration_item_id', item.Id);

        ValentinaCustomVIPImplementation c = new ValentinaCustomVIPImplementation();
        c.executeItem('', path, item);
    } 
    
    @isTest
    public static void testExecuteItemError(){
        String path = 'val_CalloutSIGAN';

        Map <String, Object> oInputs = new Map <String, Object> ();
        Map <String, Object> oOutputs = new Map <String, Object> ();

        vlocity_cmt__OrchestrationItem__c item = [SELECT Id, Name, vlocity_cmt__FulfilmentRequestLineId__c, vlocity_cmt__SystemInterfaceId__c FROM vlocity_cmt__OrchestrationItem__c WHERE Name = 'NOK' LIMIT 1];

        oInputs.put('orchestration_item_id', item.Id);

        try {
            ValentinaCustomVIPImplementation c = new ValentinaCustomVIPImplementation();
            c.executeItem('', path, item);
        } catch(Exception e) {
            System.debug('Exception testada com sucesso.');
        }
    }    
}