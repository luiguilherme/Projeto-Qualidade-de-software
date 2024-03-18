public with sharing class ChatIAInterfaceAPI {
   
    public static ChatIAAuthenticationVO.BodyToReceive getAuthentication(){
        try{
            ChatIAAuthenticationVO.BodyToReceive retorno = new ChatIAAuthenticationVO.BodyToReceive();

            ChatIAAuthenticationVO.Auth body = new ChatIAAuthenticationVO.Auth();
            body.token = '1554b0a0ccf7e7f0e9797543def1850d';
            
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ai-br-pro.telefonicabigdata.com/auth');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('User-Agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36');
            req.setHeader('Accept-Language', 'en-US,en;q=0.9,pt;q=0.8');
            req.setMethod('POST');
            req.setTimeout(120000);
            req.setBody(JSON.serialize(body));
            Http http = new Http();
            HTTPResponse res = new Http().send(req);
            
            System.debug('body => ' + JSON.serialize(body));
            System.debug('response => ' + res.getBody());

            if(res.getStatusCode() >= 200 && res.getStatusCode() <= 202){
                retorno = (ChatIAAuthenticationVO.BodyToReceive)  System.JSON.deserialize(res.getBody(), ChatIAAuthenticationVO.BodyToReceive.class);
                System.debug('retorno => '+ retorno);
            }
            return retorno;
        } catch(JSONException ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw new AuraHandledException('Erro ao consultar dados, procure seu administrador. Código 400');
        } catch(Exception ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw ex;
        }
    }

    public static ChatIAQNAAnswerVO.BodyToReceive getQNAAnswer(String question, String token){
        try{
            ChatIAQNAAnswerVO.BodyToReceive retorno = new ChatIAQNAAnswerVO.BodyToReceive();
            ChatIASubscriptionId__c subscription = ChatIASubscriptionId__c.getValues('SubscriptionId');
            User user = ChatIASelector.getInstance().getUser(UserInfo.getUserId());
            String login = user.Login__c != null ? user.Login__c : user.Id;
            String email = user.Email != null ? user.Email : '';
            String name = user.Name != null ? user.Name : '';
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ai-br-pro.telefonicabigdata.com/qna-mobile-products/?question=' + question);
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('session_id', '123456');
            req.setHeader('user_id', login);
            req.setHeader('user_name', name);
            req.setHeader('user_email', email);
            req.setHeader('token', token);
            req.setHeader('service', 'QNA_MOBILE_PRODUCTS');
            req.setHeader('subscription_id', subscription.SubscriptionId__c);
            req.setHeader('User-Agent', 'Mozilla');
            req.setHeader('Origin', 'SFA');
            req.setMethod('GET');
            req.setTimeout(120000);
            Http http = new Http();
            HTTPResponse res = new Http().send(req);
            
            System.debug('response => ' + res.getBody());

            if(res.getStatusCode() >= 200 && res.getStatusCode() <= 202){
                retorno = (ChatIAQNAAnswerVO.BodyToReceive)  System.JSON.deserialize(res.getBody(), ChatIAQNAAnswerVO.BodyToReceive.class);
                System.debug('retorno => '+ retorno);
            }
            return retorno;
        } catch(JSONException ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw new AuraHandledException('Erro ao consultar dados, procure seu administrador. Código 400');
        } catch(Exception ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw ex;
        }
    }

    public static ChatIAHistoryVO.CreateNewChatResponse CreateNewChat(ChatIAHistoryVO.CreateNewChat body, String token){
        try{
            String bodyToSend = JSON.serialize(body);
            bodyToSend = bodyToSend.replace('x_date', 'date');
            bodyToSend = bodyToSend.replace('x_id', '_id');
            ChatIAHistoryVO.CreateNewChatResponse retorno = new ChatIAHistoryVO.CreateNewChatResponse();
            ChatIASubscriptionId__c subscription = ChatIASubscriptionId__c.getValues('SubscriptionId');
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ai-br-pro.telefonicabigdata.com/flow/chat/12345');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('user_id', UserInfo.getUserId());
            req.setHeader('token', token);
            req.setHeader('session_id', '123456');
            req.setHeader('subscription_id', subscription.SubscriptionId__c);
            req.setHeader('_id', '123456');
            req.setHeader('User-Agent', 'Mozilla');
            req.setMethod('PUT');
            req.setTimeout(120000);
            req.setBody(bodyToSend);
            Http http = new Http();
            HTTPResponse res = new Http().send(req);
            
            System.debug('request => ' + bodyToSend);
            System.debug('response => ' + res.getBody());

            if(res.getStatusCode() >= 200 && res.getStatusCode() <= 202){
                String response = res.getBody();
                response = response.replace('_id', 'x_id');
                response = response.replace('date', 'x_date');
                System.debug('retorno => '+ retorno);
                retorno = (ChatIAHistoryVO.CreateNewChatResponse)  System.JSON.deserialize(response, ChatIAHistoryVO.CreateNewChatResponse.class);
            }
            else {
                if(res.getBody().contains('CHAT_DOESNT_EXISTS')){
                    return null;
                }
            }
            return retorno;
        } catch(JSONException ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw new AuraHandledException('Erro ao consultar dados, procure seu administrador. Código 400');
        } catch(Exception ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw ex;
        }
    }
    public static ChatIAHistoryVO.CreateNewChatResponse UpdateFeedback(ChatIAHistoryVO.Feedback body, String token, String chatId){
        try{
            String bodyToSend = JSON.serialize(body);
            ChatIAHistoryVO.CreateNewChatResponse retorno = new ChatIAHistoryVO.CreateNewChatResponse();
            ChatIASubscriptionId__c subscription = ChatIASubscriptionId__c.getValues('SubscriptionId');
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ai-br-pro.telefonicabigdata.com/flow/chat/feedback/12345');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('user_id', UserInfo.getUserId());
            req.setHeader('token', token);
            req.setHeader('session_id', '132456');
            req.setHeader('subscription_id', subscription.SubscriptionId__c);
            req.setHeader('_id', chatId);
            req.setHeader('User-Agent', 'Mozilla');
            req.setMethod('PUT');
            req.setTimeout(120000);
            req.setBody(bodyToSend);
            Http http = new Http();
            HTTPResponse res = new Http().send(req);
            
            System.debug('request => ' + bodyToSend);
            System.debug('response => ' + res.getBody());

            if(res.getStatusCode() >= 200 && res.getStatusCode() <= 202){
                String response = res.getBody();
                response = response.replace('_id', 'x_id');
                response = response.replace('date', 'x_date');

                retorno = (ChatIAHistoryVO.CreateNewChatResponse)  System.JSON.deserialize(response, ChatIAHistoryVO.CreateNewChatResponse.class);
                System.debug('retorno => '+ retorno);
            }
            return retorno;
        } catch(JSONException ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw new AuraHandledException('Erro ao consultar dados, procure seu administrador. Código 400');
        } catch(Exception ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw ex;
        }
    }
    public static ChatIAFeedbackVO.FeedbackResponse sendFeedback(ChatIAFeedbackVO.Feedback body, String token){
        try{
            String bodyToSend = JSON.serialize(body);
            User user = ChatIASelector.getInstance().getUser(UserInfo.getUserId());
            String login = user.Login__c != null ? user.Login__c : user.Id;
            ChatIAFeedbackVO.FeedbackResponse retorno = new ChatIAFeedbackVO.FeedbackResponse();
            ChatIASubscriptionId__c subscription = ChatIASubscriptionId__c.getValues('SubscriptionId');
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ai-br-pro.telefonicabigdata.com/v1/feedback');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('user_id', login);
            req.setHeader('token', token);
            req.setHeader('session_id', '132456');
            req.setHeader('subscription_id', subscription.SubscriptionId__c);
            req.setHeader('service', 'QNA_MOBILE_PRODUCTS');
            req.setHeader('User-Agent', 'Mozilla');
            req.setMethod('POST');
            req.setTimeout(120000);
            req.setBody(bodyToSend);
            Http http = new Http();
            HTTPResponse res = new Http().send(req);
            if(res.getStatusCode() >= 200 && res.getStatusCode() <= 202){
                String response = res.getBody();
                retorno = (ChatIAFeedbackVO.FeedbackResponse)  System.JSON.deserialize(response, ChatIAFeedbackVO.FeedbackResponse.class);
                System.debug('retorno => '+ retorno);
            }
            return retorno;
        }catch(JSONException ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw new AuraHandledException('Erro ao consultar dados, procure seu administrador. Código 400');
        } catch(Exception ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw ex;
        }
    }
    public static ChatIAHistoryVO.CreateNewChatResponse AddConversation(ChatIAHistoryVO.CreateNewChat body, String token, String idChat){
        try{
            String flow_id = '12345';
            if(Test.isRunningTest()){
                flow_id = 'TESTE';
            }
            String bodyToSend = JSON.serialize(body);
            bodyToSend = bodyToSend.replace('x_date', 'date');
            bodyToSend = bodyToSend.replace('x_id', '_id');
            ChatIAHistoryVO.CreateNewChatResponse retorno = new ChatIAHistoryVO.CreateNewChatResponse();
            ChatIASubscriptionId__c subscription = ChatIASubscriptionId__c.getValues('SubscriptionId');

            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ai-br-pro.telefonicabigdata.com/flow/chat/'+ flow_Id);
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('user_id', UserInfo.getUserId());
            req.setHeader('token', token);
            req.setHeader('session_id', '123456');
            req.setHeader('subscription_id', subscription.SubscriptionId__c);
            req.setHeader('_id', idChat);
            req.setHeader('User-Agent', 'Mozilla');
            req.setMethod('PUT');
            req.setTimeout(120000);
            req.setBody(bodyToSend);
            Http http = new Http();
            HTTPResponse res = new Http().send(req);
            
            System.debug('request => ' + bodyToSend);
            System.debug('response => ' + res.getBody());

            if(res.getStatusCode() >= 200 && res.getStatusCode() <= 202){
                String response = res.getBody();
                response = response.replace('_id', 'x_id');
                response = response.replace('date', 'x_date');

                retorno = (ChatIAHistoryVO.CreateNewChatResponse)  System.JSON.deserialize(response, ChatIAHistoryVO.CreateNewChatResponse.class);
                System.debug('retorno => '+ retorno);
            }
            return retorno;
        } catch(JSONException ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw new AuraHandledException('Erro ao consultar dados, procure seu administrador. Código 400');
        } catch(Exception ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw ex;
        }
    }

    public static ChatIAHistoryVO.GetHistoryByIdResponse GetHistoryById(String token, String chatId){
        try{
            ChatIAHistoryVO.GetHistoryByIdResponse retorno = new ChatIAHistoryVO.GetHistoryByIdResponse();
            ChatIASubscriptionId__c subscription = ChatIASubscriptionId__c.getValues('SubscriptionId');

            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ai-br-pro.telefonicabigdata.com/flow/chat/12345');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('user_id', UserInfo.getUserId());
            req.setHeader('token', token);
            req.setHeader('session_id', '123456');
            req.setHeader('subscription_id', subscription.SubscriptionId__c);
            req.setHeader('flow_id', '12345');
            System.debug('chatId ' + chatId);
            req.setHeader('_id', chatId);
            req.setHeader('User-Agent', 'Mozilla');
            req.setMethod('GET');
            req.setTimeout(120000);
            Http http = new Http();
            HTTPResponse res = new Http().send(req);
            System.debug('request => ' + req);
            System.debug('response => ' + res.getBody());

            if(res.getStatusCode() >= 200 && res.getStatusCode() <= 202){
                String response = res.getBody();
                response = response.replace('_id', 'x_id');
                response = response.replace('date', 'x_date');

                retorno = (ChatIAHistoryVO.GetHistoryByIdResponse)  System.JSON.deserialize(response, ChatIAHistoryVO.GetHistoryByIdResponse.class);
                retorno.chatFound = true;
                System.debug('retorno => '+ retorno);
            } else{
                if(res.getBody().contains('CHAT_DOESNT_EXISTS')){
                    retorno.chatFound = false;
                }
            }
            return retorno;
        } catch(JSONException ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw new AuraHandledException('Erro ao consultar dados, procure seu administrador. Código 400');
        } catch(Exception ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw ex;
        }
    }

    public static Boolean DeleteChatById(String token, String chatId){
        try{
            Boolean retorno = false;
            ChatIASubscriptionId__c subscription = ChatIASubscriptionId__c.getValues('SubscriptionId');

            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ai-br-pro.telefonicabigdata.com/flow/chat/12345');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('subscription_id', subscription.SubscriptionId__c);
            req.setHeader('token', token);
            req.setHeader('user_id', UserInfo.getUserId());
            req.setHeader('session_id', '123456');
            req.setHeader('chat_id', chatId);
            req.setHeader('User-Agent', 'Mozilla');
            req.setMethod('DELETE');
            req.setTimeout(120000);
            Http http = new Http();
            HTTPResponse res = new Http().send(req);
            
            System.debug('response => ' + res.getBody());

            if(res.getStatusCode() >= 200 && res.getStatusCode() <= 204){
                retorno = true;
                System.debug('retorno => '+ retorno);
            } 
            return retorno;
        } catch(JSONException ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw new AuraHandledException('Erro ao consultar dados, procure seu administrador. Código 400');
        } catch(Exception ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw ex;
        }
    }

    /**
    * Date: 18-01-2024
    * Author: nicholas.cinto@everymind.com.br
    * Description: Criação de novo método para geração do histórico por usuário
    */
    public static ChatIAHistoryVO.CreateNewHistoryResponse CreateNewHistory(ChatIAHistoryVO.CreateNewHistory body, String token){
        try{
            String bodyToSend = JSON.serialize(body);
            bodyToSend = bodyToSend.replace('x_date', 'date');
            bodyToSend = bodyToSend.replace('x_id', '_id');
            ChatIAHistoryVO.CreateNewHistoryResponse retorno = new ChatIAHistoryVO.CreateNewHistoryResponse();
            ChatIASubscriptionId__c subscription = ChatIASubscriptionId__c.getValues('SubscriptionId');

            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ai-br-pro.telefonicabigdata.com/flow/chat/12345');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('user_id', UserInfo.getUserId());
            req.setHeader('token', token);
            req.setHeader('session_id', '132456');
            req.setHeader('subscription_id', subscription.SubscriptionId__c);
            req.setHeader('flow_id', '12345');
            req.setHeader('User-Agent', 'Mozilla');
            req.setMethod('POST');
            req.setTimeout(120000);
            req.setBody(bodyToSend);
            Http http = new Http();
            HTTPResponse res = new Http().send(req);

            if(res.getStatusCode() >= 200 && res.getStatusCode() <= 202){
                String response = res.getBody();
                response = response.replace('_id', 'x_id');
                response = response.replace('date', 'x_date');

                retorno = (ChatIAHistoryVO.CreateNewHistoryResponse)  System.JSON.deserialize(response, ChatIAHistoryVO.CreateNewHistoryResponse.class);
                System.debug('retorno => '+ retorno);
            }
            return retorno;

        } catch(JSONException ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw new AuraHandledException('Erro ao consultar dados, procure seu administrador. Código 400');

        } catch(Exception ex) {
            System.debug('API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw ex;
        }
    }

}