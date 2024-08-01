/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ChatAppVivoControllerTest
{
    @TestSetup
    static void makeData()
    {
        Case newCase = new Case();
        newCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(CasesMyRequestsB2C.CHARGE_OF_ADDRESS_RECORD_TYPE_API_NAME).getrecordTypeId();
        insert newCase;

        CaseComment__c newCaseComment = new CaseComment__c();
        newCaseComment.ParentId__c = newCase.Id;
        newCaseComment.Comment__c = 'Teste';
        insert newCaseComment;       
    }

    @isTest
    static void getChatHistoryByCaseIdTest()
    {
        Case newCase = [SELECT Id FROM Case LIMIT 1];
        List<ChatMessage> chatHistory = ChatAppVivoController.getChatMessagesByCaseId(newCase.Id);

        System.assertEquals(1, chatHistory.size());
    }

    @isTest
    static void getChatHistoryByCaseIdFailTest()
    {
        try
        {
            List<ChatMessage> chatHistory = ChatAppVivoController.getChatMessagesByCaseId(null);
        }
        catch (Exception e)
        {
            Assert.isNotNull(e.getMessage());
        }
    }

    @isTest
    static void newChatMessageTest()
    {
        Case newCase = [SELECT Id FROM Case LIMIT 1];
        String newMessage = 'Teste';
        ChatMessage messageResponse = ChatAppVivoController.newChatMessage(newCase.Id, newMessage);

        System.assertEquals(newMessage, messageResponse.message);
    }

    @isTest
    static void newChatMessageFailTest()
    {
        try
        {
            String newMessage = 'Teste';
            ChatMessage messageResponse = ChatAppVivoController.newChatMessage(null, newMessage);
        }
        catch (Exception e)
        {
            Assert.isNotNull(e.getMessage());
        }
    }
}