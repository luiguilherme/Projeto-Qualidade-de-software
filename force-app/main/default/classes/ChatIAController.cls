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
                if(body.mensagemUsuario == false){
                    history.correlator = body.correlator;
                }
                history.x_id = '';
                historyList.add(history);
            }
            chat.history = historyList;
            chat.x_date = String.valueOf(System.today());
            chat.x_id = '';
            fullChat.chat = chat;
            ChatIAHistoryVO.CreateNewChatResponse retorno = ChatIAInterfaceAPI.CreateNewChat(fullChat, token);
            System.debug(' retorno' + retorno );
            if(retorno == null){
                retorno = createNewHistory(chatList);
            }
            return retorno;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
    @AuraEnabled
    public static ChatIAHistoryVO.CreateNewChatResponse createNewHistory(String chatList){
        try{
            ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
            String token = authentication.token;

            ChatIAHistoryVO.CreateNewHistory fullChat = new ChatIAHistoryVO.CreateNewHistory();
            ChatIAHistoryVO.ChatHistory chat = new ChatIAHistoryVO.ChatHistory();
            List<ChatIAHistoryVO.ChatHistory> listChat = new List<ChatIAHistoryVO.ChatHistory>();
            List<ChatIAHistoryVO.NewHistory> historyList = new List<ChatIAHistoryVO.NewHistory>();

            List<messageJSON> bodyToSend = (List<messageJSON>) JSON.deserialize(chatList, List<messageJSON>.class);
            for(messageJSON body : bodyToSend){
    
                ChatIAHistoryVO.NewHistory history = new ChatIAHistoryVO.NewHistory();
                history.type = body.mensagemUsuario == true ? 'user' : 'assistant';
                history.message = body.conteudoMensagem;
                if(body.mensagemUsuario == false){
                    history.correlator = body.correlator;
                }
                historyList.add(history);
            }
            chat.history = historyList;
            chat.x_date = String.valueOf(System.today());
            listChat.add(chat);
            fullChat.chats = listChat;
            ChatIAHistoryVO.CreateNewHistoryResponse retorno = ChatIAInterfaceAPI.CreateNewHistory(fullChat, token);
            ChatIAHistoryVO.CreateNewChatResponse newCreateChat = retorno.chats[0];
            return newCreateChat;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        
    }
    @AuraEnabled(cacheable=true)
    public static ChatIAHistoryVO.CreateNewChatResponse AddConversation(String chatList, String backupChat){
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
                if(body.mensagemUsuario == false){
                    history.correlator = body.correlator;
                }
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
    public static ChatIAHistoryVO.CreateNewChatResponse updateFeedback(String correlator, String feedback, String chatId){
        try {
            ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
            String token = authentication.token;
            ChatIAHistoryVO.Feedback feedbackBody = new ChatIAHistoryVO.Feedback();
            feedbackBody.correlator = correlator;
            feedbackBody.feedback = feedback;
            ChatIAHistoryVO.CreateNewChatResponse retorno = ChatIAInterfaceAPI.UpdateFeedback(feedbackBody, token, chatId);
            return retorno;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static ChatIAFeedbackVO.FeedbackResponse sendFeedback(String correlator, String feedback, String message){
        try {
            ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
            String token = authentication.token;
            ChatIAFeedbackVO.Feedback feedbackBody = new ChatIAFeedbackVO.Feedback();
            feedbackBody.correlator = correlator;
            feedbackBody.feedback = feedback;
            feedbackBody.message = message;
            ChatIAFeedbackVO.FeedbackResponse retorno = ChatIAInterfaceAPI.sendFeedback(feedbackBody, token);
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
    public static Boolean getPermission(){
        try {
            String idUser = UserInfo.getUserId();
            List<PermissionSetAssignment> permission = ChatIASelector.getInstance().getPermission(idUser);
            Boolean active = FeatureFlagService.applicationIsActive('ChatIA');
            if(permission.size() > 0 && active){
                return true;
            }
            return false;
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

    @AuraEnabled(cacheable=false)
    public static InfoChatIA getSessionId(){
        InfoChatIA info = new InfoChatIA();
        String userId = UserInfo.getUserId();
        List<ChatIA__c> chatIa = ChatIASelector.getInstance().getLastChatIA(userId);
        if(!chatIa.isEmpty()){
            if(chatIa[0].History__c && chatIa[0].Active__c){
                info.active = chatIa[0].Active__c ? 'ok':'null' ;
                info.history = chatIa[0].History__c ? 'ok':'null';
                info.backupChat = chatIa[0].Backup__c;
                info.recordFound = chatIa[0].Id;
            }
            else if(!chatIa[0].History__c && chatIa[0].Active__c){
                info.recordFound = 'null';
                info.history = 'null';
            }
            else if(chatIa[0].History__c && !chatIa[0].Active__c){
                info.recordFound = 'null';
                info.history = 'ok';
            } else{
                info.recordFound = 'null';
                info.history = 'null';
            }
        } 
        else{
            info.recordFound = 'null';
            info.history = 'null';
        }
        return info;
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
        @AuraEnabled public String correlator;
    }
    public class InfoChatIA{
        @AuraEnabled public String active;
        @AuraEnabled public String history;
        @AuraEnabled public String backupChat; 
        @AuraEnabled public String recordFound;
    }
}