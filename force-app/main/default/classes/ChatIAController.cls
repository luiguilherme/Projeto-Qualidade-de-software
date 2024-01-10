public with sharing class ChatIAController {

    @AuraEnabled(cacheable=true)
    public static ChatIAHistoryVO.CreateNewChatResponse createNewChat(String chatList){
        System.debug('chatlist '+ chatList);
        try{
            ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
            String token = authentication.token;

            ChatIAHistoryVO.CreateNewChat fullChat = new ChatIAHistoryVO.CreateNewChat();
            ChatIAHistoryVO.Chat chat = new ChatIAHistoryVO.Chat();
            List<ChatIAHistoryVO.History> historyList = new List<ChatIAHistoryVO.History>();

            List<messageJSON> bodyToSend = (List<messageJSON>) JSON.deserialize(chatList, List<messageJSON>.class);
            for(messageJSON body : bodyToSend){
    
                ChatIAHistoryVO.History history = new ChatIAHistoryVO.History();
                history.type = body.mensagemUsuario == true ? 'user' : 'assistant';
                history.message = body.conteudoMensagem;
                history.x_id = '';
                historyList.add(history);
            }
            chat.history = historyList;
            chat.x_date = String.valueOf(System.today());
            chat.x_id = '';
            fullChat.chat = chat;
            ChatIAHistoryVO.CreateNewChatResponse retorno = ChatIAInterfaceAPI.CreateNewChat(fullChat, token);

            return retorno;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
    
    @AuraEnabled(cacheable=true)
    public static ChatIAHistoryVO.CreateNewChatResponse AddConversation(String chatList, String backupChat){
        System.debug('chatlist '+ chatList);
        try{
            ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
            String token = authentication.token;

            ChatIAHistoryVO.CreateNewChat fullChat = new ChatIAHistoryVO.CreateNewChat();
            ChatIAHistoryVO.Chat chat = new ChatIAHistoryVO.Chat();
            List<ChatIAHistoryVO.History> historyList = new List<ChatIAHistoryVO.History>();

            List<messageJSON> bodyToSend = (List<messageJSON>) JSON.deserialize(chatList, List<messageJSON>.class);
            for(messageJSON body : bodyToSend){
    
                ChatIAHistoryVO.History history = new ChatIAHistoryVO.History();
                history.type = body.mensagemUsuario == true ? 'user' : 'assistant';
                history.message = body.conteudoMensagem;
                history.x_id = '';
                historyList.add(history);
            }
            chat.history = historyList;
            chat.x_date = String.valueOf(System.today());
            chat.x_id = backupChat;
            fullChat.chat = chat;
            ChatIAHistoryVO.CreateNewChatResponse retorno = ChatIAInterfaceAPI.AddConversation(fullChat, token, backupChat);

            return retorno;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }

    @AuraEnabled(cacheable=true)
    public static ChatIAHistoryVO.GetHistoryByIdResponse getChatById(String backupChat){
        try {
            ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
            String token = authentication.token;
            ChatIAHistoryVO.GetHistoryByIdResponse retorno = ChatIAInterfaceAPI.GetHistoryById(token, backupChat);

            return retorno;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static Boolean deleteChatById(String backupChat){
        try {
            ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
            String token = authentication.token;
            Boolean retorno = ChatIAInterfaceAPI.DeleteChatById(token, backupChat);

            return retorno;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static ChatIAQNAAnswerVO.BodyToReceive getQNAAnswer(String question){
        try {
            ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
            String token = authentication.token;
            ChatIAQNAAnswerVO.BodyToReceive answerQNA = ChatIAInterfaceAPI.getQNAAnswer(question, token);

            return answerQNA;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, String> getSessionId(){
        Map<String, String> mapSessionId = new Map<String, String>();
        String userId = UserInfo.getUserId();
        String sessionId = null;
        String backupChat = null;
        String recordFound;
        List<ChatIA__c> chatIa = ChatIASelector.getInstance().getActiveChatIA(userId);
        if(!chatIa.isEmpty()){
            sessionId = chatIa[0].Session__c;
            backupChat = chatIa[0].Backup__c;
            recordFound = chatIa[0].Id;
        } else{
            sessionId = userId+String.valueOf(System.today().day())+String.valueOf(System.today().month())+String.valueOf(System.today().year())+String.valueOf(System.now().hour())+String.valueOf(System.now().minute())+String.valueOf(System.now().millisecond());
            recordFound = 'null';
        }
        
        mapSessionId.put(backupChat, recordFound);

        return mapSessionId;
    }   

    @AuraEnabled(cacheable=true)
    public static List<QuestionSuggestion> getQuestionSuggestion(){
        try {
            List<QuestionSuggestion> returnList = new List<QuestionSuggestion>();
            for(QuestionSuggestion__c qs : ChatIASelector.getInstance().getQuestionSuggestion()){
                QuestionSuggestion returnQS = new QuestionSuggestion();
                returnQS.question = qs.Question__c;
                returnQS.order = Integer.valueOf(qs.Order__c);
                returnList.add(returnQS);
            }
            if(returnList.isEmpty() || returnList.size() < 3){
                Integer quantityNeeded = 3 - returnList.size();
                for(StandardQuestionSuggestion__mdt sqs : ChatIASelector.getInstance().getStandardQuestionSuggestion(quantityNeeded)){
                    QuestionSuggestion returnQS = new QuestionSuggestion();
                    returnQS.question = sqs.Question__c;
                    returnQS.order = Integer.valueOf(sqs.Order__c);
                    returnList.add(returnQS);
                }
            }
            return returnList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class QuestionSuggestion {
        @AuraEnabled public String question; 
        @AuraEnabled public Integer order; 
    }

    public class messageJSON {
        @AuraEnabled public Boolean mensagemUsuario; 
        @AuraEnabled public String conteudoMensagem; 
    }
}