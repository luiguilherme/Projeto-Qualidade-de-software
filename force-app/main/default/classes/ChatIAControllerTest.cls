@isTest
private class ChatIAControllerTest{

	@testSetup static void setup(){
        
        ChatIASubscriptionId__c setting = new ChatIASubscriptionId__c();
		setting.Name = 'SubscriptionId';
		setting.SubscriptionId__c = '6495ac826e4f0f95368f288c';
		insert setting;
		FeatureFlag__c featureFlag = new FeatureFlag__c();
		featureFlag.Name = 'ChatIA';
		featureFlag.Application__c = 'ChatIA';
		featureFlag.Active__c = true ;
		insert featureFlag;
		Questionsuggestion__c questionsuggestioncObj = new Questionsuggestion__c (
			Question__c = 'test value', 
			Order__c = 1
		);
		insert questionsuggestioncObj;
		 
	}

	@isTest static void testRetornaQuestaoMetadado() {
		Test.startTest();
		List<ChatIAController.QuestionSuggestion> questoes = ChatIAController.getQuestionSuggestion();
		Test.stopTest();
		Assert.areEqual(3, questoes.size());
	}
	@isTest static void getAuthenticationTest() {

        Test.setMock(HttpCalloutMock.class, new ChatIAInterfaceAPIMock());
		Test.startTest();
        ChatIAAuthenticationVO.BodyToReceive res = ChatIAInterfaceAPI.getAuthentication();
		Test.stopTest();

        String expectedValue = 'eyJhbGciOi';
        System.assertEquals(expectedValue, res.token);
    }

	@isTest static void getIntegracaoQNATest() {

        Test.setMock(HttpCalloutMock.class, new ChatIAInterfaceAPIMock());
		Test.startTest();
        ChatIAController.InfoQNA info = ChatIAController.getIntegracaoQNA();
		Test.stopTest();

        String expectedValue = 'https://ai-br-pro.telefonicabigdata.com/qna/stream/';
        System.assertEquals(expectedValue, info.endpoint_qna);
    }


	@isTest static void sendFeedbackTest() {
		
        Test.setMock(HttpCalloutMock.class, new ChatIAInterfaceAPIMock());
		Test.startTest();
        ChatIAFeedbackVO.FeedbackResponse res = ChatIAController.sendFeedback('abc123', 'Feedback Test', 'positive');
		Test.stopTest();
    }
	@isTest static void getChatByIdTest() {
        Test.setMock(HttpCalloutMock.class, new ChatIAInterfaceAPIMock());
		Test.startTest();
        ChatIAHistoryVO.GetHistoryByIdResponse res = ChatIAController.getChatById();
		Test.stopTest();
        String expectedValue = 'Hello';
       System.assertEquals(expectedValue, res.history[0].message);
    }

	@isTest static void deleteChatByIdTest() {
        Test.setMock(HttpCalloutMock.class, new ChatIAInterfaceAPIMock());
		Test.startTest();
        ChatIAHistoryVO.DeleteChatByIdResponse res = ChatIAController.deleteChatById();
		Test.stopTest();

        System.assertEquals(true, res.response);
    }
	@isTest static void retornaPermissaoVerdadeiro() {
		String idUser = UserInfo.getUserId();
		PermissionSet permissionSet = [SELECT Id FROM PermissionSet WHERE Name = 'ChatIA' LIMIT 1];
		List<PermissionSetAssignment> lstPermissionSetAssignment = ChatIASelector.getInstance().getPermission(idUser);
		if(lstPermissionSetAssignment.isEmpty()){
			PermissionSetAssignment psAssignment = new PermissionSetAssignment();
			psAssignment.AssigneeId = idUser;
			psAssignment.PermissionSetId = permissionSet.Id;
			insert psAssignment;
		}
		Test.startTest();
        Boolean res = ChatIAController.getPermission();
		Test.stopTest();
        System.assertEquals(true, res);
    }

	@isTest static void coverageVO() {
		//ChatIAQNAAnswerVO
		ChatIAQNAAnswerVO.Document doc = new ChatIAQNAAnswerVO.Document();
		doc.name = 'TESTE';
		doc.url = 'TESTE';
		List<ChatIAQNAAnswerVO.SupportingSnippets> supportingSnippets = new List<ChatIAQNAAnswerVO.SupportingSnippets>();
		ChatIAQNAAnswerVO.SupportingSnippets supporting = new ChatIAQNAAnswerVO.SupportingSnippets();
		supporting.content = 'TESTE';
		supporting.document = doc;
		supporting.page_number = '1';
		supportingSnippets.add(supporting);
		ChatIAQNAAnswerVO.BodyToReceive chatIAQNAAnswerVO = new ChatIAQNAAnswerVO.BodyToReceive();
		chatIAQNAAnswerVO.correlator = 'TESTE';
		chatIAQNAAnswerVO.supporting_snippets = supportingSnippets;
		chatIAQNAAnswerVO.content = 'TESTE';

		//ChatIAAuthenticationVO
		List<String> permissions = new List<String>{'teste'};

		List<ChatIAAuthenticationVO.Subscription> subscriptions = new List<ChatIAAuthenticationVO.Subscription>();
		ChatIAAuthenticationVO.Subscription subscription = new ChatIAAuthenticationVO.Subscription();
		subscription.x_id = 'Teste';
		subscription.x_v = 'Teste';
		subscription.tenantId = 'Teste';
		subscription.tenantName = 'Teste';
		subscription.subscriptionId = 'Teste';
		subscription.subscriptionName = 'Teste';
		subscription.subscriptionDescription = 'Teste';
		subscription.subscriptionRoute = 'Teste';
		subscription.created_at = 'Teste';
		subscription.updated_at = 'Teste';
		subscription.permissions = permissions;
		subscriptions.add(subscription);

		List<ChatIAAuthenticationVO.Product> products = new List<ChatIAAuthenticationVO.Product>();
		ChatIAAuthenticationVO.Product product = new ChatIAAuthenticationVO.Product();
		product.x_id = 'Teste';
		product.name = 'Teste';
		product.description = 'Teste';
		product.bu = 'Teste';
		product.url = 'Teste';
		product.project = 'Teste';
		product.x_v = 'Teste';
		product.created_at = 'Teste';
		product.updated_at = 'Teste';
		product.permissions = permissions;
		products.add(product);

		ChatIAAuthenticationVO.BodyToReceive chatIAAuthenticationVO = new ChatIAAuthenticationVO.BodyToReceive();
		chatIAAuthenticationVO.user_profile = 'Teste';
		chatIAAuthenticationVO.user_profile_permission = permissions;
		chatIAAuthenticationVO.user_id = 'Teste';
		chatIAAuthenticationVO.user_name = 'Teste';
		chatIAAuthenticationVO.user_email = 'Teste';
		chatIAAuthenticationVO.session_id = 'Teste';
		chatIAAuthenticationVO.oam_matricula = 'Teste';
		chatIAAuthenticationVO.oam_gestor = 'Teste';
		chatIAAuthenticationVO.oam_ccusto = 'Teste';
		chatIAAuthenticationVO.token = 'Teste';
		chatIAAuthenticationVO.correlator = 'Teste';
		chatIAAuthenticationVO.subscriptions = subscriptions;
		chatIAAuthenticationVO.products = products;

		//ChatIAHistoryVO
		ChatIAHistoryVO.History history = new ChatIAHistoryVO.History();
		history.correlator = '123456';
		history.feedback = 'test';
		history.message = 'teste';
		history.sessionId = 'teste';
		history.subscriptionId = 'teste';
		history.userId = 'teste';
		history.createdAt = '23/09/2024';
		history.response = 'teste';
		history.feedback_message = 'teste';

		List<ChatIAHistoryVO.History> hist = new List<ChatIAHistoryVO.History>();
        ChatIAHistoryVO.GetHistoryByIdResponse getHistoryByIdResponse = new ChatIAHistoryVO.GetHistoryByIdResponse();
		getHistoryByIdResponse.history = hist;
		ChatIAHistoryVO.DeleteChatByIdResponse deleteChatByIdResponse = new ChatIAHistoryVO.DeleteChatByIdResponse();
		deleteChatByIdResponse.response = true;
		ChatIAFeedbackVO.FeedbackResponse feedbackResponse = new ChatIAFeedbackVO.FeedbackResponse();
		feedbackResponse.message = 'responseTest';

    }
}