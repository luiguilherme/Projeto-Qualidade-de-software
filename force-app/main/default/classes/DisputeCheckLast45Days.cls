public with sharing class DisputeCheckLast45Days {
    @InvocableMethod(label='Existe contestação nos últimos 45 dias?')
    public static LIST<DisputeCheckLast45DaysOutputs> checkLast45Days(LIST<DisputeCheckLast45DaysInputs> parameters){
        LIST<DisputedItem__c> disputeLast45Days = DisputedItemDAO.getDisputeLast45Days(parameters.get(0).accountId, parameters.get(0).description);
        List<DisputeCheckLast45DaysOutputs> listResult = new List<DisputeCheckLast45DaysOutputs>();
        DisputeCheckLast45DaysOutputs result =  new DisputeCheckLast45DaysOutputs();
        
        result.checaContestacao = disputeLast45Days.size() > 0 ? 'Sim' : 'Não';
        result.checaNegada = 'Não';
        
        if(result.checaContestacao == 'Sim'){
            for (DisputedItem__c dispute : disputeLast45Days) {
                if (dispute.Status__c == 'Denied'){
                    result.checaNegada = 'Sim';
                }
            }
        }
        listResult.add(result);
        return listResult;
    }

    public class DisputeCheckLast45DaysInputs{
        @InvocableVariable
        public String accountId;
    
        @InvocableVariable
        public String description;
    }

    public class DisputeCheckLast45DaysOutputs{
        @InvocableVariable
        public String checaContestacao;
    
        @InvocableVariable
        public String checaNegada;
    }
}