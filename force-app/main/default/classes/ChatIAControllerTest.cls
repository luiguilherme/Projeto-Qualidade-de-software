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

	@isTest static void testWithSessionId() {
		String userId = UserInfo.getUserId();
		ChatIA__c chatIA = new ChatIA__c();
		chatIA.Backup__c = userId + 'Teste';
		chatIA.Usuario__c = userId;
		chatIA.Active__c = true;

		insert chatIA;

		Test.startTest();
		Map<String, String> mapChatIA = ChatIAController.getSessionId();
		Test.stopTest();
		Assert.isTrue(mapChatIA.containsKey(userId + 'Teste'));
		Assert.areNotEqual('null', mapChatIA.get(userId + 'Teste'));
	}

	@isTest static void testWithoutSessionId() {
		Test.startTest();
		Map<String, String> mapChatIA = ChatIAController.getSessionId();
		Test.stopTest();
		Assert.areEqual('null', mapChatIA.values()[0]);
		Assert.areNotEqual(null, mapChatIA.values()[0]);
	}

	@isTest static void getAuthenticationTest() {

        Test.setMock(HttpCalloutMock.class, new ChatIAInterfaceAPIMock());
		Test.startTest();
        ChatIAAuthenticationVO.BodyToReceive res = ChatIAInterfaceAPI.getAuthentication();
		Test.stopTest();

        String expectedValue = 'eyJhbGciOi';
        System.assertEquals(expectedValue, res.token);
    }

	@isTest static void getQNAAnswerTest() {

        Test.setMock(HttpCalloutMock.class, new ChatIAInterfaceAPIMock());
		Test.startTest();
        ChatIAQNAAnswerVO.BodyToReceive res = ChatIAController.getQNAAnswer('TESTE');
		Test.stopTest();

        String expectedValue = 'Desculpe, não temos a resposta neste momento. Por favor, entre em contato com seu supervisor.';
        System.assertEquals(expectedValue, res.content);
    }

	@isTest static void createNewChatTest() {
		List<ChatIAController.messageJSON> bodyList = new List<ChatIAController.messageJSON>();
		ChatIAController.messageJSON body = new ChatIAController.messageJSON();
		body.conteudoMensagem = 'TESTE';
		body.mensagemUsuario = true;
		bodyList.add(body);

		String bodyToSend = JSON.serialize(bodyList);

        Test.setMock(HttpCalloutMock.class, new ChatIAInterfaceAPIMock());
		Test.startTest();
        ChatIAHistoryVO.CreateNewChatResponse res = ChatIAController.createNewChat(bodyToSend);
		Test.stopTest();

        String expectedValue = '2023-11-27';
        System.assertEquals(expectedValue, res.x_date);
    }

	@isTest static void AddConversationTest() {
		List<ChatIAController.messageJSON> bodyList = new List<ChatIAController.messageJSON>();
		ChatIAController.messageJSON body = new ChatIAController.messageJSON();
		body.conteudoMensagem = 'TESTE';
		body.mensagemUsuario = true;
		bodyList.add(body);

		String bodyToSend = JSON.serialize(bodyList);

        Test.setMock(HttpCalloutMock.class, new ChatIAInterfaceAPIMock());
		Test.startTest();
        ChatIAHistoryVO.CreateNewChatResponse res = ChatIAController.AddConversation(bodyToSend, '123');
		Test.stopTest();

        String expectedValue = '2023-11-27';
        System.assertEquals(expectedValue, res.x_date);
    }

	@isTest static void getChatByIdTest() {

        Test.setMock(HttpCalloutMock.class, new ChatIAInterfaceAPIMock());
		Test.startTest();
        ChatIAHistoryVO.GetHistoryByIdResponse res = ChatIAController.getChatById('123');
		Test.stopTest();

        String expectedValue = '2023-11-28';
        System.assertEquals(expectedValue, res.x_date);
    }

	@isTest static void deleteChatByIdTest() {

        Test.setMock(HttpCalloutMock.class, new ChatIAInterfaceAPIMock());
		Test.startTest();
        Boolean res = ChatIAController.deleteChatById('123');
		Test.stopTest();

        System.assertEquals(true, res);
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
		List<ChatIAHistoryVO.History> hist = new List<ChatIAHistoryVO.History>();
		List<ChatIAHistoryVO.Chat> chats = new List<ChatIAHistoryVO.Chat>();

		ChatIAHistoryVO.CreateHistory createHistory = new ChatIAHistoryVO.CreateHistory();
		createHistory.chats = chats;

		ChatIAHistoryVO.CreateHistoryResponse createHistoryResponse = new ChatIAHistoryVO.CreateHistoryResponse();
		createHistoryResponse.user_id = 'Teste';
		createHistoryResponse.flow_id = 'Teste';
		createHistoryResponse.chats = chats;

		ChatIAHistoryVO.CreateNewChatResponse createNewChatResponse = new ChatIAHistoryVO.CreateNewChatResponse();
		createNewChatResponse.x_id = 'Teste';
		createNewChatResponse.x_date = 'Teste';
		createNewChatResponse.history = hist;

        ChatIAHistoryVO.GetHistoryByIdResponse getHistoryByIdResponse = new ChatIAHistoryVO.GetHistoryByIdResponse();
		getHistoryByIdResponse.x_id = 'Teste';
		getHistoryByIdResponse.x_date = 'Teste';
		getHistoryByIdResponse.history = hist;

		ChatIAHistoryVO.GetAllHistoryResponse getAllHistoryResponse = new ChatIAHistoryVO.GetAllHistoryResponse();
		getAllHistoryResponse.user_id = 'Teste';
		getAllHistoryResponse.x_id = 'Teste';
		getAllHistoryResponse.flow_id = 'Teste';
		getAllHistoryResponse.chats = chats;

		ChatIAHistoryVO.DeleteChatByIdResponse deleteChatByIdResponse = new ChatIAHistoryVO.DeleteChatByIdResponse();
		deleteChatByIdResponse.response = 'Teste';		
    }
}