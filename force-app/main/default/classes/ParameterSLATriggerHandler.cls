/**
  * @author Ronan Michel
  * @company everis do Brasil
  * @description Classe Handler da Trigger de ParameterSLA__c
*/
public class ParameterSLATriggerHandler implements ITrigger {
    public void bulkBefore() { }

    public void bulkAfter() { } 

    public void beforeInsert() {
        ValidateLogicParameterSLA.execute();
    }

    public void beforeUpdate() {
        ValidateLogicParameterSLA.execute();
    }

    public void beforeDelete() { }

    public void afterInsert() { }

    public void afterUpdate() { }

    public void afterDelete() { }

    public void andFinally() { }
}