/* -------------------------------------------------------------------------
* Autor....: Guilherme Kaiser - Deloitte
* Projeto..: Vivo - VALENTINA
* Descrição: script criado para criar palitos automáticos RELEASE SETEMBRO 2024
* Data.....: 27/05/2024
* --------------------------------------------------------------------------
* A T E N Ç Ã O : ESTE SCRIPT É APENAS PARA INCLUSÃO DE REGISTROS NA TABELA TOPICSAUTO__C - EXECUTAR APENAS 1 VEZ
* --------------------------------------------------------------------------
* Definição de valores de campo:
* Process__c   -> Nome do Ponto de palitagem a ser utilizado(funcionalidade)
* Channel__c   -> {Lojas Próprias, Revenda, Call Center, Integração}
* Status__c    -> {Ativo, Inativo}
* Topic__c     -> path completo do palito na árvore de palitagem (palito já deve estar cadastrado)
* Type__c      -> {Topic, API, Case}
* StartDate__c -> Data e hora criação
* EndDate__c   -> Data e hora desativação (quando criar sempre passar nulo)
* TopicId__c   -> Id do palito na árvore (CustomerInteractionTopicTree__c.Id). Preenchido automáticamente por esse script.
* --------------------------------------------------------------------------
* Alterações
*  -------------------------------------------------------------------------
* Data: 27/05/2024
* Palitos (Processo): Ajuste de Saldo - Atendimento, Ajuste de Saldo - Lojas/Revendas
* Bloco/Jornada/US: Bloco 15/J65/US1234 - Ressarcimento
*  -------------------------------------------------------------------------
* Data:   /  /2024
* Palitos (Processo): ..., ..., ...
* Bloco/Jornada/US: Bloco 99/J99/US1234 - nome jornada
*  -------------------------------------------------------------------------
*
*/

public class CreateTopicsAutoReleaseSetembro2024 {   
    //
    public CreateTopicsAutoReleaseSetembro2024() {
    //
    // Create a list of TopicsAuto__c to add
    //
    List<TopicsAuto__c> topicsAutoList = new List<TopicsAuto__c> {
         new TopicsAuto__c(Process__c= 'Ajuste de Saldo'                   ,Channel__c= 'Lojas Próprias',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Créditos > Cartão Pré Pago > Divergência de Saldo',Type__c= 'Case')
        ,new TopicsAuto__c(Process__c= 'Ajuste de Saldo'                   ,Channel__c= 'Revenda'       ,Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Créditos > Cartão Pré Pago > Divergência de Saldo',Type__c= 'Case')
        ,new TopicsAuto__c(Process__c= 'Ajuste de Saldo'                   ,Channel__c= 'Call Center'   ,Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Créditos > Saldo > Saldo Divergente',Type__c= 'Case')
        ,new TopicsAuto__c(Process__c= 'Tranferência de Titularidade'      ,Channel__c= 'Lojas Próprias',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços Loja > Transferência de Titularidade',Type__c= 'Topic')
        ,new TopicsAuto__c(Process__c= 'Tranferência de Titularidade'      ,Channel__c= 'Revenda'       ,Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços Loja > Transferência de Titularidade',Type__c= 'Topic')
        ,new TopicsAuto__c(Process__c= 'Tranferência de Titularidade'      ,Channel__c= 'Call Center'   ,Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Cadastro > Transferência de Titularidade',Type__c= 'Topic')
//      ,new TopicsAuto__c(Process__c= 'Recusa de xxxxxxxxxxxxxxxxx',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'API')

    };
                
    String key;
    String serviceTree;
    String channel='';
    
    Map<String, CustomerInteractionTopicTree__c> mapTree = new Map<String, CustomerInteractionTopicTree__c>(); 
    List<CustomerInteractionTopicTree__c> lstTree =[select Id, Name, ParentTopicId__c, Type__c, ServiceTree__c from CustomerInteractionTopicTree__c where  (ProductType__c= 'Pre' and Active__c= true) or (name='Início' and ParentTopicId__c =null)];
    List<TopicsAuto__c> newLstTree = new List<TopicsAuto__c>();
    
    for(CustomerInteractionTopicTree__c topic : lstTree) {
        if(topic.name.Trim()=='Início'){
        	key = 'ParentTopicId__c='+topic.ParentTopicId__c+'|name='+topic.name+'|type__c='+topic.type__c;
        } else{
        	key = 'ParentTopicId__c='+topic.ParentTopicId__c+'|name='+topic.name+'|type__c='+topic.type__c+'|serviceTree__c='+topic.serviceTree__c;
        }
        mapTree.put(key, topic);
    }

    for(TopicsAuto__c obj : topicsAutoList) {
    
        Integer sizelstAlpha;
        Integer idxCurrent =0;
        String source;
        
        List<String> lstAlpha = obj.Topic__c.split('>');
        sizelstAlpha = lstAlpha.Size();
       
        switch on obj.Channel__c {
            when 'Lojas Próprias'
            {Channel='Lojas Proprias';serviceTree='Store';}
            when 'Revenda'
            {Channel='Lojas Revendas';serviceTree='Store';}            
            when 'Call Center'        
            {Channel='Call Center';serviceTree='Service';}
        }
       
        for(String topicItem : lstAlpha){
            idxCurrent++;
            String type = idxCurrent!=sizelstAlpha ? 'Pasta' : 'Palito';
                
            
            if(topicItem.Trim()=='Início' &&idxCurrent==1){
                key = 'ParentTopicId__c='+source+'|name='+topicItem.Trim()+'|type__c='+type;
            }else{
                key = 'ParentTopicId__c='+source+'|name='+topicItem.Trim()+'|type__c='+type+'|serviceTree__c='+serviceTree;
            }
            
            if(mapTree.containsKey(key)){
                CustomerInteractionTopicTree__c recordTree = mapTree.get(key);
                source = (String) recordTree.get('Id');
                if(type=='Palito'){
                    obj.TopicId__c=source;
                    newLstTree.Add(obj);
                }
            }
        }
    }
    // Bulk update all TopicsAuto__c with one DML call
    Database.insert(newLstTree);
    }
}