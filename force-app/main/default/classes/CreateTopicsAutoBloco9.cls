/* -------------------------------------------------------------------------
* Autor....: Guilherme Kaiser - Deloitte
* Projeto..: Vivo - VALENTINA
* Descrição: script criado para criar palitos automáticos
* Data.....: 09/04/2024
* -------------------------------------------------------------------------
* A T E N Ç Ã O : ESTE SCRIPT É APENAS PARA INCLUSÃO DE REGISTROS NA TABELA TOPICSAUTO__C - EXECUTAR APENAS 1 VEZ
* -------------------------------------------------------------------------
* Alterações
*  -------------------------------------------------------------------------
* Data: 
* Palitos (Processo):
* Bloco/Jornada: 
*  -------------------------------------------------------------------------
*
*/

public class CreateTopicsAutoBloco9 {   
    //
    public CreateTopicsAutoBloco9() {
    //
    // Create a list of TopicsAuto__c to add
    //
    List<TopicsAuto__c> topicsAutoList = new List<TopicsAuto__c> {
        new TopicsAuto__c(Process__c= 'Sincronização de Linhas Pré',Channel__c= 'Lojas Próprias',Status__c= 'Ativo',	StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Sincronização de Linhas Pré',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Sincronização de Linhas Pré',Channel__c= 'Revenda',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Sincronização de Linhas Pré',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Sincronização de Linhas Pré',Channel__c= 'Call Center',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Sincronização de Linhas Pré',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Estorno de Port Out',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Autorização Port IN com marcação de Winback',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Portabilidade Numérica > Status de Win Back > Autorização Negada',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Autorização Port IN',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Portabilidade Numérica > Status de PORT IN > Autorização Negada',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Port-IN E Estorno de Port-Out-Sem Respostas SMS',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Port In Negado > Dados Incorretos',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Port-IN E Estorno de Port-Out-Dupla Autenticação',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Port In Negado > Dados Incorretos',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Port-IN E Estorno de Port-Out-Área Local Inválida',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Port In Negado > Dados Incorretos',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Port-IN E Estorno de Port-Out-Rejeição de Reversão de Fraude',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Port In Negado > Dados Incorretos',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Port-IN E Estorno de Port-Out-Tipo de Cliente não Combina',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Port In Negado > Dados Incorretos',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Port-IN E Estorno de Port-Out-CNPJ Inválido',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Port In Negado > Dados Incorretos',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Port-IN E Estorno de Port-Out-Campo Genérico de Identificação Inválido',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Port In Negado > Dados Incorretos',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Port-IN E Estorno de Port-Out-CPF Inválido',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Port In Negado > Dados Incorretos',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Port IN e Estorno de Port Out',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Port In Negado > Linha Inexistente',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Remoção de conflito deBilhete de Estorno de Port-Out',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Remoção de conflito de Bilhete de Port-In',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Reagendamento da janela de Bilhete de Estorno de Port-Out',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Reagendamento da janela de Bilhete de Port-In',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Suspensão de Bilhete de Estorno de Port-Out',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Suspensão de Bilhete de Port-In',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Cancelamento de Bilhete de Estorno de Port-Out',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Recusa de Solicitação de Cancelamento de Bilhete de Port-In',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Autorizar doação Estorno de Port In',Channel__c= 'Integração',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Portabilidade Numérica > Status de Análise de Fraude > Aguardando Autorização',Type__c= 'API'),
        new TopicsAuto__c(Process__c= 'Portabilidade - Rejeição por Dados Incorretos',Channel__c= 'Revenda',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Port In Negado > Dados Incorretos',Type__c= 'Case'),
        new TopicsAuto__c(Process__c= 'Portabilidade - Rejeição por Dados Incorretos',Channel__c= 'Lojas Próprias',Status__c= 'Ativo',StartDate__c= datetime.now(),	EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Port In Negado > Dados Incorretos',Type__c= 'Case'),
        new TopicsAuto__c(Process__c= 'Portabilidade - Rejeição por Dados Incorretos',Channel__c= 'Call Center',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Port In Negado > Dados Incorretos',Type__c= 'Case'),
        new TopicsAuto__c(Process__c= 'Portabilidade - Suspeita de Fraude no Port-Out',Channel__c= 'Revenda',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Suspeita de Fraude > Port Out Incorreto',Type__c= 'Case'),
        new TopicsAuto__c(Process__c= 'Portabilidade - Suspeita de Fraude no Port-Out',Channel__c= 'Lojas Próprias',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Suspeita de Fraude > Port Out Incorreto',Type__c= 'Case'),
        new TopicsAuto__c(Process__c= 'Portabilidade - Suspeita de Fraude no Port-Out',Channel__c= 'Call Center',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Suspeita de Fraude > Port Out Incorreto',Type__c= 'Case'),
        new TopicsAuto__c(Process__c= 'Portabilidade com Erro',Channel__c= 'Revenda',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'Case'),
        new TopicsAuto__c(Process__c= 'Portabilidade com Erro',Channel__c= 'Lojas Próprias',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'Case'),
        new TopicsAuto__c(Process__c= 'Portabilidade com Erro',Channel__c= 'Call Center',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Incidências > Portabilidade Numérica > Status > Erros',Type__c= 'Case'),
        new TopicsAuto__c(Process__c= 'Troca de Número com Portabilidade',Channel__c= 'Call Center',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços Loja > Troca de Número com Portabilidade',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Troca de Número com Portabilidade',Channel__c= 'Lojas Próprias',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços Loja > Troca de Número com Portabilidade',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Troca de Número com Portabilidade',Channel__c= 'Revenda',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços Loja > Troca de Número com Portabilidade',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Troca de Número',Channel__c= 'Call Center',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Troca de Número',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Troca de Número',Channel__c= 'Lojas Próprias',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Troca de Número',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Troca de Número',Channel__c= 'Revenda',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Troca de Número',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Troca de Chip Sem Aquisição',Channel__c= 'Call Center',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Aparelhos > Troca de Chip > Sem Aquisição',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Troca de Chip Sem Aquisição',Channel__c= 'Lojas Próprias',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Aparelhos > Troca de Chip > Sem Aquisição',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Troca de Chip Sem Aquisição',Channel__c= 'Lojas Próprias',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Aparelhos > Troca de Chip > Com Aquisição',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Desbloqueio Perda e Roubo',Channel__c= 'Call Center',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Desbloqueio Por Perda ou Roubo > Linha',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Desbloqueio Perda e Roubo',Channel__c= 'Lojas Próprias',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Desbloqueio Por Perda ou Roubo > Linha',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Desbloqueio Perda e Roubo',Channel__c= 'Revenda',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Desbloqueio Por Perda ou Roubo > Linha',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Desbloqueio a Pedido',Channel__c= 'Call Center',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Desbloqueio a Pedido do Cliente > Linha',Type__c='Topic'),
        new TopicsAuto__c(Process__c= 'Desbloqueio a Pedido',Channel__c= 'Lojas Próprias',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Desbloqueio a Pedido do Cliente > Linha',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Desbloqueio a Pedido',Channel__c= 'Revenda',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Desbloqueio a Pedido do Cliente > Linha',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Bloqueio Perda e Roubo',Channel__c= 'Call Center',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Bloqueio Por Perda ou Roubo > Linha',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Bloqueio a Pedido',Channel__c= 'Call Center',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Bloqueio a Pedido do Cliente > Linha',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Bloqueio a Pedido',Channel__c= 'Lojas Próprias',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Bloqueio a Pedido do Cliente > Linha',Type__c= 'Topic'),
        new TopicsAuto__c(Process__c= 'Bloqueio a Pedido',Channel__c= 'Revenda',Status__c= 'Ativo',StartDate__c= datetime.now(),EndDate__c=  null,Topic__c= 'Início > Serviços > Serviços Básicos > Bloqueio a Pedido do Cliente > Linha',Type__c= 'Topic')};
                
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