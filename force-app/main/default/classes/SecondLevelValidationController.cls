global with sharing class SecondLevelValidationController implements vlocity_cmt.VlocityOpenInterface2 {
    
    global Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionMap) {
        
        Boolean success = true;
        String errors = '';
        
        try {
            switch on methodName {
                when 'validateSecondLevel' {
                    validateSecondLevel(inputMap, outputMap); 
                }
            }
        } catch(Exception e) {
            errors = e.getMessage(); 
            success = false;
            outputMap.put('error', errors);
        }
        
        if (!Test.isRunningTest()) {
            outputMap.put('success', success);
        }
        
        return success;
    }
    
    global void validateSecondLevel(Map<String, Object> inputMap, Map<String, Object> outputMap) {
        String headerXAuth = (String) inputMap.get('headerXAuthValue');
        String msisdn = (String) inputMap.get('msisdn');
        
        if(!String.isNotBlank(headerXAuth)){
            outputMap.put('error', 'Nao foi informado no header da requisicao o token de usuario!');
            return;
        }
        
        Asset actualAsset = AssetDAO.getAssetByServiceIdentifier(msisdn);
        
        if(actualAsset == null){
            outputMap.put('error', 'Nao existe linha na base');
            return;
        }
        
        if (actualAsset.Account.DocumentNumber__c == null) {
            outputMap.put('error', 'Nao existe conta para essa linha');
            return;
        }
        
        String[] jwtParts = headerXAuth.split(' ');
        String authorizationHeaderValue = jwtParts[1];
        
        //Validação do JWT.
        if(JWTUtility.isValidJwt(authorizationHeaderValue)) {
            String uuid = JWTUtility.getJWTBody(authorizationHeaderValue).sub;  
            String currentDocument = actualAsset.Account.DocumentNumber__c;
            
            if(isDocument(uuid)){
                if(uuid == currentDocument){
                	outputMap.put('success', true);
                } else{
                    outputMap.put('error', 'Documento do X-Authorization nao bate com o Documento da linha');
                    outputMap.put('statusCode', '401');
                }
            } else{
                UUIDService service = new UUIDService(uuid, currentDocument);
               
                if (service.uuIDIsValid()) { 
                	outputMap.put('success', true);
                } else{
                    outputMap.put('error', 'Documento do X-Authorization nao bate com o Documento da linha');
                    outputMap.put('statusCode', '401');
                }
            }
            
        } else {
            outputMap.put('error', 'JWT invalido!');
            outputMap.put('statusCode', '401');
            return;
        }
    }
    
    private Boolean isDocument(String uuid){
        if(uuid.length() == 11 || uuid.length() == 14){
            return true;
        } else{
            return false;
        }
    }
}