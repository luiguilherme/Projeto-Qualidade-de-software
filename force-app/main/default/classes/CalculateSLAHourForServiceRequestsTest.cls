@Istest
public class CalculateSLAHourForServiceRequestsTest {
    
        @Istest
        private static void myTest(){
            User lUserGN = [SELECT Id, Name, Profile.Name  FROM User WHERE Profile.Name like '%admin%'and IsActive = true limit 1];
            system.debug(lUserGN);
           
            Account lAccount = new Account();
            lAccount.Name='teste2';
            System.runAs(new User(Id = UserInfo.getUserId())){insert lAccount;}
         
            
            Opportunity oppRecord = new Opportunity();
           
            oppRecord.AccountId = lAccount.Id;
            oppRecord.Name = 'TEST';
            oppRecord.CloseDate = System.today()+10;
            
            oppRecord.OwnerId = lUserGN.Id;
          
            oppRecord.StageName = 'F6 - Pre-Oportunidade';
            system.runAs(lUserGN) { database.insert(oppRecord); }
            
            Test.startTest();
            oppRecord.StageName = 'F4 - Desenvolvimento da Oferta';
            System.runAs(new User(Id = UserInfo.getUserId())){Database.update(oppRecord);}

            Quote quoteRecord = new Quote();
            quoteRecord.Name = 'TesteQuoteChatter';
            quoteRecord.OpportunityId = oppRecord.Id;
         //   quoteRecord.SpecialProject__c = false;
            quoteRecord.OwnerId = lUserGN.Id;
           // quoteRecord.Def_Overall_RC_with_Tax__c = 99999.91;
            //quoteRecord.RecordTypeId = RecordTypeUtil.getByDevName('Quote', 'Cotacao_Venda_Nova_Esteira_Luiza');
            quoteRecord.Status = 'Draft';
          //  quoteRecord.NC_ID_Quote__c = 'ef5109e5-73ac-460b-9707-50421f3d9de2';
            quoteRecord.Pricebook2Id = Test.getStandardPricebookId();
            System.runAs(lUserGN) { database.insert(quoteRecord); }
            
            /////
            Product2 produto = new Product2();
            produto.Name = 'Teste produto';
            produto.ProductCode = '123';
            produto.IsActive = true;
            produto.Family = 'TV';
           // produto.WalletGrouping__c = 'BasicFixed';
            System.runAs(new User(Id = UserInfo.getUserId())){insert produto;}

            PricebookEntry priceBookE = new PricebookEntry();
            priceBookE.Product2Id = produto.Id;
            priceBookE.UnitPrice = 30;
            priceBookE.Pricebook2Id = Test.getStandardPricebookId();
            priceBookE.UseStandardPrice = false;
            priceBookE.IsActive = true;
            System.runAs(new User(Id = UserInfo.getUserId())){insert priceBookE;}

            QuoteLineItem quoteLine = new QuoteLineItem();
            quoteLine.QuoteId = quoteRecord.id;
            quoteLine.Quantity = 2;
            quoteLine.UnitPrice = 30;
            quoteLine.PricebookEntryId = priceBookE.Id;
            quoteLine.Product2Id = produto.Id;
            System.runAs(new User(Id = UserInfo.getUserId())){insert quoteLine;}
            
            ////
            ParameterSLA__c lParameter= new ParameterSLA__c();
            lParameter.Logic__c= '( 1 OR 2 ) AND 3	';
            lParameter.Value__c='InProgress';
            lParameter.hours__c= 2;
            lParameter.Name= 'Regra SLA';
            lParameter.Active__c= true;
            lParameter.fieldAPI__c ='Status__c';
           // lParameter.caseRecordType__c= 'EngineeringDrive';
            lParameter.RecordTypeId= RecordTypeUtil.getByDevName('ParameterSLA__c', 'Rule');
            
            System.runAs(new User(Id = UserInfo.getUserId())){ Database.insert(lParameter);}
            
            ParameterSLA__c lCriterio1= generateCriteria('Criterio 1', 'Status__c', lAccount.Id, lParameter.Id);
            System.runAs(new User(Id = UserInfo.getUserId())){ Database.insert(new List<ParameterSLA__c>{lCriterio1});}
       BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault = true LIMIT 1];
            ServiceRequest__c sr = new ServiceRequest__c();
            //sr.RecordTypeId = RecordTypeUtil.getByDevName('ServiceRequest__c', 'EngineeringDrive');
            sr.BusinessHoursId__c=bh.id;
         	//sr.status__c='NotStarted';
            System.runAs(new User(Id = UserInfo.getUserId())){insert sr;}
  sr.status__c='InProgress';
            sr.OwnerId = lUserGN.Id;//UserInfo.getUserId();
            System.runAs(new User(Id = UserInfo.getUserId())){ update sr;}
            system.debug(sr);
        
            CalculateSLAHourForServiceRequests.execute(new list<ServiceRequest__c>{ sr});
            Test.stopTest();
            List<ServiceRequest__c> lstService= [SELECT Id, DueDate__c FROM ServiceRequest__c WHERE Id =: sr.Id AND DueDate__c != null ];
            //System.assert(!lstService.isEmpty(), 'O DueDate__c da requisição de serviço deveria ter sido preenchido com a hora útil.');
            
        }
        
        private static ParameterSLA__c generateCriteria(String aName, String aField, String aValue, Id aRule){
            ParameterSLA__c lCriteria= new ParameterSLA__c();
            lCriteria.Name= aName;
            lCriteria.Active__c= true;
            lCriteria.fieldAPI__c= aField;
            lCriteria.Value__c= aValue;
            lCriteria.Rule__c= aRule;
            lCriteria.RecordTypeId= RecordTypeUtil.getByDevName('ParameterSLA__c', 'Criteria');
            return lCriteria;
        }
        
    }