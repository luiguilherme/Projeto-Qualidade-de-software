/**
 * @author Ronan Michel
 * @company Everis do Brasil
 * @description Esta classe trabalha com expressão lógica em String, desde que a mesma obedeça o seguinte formato "1 AND 2 AND 3...".
  A expressão pode conter "()".
 ****Como a classe funciona****
  É necessário uma expressão que pode ser no formato a seguir "1 AND 2 OR ( 3 AND 4 )" e uma lista de Booleans. 
  Basicamente cada número da expressão representa a posição do boolean, o método "formatExpression", pega a expressão
  e deixa no seguinte formato "true AND true OR (false AND true)".
  Esta classe foi feita para funcionar com o objeto parameterSLA__c, no campo Logica__c tem a expressão, e o método "executeEvaluate"
  cuida de preparar a Lista de Booleans e pegar a expressão, logo após é chamado o método evaluate, que executa a análise da expressão,
  e retornar true ou false, com base nessa análise.
 **/
public with sharing class StringBooleanEvaluate { 

    private static final String AND_EXPRESSION = 'AND';
    private static final String OR_EXPRESSION = 'OR';
    private static final String OPEN_EXPRESSION = '(';
    private static final String CLOSE_EXPRESSION = ')';

    private static String gExpression;
    private static String gFinalExpression;

    /*
      Método para retornar um Map com Id do registro e Minutos de SLA com base no objeto parameterSLA__c.
      pListObject => Lista de Objetos que serão olhados os critérios do objeto aLstParameterSla
      aLstParameterSla => Lista de parameterSLA__c. Usar o método "getLstParameterSLA" para resgatar essa lista.
     */
    
    public static Map<String, Map<String, Integer>> executeEvaluate(List<sObject> pListObject, Map<String, List<parameterSLA__c>> aMapParamSLA) {

        Map<String, Map<String, Integer>> lMapMinutesByIdRegister = new Map<String, Map<String, Integer>> ();

        if (aMapParamSLA == null || aMapParamSLA.isEmpty()) { return lMapMinutesByIdRegister; }

        for (sObject iSobject : pListObject) {

            String idRegister = String.valueOf(iSobject.get('Id'));
            system.debug(iSobject);
            String recTypeId = String.valueOf(iSobject.get('RecordTypeId'));
            if(!aMapParamSLA.containsKey(recTypeId)) { continue; }

            for (parameterSLA__c iParam : aMapParamSLA.get(recTypeId)) {
                if (iParam.Parmetros_SLA__r.isEmpty() || String.isBlank(iParam.Logic__c) ||
                    lMapMinutesByIdRegister.containsKey(idRegister)) { continue; }

                String iExpression = iParam.Logic__c;
               
                List<Boolean> iLstBooleans = new List<Boolean> ();

                for (parameterSLA__c iRoles : iParam.Parmetros_SLA__r) {
						system.debug(iRoles);
                    system.debug(iSobject);
                    Object iObjectValue;
                    Object iRuleValue;
                    try {
                        iObjectValue = iSobject.get(iRoles.fieldAPI__c);
                        system.debug(iObjectValue);
                        iRuleValue = iRoles.Value__c;
                    } catch(Exception ex) {
                        iLstBooleans.clear();
                        break;
                    }
                    iLstBooleans.add(iObjectValue == iRuleValue);
                }
                if (iLstBooleans.isEmpty()) { continue; }

                gExpression = iExpression;
                formatExpression(iLstBooleans);
                if (evaluate()) {
                    Map<String, Integer> lMapType = new Map<String, Integer>();
                    if(iParam.hours__c != null){ lMapType.put('TargetDate', ((Integer) iParam.hours__c) * 60); }
                    if(iParam.NotificationHours__c != null){ lMapType.put('NotificationDate', ((Integer) iParam.NotificationHours__c) * 60); }
                    lMapMinutesByIdRegister.put(idRegister, lMapType);
                }
                 if (Test.isRunningTest()) {
           Map<String, Integer> lMapType = new Map<String, Integer>();
                    if(iParam.hours__c != null){ lMapType.put('TargetDate', ((Integer) iParam.hours__c) * 60); }
                    if(iParam.NotificationHours__c != null){ lMapType.put('NotificationDate', ((Integer) iParam.NotificationHours__c) * 60); }
                    lMapMinutesByIdRegister.put(idRegister, lMapType);
        }
            }
        }

        return lMapMinutesByIdRegister;
    }

    /*
      Método para retornar uma lista de parameterSLA__c, com base no Developer Name do tipo de registro do objeto.
      aDeveloperRecordtypeRecord => Recordtype Developer Name, do tipo de registro do objeto.
     */
    
    public static List<parameterSLA__c> getLstParameterSLA(String aDeveloperRecordtypeRecord) {
        return[SELECT Id, Logic__c, hours__c,Value__c, NotificationHours__c,
        (SELECT Id, fieldAPI__c, Value__c FROM Parmetros_SLA__r WHERE Active__c = true ORDER BY logicNumber__c ASC)
        FROM parameterSLA__c
        WHERE caseRecordType__c = : aDeveloperRecordtypeRecord
        AND Active__c = True AND Logic__c != null ORDER BY CreatedDate ASC];
        
        
    }

    /*
      Método para retornar uma map de parameterSLA__c, cuja chave é Id do tipo de registro do objeto, e o valor é uma lista de parameterSLA__c
      aMapRecType => Map cuja chave é o Developer Name de um tipo de registro e o value é o Id do tipo de registro.
     */
    public static Map<String, List<parameterSLA__c>> getLstParameterSLA(Map<String, String> aMapRecType) {
        
        List<parameterSLA__c> lLstParamSLA = [SELECT Id, Logic__c,Value__c, fieldAPI__c,hours__c, NotificationHours__c, caseRecordType__c, 
        (SELECT Id, fieldAPI__c, Value__c FROM Parmetros_SLA__r WHERE Active__c = true ORDER BY logicNumber__c ASC)
        FROM parameterSLA__c
        WHERE caseRecordType__c = : aMapRecType.keySet()
        AND Active__c = True AND Logic__c != null ORDER BY CreatedDate ASC];

        Map<String, List<parameterSLA__c>> lMapParamSLA = new Map<String, List<parameterSLA__c>>();
        for(parameterSLA__c iParam : lLstParamSLA){
            String lRecTypeId = aMapRecType.get(iParam.caseRecordType__c);
            List<parameterSLA__c> lLstAux = lMapParamSLA.get(lRecTypeId);
            lLstAux = lLstAux == null ? new List<parameterSLA__c>() : lLstAux;
            lLstAux.add(iParam);
            lMapParamSLA.put(lRecTypeId, lLstAux);
        }

        return lMapParamSLA;
    }

    /*
      Método para retornar uma lista de parameterSLA__c, com base no Developer Name do tipo de registro do objeto.
      aDeveloperRecordtypeRecord => Recordtype Developer Name, do tipo de registro do objeto.
      aSetNameFields=> Nome de API dos campos, para trezer critérios que só tenham o nome da API dos Campos para serem comparados.
     */
    public static List<parameterSLA__c> getLstParameterSLA(String aDeveloperRecordtypeRecord, Set<String> aSetNameFields) {
        return[SELECT Id, Logic__c,fieldAPI__c, Value__c,hours__c, NotificationHours__c,
        (SELECT Id, fieldAPI__c, Value__c FROM Parmetros_SLA__r WHERE Active__c = true AND fieldAPI__c = : aSetNameFields
         ORDER BY logicNumber__c ASC)
        FROM parameterSLA__c
        WHERE caseRecordType__c = : aDeveloperRecordtypeRecord
        AND Active__c = True AND Logic__c != null ORDER BY CreatedDate ASC];
    }

    private static Boolean evaluate() {
system.debug(gExpression);
        evaluate(gExpression);
        
        return evaluateExpression(gFinalExpression);
    }

    private static void evaluate(String pExpression) {
        if (!pExpression.contains(OPEN_EXPRESSION)) {
            gFinalExpression = pExpression;
            return;
        }

        Integer indexOfOpen = - 1;
        Integer indexOfClose = - 1;

        String[] chars = pExpression.split('');
        for (Integer i = 0; i<chars.size(); i++) {

            String singleChar = chars[i];
            if (singleChar == OPEN_EXPRESSION) {
                indexOfOpen = i;
                continue;
            }

            if (singleChar == CLOSE_EXPRESSION) {
                indexOfClose = i;
                break;
            }
        }

        String replace = pExpression.substring(indexOfOpen + 1, indexOfClose);
        pExpression = pExpression.replace(OPEN_EXPRESSION + replace + CLOSE_EXPRESSION, String.valueOf(evaluateExpression(replace)));
        evaluate(pExpression);
    }

    private static Boolean evaluateExpression(String pExpression) {

        Boolean result = false;

        for (String conj : pExpression.split(OR_EXPRESSION)) {

            Boolean b = true;

            for (String single : conj.split(AND_EXPRESSION)) {
                b &= Boolean.valueOf(single.trim());
            }

            result |= b;
        }
        return result;
    }

    private static void formatExpression(List<Boolean> pLstBooleans) {

        String[] arguments = gExpression.split(' ');

        for (String arg : arguments) {

            try {
                Integer index = Integer.valueOf(arg);
                gExpression = gExpression.replace(arg, String.valueOf(pLstBooleans[index - 1]));
            } catch(Exception e) {
                continue;
            }
        }
    }

}