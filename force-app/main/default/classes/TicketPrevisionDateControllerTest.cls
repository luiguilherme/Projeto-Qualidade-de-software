@isTest
public class TicketPrevisionDateControllerTest {

    @TestSetup
    static void setup(){

        Account lAccount = DataFactory.createAccount();
        lAccount.userid__c = 'userId';
        insert lAccount;

        Ticket__c lTicket = DataFactory.createTicketHistory(lAccount.Id);  
        lTicket.Status__c = 'OPEN';
        lticket.TicketId__c = '8-A89554267D-1';
        system.debug(lTicket);
        insert lTicket;
        
        insert new Webservice__c(
            Name = 'WFMSearchByWorkOrderCallout',
            Endpoint__c  = 'https://api-hml.telefonica.com.br/search-by-workorder/v1',
            SubscriptionKey__c = '36cfd2713668489bb3f7d23d042be3a3',
            switchedOn__c = true
        );
        
        WebServiceTestFactory.start().authOAuthProvider().create();
        
    }

    @isTest
    static void getTicketPrevisionDateTrue(){
        Ticket__c lTicket = [ SELECT Id FROM Ticket__c LIMIT 1];
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TicketPrevisionDateCalloutMock());
        String response = TicketPrevisionDateController.getTicketPrevisionDate(lTicket.Id);
        System.assertEquals('200', response);
        Test.stopTest();        
    }
    
    @isTest
    static void getTicketPrevisionDateWsConfigOff(){
        Ticket__c lTicket = [ SELECT Id FROM Ticket__c LIMIT 1];
        
        Webservice__c web = [ SELECT Id, switchedOn__c FROM Webservice__c limit 1];
        
        web.switchedOn__c = false;
        update web;
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TicketPrevisionDateCalloutMock());
        String response = TicketPrevisionDateController.getTicketPrevisionDate(lTicket.Id);
        System.assertEquals('', response);
        Test.stopTest();
    }
    
    @isTest
    static void getTicketPrevisionDateTicketNull(){
        Ticket__c lTicket = [ SELECT Id FROM Ticket__c LIMIT 1];
        
        lTicket.TicketId__c = null;
        update lTicket;
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new TicketPrevisionDateCalloutMock());
        String response = TicketPrevisionDateController.getTicketPrevisionDate(lTicket.Id);
        System.assertEquals('', response);
        Test.stopTest();
    }

}