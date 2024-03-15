public class CartIdJSONFilter {

    @InvocableMethod(label='Extract CartId from JSON')
    public static List<CartIdResult> extractCartId(List<String> jsonInputs) {
        List<CartIdResult> results = new List<CartIdResult>();

        for(String jsonInput : jsonInputs) {
            Map<String, Object> jsonData = (Map<String, Object>) JSON.deserializeUntyped(jsonInput);
            String cartIdFilter = (String) jsonData.get('cartId');

            CartIdResult result = new CartIdResult();
            result.cartIdFilter = cartIdFilter;
            results.add(result);
        }

        return results;
    }

    // Inner class to structure the result
    public class CartIdResult {
        @InvocableVariable(label='CartId Filter')
        public String cartIdFilter;
    }
}