/**
 * @author Ronan Michel
 * @company everis do Brasil
 * @description Classe usada na trigger de ParameterSLA__c, para validar se o formato da Expressão Lógica é valida. 
*/
public with sharing class ValidateLogicParameterSLA {
 
    Private static final String RT_PARAM_RULES = RecordTypeUtil.getByDevName('ParameterSLA__c', 'Rule');

    public static void execute() {
        Set<String> lSetCaracterValids = new Set<String> { 'AND', 'OR', '(', ')' };
        String lFormatExpression = '"1 AND 2 OR 3 AND ( 4 OR 5 )"';

        for (ParameterSLA__c iParam : (List<ParameterSLA__c>) Trigger.new) {
            if (iParam.RecordTypeId != RT_PARAM_RULES || String.isBlank(iParam.Logic__c)) { continue; }

            for (String iCaracter : iParam.Logic__c.split(' ')) {
                if (!lSetCaracterValids.contains(iCaracter) && !iCaracter.isNumeric()) {
                    iParam.addError('A a expressão "' + iParam.Logic__c + '" não está correta, favor seguir o seguinte formato: ' +
                                    lFormatExpression + ' Certifique-se de ter ESPAÇO estre os caracteres.');
                }
            }
        }
    }
}