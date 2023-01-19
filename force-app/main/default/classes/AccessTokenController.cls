global with sharing class AccessTokenController implements vlocity_cmt.VlocityOpenInterface2 {

    global boolean invokeMethod(String methodName, Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options){    
        switch on methodName {
            when 'getAccessToken'
            {output.put('result', getAccessToken());} 
        }
        return true; 
    }

    String getAccessToken() {
        OAuthEndUserRequestConfigurator tokenConfig = new OAuthEndUserRequestConfigurator();
        String accessToken;
        
        try {
            accessToken = tokenConfig.getAccessToken();
            return accessToken;
        } catch(Exception e) {
            throw new AccessTokenException('Falha ao retornar o resultado: ' + e.getMessage());
        }        
        
    }
}