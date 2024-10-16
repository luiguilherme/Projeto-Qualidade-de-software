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
       
        // GetHistoryById();
        if(req.getEndpoint().contains('https://ai-br-pro.telefonicabigdata.com/v2/history/') && req.getMethod() == 'GET'){
            // Create a fake response
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"message":"Hello","response":"Success","feedback":"Positive","correlator":"12345","feedback_message":"Great job","userId":"0011p00000ABCD","subscriptionId":"sub_ABC123","createdAt":"2024-08-20","sessionId":"sess_123456"}]');
            res.setStatusCode(200);
        }
        
        // DeleteChatById();
        if(req.getEndpoint().contains('https://ai-br-pro.telefonicabigdata.com/v2/history/') && req.getMethod() == 'DELETE'){
            // Create a fake response
            res.setHeader('Content-Type', 'application/json');
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