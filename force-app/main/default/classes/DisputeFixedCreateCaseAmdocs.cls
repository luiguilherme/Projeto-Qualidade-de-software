public with sharing class DisputeFixedCreateCaseAmdocs {

    @AuraEnabled
    public static Map<String, Object> createCaseAmdocs(Map<String, Object> inputs) {
        try {
            Map<String, Object> integrationProcedureOptions = new Map<String, Object> ();
            Map<String, Object> integrationProcedureOutput = callIntegrationProcedure('Dispute_FixedConvergentFraudCaseCreate', inputs, integrationProcedureOptions);

            return integrationProcedureOutput;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static Map<String, Object> callIntegrationProcedure(String integrationProcedureName, Map<String, Object> integrationProcedureInputs, Map<String, Object> integrationProcedureOptions) {
        return (Map<String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(integrationProcedureName, integrationProcedureInputs, integrationProcedureOptions);
    }

}