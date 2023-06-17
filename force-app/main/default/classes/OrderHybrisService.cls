public with sharing class OrderHybrisService {
    public static Map<String, Object> syncOrderStatusWithHybris(String orderIssuedId) {
        return OrderHybrisEngine.syncOrderStatusWithHybris(orderIssuedId);
        
    }
}