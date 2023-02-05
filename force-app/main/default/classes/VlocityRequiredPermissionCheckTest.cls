/*
 * Autor: Leandro Alexandrino Pereira da Silva - Deloitte
 * Criado em: 10/12/2021
*/

@isTest
public class VlocityRequiredPermissionCheckTest {
    @isTest
    public static void call() {
        //Aplica uma permission set com a Custom Permission 'CustomPermissionTestPermission' ao usuário executando o código
        TestingUtils.activateCustomPerm(
            UserInfo.getUserId(),
            'CustomPermissionTestPermission'
        );
        String action;
        Map<String, Object> args = new Map<String, Object>();
        Boolean callCheckPermission;
        Boolean callNotCheckPermission;

        VlocityRequiredPermissionCheck cVlocityRequiredPermissionCheck = new VlocityRequiredPermissionCheck();

        System.runAs(new User(Id = UserInfo.getUserId())) {
            //Realização da chamada do método call para checar as permissões do usuário
            action = 'checkPermission';
            args.put('requiredPermission', 'CustomPermissionTestPermission');
            callCheckPermission = cVlocityRequiredPermissionCheck.call(action, args);

            //Realização da chamada do método call para não checar as permissões do usuário
            action = 'notCheckPermission';
            callNotCheckPermission = cVlocityRequiredPermissionCheck.call(action, args);
        }

        System.assertEquals(true, callCheckPermission, 'Custom permission não foi encontrada no usuário, mas deveria.');
        System.assertEquals(false, callNotCheckPermission, 'Custom permission foi encontrada no usuário, mas a validação de permissão não deveria ter sido executada.');
    }
}