public with sharing class ChatIAController {

    @AuraEnabled(cacheable=true)
    public static ChatIAFeedbackVO.FeedbackResponse sendFeedback(String correlator, String feedback, String message) {
    ChatIAFeedbackVO.FeedbackResponse retorno = new ChatIAFeedbackVO.FeedbackResponse();
    try {
            ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
            String token = authentication.token;
            ChatIAFeedbackVO.Feedback feedbackBody = new ChatIAFeedbackVO.Feedback();
            feedbackBody.correlator = correlator;
            feedbackBody.feedback = feedback;
            feedbackBody.message = message;
            retorno = ChatIAInterfaceAPI.sendFeedback(feedbackBody, token);
        } catch (Exception e) {
            retorno.response = false;
            retorno.message = 'Erro ao enviar feedback: ' + e.getMessage();
        }
        return retorno;
    }

    @AuraEnabled(cacheable=true)
    public static ChatIAHistoryVO.GetHistoryByIdResponse getChatById() {
    try {
            ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
            String token = authentication.token;
            ChatIAHistoryVO.GetHistoryByIdResponse retorno = ChatIAInterfaceAPI.GetHistoryById(token);
            return retorno;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static ChatIAHistoryVO.DeleteChatByIdResponse deleteChatById(){
        try {
            ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
            String token = authentication.token;
            ChatIAHistoryVO.DeleteChatByIdResponse retorno = ChatIAInterfaceAPI.DeleteChatById(token);
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
    @AuraEnabled(cacheable=false)
    public static InfoQNA getIntegracaoQNA(){
        InfoQNA infoIntegracao = new InfoQNA();
        ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
        String token = authentication.token;
        User user = ChatIASelector.getInstance().getUser(UserInfo.getUserId());
        ChatIASubscriptionId__c subscription = ChatIASubscriptionId__c.getValues('SubscriptionId');
        String login = user.Login__c != null ? user.Login__c : user.Id;
        String email = user.Email != null ? user.Email : '';
        String name = user.Name != null ? user.Name : '';
        String profile = user.Profile.Name != null? user.Profile.Name : '';
        infoIntegracao.header_subscriptionId = subscription.SubscriptionId__c;
        infoIntegracao.header_token = token;
        infoIntegracao.header_userId = login;
        infoIntegracao.header_userEmail = email;
        infoIntegracao.header_userName = name;
        infoIntegracao.header_userProfile = profile;
        infoIntegracao.header_Origin = 'SFA';
        infoIntegracao.header_UserAgent = 'Mozilla';
        infoIntegracao.header_service = 'QNA_MOBILE_PRODUCTS';
        infoIntegracao.header_ContentType = 'application/json';
        infoIntegracao.header_sessionId = 'Salesforce';
        infoIntegracao.endpoint_qna = 'https://ai-br-pro.telefonicabigdata.com/qna/stream/';
        return infoIntegracao;
    } 
     @AuraEnabled(cacheable=false)
    public static InfoQNA getIntegracaoSuggestions(){
        InfoQNA infoIntegracao = new InfoQNA();
        ChatIAAuthenticationVO.BodyToReceive authentication = ChatIAInterfaceAPI.getAuthentication();
        String token = authentication.token;
        User user = ChatIASelector.getInstance().getUser(UserInfo.getUserId());
        ChatIASubscriptionId__c subscription = ChatIASubscriptionId__c.getValues('SubscriptionId');
        String login = user.Login__c != null ? user.Login__c : user.Id;
        String email = user.Email != null ? user.Email : '';
        String name = user.Name != null ? user.Name : '';
        String profile = user.Profile.Name != null? user.Profile.Name : '';
        infoIntegracao.header_subscriptionId = subscription.SubscriptionId__c;
        infoIntegracao.header_token = token;
        infoIntegracao.header_userId = login;
        infoIntegracao.header_UserAgent = 'Mozilla';
        infoIntegracao.header_service = 'QNA_MOBILE_PRODUCTS';
        infoIntegracao.header_ContentType = 'application/json';
        infoIntegracao.header_sessionId = 'Salesforce';
        infoIntegracao.endpoint_qna = 'https://ai-br-pro.telefonicabigdata.com/questions/suggestions/'+subscription.SubscriptionId__c+'/';
        return infoIntegracao;
    }   
    @AuraEnabled(cacheable=false)
    public static Config getConfig(){
        Config settings = new Config();
        ChatIAConfiguracao__c chatIAConfig = ChatIAConfiguracao__c.getValues('PerguntasFrequentes');
        settings.letters = chatIAConfig.Caracteres__c;
        settings.words = chatIAConfig.Palavras__c;
        settings.quantify = chatIAConfig.Quantidade__c;
        return settings;
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
    public class Config {
        @AuraEnabled public Boolean words; 
        @AuraEnabled public Boolean letters; 
        @AuraEnabled public Decimal quantify; 
    }
    public class MessageJSON {
        @AuraEnabled public Boolean mensagemUsuario; 
        @AuraEnabled public String conteudoMensagem; 
        @AuraEnabled public String correlator;
    }
    public class InfoQNA {
        @AuraEnabled public String endpoint_qna;
        @AuraEnabled public String header_userId;
        @AuraEnabled public String header_token;
        @AuraEnabled public String header_subscriptionId; 
        @AuraEnabled public String header_userName;
        @AuraEnabled public String header_userEmail; 
        @AuraEnabled public String header_service;
        @AuraEnabled public String header_sessionId;
        @AuraEnabled public String header_userProfile;
        @AuraEnabled public String header_UserAgent;
        @AuraEnabled public String header_Origin;
        @AuraEnabled public String header_ContentType;
    }
}