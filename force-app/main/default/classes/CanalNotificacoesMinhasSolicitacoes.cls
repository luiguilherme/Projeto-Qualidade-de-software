public with sharing class CanalNotificacoesMinhasSolicitacoes {

    public List<CanalNotificacoesMinhasSolicitacoes__mdt> getMetadataByFuncionalidadeControlada(String funcionalidadeControlada) {
        return [
            SELECT Id, CallOut__c, PushSMS__c, MasterLabel
            FROM CanalNotificacoesMinhasSolicitacoes__mdt
            WHERE FuncionalidadeControlada__c = :funcionalidadeControlada
        ];
    }
}