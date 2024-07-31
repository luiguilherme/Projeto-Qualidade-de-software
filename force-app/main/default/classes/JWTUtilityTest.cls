@IsTest
public with sharing class JWTUtilityTest {

    public static final String PUBLIC_KEY = 'MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgGem2Z/GaUjUe/6OGfilrcdrklxa0fyMqQIbSMBjC9rr7g+2db+mC1C/pSwNEOHjnM8OcObtSeTz9khtd/jB8aFggYbnmFAJgBEvOmiPLFpaDObBKVMytSK/M8j63gmu2fGIWZAupnyCG1BKe2YOpOwG4nOwlRSqUhISUosYFotfAgMBAAE=';
    public static final String FAKE_PUBLIC_KEY = 'MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgGem2z/GaUjUe/6OGfilrcdrklxa0fyMqQIbSMBjC9rr7g+2db+mC1C/pSwNEOHjnM8OcObtSeTz9khtd/jB8aFggYbnmFAJgBEvOmiPLFpaDObBKVMytSK/M8j63gmu2fGIWZAupnyCG1BKe2YOpOwG4nOwlRSqUhISUosYFotfAgMBAAE=';
    public static final String PRIVATE_KEY = 'MIICWwIBAAKBgGem2Z/GaUjUe/6OGfilrcdrklxa0fyMqQIbSMBjC9rr7g+2db+m\nC1C/pSwNEOHjnM8OcObtSeTz9khtd/jB8aFggYbnmFAJgBEvOmiPLFpaDObBKVMy\ntSK/M8j63gmu2fGIWZAupnyCG1BKe2YOpOwG4nOwlRSqUhISUosYFotfAgMBAAEC\ngYA2mwH/WGnTAo4oNvibs7zvWE6M9RO3Nus6vuD+6a8vMCgEgx1ZT8KaUbxUjrWc\nK2tK8dKs9cl+IsBWu8T+ej4vF3R01pVHRhkWRakpwwCeF7vlUwAj49tcnAqcXQZb\nIXImD3mp+yGWT2jQ9wyPnJc9fxEevHruxaYap2OzGepzQQJBALczGIS4jwxufy8h\nBKhLD3uJTEy5EMLcWelyMPRV6zcxle86uIqTfBgexwJAxE4zZ2B5lTKRW09/G8xo\n0YfeB68CQQCQ11lSHa65LUxuG55yd2cDRriFsGeoolehucLL1OPCX5+Mm0PcKYgY\nfZQ2YMDa87wJHA3j1e+3DnSQZgGm5fNRAkB0XM0XCA88azb3nXZS2xJjekrvdKEz\n1Dh78h8sIyK7NRCyGk87HgC1ZV8sjCzkKvxfp/pfWzpvXSIwDOgB78JbAkBI4+by\neTeVvyMogkOxzT8NGgkAVm9EITbCj65lT6SzC9ZKN1TmNgxkbsYou3YyedhWKUUg\nNGinkeG9TWhlanGRAkEAq0qKYyeCvCP6zIHd5bP/sX9vokqoYYyC22swKEqIcZGV\nNoHOtaaeNR914ruRn2Gx6auH/TTPgDL8CgxxdigIgQ==';
    public static final String VALID_JWT ='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJpc3MiOiJ1c2VyIn0.YGWxvelNqOzIFnOQt_dK4vsf_Sj65Cki1z4NT6VWYzc';
    
    public static void setPublicTestKey() {
        JWTPublicKey.PUBLIC_KEY = PUBLIC_KEY;
    }
    
    public static void setPublicTestFakeKey() {
        JWTPublicKey.PUBLIC_KEY = FAKE_PUBLIC_KEY;
    }

    @TestSetup
    static void makeData(){
        setPublicTestKey();
    }

    public static String createValidJWT() {
        String algorithmName = 'RSA-SHA256';
        Blob privateKeyBlob = EncodingUtil.base64Decode(PRIVATE_KEY);
        String tokenPart1 = '{"alg":"HS256","typ":"JWT"}';
        Blob tokenPart1Blob = Blob.valueOf(tokenPart1);
        String tokenPart2 = '{"sub":"1234567890","name":"John Doe","iat":1516239022,"iss":"user"}';
        Blob tokenPart2Blob = Blob.valueOf(tokenPart2);
        String separator = '.';

        String tokenHeader = EncodingUtil.base64Encode(tokenPart1Blob) + separator + EncodingUtil.base64Encode(tokenPart2Blob);
        Blob tokenHeaderBlob = Blob.valueOf(tokenHeader);
        
        Blob signature = Crypto.sign(algorithmName, tokenHeaderBlob, privateKeyBlob);
        
        String signatureBase64 = EncodingUtil.base64Encode(signature);
        String urlSafeSignatureBase64 = signatureBase64.replace('+', '-').replace('/', '_');
        urlSafeSignatureBase64 = urlSafeSignatureBase64.replace('=', '');
        String tokenPart3 = urlSafeSignatureBase64;
        
        String jwt = tokenHeader + separator + tokenPart3;
        return jwt;
    }
    
    public static String createInvalidJWT() {
        String algorithmName = 'RSA-SHA512';
        Blob privateKeyBlob = EncodingUtil.base64Decode(PRIVATE_KEY);
        String tokenPart1 = '{"alg":"HS256","typ":"JWT"}';
        Blob tokenPart1Blob = Blob.valueOf(tokenPart1);
        String tokenPart2 = '{"sub":"1234567890","name":"John Doe","iat":1516239022,"iss":"user"}';
        Blob tokenPart2Blob = Blob.valueOf(tokenPart2);
        String separator = '.';

        String tokenHeader = tokenPart1 + separator + tokenPart2;
        Blob tokenHeaderBlob = Blob.valueOf(tokenHeader);
        
        Blob signature = Crypto.sign(algorithmName, tokenHeaderBlob, privateKeyBlob);
        
        String signatureBase64 = EncodingUtil.base64Encode(signature);
        String urlSafeSignatureBase64 = signatureBase64.replace('+', '-').replace('/', '_');
        urlSafeSignatureBase64 = urlSafeSignatureBase64.replace('=', '');
        String tokenPart3 = urlSafeSignatureBase64;
        
        String fakeTokenPart2 = '{"sub":"0123456789","name":"John Doe","iat":1516239022,"iss":"user"}';
        String fakeTokenHeader = tokenPart1Blob + separator + tokenPart2Blob;

        String jwt = fakeTokenHeader + separator + tokenPart3;
        return jwt;
    }

    
    @IsTest
    public static void deveValidarJWT() {
        String jwt = createValidJWT();
        
        Test.startTest();
            setPublicTestKey();
            Boolean valid = JWTUtility.isValidJwt(jwt);
        Test.stopTest();
        
        Assert.isTrue(valid, 'não autenticou JWT válido');
    }
    
    @IsTest
    public static void naoDeveValidarJWTComPublicKeyFalsa(){
    
        String jwt = createInValidJWT();
        setPublicTestFakeKey();
        Test.startTest();
            Boolean valid = JWTUtility.isValidJwt(jwt);
        Test.stopTest();
        
        Assert.isFalse(valid, 'autenticou JWT com chave pública falsa');
    }
    
    @IsTest
    public static void naoDeveValidarJWTNaoAssinado(){
        String jwt = createInvalidJWT();
        setPublicTestKey();
        Test.startTest();
            Boolean valid = JWTUtility.isValidJwt(jwt);
        Test.stopTest();
        
        Assert.isFalse(valid, 'autenticou JWT não assinado');
    }
    @IsTest
    public static void jwtBodyRetornoValido(){
        Test.startTest();
            JWTUtility.PayLoadJwtWrapper payLoadReturn = JWTUtility.getJWTBody(VALID_JWT) ;
        Test.stopTest();
        
        Assert.isNotNull(payLoadReturn, 'Jwt Inválido');

    }
    @IsTest
    public static void jwtBodyRetornoInValido(){
        String invalidJwt='mockError';
        Boolean isInvalid =false;
        Test.startTest();
        try {
            JWTUtility.PayLoadJwtWrapper payLoadReturn = JWTUtility.getJWTBody(invalidJwt) ;
        } catch (Exception e) {
            isInvalid =true;
        }
          
        Test.stopTest();
        
        Assert.isTrue(isInvalid);

    }
    
}