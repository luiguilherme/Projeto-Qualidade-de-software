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


    public class PayLoadJwtWrapper{
        public String sub {get;set;}
        public String name {get;set;}
        public String iat {get;set;}
        public String iss {get;set;}   
        public String identifier {get;set;}
        public String nrdocumento {get;set;}
    }
}