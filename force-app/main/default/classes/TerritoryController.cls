global without sharing class TerritoryController implements vlocity_cmt.VlocityOpenInterface2 {
    public Boolean invokeMethod(String methodName, Map<String,Object> input, Map<String,Object> output, Map<String,Object> options) {
        Boolean result = true;
        try{
            if (methodName.equalsIgnoreCase('getRepresentantesCarteira')) {
                getRepresentantesCarteira(input, output, options);
            } else {
                output.put('result','');
            }
        } catch (Exception e) {
            throw new AccessTokenException('Falha ao retornar o resultado: ' + e.getMessage());
        }
        return result;
    }

    public static void getRepresentantesCarteira(Map<String,Object> input, Map<String,Object> output, Map<String,Object> options) {  
        String territoryId = (String)input.get('territoryId');
        List<UserTerritory2Association> lstUsersTerritory = [SELECT Id, User.Email, User.Name, User.FirstName, User.LastName FROM UserTerritory2Association WHERE Territory2Id = :territoryId];
        List<User> lstUsers = new List<User>();
        for (UserTerritory2Association u : lstUsersTerritory){
            User w = new User();
            w.FirstName = u.User.Name;
            w.Email = u.User.Email;
            lstUsers.add(w);
        }
        output.put('result',lstUsers);
    }
}