/*
@author - Flavio Tobias
@company - Everymind 
@date - 16/09/2024
@description - Classe responsável por realizar integrações com APIs externas para autenticação,
envio de feedback, consulta de histórico de chat e exclusão de históricos de chat.
*/
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
            HTTPResponse res = new Http().send(req);

            if(res.getStatusCode() >= 200 && res.getStatusCode() <= 202){
                retorno = (ChatIAAuthenticationVO.BodyToReceive)  System.JSON.deserialize(res.getBody(), ChatIAAuthenticationVO.BodyToReceive.class);
            }
            return retorno;
        } catch(JSONException ex) {
            System.debug(LoggingLevel.Error, 'API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw new AuraHandledException('Erro ao consultar dados, procure seu administrador. Código 400');
        } catch(Exception ex) {
            System.debug(LoggingLevel.Error, 'API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw ex;
        }
    }
    public static ChatIAFeedbackVO.FeedbackResponse sendFeedback(ChatIAFeedbackVO.Feedback body, String token) {
        ChatIAFeedbackVO.FeedbackResponse retorno = new ChatIAFeedbackVO.FeedbackResponse();
        try {
            String bodyToSend = JSON.serialize(body);
            User user = ChatIASelector.getInstance().getUser(UserInfo.getUserId());
            String login = user.Login__c != null ? user.Login__c : user.Id;
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
            HTTPResponse res = new Http().send(req);
    
            if (res.getStatusCode() >= 200 && res.getStatusCode() <= 202) {
                retorno = (ChatIAFeedbackVO.FeedbackResponse) System.JSON.deserialize(res.getBody(), ChatIAFeedbackVO.FeedbackResponse.class);
                retorno.response = true;
            } else {
                retorno.response = false;
                retorno.code = String.valueOf(res.getStatusCode());
                retorno.message = res.getStatus();
            }
        } catch (JSONException ex) {
            System.debug(LoggingLevel.Error, 'API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            retorno.response = false;
            retorno.message = 'Erro ao processar JSON. ' + ex.getMessage();
        } catch (Exception ex) {
            System.debug(LoggingLevel.Error, 'API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            retorno.response = false;
            retorno.message = 'Erro inesperado. ' + ex.getMessage();
        }
        return retorno;
    }
    public static ChatIAHistoryVO.GetHistoryByIdResponse getHistoryById(String token) {
        ChatIAHistoryVO.GetHistoryByIdResponse retorno = new ChatIAHistoryVO.GetHistoryByIdResponse();
        retorno.history = new List<ChatIAHistoryVO.History>();
        try {
            String chatId = 'Salesforce';
            ChatIASubscriptionId__c subscriptionObj = ChatIASubscriptionId__c.getValues('SubscriptionId');
            String subscription = subscriptionObj.SubscriptionId__c;
            User user = ChatIASelector.getInstance().getUser(UserInfo.getUserId());
            String login = user.Login__c != null ? user.Login__c : user.Id;     
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ai-br-pro.telefonicabigdata.com/v2/history/' + login + '/' + subscription);
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('user_id', login);
            req.setHeader('token', token);
            req.setHeader('session_id', chatId);
            req.setHeader('subscription_id', subscription);
            req.setHeader('service', 'QNA_MOBILE_PRODUCTS');
            req.setHeader('User-Agent', 'Mozilla');
            req.setMethod('GET');
            req.setTimeout(120000);
            HTTPResponse res = new Http().send(req);
    
            if (res.getStatusCode() >= 200 && res.getStatusCode() <= 202) {
                String response = res.getBody();
                retorno.history = (List<ChatIAHistoryVO.History>) System.JSON.deserialize(response, List<ChatIAHistoryVO.History>.class);
                retorno.response = true;
            } else {
                retorno.response = false;
                retorno.code = String.valueOf(res.getStatusCode());
                retorno.message = 'Erro: ' + res.getStatus() + ' - ' + res.getStatusCode();
            }
        } catch (Exception ex) {
            System.debug(LoggingLevel.Error, 'API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            retorno.response = false;
            retorno.message = ex.getMessage();
        }
        return retorno;
    }
    

    public static ChatIAHistoryVO.DeleteChatByIdResponse deleteChatById(String token){
        try{
            ChatIAHistoryVO.DeleteChatByIdResponse retorno = new ChatIAHistoryVO.DeleteChatByIdResponse();
            String chatId = 'Salesforce';
            ChatIASubscriptionId__c subscriptionObj = ChatIASubscriptionId__c.getValues('SubscriptionId');
            String subscription = subscriptionObj.SubscriptionId__c;
            User user = ChatIASelector.getInstance().getUser(UserInfo.getUserId());
            String login = user.Login__c != null ? user.Login__c : user.Id;
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://ai-br-pro.telefonicabigdata.com/v2/history/'+login+'/'+subscription);
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('user_id', login);
            req.setHeader('token', token);
            req.setHeader('session_id', chatId);
            req.setHeader('subscription_id', subscription);
            req.setHeader('service', 'QNA_MOBILE_PRODUCTS');
            req.setHeader('User-Agent', 'Mozilla');
            req.setMethod('DELETE');
            req.setTimeout(120000);
            HTTPResponse res = new Http().send(req);

            if(res.getStatusCode() >= 200 && res.getStatusCode() <= 204){
                retorno.response = true;
            } else {
                retorno = (ChatIAHistoryVO.DeleteChatByIdResponse) System.JSON.deserialize(res.getBody(), ChatIAHistoryVO.DeleteChatByIdResponse.class);
                retorno.response = false;
            }
            return retorno;
        } catch(JSONException ex) {
            System.debug(LoggingLevel.Error, 'API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw new AuraHandledException('Erro ao consultar dados, procure seu administrador. Código 400');
        } catch(Exception ex) {
            System.debug(LoggingLevel.Error, 'API Erro => ' + ex.getMessage() + ' | ' + ex.getStackTraceString());
            throw ex;
        }
    }

}