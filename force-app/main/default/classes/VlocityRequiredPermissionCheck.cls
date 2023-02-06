/*
 * Autor: Leandro Alexandrino Pereira da Silva - Deloitte
 * Criado em: 10/12/2021
 * Desenvolvimento de acordo com a documentação em https://docs.vlocity.com/en/Implement-the-VlocityRequiredPermissionCheck-Class-825555.html
*/

global class VlocityRequiredPermissionCheck implements Callable
{
    global Boolean call(String action, Map<String, Object> args)
    {
        if (action == 'checkPermission')
        {
            return checkPermission((String)args.get('requiredPermission'));
        }
        return false;
    }

    private Boolean checkPermission(String requiredPermission)
    {
        Boolean hasCustomPermission = false;
        List<String> customPermissionsName = requiredPermission.split(',');
        for (String permissionName : customPermissionsName)
        {
            Boolean hasPermission = FeatureManagement.checkPermission(permissionName.normalizeSpace());
            if (hasPermission == true)
            {
                hasCustomPermission = true;
                break;
            }
        }
        return hasCustomPermission;
    }
}