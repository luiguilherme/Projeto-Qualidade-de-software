public with sharing class JWTPublicKey {
    public static String PUBLIC_KEY;
    static {
        JWTPublickey__mdt JWTMdt = [SELECT Value__c FROM JWTPublickey__mdt];
        PUBLIC_KEY = JWTMdt.Value__c;
    }
}