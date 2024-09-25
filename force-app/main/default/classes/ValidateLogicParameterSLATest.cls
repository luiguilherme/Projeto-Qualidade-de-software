/**
 * @author Ronan Michel
 * @company everis do Brasil
 * @description Classe de teste da classe ValidateLogicParameterSLA. 
*/
@Istest
public class ValidateLogicParameterSLATest {

    @Istest
    private static void myTestValidateExpressionInvalid() {

        ParameterSLA__c lParameter = new ParameterSLA__c();
        lParameter.Logic__c = '1 AND2';
        lParameter.hours__c = 2;
        lParameter.Name = 'Regra SLA';
        lParameter.Active__c = true;
        lParameter.caseRecordType__c = 'RegisterAddressAtSREBase';
        lParameter.RecordTypeId = RecordTypeUtil.getByDevName('ParameterSLA__c', 'Rule');

        Test.startTest();
        Database.SaveResult lSavRes = database.insert(lParameter, false);
        Test.stopTest();

    }

    @Istest
    private static void myTestValidateExpressionValid() {

        ParameterSLA__c lParameter = new ParameterSLA__c();

        lParameter.hours__c = 2;
        lParameter.Name = 'Regra SLA';
        lParameter.Active__c = true;
        lParameter.caseRecordType__c = 'RegisterAddressAtSREBase';
        lParameter.RecordTypeId = RecordTypeUtil.getByDevName('ParameterSLA__c', 'Rule');
        database.insert(lParameter);

        Test.startTest();
        lParameter.Logic__c = '1 AND 2';
        Database.SaveResult lSavRes = database.update(lParameter, false);
        System.assert(lSavRes.isSuccess(), 'A expressão lógica ' + lParameter.Logic__c + ' é válida.');
        Test.stopTest();

    }

}