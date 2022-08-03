@IsTest 
public class OAMSystemOAuthProviderTest {
	private static final String CLIENT_ID = 'testClientId';
    private static final String CLIENT_SECRET = 'testClientSecret';
    private static final String AUTH_URL = 'http://www.dummy.com/authurl';
    private static final String REDIRECT_URL = 'http://localhost/services/authcallback/orgId/OAM';
    private static final String TOKEN_URL = 'http://www.dummyhost.com/accessTokenUri';
    private static final String REFRESH_URL = 'http://www.dummyhost.com/refreshTokenUri';
    private static final String API_USER_VERSION_URL = 'http://www.dummyhost.com/user/20/1'; 
    private static final String HEADERS = 'app-key: 905df2d2-f88e-49b6-9f1b-64086baab524;oam:MDAz';
    private static final String SCOPES = 'testScope';
    private static final String USER_INFO = 'testUserInfo';

    private static final String OAUTH_TOKEN = 'eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsIng1dCI6Ik16WXdYRnpMT2JDY2pLc1J4RW1TaklBM19WVSIsImtpZCI6Im9yYWtleSJ9.eyJzdWIiOiJhMDA2OTg2MSIsIm9yYWNsZS5vYXV0aC51c2VyX29yaWdpbl9pZF90eXBlIjoiTERBUF9VSUQiLCJvcmFjbGUub2F1dGgudXNlcl9vcmlnaW5faWQiOiJhMDA2OTg2MSIsImlzcyI6Imh0dHBzOi8vYXV0ZW50aWNhaW50aG1sLnJlZGVjb3JwLmJyIiwidml2by5lbnYiOiJDT1JQLUhNTCIsIm9yYWNsZS5vYXV0aC5zdmNfcF9uIjoiVml2b1NlcnZpY2VQcm9maWxlIiwiaWF0IjoxNjQ3NDM2OTI1LCJvcmFjbGUub2F1dGgucHJuLmlkX3R5cGUiOiJMREFQX1VJRCIsIm9yYWNsZS5vYXV0aC50a19jb250ZXh0IjoicmVzb3VyY2VfYWNjZXNzX3RrIiwiZXhwIjoxNjQ3NDQwNTI1LCJwcm4iOiJhMDA2OTg2MSIsInZpdm8uZW5kcG9pbnQiOiJ2aXZvb2F1dGhzZXJ2aWNlIiwianRpIjoiYjQzZmIwNmItYmFmYi00YWViLWExZGQtMzI5Nzg1NGFlNWQ5Iiwib3JhY2xlLm9hdXRoLnNjb3BlIjoiU2VydmljZUFjY291bnQuUHJvZmlsZSIsIm9yYWNsZS5vYXV0aC5jbGllbnRfb3JpZ2luX2lkIjoiNTYwNGFkMjE5M2M3NGM0MGFlNTQ2M2ZjOGQwZTI5MGYiLCJvcmFjbGUub2F1dGguaWRfZF9pZCI6IjYzNDRhZDJiLTE4YjItNDU4ZC04NzYyLWFlY2RmYzYzYmUxMCIsInVzZXIudGVuYW50Lm5hbWUiOiJWaXZvIiwiZGlzcGxheW5hbWUiOiJZZWxlbmEgQmVsb3ZhIn0.DYqnCcG81MZVXFF1wd9fuWA7c0sC1UE0ta8ElmJu-PWWw2YVNyBfsj0_BR6N__pJYkreoli4earLXH5njbB5hLpPyNApR04WwlCtf851dgb5hXojRtYvcBozlQw-2hy58fexAduNoG74yEmVjPvkf_V0TqHpzpwnDMcjqDBKqNk'; 
    private static final String STATE = 'mocktestState'; 
    private static final String REFRESH_TOKEN = 'eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsIng1dCI6Ik16WXdYRnpMT2JDY2pLc1J4RW1TaklBM19WVSIsImtpZCI6Im9yYWtleSJ9.eyJzdWIiOm51bGwsIm9yYWNsZS5vYXV0aC51c2VyX29yaWdpbl9pZF90eXBlIjoiTERBUF9VSUQiLCJvcmFjbGUub2F1dGgudXNlcl9vcmlnaW5faWQiOiJhMDA2OTg2MSIsImlzcyI6Imh0dHBzOi8vYXV0ZW50aWNhaW50aG1sLnJlZGVjb3JwLmJyIiwib3JhY2xlLm9hdXRoLnJ0LnR0YyI6InJlc291cmNlX2FjY2Vzc190ayIsIm9yYWNsZS5vYXV0aC5zdmNfcF9uIjoiVml2b1NlcnZpY2VQcm9maWxlIiwiaWF0IjoxNjQ3NDM2OTI1LCJvcmFjbGUub2F1dGgudGtfY29udGV4dCI6InJlZnJlc2hfdG9rZW4iLCJleHAiOjE2NDc0NTEzMjUsInBybiI6bnVsbCwianRpIjoiZDQ3M2E3MDgtNDJiZi00YTAwLTliNTMtZjE2OGNlNTM4ZTQzIiwib3JhY2xlLm9hdXRoLnNjb3BlIjoiU2VydmljZUFjY291bnQuUHJvZmlsZSIsIm9yYWNsZS5vYXV0aC5jbGllbnRfb3JpZ2luX2lkIjoiNTYwNGFkMjE5M2M3NGM0MGFlNTQ2M2ZjOGQwZTI5MGYiLCJ1c2VyLnRlbmFudC5uYW1lIjoiVml2byIsIm9yYWNsZS5vYXV0aC5pZF9kX2lkIjoiNjM0NGFkMmItMThiMi00NThkLTg3NjItYWVjZGZjNjNiZTEwIn0.nf-cIDWeXgQWim4dh18YJctMf_X3DvzfriSB2Ifvv83NnCGpIsdCnBQezvqJHoTpRiK8yIE2Ee5ny69i8P0ukyzN0BrlnzvFlFaODG0CkUCmE3kk3UOpvI3f3jBZ6EYxs9Zpg0zG8cks4aG043qh0Qxl_yc6-JlPihW2DFdftpo'; 
    private static final String ID_TOKEN = 'eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsIng1dCI6Ik16WXdYRnpMT2JDY2pLc1J4RW1TaklBM19WVSIsImtpZCI6Im9yYWtleSJ9.eyJzdWIiOiJhMDA2OTg2MSIsIm9yYWNsZS5vYXV0aC51c2VyX29yaWdpbl9pZF90eXBlIjoiTERBUF9VSUQiLCJvcmFjbGUub2F1dGgudXNlcl9vcmlnaW5faWQiOiJhMDA2OTg2MSIsImlzcyI6Imh0dHBzOi8vYXV0ZW50aWNhaW50aG1sLnJlZGVjb3JwLmJyIiwidml2by5lbnYiOiJDT1JQLUhNTCIsIm9yYWNsZS5vYXV0aC5zdmNfcF9uIjoiVml2b1NlcnZpY2VQcm9maWxlIiwiaWF0IjoxNjQ3NDM2OTI1LCJvcmFjbGUub2F1dGgucHJuLmlkX3R5cGUiOiJMREFQX1VJRCIsIm9yYWNsZS5vYXV0aC50a19jb250ZXh0IjoicmVzb3VyY2VfYWNjZXNzX3RrIiwiZXhwIjoxNjQ3NDQwNTI1LCJwcm4iOiJhMDA2OTg2MSIsInZpdm8uZW5kcG9pbnQiOiJ2aXZvb2F1dGhzZXJ2aWNlIiwianRpIjoiYjQzZmIwNmItYmFmYi00YWViLWExZGQtMzI5Nzg1NGFlNWQ5Iiwib3JhY2xlLm9hdXRoLnNjb3BlIjoiU2VydmljZUFjY291bnQuUHJvZmlsZSIsIm9yYWNsZS5vYXV0aC5jbGllbnRfb3JpZ2luX2lkIjoiNTYwNGFkMjE5M2M3NGM0MGFlNTQ2M2ZjOGQwZTI5MGYiLCJvcmFjbGUub2F1dGguaWRfZF9pZCI6IjYzNDRhZDJiLTE4YjItNDU4ZC04NzYyLWFlY2RmYzYzYmUxMCIsInVzZXIudGVuYW50Lm5hbWUiOiJWaXZvIiwiZGlzcGxheW5hbWUiOiJZZWxlbmEgQmVsb3ZhIn0.DYqnCcG81MZVXFF1wd9fuWA7c0sC1UE0ta8ElmJu-PWWw2YVNyBfsj0_BR6N__pJYkreoli4earLXH5njbB5hLpPyNApR04WwlCtf851dgb5hXojRtYvcBozlQw-2hy58fexAduNoG74yEmVjPvkf_V0TqHpzpwnDMcjqDBKqN8'; 

    private static final String LOGIN_ID = '80584585'; 
    private static final String USERNAME = '80584585@telefonica.b2cva.com'; 
    private static final String FIRST_NAME = 'Carlos'; 
    private static final String LAST_NAME = 'Faucz'; 
    private static final String EMAIL_ADDRESS = 'cefaucz@gmail.com'; 
    private static final String LOCALE_NAME = 'testLocalName'; 
    private static final String FULL_NAME = FIRST_NAME + ' ' + LAST_NAME; 
    private static final String PROVIDER = 'OAMSystemUser'; 
    private static final String SITE_URL_LOGIN = 'https://autenticainthml.redecorp.br';
    private static final String STATE_TO_PROPOGATE = 'testState'; 
    private static final String RESPONSE_TYPE = 'code'; 
    private static final String ATT_SUB = 'a0069861'; 
    private static final String ATT_ISS = 'https://autenticainthml.redecorp.br'; 
    private static final String ATT_IAT = '1643895333'; 
    private static final String ATT_EXP = '1643898933'; 
    private static final String ATT_PRN = 'a0069861'; 
    private static final String ATT_JTI = '1a0df0ec-ddf3-43c0-8e50-a033c183d708'; 
    private static final String ATT_DISPLAY_NAME = 'Yelena Belova'; 

    // In the real world scenario, the key and value would be read 
    // from the (custom fields in) custom metadata type record. 
    private static Map<String,String> setupAuthProviderConfig () 
    { 
        Map<String,String> authProviderConfiguration = new Map<String,String>(); 
        authProviderConfiguration.put('AuthorizeURL__c', AUTH_URL); 
        authProviderConfiguration.put('ClientId__c', CLIENT_ID); 
        authProviderConfiguration.put('RedirectURL__c', REDIRECT_URL); 
        authProviderConfiguration.put('Scopes__c', SCOPES); 
        authProviderConfiguration.put('ClientSecret__c',CLIENT_SECRET); 
        authProviderConfiguration.put('Headers__c', HEADERS); 
        authProviderConfiguration.put('TokenURL__c',TOKEN_URL); 
        authProviderConfiguration.put('Refresh_URL__c',REFRESH_URL); 
        authProviderConfiguration.put('UserInfoURL__c',USER_INFO); 
        return authProviderConfiguration; 

    } 

    static testMethod void testInitiateMethod() 
    { 
        String stateToPropogate = 'mocktestState'; 
        Map<String,String> authProviderConfiguration = setupAuthProviderConfig(); 
        OAMSystemOAuthProvider oamProviderCls = new OAMSystemOAuthProvider(); 
        PageReference expectedUrl = new PageReference(authProviderConfiguration.get('RedirectURL__c') +
                                                      '?state=' + STATE_TO_PROPOGATE); 
        PageReference actualUrl = oamProviderCls.initiate(authProviderConfiguration, STATE_TO_PROPOGATE); 
        System.assertEquals(expectedUrl.getUrl(), actualUrl.getUrl());
    } 
    
    static testMethod void testHandleCallback() 
    { 
        Map<String,String> authProviderConfiguration = setupAuthProviderConfig(); 
        OAMSystemOAuthProvider oamProviderCls = new OAMSystemOAuthProvider(); 

        Test.setMock(HttpCalloutMock.class, new OAMMockHttpResponseGenerator()); 

        Map<String,String> queryParams = new Map<String,String>(); 
        queryParams.put('code','code'); 
        queryParams.put('state','testState'); 
        Auth.AuthProviderCallbackState cbState = new Auth.AuthProviderCallbackState(null,null,queryParams); 
        Auth.AuthProviderTokenResponse actualAuthProvResponse = oamProviderCls.handleCallback(authProviderConfiguration, cbState); 
        Auth.AuthProviderTokenResponse expectedAuthProvResponse = new Auth.AuthProviderTokenResponse('OAMSystemUser', OAUTH_TOKEN, REFRESH_TOKEN, 'testState');

        System.assertEquals(expectedAuthProvResponse.provider, actualAuthProvResponse.provider); 
        System.assertEquals(expectedAuthProvResponse.oauthToken, actualAuthProvResponse.oauthToken); 
        System.assertEquals(expectedAuthProvResponse.oauthSecretOrRefreshToken, actualAuthProvResponse.oauthSecretOrRefreshToken); 
        System.assertEquals(expectedAuthProvResponse.state, actualAuthProvResponse.state);

    } 
    
    static testMethod void testGetUserInfo() 
    { 
        Map<String,String> authProviderConfiguration = setupAuthProviderConfig(); 
        OAMSystemOAuthProvider oamProviderCls = new OAMSystemOAuthProvider(); 

        Test.setMock(HttpCalloutMock.class, new OAMMockHttpResponseGenerator()); 

        Map<String, String> attributeMap = new Map<String,String>();
        attributeMap.put('sub', 			ATT_SUB);
        attributeMap.put('iss', 			ATT_ISS);
        attributeMap.put('iat', 			ATT_IAT);
        attributeMap.put('exp', 			ATT_EXP);
        attributeMap.put('prn', 			ATT_PRN);
		attributeMap.put('jti',				ATT_JTI);
        attributeMap.put('displayname', 	ATT_DISPLAY_NAME); 
        
        Auth.AuthProviderTokenResponse response = new Auth.AuthProviderTokenResponse(PROVIDER, OAUTH_TOKEN ,REFRESH_TOKEN, STATE); 
        Auth.UserData actualUserData = oamProviderCls.getUserInfo(authProviderConfiguration, response); 
        Auth.UserData expectedUserData = new Auth.UserData(null, null, null, ATT_DISPLAY_NAME, null, null, ATT_SUB, null, PROVIDER, SITE_URL_LOGIN, attributeMap);
    
        System.assertNotEquals(expectedUserData,null); 
        System.assertEquals(expectedUserData.firstName, actualUserData.firstName); 
        System.assertEquals(expectedUserData.lastName, actualUserData.lastName); 
        System.assertEquals(expectedUserData.fullName, actualUserData.fullName); 
        System.assertEquals(expectedUserData.email, actualUserData.email); 
        System.assertEquals(expectedUserData.username, actualUserData.username); 
        System.assertEquals(expectedUserData.locale, actualUserData.locale); 
        System.assertEquals(expectedUserData.provider, actualUserData.provider); 
        System.assertEquals(expectedUserData.siteLoginUrl, actualUserData.siteLoginUrl);  
    } 

    static testMethod void testGetCustomMetadataType() 
    { 
        Map<String,String> authProviderConfiguration = setupAuthProviderConfig(); 
        OAMSystemOAuthProvider oamProviderCls = new OAMSystemOAuthProvider(); 
        String providerMdt = oamProviderCls.getCustomMetadataType(); 
        System.assertEquals('OAMProvider__mdt', providerMdt);
    } 

    static testMethod void testRefresh() 
    { 
        Map<String,String> authProviderConfiguration = setupAuthProviderConfig(); 
        OAMSystemOAuthProvider oamProviderCls = new OAMSystemOAuthProvider(); 

        Test.setMock(HttpCalloutMock.class, new OAMMockHttpResponseGenerator()); 

        Auth.OAuthRefreshResult actualAuthRefreshResult = oamProviderCls.refresh(authProviderConfiguration, REFRESH_TOKEN); 
        Auth.OAuthRefreshResult expectedAuthRefreshResult = new Auth.OAuthRefreshResult(OAUTH_TOKEN, REFRESH_TOKEN);

        System.assertEquals(expectedAuthRefreshResult.accessToken, actualAuthRefreshResult.accessToken); 
        System.assertEquals(expectedAuthRefreshResult.refreshToken, actualAuthRefreshResult.refreshToken); 
    } 
    
    // Implement a mock http response generator for OAM. 
    public class OAMMockHttpResponseGenerator implements HttpCalloutMock 
    { 
        public HTTPResponse respond(HTTPRequest req) 
        { 
            // Create a fake response 
            HttpResponse res = new HttpResponse(); 
            res.setHeader('Content-Type', 'application/xml'); 
            res.setBody('{"id_token":"'+ID_TOKEN+'","refresh_token":"'+REFRESH_TOKEN+'","access_token":"'+OAUTH_TOKEN+'"}'); 
            res.setStatusCode(200); 
            return res; 
        } 
    }
}