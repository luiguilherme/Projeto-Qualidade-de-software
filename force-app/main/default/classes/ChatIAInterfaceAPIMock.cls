@isTest
global class ChatIAInterfaceAPIMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {

        HttpResponse res = new HttpResponse();
        
        // getAuthentication();
        if(req.getEndpoint() == 'https://ai-br-pro.telefonicabigdata.com/auth'){
            // Create a fake response
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"user_profile":"VGPT_ADMIN_LAB_IA","user_profile_permissions":["READ","CREATE","UPDATE","DELETE"],"user_id":"A0000000","user_name":"System","user_email":"dev@telefonica.com","session_id":"d513d06d-8ed2-4183-bc31-68c571ffa303","oam_matricula":"00TT000000","oam_gestor":"CN=R329553,OU=Usuarios,OU=Administrativo,OU=SP,OU=SP,OU=Corporativo,ou=adredecorp,dc=ovdcorp_prd,dc=br","oam_ccusto":"00TT000000","token":"eyJhbGciOi","subscriptions":[{"_id":"65135002feeafc4f94ea6948","__v":0,"tenantId":"64959d738a3c541fc4384ffb","tenantName":"VGPT_ADMIN_LAB_IA","subscriptionId":"6479f3b4d324b32f05eb6b7f","subscriptionName":"B2B Produtos Móveis","subscriptionDescription":"ChatGPT Enterprise","subscriptionRoute":"/b2b/qa","created_at":"2023-09-26T21:41:22.421Z","updated_at":"2023-09-26T21:41:22.421Z","permissions":["QNA_MOBILE_PRODUCTS","QNA_PDF","QNA_MOBILE_PRODUCTS_ADMIN","CHAT_GPT"]}],"correlator":"f046c0d3-4907-4e95-98e2-221e979f65a3","products":[{"_id":"64cbc2474872d839befc32cd","name":"Tiny Tyson","description":"Crafting Dialogues that Drive Business Success.","bu":"","url":"/chat?subscription_id=223217529779164882042369487210930705204","permissions":["VIVO_FLOW"]}]}');
            res.setStatusCode(200);
        }

        // getQNAAnswer();
        if(req.getEndpoint() == 'https://ai-br-pro.telefonicabigdata.com/qna-mobile-products/?question=TESTE'){
            // Create a fake response
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"content":"Desculpe, não temos a resposta neste momento. Por favor, entre em contato com seu supervisor.","supporting_snippets":[{"content":" ","document":{"name":"Manual LDI v3.pdf","url":"https://ai-br-pro.telefonicabigdata.com/pdfs/6479f3b4d324b32f05eb6b7f/Manual LDI v3.pdf"},"page_number":14},{"content":" ","document":{"name":"Manual LDI v3.pdf","url":"https://ai-br-pro.telefonicabigdata.com/pdfs/6479f3b4d324b32f05eb6b7f/Manual LDI v3.pdf"},"page_number":15},{"content":" ","document":{"name":"Manual_Gestão Dispositivo_vChatv3.pdf","url":"https://ai-br-pro.telefonicabigdata.com/pdfs/6479f3b4d324b32f05eb6b7f/Manual_Gestão Dispositivo_vChatv3.pdf"},"page_number":20}],"correlator":"1c404007-6398-4d66-b4bd-c44a5b0922c6"}');
            res.setStatusCode(200);
        }

        // CreateNewChat();
        if(req.getEndpoint() == 'https://ai-br-pro.telefonicabigdata.com/flow/chat/12345' && req.getMethod() == 'PUT'){
            // Create a fake response
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"date":"2023-11-27","history":[{"type":"user","message":"a API está funcionando?","_id":"123"},{"type":"assistant","message":"Desculpe, não temos a resposta neste momento. Por favor, entre em contato com seu supervisor.","_id":"456"}],"_id":"6564cff7ff71047362031bd4"}');
            res.setStatusCode(200);
        }

        // CreateNewHistory();
        if(req.getEndpoint() == 'https://ai-br-pro.telefonicabigdata.com/flow/chat/12345' && req.getMethod() == 'POST'){
            // Create a fake response
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"user_id": "0058J000001NLnDQAWAA12", "flow_id": "12345","chats": [{"date": "2024-01-19","history": [{"type": "user","message": "Como ativar o eSim?","correlator": null,"has_feedback": null,"feedback": null,"_id": "65aac862deb68aa9b434d6fd"},{"type": "assistant","message": "TESTE","correlator": "09a10af1-ada0-432e-9d50-afe3efb2fc29","has_feedback": null,"feedback": null,"_id": "65aac862deb68aa9b434d6fe"}],"_id": "65aac862deb68aa9b434d6fc"}],"_id": "65aac862deb68aa9b434d6fb","created_at": "2024-01-19T19:07:14.127Z","updated_at": "2024-01-19T19:07:14.127Z","__v": 0}');
            res.setStatusCode(200);
        }

        // AddConversation();
        if(req.getEndpoint() == 'https://ai-br-pro.telefonicabigdata.com/flow/chat/TESTE' && req.getMethod() == 'PUT'){
            // Create a fake response
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"date":"2023-11-27","history":[{"type":"user","message":"a API está funcionando?","_id":"123"},{"type":"assistant","message":"Desculpe, não temos a resposta neste momento. Por favor, entre em contato com seu supervisor.","_id":"456"}],"_id":"6564cff7ff71047362031bd4"}');
            res.setStatusCode(200);
        }
       
        // GetHistoryById();
        if(req.getEndpoint() == 'https://ai-br-pro.telefonicabigdata.com/flow/chat/12345' && req.getMethod() == 'GET'){
            // Create a fake response
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"date":"2023-11-28","history":[{"type":"user","message":"Como acessar minha conta?","_id":"6565dea8fbaa8bf6581f08a5"},{"type":"assistant","message":"Para acessar sua conta no portal Vivo Gestão, você deve informar seu usuário (login) e senha","_id":"6565dea8fbaa8bf6581f08a6"}],"_id":"6565dea8fbaa8bf6581f08a4"}');
            res.setStatusCode(200);
        }
        
        // DeleteChatById();
        if(req.getEndpoint() == 'https://ai-br-pro.telefonicabigdata.com/flow/chat/12345' && req.getMethod() == 'DELETE'){
            // Create a fake response
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(200);
        }
        
        // updateFeedback();
        if(req.getEndpoint() == 'https://ai-br-pro.telefonicabigdata.com/flow/chat/feedback/12345' && req.getMethod() == 'PUT'){
            // Create a fake response
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"history":[{"type":"user","message":"a API está funcionando?","_id":"123"},{"type":"assistant","message":"Desculpe, não temos a resposta neste momento. Por favor, entre em contato com seu supervisor.","_id":"456"}], "x_date":"01/01/2024", "x_id":"64ff7ca1d775598c686dabf8"}');
            res.setStatusCode(200);
        }

        // sendFeedback();
        if(req.getEndpoint() == 'https://ai-br-pro.telefonicabigdata.com/v1/feedback' && req.getMethod() == 'POST'){
            // Create a fake response
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"message": "Feedback received successfully"}');
            res.setStatusCode(200);
        }

        return res;
    }
}