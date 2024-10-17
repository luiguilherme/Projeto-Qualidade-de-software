# PTI-3652 - Contestação de Fatura Móvel

## Criando uma nova Definição de Atendimento através de Script Apex:

1. Entre na ORG que será criada a Definição de Atendimento

1. Clique na engremagem, que se localiza no lado direito superior da tela 

1. Clique na opção "Developer Console" abrirá uma nova tela

1. Na parte superior do lado esquerdo, clique em "Open Execute Anonymous Window"

1. Abriá uma tela em branco, cole o seguinte código nessa tela:

    ```
    List<ServiceDefinition__c> serviceDefinitionsToCreate = new List<ServiceDefinition__c>{
        new ServiceDefinition__c(
            Name='Verificar se existe evidência de contratação', 
            AttendantMessage__c='Ajuste concedido! Informe o cliente que foi feita a contestação.', 
            Closure__c='NEGADO > FRAUDE > ABERTURA CHAMADO', 
            ClosureMapping__c='INFORMACAO > ATENDIMENTO > CLIENTE ORIENTADO', 
            Context__c='Informação', 
            DisputeDenied__c=false, 
            GeneratesRecordsLegacySystem__c=false, 
            IsActive__c=true, 
            RecordTypeId='0125f000000a4atAAA', 
            ServiceDefinitionName__c ='ATC-MVL-FIN-CONT-ATRIBUIDO-FRAUDE-003', 
            RootCause__c=false,
            Status__c='Closed', 
            StatusItem__c='Approved',
            LegacySystem__c='NEXT',
            StepCode__c = 'PLANO031.3'
        )
    };
    insert serviceDefinitionsToCreate;
    ```

1. Clique em "Execute"

## Desativação e Ativação de OmniScripts
Realizar a ativação e desativação para os seguintes OmniScripts:

* DisputeDuplicateBilling

* DisputeAmountDifferentFromNegotiated

* DisputeNotRecognizeQualificationOrPlanChange

* MobileAdjust

### Passo a Passo

1.  Acesse a ORG onde será realizado o processo pós-deploy;

1.  Clique no App Launcher, localizado no canto superior esquerdo;

1.  Pesquise por OmniStudio e clique no aplicativo correspondente;

1.  No canto superior esquerdo, clique na seta ao lado da aba OmniStudio;

1.  Uma lista será expandida. Clique em "OmniScripts";

1.  Use a campo "Find in page" para pesquisar pelo nome: "DisputeDuplicateBilling";

1.  Expanda as opções e clique na versão mais recente do componente;

1.  No canto superior direito, clique no botão "Deactivate Version";

1.  Uma pop-up será exibida. Clique em "Done";

1. No canto superior direito, clique no botão "Activate Version";

1. Uma nova pop-up será exibida. Clique em "Done";

1. Repita os passos 4 e 5;

1. Use a campo "Find in page" para pesquisar pelo nome: "DisputeAmountDifferentFromNegotiated";

1. Repita os passos 7 a 11;

1. Repita os passos 4 e 5;

1. Use a campo "Find in page" para pesquisar pelo nome: "DisputeNotRecognizeQualificationOrPlanChange";

1. Repita os passos 7 a 11;

1. Repita os passos 4 e 5;

1. Use a campo "Find in page" para pesquisar pelo nome: "MobileAdjust";

1. Repita os passos 7 a 11.

## Desativação e Ativação de Integration Procedure

Realizar a ativação e desativação para a seguinte Integration Procedure:

* ValidateServiceDefinitionNotRecognize

### Passo a Passo:
1. Acesse a ORG onde será realizado o processo pós-deploy;

1. Clique no App Launcher, localizado no canto superior esquerdo;

1. Pesquise por OmniStudio e clique no aplicativo correspondente;

1. No canto superior esquerdo, clique na seta ao lado da aba OmniStudio;

1. Uma lista será expandida. Clique em "OmniStudio Integration Procedures";

1. Use a campo "Find in page" para pesquisar pelo nome: "ValidateServiceDefinitionNotRecognize";

1. Expanda as opções e clique na versão mais recente do componente;

1. Em Structure, clique em "Procedure Configuration";

1. Em Properties, clique no botão "Deactivate Version", localizado na parte inferior da tela;

1. Aguarde o carregamento da tela;

1. Em Structure, clique novamente em "Procedure Configuration";

1. Em Properties, clique no botão "Activate Version", localizado na parte inferior da tela.