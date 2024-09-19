/**
  * @author Ronan Michel
  * @company everis do Brasil
  * @description Classe de teste da classe StringBooleanEvaluate. 
*/
@Istest
public class StringBooleanEvaluateTest {
    
    @Istest
    
    private static void myTest(){
// User lUserGN = BI_DataLoad.getUserGN();
        //database.insert(lUserGN);
        User lUserGN = [SELECT Id, Name, Profile.Name  FROM User WHERE Profile.Name like '%admin%'and IsActive = true limit 1];

        //Account lAccount = BI_DataLoad.getAccount();
       // lAccount.Subsegmento_do_Cliente__c = 'Massivo';
        //lAccount.BI_No_Identificador_fiscal__c = '25867521000171';
       // system.runAs(lUserGN){ database.insert(lAccount); }

        Case lCase = new Case();
        //lCase.RecordTypeId = CaseRecordTypes.REGISTERADDRESSATSREBASE;
        //lCase.AccountId = lAccount.Id;
        lCase.Status = 'Rascunho';
        System.runAs(lUserGN){ Database.insert(lCase); }
        List<Case> lLstCases= new List<Case>{lCase};
         
        ParameterSLA__c lParameter= new ParameterSLA__c();
        lParameter.Logic__c= '1 AND 2 AND ( 3 OR 4 )';
        lParameter.hours__c= 2;
        lParameter.Name= 'Regra SLA';
        lParameter.Active__c= true;
        lParameter.caseRecordType__c= 'RegisterAddressAtSREBase';
        lParameter.RecordTypeId= RecordTypeUtil.getByDevName('ParameterSLA__c', 'Rule');
        System.runAs(new User(Id = UserInfo.getUserId())){Database.insert(lParameter);}
            
        
        //ParameterSLA__c lCriterio1= generateCriteria('Criterio 1', 'AccountId', null, lParameter.Id, 1);
        ParameterSLA__c lCriterio2= generateCriteria('Criterio 2', 'Status', 'Rascunho', lParameter.Id, 2);
        ParameterSLA__c lCriterio3= generateCriteria('Criterio 3', 'Status', 'Em andmento', lParameter.Id, 3);
        ParameterSLA__c lCriterio4= generateCriteria('Criterio 4', 'Status', 'Rascunho', lParameter.Id, 4);
       System.runAs(new User(Id = UserInfo.getUserId())){ Database.insert(new List<ParameterSLA__c>{ lCriterio2, lCriterio3, lCriterio4});}
        
        String lTargetDate = 'TargetDate';
        Test.startTest();
        Map<String, String> aMapRecType = new Map<String, String>{'RegisterAddressAtSREBase' => lCase.RecordTypeId};
        Map<String, List<parameterSLA__c>> lLstParameterSla= StringBooleanEvaluate.getLstParameterSLA(aMapRecType);
        Map<String,Map<String,Integer>> lMapMinutes= StringBooleanEvaluate.executeEvaluate(lLstCases,lLstParameterSla);
       // System.assert(lMapMinutes.get(lCase.Id).get(lTargetDate) == ((Integer) lParameter.hours__c) * 60);
        Test.stopTest();
    }
    private static ParameterSLA__c generateCriteria(String aName, String aField, String aValue, Id aRule, Integer aNumberLogic){
        ParameterSLA__c lCriteria= new ParameterSLA__c();
        lCriteria.Name= aName;
        lCriteria.logicNumber__c= aNumberLogic;
        lCriteria.Active__c= true;
        lCriteria.fieldAPI__c= aField;
        lCriteria.Value__c= aValue;
        lCriteria.Rule__c= aRule;
        lCriteria.RecordTypeId= RecordTypeUtil.getByDevName('ParameterSLA__c', 'Criteria');
        return lCriteria;
        
    }
    
}