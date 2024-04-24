@isTest
public with sharing class ScheduleDeleteChatIATest {
    
	@testSetup static void setup(){
        List<ChatIA__c> listaChatIA = new List<ChatIA__c>();
        for(Integer contador = 0; contador < 2; contador++) {
            ChatIA__c chatIA = new ChatIA__c (
                Usuario__c = UserInfo.getUserId(),
                Backup__c = 'teste ' + contador
            );
            listaChatIA.add(chatIA);
        }
        insert listaChatIA;
    }
    @isTest static void testExclusaoDe1RegistroDoChatIA() {
    Datetime momentoExecucao = System.now().addMinutes(1);
    String expressaoCRON = '' + momentoExecucao.second() + ' ' + momentoExecucao.minute() + ' ' + momentoExecucao.hour() + ' ' + momentoExecucao.day() + ' ' + momentoExecucao.month() + ' ? ' + momentoExecucao.year();
    List<ChatIA__c> listaChatIA = [
            SELECT Id 
            FROM ChatIA__c
            WHERE Usuario__c =: UserInfo.getUserId()
        ];
        Datetime startDate = System.now().addMonths(-1);
        Datetime endDate = System.now().addDays(-1);
        Integer numberLimit = 10000;
        String jobId = System.schedule('Delete chatIA ' + expressaoCRON , expressaoCRON, new ScheduleDeleteChatIA(startDate,endDate, numberLimit));
        Assert.areEqual(listaChatIA.size(), 2);
    }
}