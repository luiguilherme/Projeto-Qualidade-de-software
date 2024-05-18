/*
* @author Diego Costa @ Deloitte
* @date 06/06/2022
* @description classe Util 
*/
public with sharing class Util {
    
    public static Boolean validateUserIdInformation(Id accountId){
        Account accountObj = AccountDAO.getByIds(accountId);
        return (accountObj != null && accountObj.UserId__c != null);
    }

    public static Webservice__c getWebService(String webServiceName){
        Webservice__c wsConfig = new Webservice__c();
        wsConfig = Webservice__c.getInstance(webServiceName);

        //valida se encontrou
        if(wsConfig == null){
            throw new AuraHandledException('Nenhum webservice encontrado com o nome: ' + webServiceName);
        }

        //Valida se está ligado.
        if(!wsConfig.switchedOn__c){
            throw new AuraHandledException('Webservice está desativado, acesse a configuração do mesmo, caso queira usa-lo');
        }

        return wsConfig;
    }

    public static String getNumbers(String stringValue){

        Pattern objPattern = Pattern.compile('([0-9]+)');
        Matcher objMatcher = objPattern.matcher(stringValue);

        return objMatcher.find() ? objMatcher.group(1) : '';
    }

    public static String getEnvironmentName() {
        String baseUrl = URL.getOrgDomainURL().toExternalForm();
        
        return baseUrl.contains('--')
            ? '.' + baseUrl.substringAfterLast('--').substringBefore('.') 
            : '';
    }


}