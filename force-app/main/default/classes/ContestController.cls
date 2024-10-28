global class ContestController implements vlocity_cmt.VlocityOpenInterface {
    global Boolean invokeMethod(String methodName, Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options)
    {
        switch on methodName {
            when 'getContestPicklists' 
            {output.put('result', getContestPicklists(inputs, output, options));}
            when 'setContestPicklists' 
            {output.put('result', setContestPicklists(inputs, output, options));}
            when 'getImpugnationReasonPicklist' 
            {output.put('result', getImpugnationReasonPicklist(inputs, output, options));}
        }
        return true;
    }

   /*
    * Autor....: Otávio Fonseca - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método retornar as picklist de motivo de contestação
    * Data.....: 09/08/2024
    */
    public Map<String, Object> getContestPicklists(Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options) {         
        Boolean ProductWithdrawal = (Boolean)inputs.get('ProductWithdrawal');
        Boolean ImproperActivation = (Boolean)inputs.get('ImproperActivation');
        Boolean CustomerRequest = (Boolean)inputs.get('CustomerRequest');
        Boolean InternalProcedure = (Boolean)inputs.get('InternalProcedure');  

        Map<String, Object> mapPickListOptions = new Map<String, Object>();

        List<Map<String, String>> listLabelValuesAuto = new List<Map<String, String>>();
        Map<String, String> mapItensAuto = new Map<String, String>();
        
        List<Map<String, String>> listLabelValuesManual = new List<Map<String, String>>();
        Map<String, String> mapItensManual = new Map<String, String>();  
        
        // Primeiro item vazio
        mapItensAuto.put('value', '');
        mapItensAuto.put('label', '--');
        listLabelValuesAuto.add(mapItensAuto);	

        // Primeiro item vazio
        mapItensManual.put('value', '');
        mapItensManual.put('label', '--');
        listLabelValuesManual.add(mapItensManual);        

        // Impugnação automatica - Trocar campo
        if (ProductWithdrawal) {
            mapItensAuto = new Map<String, String>();
            mapItensAuto.put('value', 'Desistência do Produto');
            mapItensAuto.put('label', 'Desistência do Produto');
            listLabelValuesAuto.add(mapItensAuto);            
        }

        if (ImproperActivation) {
            mapItensAuto = new Map<String, String>();
            mapItensAuto.put('value', 'Ativação Indevida');
            mapItensAuto.put('label', 'Ativação Indevida');
            listLabelValuesAuto.add(mapItensAuto);            
        }
        
        // Impugnação manual
        if (CustomerRequest) {
            mapItensManual = new Map<String, String>();
            mapItensManual.put('value', 'A Pedido do Cliente');
            mapItensManual.put('label', 'A Pedido do Cliente');
            listLabelValuesManual.add(mapItensManual);            
        }

        if (InternalProcedure) {
            mapItensManual = new Map<String, String>();
            mapItensManual.put('value', 'Procedimento Interno');
            mapItensManual.put('label', 'Procedimento Interno');
            listLabelValuesManual.add(mapItensManual);            
        }        
        
        mapPickListOptions.put('AutoPicklistValues', listLabelValuesAuto);
        mapPickListOptions.put('ManualPicklistValues', listLabelValuesManual);

        return mapPickListOptions;
	}

/*
    * Autor....: Otávio Fonseca - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método setar as picklist de motivo de contestação
    * Data.....: 09/08/2024
    */
    public List<Object> setContestPicklists(Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options) { 
        Map<String, Object> items = (Map<String, Object>)inputs.get('BoxesList');
        List<Object> itemsList = (List<Object>)items.get('PicklistList');
        Map<String, Object> picklistOptions = (Map<String, Object>)inputs.get('ContestPicklistOptions');
        List<Object> reasonList;
        Map<String, Object> reasonMap;

        for(Object obj : itemsList) {
            Map<String, Object> item = (Map<String, Object>)obj;
          
            if (item.get('itemRule') == 'Auto') {
                item.put('pickListOptions', picklistOptions.get('AutoPicklistValues'));
            } else if (item.get('itemRule') == 'Manual') {
                item.put('pickListOptions', picklistOptions.get('ManualPicklistValues'));
            } 

            reasonList = (List<Object>)item.get('pickListOptions');

            if (reasonList.size() == 2) {
                reasonMap = (Map<String, Object>)reasonList.get(1);
                item.put('reason', reasonMap.get('label'));
            }

            //Total
            if (item.get('type') == 'scoreCredit') {
                item.put('totalAmount', String.valueOf((Decimal)item.get('usedAmountDCA') + (Decimal)item.get('usedAmountCAT'))); 
                item.put('usedUnitOfMeasure', 'BRL');
            } else {
                item.put('totalAmount', String.valueOf((Decimal)item.get('usedAmountNOR') + (Decimal)item.get('usedAmountCAC') + (Decimal)item.get('usedAmountSNS') + (Decimal)item.get('usedAmountCAE')));
                if (String.isNotBlank(String.valueOf(item.get('type')))) {
                    item.put('usedUnitOfMeasure', 'BRL');
                } else {
                    if (item.get('totalAmount') == '0') {
                        item.put('showCheck', false);
                    }    
                }
            }               
        }

        return (List<Object>)items.get('PicklistList');
	}
    
    /*
    * Autor....: Eduardo Murakami - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método retornar as picklist de motivo de impugnação
    * Data.....: 13/09/2024
    */
    public Map<String, Object> getImpugnationReasonPicklist(Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options) {         
        Boolean Concession = (Boolean)inputs.get('Concession');
        Boolean Rectification = (Boolean)inputs.get('Rectification');
        Boolean CustomerRequest = (Boolean)inputs.get('CustomerRequest');
        Boolean InternalProcedure = (Boolean)inputs.get('InternalProcedure');

        Map<String, Object> mapPickListOptions = new Map<String, Object>();

        List<Map<String, String>> listImpunationReasons = new List<Map<String, String>>();
        Map<String, String> mapItensImpunation = new Map<String, String>();

        List<Map<String, String>> listNonProceedReasons = new List<Map<String, String>>();
        Map<String, String> mapItensNonProceed = new Map<String, String>();
        
        // Primeiro item vazio
        mapItensImpunation.put('value', '');
        mapItensImpunation.put('label', '--');
        listImpunationReasons.add(mapItensImpunation);

        mapItensNonProceed.put('value', '');
        mapItensNonProceed.put('label', '--');
        listNonProceedReasons.add(mapItensNonProceed);	

        // Impugnação Parcial
        if (Concession) {
            mapItensImpunation = new Map<String, String>();
            mapItensImpunation.put('value', 'Fidelização - Liberalidade (Concessão)');
            mapItensImpunation.put('label', 'Fidelização - Liberalidade (Concessão)');
            listImpunationReasons.add(mapItensImpunation);
        }

        // Impugnação Total
        if (Rectification) {
            mapItensImpunation = new Map<String, String>();
            mapItensImpunation.put('value', 'Retificação - Falha de cobrança');
            mapItensImpunation.put('label', 'Retificação - Falha de cobrança');
            listImpunationReasons.add(mapItensImpunation);
        }

        // Não Procede
        if (CustomerRequest) {
            mapItensNonProceed = new Map<String, String>();
            mapItensNonProceed.put('value', 'A Pedido do Cliente');
            mapItensNonProceed.put('label', 'A Pedido do Cliente');
            listNonProceedReasons.add(mapItensNonProceed);
        }

        if (InternalProcedure) {
            mapItensNonProceed = new Map<String, String>();
            mapItensNonProceed.put('value', 'Procedimento Interno');
            mapItensNonProceed.put('label', 'Procedimento Interno');
            listNonProceedReasons.add(mapItensNonProceed);
        }
        
        // Adicionando a lista de opções de impugnação ao mapa de saída
        mapPickListOptions.put('ImpunationPicklistValues', listImpunationReasons);
        mapPickListOptions.put('NonProceedPicklistValues', listNonProceedReasons);

        return mapPickListOptions;
    }

}