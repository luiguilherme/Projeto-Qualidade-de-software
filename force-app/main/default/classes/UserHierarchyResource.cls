@RestResource(urlMapping='/User/Hierarchy')
global without sharing class UserHierarchyResource {
    private static final String ERROR_4041 = '{"code": "4041", "error": "Erro! Gerente não encontrado."}';
    private static final String ERROR_4042 = '{"code": "4042", "error": "Erro! Operador não encontrado."}';
    private static final String ERROR_4043 = '{"code": "4043", "error": "Erro! Supervisor não encontrado."}';
    private static final String ERROR_4044 = '{"code": "4044", "error": "Erro! Gerente não encontrado. Operador não encontrado. Supervisor não encontrado."}';
    private static final String ERROR_5000 = '{"code": "5000", "error": "Erro! Matrícula do Operador, Gerente e Supervisor não pode ser vazio."}';

	@HttpPost
    global static void updateHierarchy(String operator, String manager, String supervisor) {
        RestResponse response = RestContext.response;
        
        response.addHeader('Content-Type', 'application/json');
        
        if (String.isBlank(operator) || String.isBlank(manager) || String.isBlank(supervisor)) {
            response.statusCode = 500;
            response.responseBody = Blob.valueOf(JSON.serialize(JSON.deserializeUntyped(ERROR_5000)));
            
            return;
        }
        
        List<User> ltUsers = UserDAO.getByLogin(new Set<String>{operator, manager, supervisor});
        
        User operatorUser;
        User managerUser;
        User supervisorUser;
        
        for (User user : ltUsers) {
            if (user.Login__c.equalsIgnoreCase(operator)) {
                operatorUser = user;
        
            } else if (user.Login__c.equalsIgnoreCase(manager)) {
                managerUser = user;
            
            } else if (user.Login__c.equalsIgnoreCase(supervisor)) {
                supervisorUser = user;
            }
        }
        
        if (operatorUser == null || managerUser == null || supervisorUser == null) {
            String erro = '';
            
			if (operatorUser == null && managerUser == null && supervisorUser == null) {
				erro = ERROR_4044;

            } else if (operatorUser == null) {
				erro = ERROR_4042;

			} else if (managerUser == null) {
				erro = ERROR_4041;
            
            } else if (supervisorUser == null) {
				erro = ERROR_4043;
            }
            
            response.statusCode = 500;
            response.responseBody = Blob.valueOf(JSON.serialize(JSON.deserializeUntyped(erro)));
            
            return;
        }
        
        try {
            operatorUser.ManagerId = managerUser.Id;        
            operatorUser.SupervisorId__c = supervisorUser.Id;
            
            update operatorUser;
            
            response.statusCode = 200;

        } catch (Exception e) {
            response.statusCode = 500;
            response.responseBody = Blob.valueOf(e.getMessage());
        }
    }
}