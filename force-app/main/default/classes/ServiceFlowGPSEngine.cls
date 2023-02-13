/*
*
*   Description: Classe responsável exclusivamente pelas regras de negócio do Fluxo de Atendimento do GPS
*
*   Author: Geimison Oliveira
*   Date:   15/06/2021
*
*/
public with sharing class ServiceFlowGPSEngine {

    private static final String CASE_ORIGIN_GPS = 'GPS';
    private static final String CASE_PRIORITY_LOW = 'Low';
    private static final String CASE_PRODUCT_FIXA = 'Fixa';
    private static final String CASE_STATUS_CLOSED = 'Closed';
    private static final String BILLING_ACCOUNT_FIXA = 'Fixa';
    private static final String CASE_PRIORITY_MEDIUM = 'Medium';
    private static final String GPS_CANVAS_APP_NAME = 'GpsCanvas';
    private static final String CASE_STATUS_EM_ATENDIMENTO = 'Em Atendimento';
    private static final String CTI_INTEGRATION_QUEUE = 'CTIIntegrationQueue';
    private static final String CASE_SUBJECT_PALITAGEM_FIXA = 'Palitagem Fixa';
    private static final String EXCEPTION_MESSAGE = 'Exception on ServiceFlowGPSEngine -->';

    private static final Id CURRENT_USER_ID = UserInfo.getUserId();
    private static final Id RECORDTYPE_ID_CASE_CTI = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('CTIService').getrecordTypeId();
    private static final Id RECORDTYPE_ID_CASE_FIXA = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('FixedServiceQualification').getrecordTypeId();

    public static List<Asset> getAssetFixedByAccount(Id accountId) {
        List<Asset> ltAsset = AssetDAO.getAssetFixedByAccount(accountId);        
        return ltAsset;
    }

    public static Map<String, Object> getAccountInfo(Id accountId) {
        Map<String, Object> mapResult = new Map<String, Object>();
        List<Account> ltAccount = AccountDAO.getAccountById(accountId);        
        List<Account> lstBillingAccount = BillingAccountDAO.getByAccountIdDeveloperName(accountId, BILLING_ACCOUNT_FIXA);

        if(!ltAccount.isEmpty() && ltAccount[0] != null){
            mapResult.put('account', ltAccount[0]);
        }
        if(!lstBillingAccount.isEmpty() && lstBillingAccount[0] != null){
            mapResult.put('billingAccount', lstBillingAccount[0]);
        }
        return mapResult;    
    }
    
    public static List<Account> getAccountById(Id accountId) {
        List<Account> ltAccount = AccountDAO.getAccountById(accountId);        
        return ltAccount;
    }
    
    public static Map<String, Object> getServiceFlow(String pageReference){
        Map<String, Object> mapReturn = new Map<String, Object>();
        Set<String> setSegment = new Set<String>();
        List<FromToMapping__mdt> ltFromToMapping = new List<FromToMapping__mdt>();
        User user = UserDAO.getById(UserInfo.getUserId());
        String userRole = user.PartnerGroup__c != null ? user.PartnerGroup__c : user.UserRole.DeveloperName;

        ltFromToMapping = FromToMappingDAO.getServiceTreeOperatorSegmentIdentifier(userRole);
        CollectionUtil.loadSet(setSegment, 'OperatorSegment__c', ltFromToMapping);        

        List<CustomerInteractionTopicTree__c> ltCustomerInteractionTopicTree = new List<CustomerInteractionTopicTree__c>();
        System.debug('pageReference: ' + pageReference);
        ltCustomerInteractionTopicTree = CustomerInteractionTopicTreeDAO.getServiceFlowBySegment(setSegment, pageReference);
        
        if(ltCustomerInteractionTopicTree != null){
            mapReturn.put('ltCustomerInteractionTopicTree', ltCustomerInteractionTopicTree);
        }
        
        return mapReturn;
    }
    
    public static Map<String, Object> getActionGPS(Id serviceFlowId, String assetInstance){
        Map<String, Object> mapResponse = new Map<String,Object>();
        try{
            String gpsId;
            
            for(CustomerInteractionTopicTree__c item : CustomerInteractionTopicTreeDAO.getEndFlowCustomerInteractionTopicTreeById(serviceFlowId)){
                gpsId = item.GPSId__c;
            }
            
            GPSGroup gpsGroup = new GPSGroup();
            List<GPSGroup> ltPreviousGroups = new List<GPSGroup>();
            mapResponse = ServiceFlowDiagnosticCallout.execute(mapResponse, null, assetInstance, gpsGroup, null);

            ServiceFlowDiagnosticResponse response;
            if(!mapResponse.containsKey('error') && mapResponse.get('success') != null){
                response = (ServiceFlowDiagnosticResponse) mapResponse.get('success');
                gpsGroup = createGPSGroup(mapResponse, response);
                
                if(response.grupoDiagnostico != null && response.grupoDiagnostico.pai != null){
                    ltPreviousGroups = getPreviousGroups(response.grupoDiagnostico.pai, ltPreviousGroups, mapResponse);
                }
            }else{
                if(mapResponse.get('errorToast') != null){
                    ServiceFlowGPSFormResponse responseDetails = (ServiceFlowGPSFormResponse) mapResponse.get('errorToast');
                    String errorMessage = 'Ocorreu um erro na chamada externa, tente novamente';
                    if(responseDetails.erro != null && responseDetails.erro.descricao != null){
                        errorMessage = responseDetails.erro.descricao.replaceAll('<[^>]+>',' ');
                    }
                    mapResponse.put('errorToast', errorMessage);
                }
            }

            if(response.resultadoAtendimento != null && response.resultadoAtendimento.rotinas != null){
                for(ServiceFlowDiagnosticResponse.Rotina rotina : response.resultadoAtendimento.rotinas.rotina){
                    for(ServiceFlowDiagnosticResponse.Formularios formulario : rotina.formularios){
                        if(formulario.id != null){
                            mapResponse = getForm(mapResponse, gpsGroup.token, formulario.id);
                            mapResponse.put('rotina', true);
                            continue;
                        }
                    }
                }
            }

            mapResponse.put('response', gpsGroup);
            mapResponse.put('ltPreviousGroups', ltPreviousGroups);
            
            return mapResponse;
        }catch (Exception e){
            if(mapResponse.get('errorToast') == null){
                mapResponse.put('errorToast', e.getMessage());
            }
            return mapResponse;
        }finally{
            ServiceTransaction.getInstance().commitTransactionsList();
        } 
    }

    public static Map<String, Object> getNextGroup(String currentGroup) {
        Map<String, Object> mapResponse = new Map<String, Object>();
        try{
            GPSGroup gps = new GPSGroup();
            gps = (GPSGroup) System.JSON.deserialize(currentGroup, GPSGroup.class);

            if(gps != null){
                mapResponse = ServiceFlowDiagnosticCallout.execute(mapResponse, null, null, gps, null);
            }

            GPSGroup gpsGroup = new GPSGroup();
            List<GPSGroup> ltPreviousGroups = new List<GPSGroup>();

            ServiceFlowDiagnosticResponse response;
            if(!mapResponse.containsKey('error') && mapResponse.get('success') != null){
                response = (ServiceFlowDiagnosticResponse) mapResponse.get('success');
                gpsGroup = createGPSGroup(mapResponse, response);

                if(response.grupoDiagnostico.pai != null){
                    ltPreviousGroups = getPreviousGroups(response.grupoDiagnostico.pai, ltPreviousGroups, mapResponse);
                }
            }else{
                if(mapResponse.get('errorToast') != null){
                    ServiceFlowGPSFormResponse responseDetails = (ServiceFlowGPSFormResponse) mapResponse.get('errorToast');
                    String errorMessage = 'Ocorreu um erro na chamada externa, tente novamente';
                    if(responseDetails.erro != null && responseDetails.erro.descricao != null){
                        errorMessage = responseDetails.erro.descricao.replaceAll('<[^>]+>',' ');
                    }
                    mapResponse.put('errorToast', errorMessage);
                }
            }

            if(response.resultadoAtendimento != null && response.resultadoAtendimento.rotinas != null){
                for(ServiceFlowDiagnosticResponse.Rotina rotina : response.resultadoAtendimento.rotinas.rotina){
                    for(ServiceFlowDiagnosticResponse.Formularios formulario : rotina.formularios){
                        if(formulario.id != null){
                            mapResponse = getForm(mapResponse, gpsGroup.token, formulario.id);
                            mapResponse.put('rotina', true);
                            continue;
                        }
                    }
                }
            }
            
            mapResponse.put('ltPreviousGroups', ltPreviousGroups);
            mapResponse.put('response', gpsGroup);
            
            return mapResponse;
        }catch (Exception e){
            if(mapResponse.get('errorToast') == null){
                mapResponse.put('errorToast', e.getMessage());
            }
            return mapResponse;
        }finally{
            ServiceTransaction.getInstance().commitTransactionsList();
        } 

    }

    public static GPSGroup createGPSGroup(Map<String, Object> mapResponse, ServiceFlowDiagnosticResponse response){
        GPSGroup gpsGroup = new GPSGroup();
        List<GPSAction> ltAction = new List<GPSAction>();
    
        gpsGroup.token = response.token;
        gpsGroup.codigoOperacao = response.codigoOperacao;
        if(response.formularios != null && response.formularios.formulario != null && response.formularios.formulario.size() > 0){
            for(ServiceFlowDiagnosticResponse.Formulario formulario : response.formularios.formulario){

                mapResponse = getForm(mapResponse, gpsGroup.token, formulario.id);                
                
                return gpsGroup;
            }
        }

        if(response.grupoDiagnostico == null || response.grupoDiagnostico.id == null){
            return gpsGroup;
        }

        gpsGroup.id = String.valueOf(response.grupoDiagnostico.id);
        gpsGroup.nome = response.grupoDiagnostico.nome;
        gpsGroup.status = response.status;

        if(response.resultadoAtendimento != null){
            GPSGroup.ResultadoAtendimento resultadoAtendimento = new GPSGroup.ResultadoAtendimento();
            gpsGroup.resultadoAtendimento = new GPSGroup.ResultadoAtendimento();

            resultadoatendimento.id = String.valueOf(response.resultadoAtendimento.id);
            resultadoatendimento.codigo = response.resultadoAtendimento.codigo;
            resultadoatendimento.mensagem = response.resultadoAtendimento.mensagem;
            gpsGroup.resultadoAtendimento = resultadoAtendimento;
        }
        gpsGroup.ltResultadoAtendimento = new List<GPSGroup.ResultadoAtendimento>();
        if(response.resultadosAtendimento != null){
            
            for(ServiceFlowDiagnosticResponse.ResultadoAtendimento resultado : response.resultadosAtendimento.resultadoAtendimento){
                GPSGroup.ResultadoAtendimento resultadoAtendimento = new GPSGroup.ResultadoAtendimento();

                resultadoatendimento.id = String.valueOf(resultado.id);
                resultadoatendimento.codigo = resultado.codigo;
                resultadoatendimento.mensagem = resultado.mensagem;

                gpsGroup.ltResultadoAtendimento.add(resultadoatendimento);
            }
        }
        if(response.informacoesTransferencia != null){
            GPSGroup.InformacoesTransferencia informacoesTransferencia = new GPSGroup.InformacoesTransferencia();

            informacoesTransferencia.celulasDestino = response.informacoesTransferencia.celulasDestino.celulaDestino;
            informacoesTransferencia.celulasOrigem = response.informacoesTransferencia.celulasOrigem.celulaOrigem;

            gpsGroup.informacoesTransferencia = informacoesTransferencia;
        }

        gpsGroup.ltAction = createGPSAction(response.grupoDiagnostico.acoes.acao, mapResponse, response.token);

        if(response.campos != null){
            gpsGroup = getFields(gpsGroup, response.campos.campo);
        }

        return gpsGroup;

    }

    public static List<GPSGroup> getPreviousGroups(ServiceFlowDiagnosticResponse.Pai responsePai, List<GPSGroup> ltPreviousGroups, Map<String, Object> mapResponse){
        GPSGroup gpsGroup = new GPSGroup();
        List<GPSGroup> ltGPSGroupAux = new List<GPSGroup>();
        List<GPSAction> ltAction = new List<GPSAction>();
        
        gpsGroup.id = String.valueOf(responsePai.id);
        gpsGroup.nome = responsePai.nome;
        ServiceFlowDiagnosticResponse response = (ServiceFlowDiagnosticResponse) mapResponse.get('success');
        gpsGroup.token = response.token;
        
        gpsGroup.ltAction = createGPSAction(responsePai.acoes.acao, mapResponse, '');
        
        ltGPSGroupAux.add(gpsGroup);
        ltGPSGroupAux.addAll(ltPreviousGroups);

        if(responsePai.pai != null){
            ltGPSGroupAux = getPreviousGroups(responsePai.pai, ltGPSGroupAux, mapResponse);
        }

        return ltGPSGroupAux;
    }

    public static GPSProtocol getProtocol(String accountId, String assetInstance, String currentGroup, Id serviceFlowId, String parentCaseId) {
        Map<String, Object> mapResponse = new Map<String, Object>();
        GPSGroup gpsGroup = new GPSGroup();
        gpsGroup = (GPSGroup) System.JSON.deserialize(currentGroup, GPSGroup.class);

        for(GPSGroup.Campo textField : gpsGroup.ltText){
            if(textField.valor == null || textField.valor == ''){
                textField.valor = 'null';
            }
        }

        for(GPSGroup.Campo numberField : gpsGroup.ltNumber){
            if(numberField.valor == null || numberField.valor == ''){
                numberField.valor = 'null';
            }
        }

        for(GPSGroup.Campo checkboxField : gpsGroup.ltCheckbox){
            if(checkboxField.valor == null || checkboxField.valor == ''){
                checkboxField.valor = 'false';
            }
        }

        for(GPSGroup.Campo comboboxField : gpsGroup.ltCombobox){
            if(comboboxField.valor == null || comboboxField.valor == ''){
                comboboxField.valor = 'null';
            }
        }
        
        if(gpsGroup != null){
            mapResponse = ServiceFlowProtocolCallout.execute(mapResponse, gpsGroup);
        }        
        
        GPSProtocol gpsProtocol = new GPSProtocol();
        ServiceFlowProtocolResponse response;
        if(mapResponse.get('success') != null){
            response = (ServiceFlowProtocolResponse) mapResponse.get('success');

            gpsProtocol.protocol = response.protocolo;

            for(ServiceFlowProtocolResponse.Parametro parametro : response.parametros.parametro){
                if(parametro.chave == 'ERRO'){
                    gpsProtocol.errorDetail = '';
                    for(ServiceFlowProtocolResponse.Parametro param : parametro.parametros.parametro){
                        if(param.chave == 'Detalhe'){
                            gpsProtocol.errorDetail += param.valor;
                        }
                    }
                } else if(parametro.chave == 'ID_SS'){
                    gpsProtocol.ssNumber = parametro.valor;
                } else if(parametro.chave == 'STATUS_SS'){
                    gpsProtocol.ssStatus = parametro.valor;
                } else if(parametro.chave == 'EXPECTATIVA_ATENDIMENTO'){
                    gpsProtocol.serviceExpectation = parametro.valor;
                }
            }
        }

        createCase(accountId, assetInstance, gpsProtocol, serviceFlowId, parentCaseId);
        
        return gpsProtocol;
    }

    public static List<GPSAction> createGPSAction(List<ServiceFlowDiagnosticResponse.Acao> ltActions, 
                                                    Map<String, Object> mapResponse,
                                                    String token){
        List<GPSAction> ltAction = new List<GPSAction>();

        for(ServiceFlowDiagnosticResponse.Acao acao : ltActions){
            String mediaType = acao.midia != null && acao.midia.tipo != null ? acao.midia.tipo : '';
            String mediaUrl = acao.midia != null && acao.midia.url != null ? acao.midia.url : '';
            String link;
            String linkAlias;
            if(acao.atributosAdicionais != null){
                for(ServiceFlowDiagnosticResponse.AtributoAdicional atributo : acao.atributosAdicionais.atributoAdicional){
                    if(atributo.chave == 'LINK'){
                        link = atributo.valor;
                    } else if(atributo.chave == 'LINK_ALIAS'){
                        linkAlias = atributo.valor;
                    }
                }
            }
            String informacoesAdicionais = acao.informacoesAdicionais != null ? acao.informacoesAdicionais : '';
            String error = acao.erro != null ? acao.erro : '';

            if(mediaType == 'IMAGEM'){
                List<StaticResource> ltStaticResource = new List<StaticResource>(); 
                ltStaticResource = StaticResourceDAO.getByDescription(mediaUrl);

                if(!ltStaticResource.isEmpty()){
                    mediaUrl = '/resource/' + ltStaticResource[0].Name;
                }
            }
            
            if (acao.formulario != null && acao.formulario.id != null) {
                mapResponse = getForm(mapResponse, token, acao.formulario.id);

                ServiceFlowGPSFormResponse formResponse;
                if(mapResponse.get('form') != null){
                    formResponse = (ServiceFlowGPSFormResponse) mapResponse.get('form');
                    if(formResponse.formulario.id == 'formularioConsultaAtendimento'){
                        Map<String, Object> mapForm = new Map<String, Object>();
                        mapForm.put('CELULA_EPS_FORM_ACAO_CONSULTA', (Object)'CELULA_EPS_FORM_ACAO_CONSULTA');
                        mapResponse = ServiceFlowFormCallout.execute(mapResponse, token, formResponse.formulario.id, mapForm);
                        mapResponse = getFormValues(mapResponse);
                    }
                }
            }

            ltAction.add(new GPSAction(String.valueOf(acao.id), acao.nome, acao.status, acao.tipo, acao.resposta, acao.observacao, acao.tempo, mediaType, mediaUrl, link, linkAlias, informacoesAdicionais, error));                
        }
        return ltAction;
    }

    public static GPSGroup getFields(GPSGroup gpsGroup, List<ServiceFlowDiagnosticResponse.Campo> ltCampos){
        gpsGroup.ltNumber = new List<GPSGroup.Campo>();
        gpsGroup.ltText = new List<GPSGroup.Campo>();
        gpsGroup.ltCheckbox = new List<GPSGroup.Campo>();
        gpsGroup.ltCombobox = new List<GPSGroup.Campo>();

        for(ServiceFlowDiagnosticResponse.Campo campo : ltCampos){
            GPSGroup.Campo newField = new GPSGroup.Campo();
            newField.chave = campo.chave;
            if(campo.maxLenght != null){
                newField.maxLenght = campo.maxLenght;
            } else {
                newField.maxLenght = 0;
            }
            newField.readOnly = campo.readOnly;
            newField.tipo = campo.tipo;

            if(campo.tipo == 'NUMBER'){
                gpsGroup.ltNumber.add(newField);
            } else if(campo.tipo == 'TEXT'){
                gpsGroup.ltText.add(newField);
            } else if(campo.tipo == 'CHECKBOX'){
                if(campo.parametros != null){
                    for(ServiceFlowDiagnosticResponse.Parametro param : campo.parametros.parametro){
                        if(param.chave == 'VISIVEL'){
                            newField.isVisible = param.valor;
                        }else if(param.chave == 'VALOR_DEFAULT'){
                            newField.valor = param.valor;
                        }
                    }
                }
                gpsGroup.ltCheckbox.add(newField);
            } else if(campo.tipo == 'COMBOBOX'){
                List<ServiceFlowDiagnosticResponse.Parametro> ltParam = new List<ServiceFlowDiagnosticResponse.Parametro>();
                ServiceFlowDiagnosticResponse.Parametros ltParams = new ServiceFlowDiagnosticResponse.Parametros();
                
                for(ServiceFlowDiagnosticResponse.Parametro param : campo.parametros.parametro){
                    if(param.chave == 'VISIVEL'){
                        newField.isVisible = param.valor;
                    }else if(param.chave == 'VALOR_DEFAULT'){
                        newField.valor = param.valor;
                    }else{
                        param.chave = campo.chave;
                        ltParam.add(param);
                    }
                    
                }

                ltParams.parametro = ltParam;
                newField.parametros = ltParams;
                gpsGroup.ltCombobox.add(newField);
            }
        }

        return gpsGroup;
    }

    public static Map<String, Object> getForm(Map<String, Object> mapResponse, String token, String formId){

        mapResponse = ServiceFlowFormCallout.execute(mapResponse, token, formId, null);
        mapResponse = getFormValues(mapResponse);

        return mapResponse;
    }

    
    public static Map<String, Object> getFormValues(Map<String, Object> mapResponse){
        ServiceFlowGPSFormResponse formResponse;
        if(mapResponse.get('form') != null){
            formResponse = (ServiceFlowGPSFormResponse) mapResponse.get('form');
        }
        String formId = (String)formResponse.formulario.id;

        List<DatatableColumnsTO> ltDatatableColumns = new List<DatatableColumnsTO>();
        Set<String> setDatatableColumns = new Set<String>();
        List<DatatableDataTO> ltDatatableData = new List<DatatableDataTO>();
        List<Map<String,Object>> ltMapData = new List<Map<String,Object>>();
        List<ParametersDataTO> ltParametroData = new List<ParametersDataTO>();

        Boolean cleanParametersList = false;

        if(formResponse.formulario.etapa.parametros != null && formResponse.formulario.etapa.parametros.parametrosDisponiveis != null){
            for(ServiceFlowGPSFormResponse.Parametro parametroTable : formResponse.formulario.etapa.parametros.parametrosDisponiveis.parametro){

                Boolean addParameterToList = true;
                ParametersDataTO parametersData = new ParametersDataTO();
                parametersData.type = parametroTable.tipo;
                parametersData.value = parametroTable.valor;
    
                if(parametroTable.tipo == 'TABLE'){
                    
                    for(ServiceFlowGPSFormResponse.Parametro parametroTableLine : parametroTable.parametros.parametro){
    
                        if(formId == 'formularioVerificarDisponibilidadeFibraMb' || formId == 'selecaoInstanciaFormAtendimentoController'){
                            parametersData = createCustomDatatable(parametroTable.parametros.parametro, parametersData);

                            if(formId == 'selecaoInstanciaFormAtendimentoController'){

                                Set <String> instancesSet = new Set<String>();

                                for(List<DatatableItemTO> parametersLtData : parametersData.ltData ){

                                    String offerData;
                                    String offerType;
                                    String perfilCobranca;

                                    for(DatatableItemTO datatableItem : parametersLtData){

                                        if(datatableItem.columnName == 'Oferta'){
                                            offerData = datatableItem.value;
                                        }else if(datatableItem.columnName == 'Tipo Produto'){
                                            offerType = datatableItem.value;
                                        }else if(datatableItem.columnName == 'Perfil de Cobrança'){
                                            perfilCobranca = datatableItem.value;
                                        }
                                    }

                                    String offerId = offerData + '-' + perfilCobranca;

                                    for(DatatableItemTO datatableItem : parametersLtData){

                                        if(datatableItem.columnName == 'Oferta'){
                                            if(!instancesSet.contains(offerId)){
                                                instancesSet.add(offerId);
                                            }else{
                                                datatableItem.value = '';
                                            }
                                        }
                                    }

                                    for(DatatableItemTO datatableItem : parametersLtData){

                                        if(datatableItem.columnName == 'Sel.'){
                                            datatableItem.offerName = offerId;
                                            datatableItem.offerType = offerType;
                                        }else if(datatableItem.columnName == 'Tipo Produto'){
                                            datatableItem.offerName = offerId;
                                        }
                                    }
                                }

                            }
                        }
                        else{
                            cleanParametersList = true;
                            Map<String, Object> customObject = new Map<String, Object>();
                            if(parametroTableLine.tipo == 'TABLE_LINE'){
                                customObject.put('offerId', parametroTableLine.valor);
        
                                for(ServiceFlowGPSFormResponse.Parametro parametroItem : parametroTableLine.parametros.parametro){
                                    if(parametroItem.chave == 'Ações' || parametroItem.chave == 'Remover'){
                                        for(ServiceFlowGPSFormResponse.Parametro parametroButton : parametroItem.parametros.parametro){
        
                                            if(parametroButton.valor == 'Ações' || parametroButton.valor == 'Remover'){
                                                continue;
                                            }
        
                                            customObject.put(parametroButton.valor.deleteWhitespace().uncapitalize(), parametroButton.valor.deleteWhitespace().uncapitalize());
        
                                            if(setDatatableColumns.contains(parametroButton.valor)){
                                                continue;
                                            }
                                            Boolean readOnlyButton = false;
    
                                            if(parametroButton.readOnly != null && parametroButton.readOnly == 'true'){
                                                customObject.put('readOnlyButton', true);
                                            }
                                            DatatableColumnsTO datatableColumn = new DatatableColumnsTO(parametroButton.valor, parametroButton.valor.deleteWhitespace().uncapitalize(), parametroButton.tipo);
                                            ltDatatableColumns.add(datatableColumn);
                                            setDatatableColumns.add(parametroButton.valor);
                                        }
                                    }
                                    if(parametroItem.tipo == 'BUTTON'){
                                        for(ServiceFlowGPSFormResponse.Parametro parametroButton : parametroItem.parametros.parametro){
                                            if(parametroButton.valor != null){
                                                Blob base64Content = EncodingUtil.base64Decode(parametroButton.valor);
                                                String payload = base64Content.toString();
            
                                                customObject.put(parametroItem.chave.deleteWhitespace().uncapitalize(), payload);
                                            }
                                        }
                                    } else if(parametroItem.tipo == 'TEXT' && parametroItem.parametros != null){
                                        for(ServiceFlowGPSFormResponse.Parametro parametroText : parametroItem.parametros.parametro){
                                            if(parametroText.tipo == 'TEXT'){
                                                customObject.put(parametroItem.chave.deleteWhitespace().uncapitalize(), parametroText.valor);
                                            }
                                        }
        
                                    } else {
                                        
                                        customObject.put(parametroItem.chave.deleteWhitespace().uncapitalize(), parametroItem.valor);
                                        
                                    }
                                    
                                    if(setDatatableColumns.contains(parametroItem.chave)){
                                        continue;
                                    }
                                    
                                    if(parametroItem.tipo != 'CHECKBOX' && parametroItem.chave != 'Ações' && parametroItem.chave != 'Remover'){
                                        DatatableColumnsTO datatableColumn = new DatatableColumnsTO(parametroItem.chave, parametroItem.chave.deleteWhitespace().uncapitalize(), parametroItem.tipo);
                                        ltDatatableColumns.add(datatableColumn);
                                        setDatatableColumns.add(parametroItem.chave);
                                    }
        
        
                                }
                            }
                            ltMapData.add(customObject);
                        }
                    }
                } else if(parametroTable.tipo == 'TEXT'){
                    if(parametroTable.parametros != null){
                        String style;
                        if(formId != 'formularioVerificarDisponibilidadeFibraMb'){
                            style = 'slds-align_absolute-center';
                        }
    
                        for(ServiceFlowGPSFormResponse.Parametro tableLineParameter : parametroTable.parametros.parametro){
                            if (style == null) {
                                style = tableLineParameter.valor;
                            }else{
                                style = style + ' ' + tableLineParameter.valor;
                            }
                        }
                        parametersData.style = style;
                    }
    
                } else if(parametroTable.tipo == 'PANEL'){
                    ParametersDataTO cell;

                    if(parametersData.ltCombobox == null){
                        parametersData.ltCombobox = new List<ParametersDataTO>();
                    }

                    for(ServiceFlowGPSFormResponse.Parametro parametroTableLine : parametroTable.parametros.parametro){
                        
                        if(formId == 'formularioConsultaAtendimento'){
                            cell = new ParametersDataTO();
                            cell.value = parametroTableLine.valor;
                            cell.id = parametroTableLine.parametros.parametro[0].valor;

                            parametersData.ltCombobox.add(cell);
                        }
                    }
                } else {
                    
                    addParameterToList = false;
                    Map<String, Object> customObject = new Map<String, Object>();
                    
                    if(parametroTable.tipo == 'WARNING_MESSAGE' || parametroTable.chave == 'WARNING_MESSAGE') {
                        mapResponse.put('hasWarning', true);
                        mapResponse.put('warningMessage', parametroTable.valor);
                        mapResponse.put('ltColumns', '');
                        mapResponse.put('ltData', '');
                        break;
                    }
    
                    if(parametroTable.chave == 'WARNING_MESSAGE') {
                        mapResponse.put('hasWarning', true);
                        mapResponse.put('warningMessage', parametroTable.valor);
                    }
        
                    if(parametroTable.tipo == 'CHECKBOX' && parametroTable.valor != 'Selecionar tudo') {
                        customObject.put('valor', parametroTable.valor);
                        ltMapData.add(customObject);
                    }
                    
                    if(parametroTable != null && parametroTable.parametros != null) {
                        for(ServiceFlowGPSFormResponse.Parametro parametroTableLine : parametroTable.parametros.parametro){
                            if(parametroTableLine.parametros != null) {
                                for(ServiceFlowGPSFormResponse.Parametro parametroItem : parametroTableLine.parametros.parametro){
                                
                                    if(setDatatableColumns.contains(parametroItem.chave)){
                                        continue;
                                    }
                                    DatatableColumnsTO datatableColumn = new DatatableColumnsTO('Selecionar tudo', 'valor', 'text');
                                    ltDatatableColumns.add(datatableColumn);
                                    setDatatableColumns.add(parametroItem.chave);
                                }
                            }
                        }
                    }
                }
                
                if(addParameterToList){
                    ltParametroData.add(parametersData);
                }
            }
        }
        

        if(cleanParametersList){
            ltParametroData.clear();
        }
       
        mapResponse.put('codigoOperacao', (Object)formResponse.codigoOperacao);
        mapResponse.put('ltColumns', ltDatatableColumns);
        mapResponse.put('ltData', ltMapData);
        mapResponse.put('formHeaderLabel', (Object)formResponse.formulario.label);
        mapResponse.put('formId', (Object)formResponse.formulario.id);
        mapResponse.put('formStatus', (Object)formResponse.formulario.status);
        mapResponse.put('ltParametroData', ltParametroData);

        return mapResponse;
    }

    public static Map<String, Object> sendForm(String jsonMapForm, String currentGroup, String accountId, String assetInstance, Id serviceFlowId, String parentCaseId){
        Map<String, Object> mapResponse = new Map<String, Object>();
        try{ 
            Map<String, Object> mapForm = (Map<String, Object>) JSON.deserializeUntyped(jsonMapForm);

            GPSGroup gpsGroup = new GPSGroup();
            gpsGroup = (GPSGroup) System.JSON.deserialize(currentGroup, GPSGroup.class);
            
            if(gpsGroup != null){
                if(mapForm.get('FORM_ADC_ORDERNUM_RESENDEXTRACT') != null){
                    mapResponse = ServiceFlowFormCallout.execute(mapResponse, gpsGroup.token, 'reenviarExtratoDeComprasController', mapForm);
                } else if(mapForm.get('SERIAL_INSTANCIA_FORM_ATEND_SEL_INST') != null){
                    mapResponse = ServiceFlowFormCallout.execute(mapResponse, gpsGroup.token, 'selecaoInstanciaFormAtendimentoController', mapForm);
                } else if(mapForm.get('FORM_ADC_LINHAS_SMS_INCENTIVO') != null){
                    mapResponse = ServiceFlowFormCallout.execute(mapResponse, gpsGroup.token, 'formularioEnvioSMSIncentivo', mapForm);
                } else if(mapForm.get('FORM_DISPONIBILIDADE_FIBRA') != null){
                    mapResponse = ServiceFlowDiagnosticCallout.execute(mapResponse, null, null, gpsGroup, null);
                }else if(mapForm.get('FORM_ACAO_CONSULTA_REALIZADA') != null){
                    mapResponse = ServiceFlowFormCallout.execute(mapResponse, gpsGroup.token, 'formularioConsultaAtendimento', mapForm);
                }
            }

            ServiceFlowGPSFormResponse formResponse;
            if(mapResponse.get('form') != null){
                formResponse = (ServiceFlowGPSFormResponse) mapResponse.get('form');
            }

            if(!mapResponse.containsKey('error') && mapResponse.get('success') != null){

                List<GPSGroup> ltPreviousGroups = new List<GPSGroup>();
    
                ServiceFlowDiagnosticResponse response;
                if(!mapResponse.containsKey('error') && mapResponse.get('success') != null){
                    response = (ServiceFlowDiagnosticResponse) mapResponse.get('success');
                    gpsGroup = createGPSGroup(mapResponse, response);
    
                    if(response.grupoDiagnostico.pai != null){
                        ltPreviousGroups = getPreviousGroups(response.grupoDiagnostico.pai, ltPreviousGroups, mapResponse);
                    }
                }
    
                if(response.resultadoAtendimento != null && response.resultadoAtendimento.rotinas != null){
                    for(ServiceFlowDiagnosticResponse.Rotina rotina : response.resultadoAtendimento.rotinas.rotina){
                        for(ServiceFlowDiagnosticResponse.Formularios formulario : rotina.formularios){
                            if(formulario.id != null){
                                mapResponse = getForm(mapResponse, gpsGroup.token, formulario.id);
                                mapResponse.put('rotina', true);
                                continue;
                            }
                        }
                    }
                }
                
                mapResponse.put('ltPreviousGroups', ltPreviousGroups);
                mapResponse.put('response', gpsGroup);
            }

    
            if(formResponse != null){
                if(formResponse.formulario.status == 'PENDENTE'){
                    mapResponse = getFormValues(mapResponse);
                    List<GPSGroup> ltPreviousGroups = new List<GPSGroup>();

                    mapResponse.put('response', gpsGroup);
                    mapResponse.put('ltPreviousGroups', ltPreviousGroups);    

                    return mapResponse;
                } else if(formResponse.formulario.status == 'RESPONDIDO'){

                    if(gpsGroup.status == 'FINALIZADO'){
                        GPSProtocol gpsProtocol = new GPSProtocol();
        
                        gpsProtocol = getProtocol(accountId, assetInstance, currentGroup, serviceFlowId, parentCaseId);
                        mapResponse.put('protocol', gpsProtocol);

                        return mapResponse;
                    }
                    mapResponse = ServiceFlowDiagnosticCallout.execute(mapResponse, null, null, null, gpsGroup.token);
                    List<GPSGroup> ltPreviousGroups = new List<GPSGroup>();
    
                    ServiceFlowDiagnosticResponse response;

                    if(!mapResponse.containsKey('error') && mapResponse.get('success') != null){
                        response = (ServiceFlowDiagnosticResponse) mapResponse.get('success');
                        gpsGroup = new GPSGroup();

                        gpsGroup = createGPSGroup(mapResponse, response);
    
                        if(response.grupoDiagnostico != null && response.grupoDiagnostico.pai != null){
                            ltPreviousGroups = getPreviousGroups(response.grupoDiagnostico.pai, ltPreviousGroups, mapResponse);
                        }
                    }
        
                    if(gpsGroup.resultadoAtendimento != null && gpsGroup.resultadoAtendimento.codigo != null){
                        GPSProtocol gpsProtocol = new GPSProtocol();
        
                        gpsProtocol = getProtocol(accountId, assetInstance, currentGroup, serviceFlowId, parentCaseId);
                        mapResponse.put('protocol', gpsProtocol);
                    }

                    if(mapResponse.get('formRespondido') == null){
                        mapResponse.put('response', gpsGroup);
                        mapResponse.put('ltPreviousGroups', ltPreviousGroups);
                    }
                }
            }

            if(mapResponse.get('errorToast') != null){
                ServiceFlowGPSFormResponse responseDetails = (ServiceFlowGPSFormResponse) mapResponse.get('errorToast');
                String errorMessage = 'Ocorreu um erro na chamada externa, tente novamente';
                if(responseDetails.erro != null && responseDetails.erro.descricao != null && responseDetails.erro.descricao.contains('Mensagem:')){
                    errorMessage = responseDetails.erro.descricao.substringAfter('Mensagem: ');
                }
                mapResponse.put('errorToast', errorMessage);
            }
            
            return mapResponse;
        }catch (Exception e){
            if(mapResponse.get('errorToast') == null){
                mapResponse.put('errorToast', e.getMessage());
            }
            return mapResponse;
        }finally{
            ServiceTransaction.getInstance().commitTransactionsList();
        } 
    }

    public static void createCase(String accountId, String assetInstance, GPSProtocol gpsProtocol, Id serviceFlowId, String parentCaseId){
        Case newCase = new Case();
        
        try {
            
            newCase.AccountId = accountId;
            newCase.Product__c = assetInstance;
            newCase.Origin = CASE_ORIGIN_GPS;
            newCase.Subject = CASE_SUBJECT_PALITAGEM_FIXA;
            newCase.Status = CASE_STATUS_CLOSED;
            newCase.Priority = CASE_PRIORITY_LOW;
            newCase.Protocol__c = gpsProtocol.protocol;
            if(parentCaseId != null && parentCaseId != ''){
                newCase.ParentId = parentCaseId;
            }
            
            newCase.Description = '';
            newCase.Description = gpsProtocol.protocol != null ? newCase.Description + 'Protocolo: ' + gpsProtocol.protocol : newCase.Description; 
            newCase.Description = gpsProtocol.ssNumber != null ? newCase.Description + ' Número da SS: ' + gpsProtocol.ssNumber : newCase.Description; 
            newCase.Description = gpsProtocol.ssStatus != null ? newCase.Description + ' Status da SS: ' + gpsProtocol.ssStatus : newCase.Description; 
            newCase.Description = gpsProtocol.errorDetail != null ? newCase.Description + ' Detalhe do erro: ' + gpsProtocol.errorDetail : newCase.Description; 
            
            List<CustomerInteractionTopicTree__c> ltCustomerInteractionTopicTree = new List<CustomerInteractionTopicTree__c>();
            ltCustomerInteractionTopicTree = CustomerInteractionTopicTreeDAO.getEndFlowCustomerInteractionTopicTreeById(serviceFlowId);
            
            if(ltCustomerInteractionTopicTree[0] != null && ltCustomerInteractionTopicTree[0].GpsFlow__c != null){
                newCase.ServiceReason__c = ltCustomerInteractionTopicTree[0].GpsFlow__c;
                //newCase.ServiceQualificationMobile__c = ltCustomerInteractionTopicTree[0].Id;
            }
            
            newCase.RecordTypeId = RECORDTYPE_ID_CASE_FIXA;

            insert newCase;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static void createCase(String accountId, String caseIdUra){
        Case newCase = new Case();

        newCase.AccountId = accountId;
        newCase.Origin = CASE_ORIGIN_GPS;
        newCase.Status = CASE_STATUS_CLOSED;
        newCase.Priority = CASE_PRIORITY_LOW;
        newCase.Product__c = CASE_PRODUCT_FIXA;
        newCase.Subject = CASE_SUBJECT_PALITAGEM_FIXA;
        newCase.RecordTypeId = RECORDTYPE_ID_CASE_FIXA;

        try{
            CustomerInteractionTopicTree__c customerInteractionTopicTree = CustomerInteractionTopicTreeDAO.getCustomerInteractionTopicTreeToFillProdutoOutrosFixa();         
            // newCase.ServiceQualificationMobile__c = customerInteractionTopicTree.Id;
        } catch (Exception e){
            System.debug(EXCEPTION_MESSAGE + e.getMessage());
        }

        try{
            Case parentCase = CaseDAO.getCasebyId(caseIdUra);
            if(parentCase.RecordTypeId == RECORDTYPE_ID_CASE_CTI){
                newCase.ParentId = parentCase.Id;
                newCase.ProtocolURA__c = parentCase.ProtocolURA__c;
            }else if(parentCase.RecordTypeId == RECORDTYPE_ID_CASE_FIXA && parentCase.Status == CASE_STATUS_EM_ATENDIMENTO && parentCase.OwnerId == CURRENT_USER_ID){
                newCase.ParentId = parentCase.ParentId;
                newCase.ProtocolURA__c = parentCase.Parent.ProtocolURA__c;
            }
        } catch (Exception e){
            System.debug(EXCEPTION_MESSAGE + e.getMessage());
        }

        insert newCase;
    }

    public static Boolean closeCase(Map<String, String> payload){
        try{
            Case qualificationCase = new Case();
            qualificationCase = CaseDAO.getCasebyId(payload.get('CaseId__c'));

            if(qualificationCase != null && qualificationCase.Status != CASE_STATUS_CLOSED){
                qualificationCase.Status = CASE_STATUS_CLOSED;
                qualificationCase.ServiceRequestId__c = payload.get('ServiceRequestId__c');
                qualificationCase.ServiceRequestStatus__c = payload.get('ServiceRequestStatus__c');
                qualificationCase.Closure__c = payload.get('Closure__c');
                qualificationCase.RequestObservation__c = payload.get('Observation__c');
                qualificationCase.Context__c = payload.get('Context__c');
                qualificationCase.Protocol__c = payload.get('Protocol__c');
                qualificationCase.Description = payload.get('Description__c');
    
                update qualificationCase;
            }

            return true;

        } catch (Exception e){
            return true;
        }
    }


    private static ParametersDataTO createCustomDatatable(List<ServiceFlowGPSFormResponse.Parametro> parametersList, ParametersDataTO parametersData){

        parametersData.ltData = new List<List<DatatableItemTO>>();
        parametersData.setColumns = new Set<String>();

        for(ServiceFlowGPSFormResponse.Parametro parametroTableLine : parametersList){

            if(parametroTableLine.tipo == 'TABLE_LINE'){
                List<DatatableItemTO> ltTableLineData = new List<DatatableItemTO>();

                for(ServiceFlowGPSFormResponse.Parametro tableLineItem : parametroTableLine.parametros.parametro){

                    String tableLineItemValue = tableLineItem.valor == 'TRUE' ? 'true' : tableLineItem.valor;
                    DatatableItemTO tableLineData = new DatatableItemTO(tableLineItemValue, tableLineItem.tipo, tableLineItem.chave, tableLineItem.readOnly);

                    if(tableLineItem.parametros != null){
                        String style;
                        tableLineData.parameters = tableLineItem.parametros.parametro;
                        for(ServiceFlowGPSFormResponse.Parametro tableLineParameter : tableLineItem.parametros.parametro){
                            if (style == null) {
                                style = tableLineParameter.valor;
                            }else{
                                style = style + ' ' + tableLineParameter.valor;
                            }
                        }
                        tableLineData.style = style;
                    }else{
                        tableLineData.parameters = parametroTableLine.valor;
                    }

                    ltTableLineData.add(tableLineData);
                    parametersData.setColumns.add(tableLineItem.chave);
                }
                parametersData.ltData.add(ltTableLineData);
            }
        }

        return parametersData;
    }

    public static Map<String, Object> getBase64(String jsonMapForm, String currentGroup, String accountId, String assetInstance, Id serviceFlowId){
        Map<String, Object> calloutResponse = new Map<String, Object>();
        Map<String, Object> finalResponse = new Map<String, Object>();
        try{ 
            Map<String, Object> mapForm = (Map<String, Object>) JSON.deserializeUntyped(jsonMapForm);

            GPSGroup gpsGroup = new GPSGroup();
            gpsGroup = (GPSGroup) System.JSON.deserialize(currentGroup, GPSGroup.class);
            
            if(gpsGroup != null){
                if(mapForm.get('FORM_ADC_ORDERNUM_RESENDEXTRACT') != null){
                    calloutResponse = ServiceFlowFormCallout.execute(calloutResponse, gpsGroup.token, 'reenviarExtratoDeComprasController', mapForm);
                }
            }
    
            if(calloutResponse.get('form') != null){
                ServiceFlowGPSFormResponse formResponse = (ServiceFlowGPSFormResponse) calloutResponse.get('form');
                finalResponse.put('formId', (Object)formResponse.formulario.id);
                if(formResponse.formulario.etapa.parametros != null && formResponse.formulario.etapa.parametros.parametrosDisponiveis != null){
                    for(ServiceFlowGPSFormResponse.Parametro parametroTable : formResponse.formulario.etapa.parametros.parametrosDisponiveis.parametro){
                        for(ServiceFlowGPSFormResponse.Parametro parametroTableLine : parametroTable.parametros.parametro){
                            if(parametroTableLine.valor != null){
                                Blob base64Content = EncodingUtil.base64Decode(parametroTableLine.valor);
                                String payload = base64Content.toString();
                                finalResponse.put('base64', payload);
                            }
                        }
                    }
                }
            }else if(calloutResponse.get('errorToast') != null){
                ServiceFlowGPSFormResponse responseDetails = (ServiceFlowGPSFormResponse) calloutResponse.get('errorToast');
                String errorMessage = 'Ocorreu um erro na chamada externa, tente novamente';
                if(responseDetails.erro != null && responseDetails.erro.descricao != null && responseDetails.erro.descricao.contains('Mensagem:')){
                    errorMessage = responseDetails.erro.descricao.substringAfter('Mensagem: ');
                }
                finalResponse.put('errorToast', errorMessage);
            }

            return finalResponse;

        }catch (Exception e){
            if(calloutResponse.get('errorToast') == null){
                finalResponse.put('errorToast', e.getMessage());
            }
            return finalResponse;
        }finally{
            ServiceTransaction.getInstance().commitTransactionsList();
        } 
    }

    public static CanvasResult getCanvasParameters(String recordId, String serviceFlowId, String assetInstance, String caseId){
        CanvasResult result = new CanvasResult();
        Map<String,Object> parameters = new Map<String,Object>();

        if (String.isBlank(recordId)){
            result.canOpenCanvas = false;
        }else{
            Id accountId = Id.valueOf(recordId);

            parameters.put('CaseId', caseId);
            parameters.put('AccountId', accountId);
            parameters.put('UserId', CURRENT_USER_ID);

            try{
                Asset selectedAsset = AssetDAO.getAssetById(assetInstance);
                if(selectedAsset.Instance__c != null){
                    parameters.put('Asset', selectedAsset.Instance__c);
                }else{
                    parameters.put('Asset', selectedAsset.Name);
                }
                parameters.put('Status', selectedAsset.Status);
            } catch (Exception e){
                System.debug(EXCEPTION_MESSAGE + e.getMessage());
            }

            try{
                Case c = CaseDAO.getCasebyId(caseId);
                if(c.Status != CASE_STATUS_EM_ATENDIMENTO){
                    result.canOpenCanvas = false;
                    return result;
                }
                parameters.put('CaseNumber', c.CaseNumber);
                parameters.put('Protocol', c.ProtocolURA__c);
                parameters.put('ServiceRequestId', c.ServiceRequestId__c);
            } catch (Exception e){
                System.debug(EXCEPTION_MESSAGE + e.getMessage());
            }

            try{
                List<CustomerInteractionTopicTree__c> ltCustomerInteractionTopicTree = CustomerInteractionTopicTreeDAO.getEndFlowCustomerInteractionTopicTreeById(serviceFlowId);
                if(ltCustomerInteractionTopicTree.size() > 0){
                    parameters.put('TipificacaoId', ltCustomerInteractionTopicTree[0].GPSId__c);
                }
            } catch (Exception e){
                System.debug(EXCEPTION_MESSAGE + e.getMessage());
            }

            try{
                Account acc = AccountDAO.getAccountById(accountId)[0];
                parameters.put('Document', acc.DocumentNumber__c);
            } catch (Exception e){
                System.debug(EXCEPTION_MESSAGE + e.getMessage());
            }

            try{
                OAuthEndUserRequestConfigurator OAuthClass = new OAuthEndUserRequestConfigurator();
                parameters.put('TokenJWT', OAuthClass.getAccessToken());
            } catch (Exception e){
                System.debug(EXCEPTION_MESSAGE + e.getMessage());
            }
            
            try{
                User u = UserDAO.getById(CURRENT_USER_ID);
                parameters.put('UserLogin', u.Alias);
            } catch (Exception e){
                System.debug(EXCEPTION_MESSAGE + e.getMessage());
            }

            result.canvasAppName        = GPS_CANVAS_APP_NAME;
            result.parameters           = parameters;
            result.canOpenCanvas        = true;
        }
        return result;
    }

    public static Map<String, Object> getURLToRedirect(String caseId){
        Map<String, Object> mapResult = new Map<String, Object>();
        String urlToRedirect = '';

        Webservice__c wsConfig = Webservice__c.getInstance('GPSTreatmentConsultation');
        Case closedCase = CaseDAO.getCasebyId(caseId);
        
        if (wsConfig == null) {
            mapResult.put('error', 'Configuração de URL não encontrada');
            return mapResult;
        }
        urlToRedirect = wsConfig.Endpoint__c;
        if(!String.isBlank(closedCase.ServiceRequestId__c)){
           urlToRedirect += 'idss=' + closedCase.ServiceRequestId__c;

            mapResult.put('success', urlToRedirect);
        } else {
            mapResult.put('error', 'O caso deve possuir o número da SS para consulta');
        }
        return mapResult;
    }

    public static Case getOrCreateCase (Map<String, String> payload){
        try {

            String gpsFlowId;
            String customerInteractionTopicTreeId;
            String userId = UserInfo.getUserId();
            String caseId = payload.get('caseId');
            String accountId = payload.get('accountId');
            String caseIdUra = payload.get('caseIdUra');
            String selectedFlow = payload.get('selectedFlow');
            String selectedAssetId = payload.get('selectedAssetId');
            String selectedAssetInstance = payload.get('selectedAssetInstance');

            List<CustomerInteractionTopicTree__c> ltCustomerInteractionTopicTree = new List<CustomerInteractionTopicTree__c>();
            ltCustomerInteractionTopicTree = CustomerInteractionTopicTreeDAO.getEndFlowCustomerInteractionTopicTreeById(selectedFlow);

            if(ltCustomerInteractionTopicTree.size() > 0 && ltCustomerInteractionTopicTree[0] != null && ltCustomerInteractionTopicTree[0].GpsFlow__c != null){
                gpsFlowId= ltCustomerInteractionTopicTree[0].GpsFlow__c;
                customerInteractionTopicTreeId = ltCustomerInteractionTopicTree[0].Id;
            }

            if(caseId != null && caseId != ''){

                Case existingCase = CaseDAO.getCasebyId(caseId);

                if(existingCase != null){

                    existingCase.Product__c = selectedAssetInstance;
                    existingCase.ComplainedAsset__c = selectedAssetId;
                    existingCase.ServiceReason__c = gpsFlowId;
                    // existingCase.ServiceQualificationMobile__c = customerInteractionTopicTreeId;
    
                    update existingCase;
    
                    return existingCase;
                }else{
                    throw new AuraHandledException('Caso não localizado na base');
                }
            } else{
                List<Case> previousCaseList = CaseDAO.getOpenCaseFixa(accountId, userId);

                if(previousCaseList.size() > 0){
                    Case previousCase = previousCaseList[0];

                    previousCase.Product__c = selectedAssetInstance;
                    previousCase.ComplainedAsset__c = selectedAssetId;
                    previousCase.ServiceReason__c = gpsFlowId;
                    // previousCase.ServiceQualificationMobile__c = customerInteractionTopicTreeId;

                    update previousCase;

                    return previousCase;
                }else{
                    Case newCase = new Case();

                    newCase.AccountId = accountId;
                    newCase.Product__c = selectedAssetInstance;
                    newCase.ComplainedAsset__c = selectedAssetId;
                    newCase.Origin = CASE_ORIGIN_GPS;
                    newCase.Subject = CASE_SUBJECT_PALITAGEM_FIXA;
                    newCase.Status = CASE_STATUS_EM_ATENDIMENTO;
                    newCase.Priority = CASE_PRIORITY_MEDIUM;
                    newCase.ServiceReason__c = gpsFlowId;
                    // newCase.ServiceQualificationMobile__c = customerInteractionTopicTreeId;
                    newCase.RecordTypeId = RECORDTYPE_ID_CASE_FIXA;
                    
                    if(caseIdUra != null){
    
                        Case caseURA = CaseDAO.getCasebyId(caseIdUra);
                        newCase.ParentId = caseURA.Id;
                        newCase.ProtocolURA__c = caseURA.ProtocolURA__c;
                        newCase.CallerDDD__c = caseURA.CallerDDD__c;
                        newCase.CallerPhone__c = caseURA.CallerPhone__c;
                        
                    }
        
                    insert newCase;
                    return newCase;
                }
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}