public with sharing class JWTUtility {
    
    public static Boolean isValidJwt (String jwt){
        String  publicKeyReference = JWTPublicKey.PUBLIC_KEY;
        String[] parts = jwt.split('\\.');
        String headerAndPayload = parts[0] + '.' + parts[1];
        String signature = parts[2 ];
        Blob publicKey = EncodingUtil.base64Decode(publicKeyReference);
        Blob bsignature = EncodingUtil.base64Decode(signature
                        .replace('-', '+')
                        .replace('_', '/')
                        .rightPad(math.mod(signature.length() + (math.mod(4 - signature.length(), 4)), 4))
                        .replace(' ','='));
        boolean verified = Crypto.verify('RSA-SHA256', Blob.valueOf(headerAndPayload), bsignature, publicKey);
    
        
        return verified;
    }

    public static PayLoadJwtWrapper getJWTBody(String jwt){  

        String jwtBase64 = jwt.split('\\.')[1];
        Blob blobJwt = EncodingUtil.base64Decode(jwtBase64);
        String convertedJwt = blobJwt.toString();
        
        return (PayLoadJwtWrapper) json.deserialize(convertedJwt, PayLoadJwtWrapper.class);

    }

    //Validar se o iss que vem do token é OAMExterno
    public static Boolean isToValidate(String iss){
        String OAMExterno = ValidaJWT__mdt.getInstance('OAMExterno').OAM__c;

        if(iss == OAMExterno){
            return true;
        }
        return false;
    }

    public class PayLoadJwtWrapper{
        public String sub {get;set;}
        public String name {get;set;}
        public String iat {get;set;}
        public String iss {get;set;}   
        public String identifier {get;set;}
        public String nrdocumento {get;set;}
        public List<AuthenticationContext> authentication_context {get;set;}
        
        public String getIdentifier() {
            if (authentication_context  != null && !authentication_context.isEmpty()) {
                return authentication_context[0].identifier;
            }
            return null;
        }
    }
    
    public class AuthenticationContext {
        public String identifier { get; set; }
        public String type { get; set; }
    }
}