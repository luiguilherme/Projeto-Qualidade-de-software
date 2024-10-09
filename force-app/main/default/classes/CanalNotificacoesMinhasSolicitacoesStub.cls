@IsTest
public with sharing class CanalNotificacoesMinhasSolicitacoesStub implements StubProvider {
    List<CanalNotificacoesMinhasSolicitacoes__mdt> canais;
    public CanalNotificacoesMinhasSolicitacoesStub(List<CanalNotificacoesMinhasSolicitacoes__mdt> canais) {
        this.canais = canais;
    }
    public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, 
        Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames, 
        List<Object> listOfArgs) {
        return this.canais;
    }
}