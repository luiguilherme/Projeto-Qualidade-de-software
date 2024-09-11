/*
* Autor: Giovani de Souza - Deloitte
* Criado em: 05/11/2021
*/
global class CustomFunctionService implements vlocity_cmt.VlocityOpenInterface
{
    global Boolean invokeMethod(String methodName, Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options)
    {
        List<Object> arguments = (List<Object>) inputs.get('arguments');
        
        switch on methodName {
            when 'validateEmailFormat' 
            {output.put('result', validateEmailFormat(arguments));}        
            when 'validateOnlyTextFormat' 
            {output.put('result', validateOnlyTextFormat(arguments));}
            when 'GroupKeyValues' 
            {output.put('result', GroupKeyValues(arguments));}            
            when 'validateCPF' 
            {output.put('result', validateCPF(arguments));}
            when 'validateCNPJ' 
            {output.put('result', validateCNPJ(arguments));}
            when 'mapKeysValues' 
            {output.put('result', mapKeysValues(arguments));}  
            when 'mapKeysValuesSmart' 
            {output.put('result', mapKeysValuesSmart(arguments));}              
            when 'trim' 
            {output.put('result', trimValues(arguments));}   
            when 'trimClass'
            {output.put('result', trimClass(arguments));}
            when 'length' 
            {output.put('result', length(arguments));}               
            when 'formatDate' 
            {output.put('result', formatDate(arguments));}          
            when 'translatePickListValues' 
            {output.put('result', translatePickListValues(arguments));}
            when 'getPickListKeyValues' 
            {output.put('result', getPickListKeyValues(arguments));}
            when 'getPickListLabelValues' 
            {output.put('result', getPickListLabelValues(arguments));}
            when 'replaceString' 
            {output.put('result', replaceString(arguments));} 
            when 'replaceBackslashTopicName'
            {output.put('result', replaceBackslashTopicName(arguments));}            
            when 'replacePhoneCaracters'
            {output.put('result', replacePhoneCaracters(arguments));}            
            when 'GetListRange' 
            {output.put('result', GetListRange(arguments));}
            when 'convertByte' 
            {output.put('result', convertByte(arguments));}
            when 'getElementApiName'
            {output.put('result', getElementApiName(arguments));}
            when 'removeValueFromList'
            {output.put('result', removeValueFromList(arguments));}   
            when 'getPathTree'
            {output.put('result', getPathTree(arguments));}
            when 'getPath'
            {output.put('result', getPath(arguments));} 
            when 'getUserRole'
            {output.put('result', getUserRole(arguments));}
            when 'getTotalChannels'
            {output.put('result', getTotalChannels(arguments));} 
            when 'validateCEP'
            {output.put('result', validateCEP(arguments));} 
            when 'getLabel'
            {output.put('result', getLabel(arguments));}
            when 'reorderComplements'
            {output.put('result', reorderComplements(arguments));}
            when 'properCase'
            {output.put('result', properCase(arguments));}
            when 'orgURL'
            {output.put('result', orgURL(arguments));}
            when 'mapAttributes'
            {output.put('result', mapAttributes(inputs));}
            when 'getUserInCommunity'
            {output.put('result', getUserInCommunity(arguments));}
            when 'getDependentPicklist'
            {output.put('result', getDependentPicklist(arguments));}
            when 'getDatetimeLast24Hours'
            {output.put('result', getDatetimeLast24Hours(arguments));}
            when 'getCalcDateCase'
            {output.put('result', getCalcDateCase(arguments));}
            when 'convertPicklistAPINameToLabel'
            {output.put('result', convertPicklistAPINameToLabel(arguments));}
            when 'convertCurrencyToNumber'
            {output.put('result', convertCurrencyToNumber(arguments));}
            when 'listToCommaSeparatedValues'
            {output.put('result', listToCommaSeparatedValues(arguments));}
            when 'contains'
            {output.put('result', contains(arguments));}
            when 'base64Decode'
            {output.put('result', base64Decode(arguments));}            
            when 'convertObjectToList'
            {output.put('result', convertObjectToList(arguments));}
            when 'validaEid'
            {output.put('result', validaEid(arguments));} 
            when 'validaImei'
            {output.put('result', validaImei(arguments));}             
            when 'cloneAsset' 
            {output.put('result', cloneAsset(arguments));}               
            when 'productEligibilityQuery' 
            {output.put('result', productEligibilityQuery(arguments));}
            when 'removeNullValues'
            {output.put('result', removeNullValues(inputs));}                      
        }
        return true;
    }
    
    /*
    * Autor....: carlosaraujo@deloitte - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método que retorna custom label
    * Data.....: 01/02/2023
    * ----------------------------------------------
    */	
    String getLabel(List<Object> argument) {
        String label = (String) argument[0];
        switch on label {
            when 'ScheduleFound' {return System.Label.ScheduleFound;}
            when 'InvalidCPF' {return System.Label.InvalidCPF;}
            when 'ValidCPF' {return System.Label.ValidCPF;}
            when 'CPFTryAgain' {return System.Label.CPFTryAgain;}
            when 'CPFIrregular' {return System.Label.CPFIrregular;}
            when 'CPFPEPThirdParty' {return System.Label.CPFPEPThirdParty;}
            when 'CPFPEPThirdPartyLR' {return System.Label.CPFPEPThirdPartyLR;}
            when 'CPFUnderageThirdParty' {return System.Label.CPFUnderageThirdParty;}
            when 'CPFPEPFirstParty' {return System.Label.CPFPEPFirstParty;}
            when 'CPFPEPFirstPartyLP' {return System.Label.CPFPEPFirstPartyLP;}
            when 'CPFUnderageFirstParty' {return System.Label.CPFUnderageFirstParty;}
            when 'InvalidFirstLastName' {return System.Label.InvalidFirstLastName;}
            when 'valApprovalProcessMessageHeader' {return System.Label.valApprovalProcessMessageHeader;}
            when 'valApprovalProcessMessageFooter' {return System.Label.valApprovalProcessMessageFooter;}
            when 'valApprovalProcessApprovalClientWithRestriction' {return System.Label.valApprovalProcessApprovalClientWithRestriction;}
            when 'valApprovalProcessMinorAge' {return System.Label.valApprovalProcessMinorAge;}
            when 'valApprovalProcessNameWithDifference' {return System.Label.valApprovalProcessNameWithDifference;}
            when 'valApprovalProcessLimitQtyMonth' {return System.Label.valApprovalProcessLimitQtyMonth;}
            when 'valApprovalProcessTotalLimit' {return System.Label.valApprovalProcessTotalLimit;}
            when 'valApprovalProcessApprovalRequested' {return System.Label.valApprovalProcessApprovalRequested;}
            when 'valApprovalProcessApprovalMessage' {return System.Label.valApprovalProcessApprovalMessage;}
            when 'valApprovalProcessSelectOneApprover' {return System.Label.valApprovalProcessSelectOneApprover;}            
            when 'valApprovalProcessApprovalLabel' {return System.Label.valApprovalProcessApprovalLabel;}
            when 'valApprovalProcessDonate' {return System.Label.valApprovalProcessDonate;}
            when 'valICCIDErrorCombo' {return System.Label.valICCIDErrorCombo;}
        }
        
        return null;
    }
    
    Boolean validateCEP(List<Object> argument) {
        String CEP = (String) argument[0];
        Boolean result = false;
        
        if (CEP != null && CEP.length() == 8 && CEP.isNumeric()) result = true;
        
        return result;
    }
    
    Boolean validateEmailFormat(List<Object> argument)
    {
        Pattern emailPattern = Pattern.compile('(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$)');
        Matcher emailMatcher = emailPattern.matcher((String) argument[0]);
        return emailMatcher.matches();
    }
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Validar se contém apenas Letras (exclui números e simbolos)
    * Data.....: 30/12/2022
    */	     
    Boolean validateOnlyTextFormat(List<Object> argument)
    {
        Pattern textPattern = Pattern.compile('([A-Za-zÀ-ú ]{1,})');       
        Matcher textMatcher = textPattern.matcher((String) argument[0]);
        return textMatcher.matches();
    }
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método criado para validar CPF
    * Data.....: 08/11/2021
    */	    
    boolean validateCPF(List<Object> argument) {
        String CPF = (String) argument[0];
        CPF = CPF.remove('.');
        CPF = CPF.remove('-');
        
        if (CPF.equals('00000000000') || CPF.equals('11111111111') ||
            CPF.equals('22222222222') || CPF.equals('33333333333') ||
            CPF.equals('44444444444') || CPF.equals('55555555555') ||
            CPF.equals('66666666666') || CPF.equals('77777777777') ||
            CPF.equals('88888888888') || CPF.equals('99999999999') ||
            (CPF.length() != 11))
            return false;
        
        Integer dig10, dig11, sm, i, r, num, peso;
        sm = 0;
        peso = 10;
        List<String> cpfString = cpf.split('');
        for (i=0; i<9; i++) {
            num = Integer.valueOf(cpfString[i]); 
            sm = sm + (num * peso);
            peso = peso - 1;
        }
        
        r = 11 - (math.mod(sm,11));
        if ((r == 10) || (r == 11))
            dig10 = 0;
        else dig10 = r;
        
        // Valida 2o. Digito Verificador
        sm = 0;
        peso = 11;
        for(i=0; i<10; i++) {
            num = Integer.valueOf(cpfString[i]);
            sm = sm + (num * peso);
            peso = peso - 1;
        }
        
        r = 11 - (math.mod(sm,11));
        if ((r == 10) || (r == 11))
            dig11 = 0;
        else dig11 = r;
        
        if (dig10 == Integer.valueOf(cpfString[9]) && dig11 == Integer.ValueOf(cpfString[10])){
            return true;
        }else{
            return false;
        }
    }    
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método criado para validar CNPJ
    * Data.....: 01/12/2021
    */	        
    public static Boolean validateCNPJ(List<Object> argument){
        
        String cnpj = (String) argument[0];
        // considera-se erro CNPJ's formados por uma sequencia de numeros iguais
        if ('00000000000000'.equals(cnpj) || '11111111111111'.equals(cnpj) ||
            '22222222222222'.equals(cnpj) || '33333333333333'.equals(cnpj) ||
            '44444444444444'.equals(cnpj) || '55555555555555'.equals(cnpj) ||
            '66666666666666'.equals(cnpj) || '77777777777777'.equals(cnpj) ||
            '88888888888888'.equals(cnpj) || '99999999999999'.equals(cnpj) ||
            (cnpj.length() != 14)){
                System.debug('Validar CNPJ - FALSO 1.1'+cnpj);
                return false;
            }
        Integer sm, i, r, num, peso, dig13, dig14;
        List<String> cnpjString = CNPJ.split('');
        sm = 0;
        peso = 2;
        for (i=11; i>=0; i--) {
            num = Integer.valueOf(cnpjString[i]);
            sm = sm + (num * peso);
            peso = peso + 1;
            if (peso == 10)
                peso = 2;
        }
        
        r = math.mod(sm, 11);
        if ((r == 0) || (r == 1))
            dig13 = 0;
        else dig13 = Integer.valueOf(11-r);
        
        //Calculo do 2o. Digito Verificador
        sm = 0;
        peso = 2;
        for (i=12; i>=0; i--) {
            num = Integer.valueOf(cnpjString[i]);
            sm = sm + (num * peso);
            peso = peso + 1;
            if (peso == 10)
                peso = 2;
        }
        
        r = math.mod(sm, 11);
        if ((r == 0) || (r == 1))
            dig14 = 0;
        else dig14 = Integer.valueOf(11-r);
        
        // Verifica se os dígitos calculados conferem com os dígitos informados.
        if (dig13 == Integer.valueOf(cnpjString[12]) && dig14 == Integer.valueOf(cnpjString[13])){
            System.debug('Validar CNPJ - VERDADE');
            return true;
        }
        else {
            System.debug('Validar CNPJ - FALSO 2');
            return false ;
        }
    }
    
    /*
    * Autor....: Leandro Alexandrino - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Entrada do método é uma lista de objetos. Cada objeto deve conter uma chave name e uma chave value.
    Saída do método é um mapa de string,string formado por chaves de names e valores de values.
    * Data.....: 2021
    */    
    Map<String,String> mapKeysValues(List<Object> argument)
    {
        //Entrada do método é uma lista de objetos. Cada objeto deve conter uma chave name e uma chave value.
        //Saída do método é um mapa de string,string formado por chaves de names e valores de values.
        Map<String,String> mapKeysValues = new Map<String,String>();
        Map<String,Object> argumentMap = new Map<String,Object>();

            for(Object obj : argument) {
                argumentMap = (Map<String,Object>) obj;
                mapKeysValues.put((String) argumentMap.get('name'),(String) argumentMap.get('value'));
        }
        return mapKeysValues;
    }

    Map<String,String> mapKeysValuesSmart(List<Object> argument)
    {
        //Entrada do método é uma lista de objetos. Cada objeto deve conter uma chave name e uma chave value.
        //Saída do método é um mapa de string,string formado por chaves de names e valores de values.
        Map<String,String> mapKeysValues = new Map<String,String>();
        Map<String,Object> argumentMap = new Map<String,Object>();

            for(Object obj : argument) {
                argumentMap = (Map<String,Object>) obj;
                mapKeysValues.put((String) argumentMap.get('id'),(String) argumentMap.get('status'));
        }
        return mapKeysValues;
    }
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método criado fazer um distinct em uma lista
    * Data.....: 02/01/2023
    */    
    List<Object> GroupKeyValues(List<Object> argument)
    {   
        Set<Object> tempSet = new Set<Object>();
        tempSet.addAll(argument);
        
        return new List<Object>(tempSet);
    }   
    
    String trimValues(List<Object> argument) {
        String value = (String) argument[0];  
        
        return value.replace(' ', '');       
    }   
    String trimClass(List<Object> argument) {
        String value = (String) argument[0];  
        
        return value.trim();
    }   
    
    Integer length(List<Object> argument) {
        String value = (String) argument[0];
        return value.length();
    }   
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método criado para formatar data em DR
    * Data.....: 17/02/2021
    */
    public static String formatDate(List<Object> argument)
    {
        String dataNascimento = (String) argument[0];
        Date d = date.parse(dataNascimento);
        String dt = DateTime.newInstance(d.year(),d.month(),d.day()).format('dd/MM/YYYY');
        system.debug(logginglevel.error,dt);		        
        return dt;
    }
    
    /*
    * Autor....: Lucas Ferreira Magalhães - Deloitte 22/04/2022
    * Modificado por: Giovani de Souza 22/04/2022
    * Projeto..: Vivo - VALENTINA
    * Descrição: Metodo para capturar os valores traduzidos de uma picklist com Objeto e campo como parametro.
    Retornando uma lista de Map com apiName = key, Label = Value.
    * Data.....: 2021
    */
    public static List<Map<String, String>> translatePickListValues(List<Object> argument) {
        
        String objectApiName = (String) argument[0];
        String objectFieldName = (String) argument[1];
        
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        
        Schema.SObjectField sField;
        Schema.SObjectType sObjType = gd.get(objectApiName);
        Schema.DescribeSObjectResult objectResult = sobjType.getDescribe();
        
        Map<String,Schema.SObjectField> fieldsMap = objectResult.fields.getMap();
        sField = fieldsMap.get(objectFieldName);		
        
        List<Schema.PicklistEntry> picklistValues = sField.getDescribe().getPicklistValues();
        List<Map<String, String>> listValuesTranslated = new List<Map<String, String>>();
        
        Map<String, Object> finalMap = new Map<String, Object>();
        
        for (Schema.PicklistEntry pe: picklistValues) {
            Map<String, String> mapTranslatedValues = new Map<String, String>();
            mapTranslatedValues.put(objectApiName+objectFieldName+'Value', pe.getLabel());
            mapTranslatedValues.put(objectApiName+objectFieldName+'Key', pe.getValue());
            
            listValuesTranslated.add(mapTranslatedValues);	
        }
        
        return listValuesTranslated;
    }
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método para retornar o Key/Valeu de um picklist - usado no filtro de parms do palito
    * Data.....: 10/10/2022
    */	     
    public static List<Map<String, String>> getPickListKeyValues(List<Object> argument) {
        
        String objectApiName = (String) argument[0];
        String objectFieldName = (String) argument[1];
        
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        
        Schema.SObjectField sField;
        Schema.SObjectType sObjType = gd.get(objectApiName);
        Schema.DescribeSObjectResult objectResult = sobjType.getDescribe();
        
        Map<String,Schema.SObjectField> fieldsMap = objectResult.fields.getMap();
        sField = fieldsMap.get(objectFieldName);		
        
        List<Schema.PicklistEntry> picklistValues = sField.getDescribe().getPicklistValues();
        List<Map<String, String>> listValuesTranslated = new List<Map<String, String>>();
        
        Map<String, Object> finalMap = new Map<String, Object>();
        
        for (Schema.PicklistEntry pe: picklistValues) {
            Map<String, String> mapTranslatedValues = new Map<String, String>();
            mapTranslatedValues.put('Value', pe.getLabel());
            mapTranslatedValues.put('Key', pe.getValue());
            
            listValuesTranslated.add(mapTranslatedValues);	
        }
        
        return listValuesTranslated;
    }  
    
    public static List<Map<String, String>> getPickListLabelValues(List<Object> argument) {
        
        String objectApiName = (String) argument[0];
        String objectFieldName = (String) argument[1];
        
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        
        Schema.SObjectField sField;
        Schema.SObjectType sObjType = gd.get(objectApiName);
        Schema.DescribeSObjectResult objectResult = sobjType.getDescribe();
        
        Map<String,Schema.SObjectField> fieldsMap = objectResult.fields.getMap();
        sField = fieldsMap.get(objectFieldName);		
        
        List<Schema.PicklistEntry> picklistValues = sField.getDescribe().getPicklistValues();
        List<Map<String, String>> listLabelValues = new List<Map<String, String>>();
        Map<String, String> mapItens = new Map<String, String>();
        
        // Primeiro item vázio
        mapItens.put('value', '');
        mapItens.put('label', '');
        listLabelValues.add(mapItens);	
        
        for (Schema.PicklistEntry pe: picklistValues) {
            mapItens = new Map<String, String>();
            mapItens.put('value', pe.getLabel());
            mapItens.put('label', pe.getValue());
            listLabelValues.add(mapItens);	
        }
        
        return listLabelValues;
    }  
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método criado para substituir valores DE/PARA em uma string
    * Data.....: 08/11/2021
    */	    
    public static String replaceString(List<Object> argument){
        
        String stringToReplace = (String) argument[0];
        String searchString = (String) argument[1];
        String replacementString = (String) argument[2];
        
        return stringToReplace.replace(searchString, replacementString);
    }
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método criado para substituir o scape '\\' por '\' em uma string
    * Data.....: 29/06/2022
    */
    public static String replaceBackslashTopicName(List<Object> argument){
        
        String stringToReplace = (String) argument[0];
        String searchString =  '\\';
        String replacementString = String.fromCharArray( new integer[] { 92 });
        
        return stringToReplace.replace(searchString, replacementString);
    }    
    
    /*
	* Autor....: Guilherme Kaiser - Deloitte
	* Projeto..: Vivo - VALENTINA
	* Descrição: Método criado para remover máscara de telefone
	* Data.....: 16/01/2024
	*/	    
    public static String replacePhoneCaracters(List<Object> argument){
        
        String stringToReplace = (String) argument[0];

        return stringToReplace.replaceAll('[^0-9]', '');
    }
    
    public static List<Object> GetListRange(List<Object> arguments){
        try{
            Map <String, Object> objectsMap =  (Map <String, Object>) arguments[0];
            List<Object> objects = (List<Object>) objectsMap.get('Objects');
            List<Object> filtredList =  new List<Object> ();            
            Integer startIndex = Integer.valueOf(arguments[1]);
            Integer endIndex = Integer.valueOf(arguments[2]);
            
            for(Integer index = startIndex; index < endIndex && index <objects.Size(); index++){
                filtredList.add(objects[index]);
            }            
            return filtredList;
        } 
        catch(Exception e){
            System.debug(e.getMessage());
            return null;
        }
    }
    
    public static Decimal convertByte (List<Object> arguments) {
        Long value = Long.valueOf(String.valueof(arguments[0]));
        String unitMeasurementValue = (String) arguments[1];
        String targetUnitMeasurement = (String) arguments[2];
        
        return valUnitConvert.convertByte(value, unitMeasurementValue, targetUnitMeasurement);
    }
    
    /*
    * Autor....: Giovani de Souza - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método para identificar o nome do objeto com base no recordId
    * Data.....: 20/09/2022
    */	
    public static String getElementApiName (List<Object> arguments) {
        Id id = Id.valueOf(String.valueof(arguments[0]));
        
        return id.getSObjectType().getDescribe().getName();
    }
    
    /*
    * Autor....: Giovani de Souza - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método para remover valor de uma lista
    * Data.....: 13/10/2022
    */	
    public static List<Object> removeValueFromList (List<Object> arguments) {     
        
        Map<String,Object> menusMap  = (Map<String,Object>) arguments[0];
        List<Object> menus = (List<Object>) menusMap.get('VLOCITY-FORMULA-LIST');
        String valueToRemove = (String.valueOf(arguments[1]));
        List<Object> listToReturn = new List<Object>();
        
        while(menus.contains(valueToRemove)){            
            menus.remove(menus.indexOf(valueToRemove));
        }
        
        return menus;
    }
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método criado para retornar o nome dos níveis a partir de um ID
    * Data.....: 13/10/2022
    */	    
    public static List<String>  getPathTree (List<Object> arguments){
        
        String recordId = (String) Id.valueOf(String.valueof(arguments[0]));
        String recordIdNext;
        Boolean ignoreFirstId =true;
        List<String> lstNewTree = new List<String>();
        
        if(recordId != null){
            List<CustomerInteractionTopicTree__c> lstTree =[select Id, Name, ParentTopicId__c, Type__c from CustomerInteractionTopicTree__c];
            Map<Id,CustomerInteractionTopicTree__c> mapTree = new Map<Id,CustomerInteractionTopicTree__c>(lstTree);            
            recordIdNext = recordId;                
            if(mapTree.containsKey(recordIdNext)){
                do {
                    CustomerInteractionTopicTree__c recordTree = mapTree.get(recordIdNext);
                    if(!ignoreFirstId || recordTree.get('Type__c')=='Pasta'){
                        lstNewTree.add((String) recordTree.get('Name'));   
                    }                    
                    ignoreFirstId=false;                                            
                    recordIdNext = (String) recordTree.get('ParentTopicId__c');
                } while (mapTree.containsKey(recordIdNext));
            }
        }        
        List<String> lstNewTreeReversed = new List<String>();        
        for(Integer i = lstNewTree.size() - 1; i >= 0; i--){
            lstNewTreeReversed.add(lstNewTree[i]);
        }                
        return lstNewTreeReversed;
    }    
    
    /*
    * Autor....: Otávio Fonseca - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método criado para retornar o nome dos níveis a partir de um ID
    * Data.....: 24/10/2022
    */	    
    public static String getPath(List<Object> arguments) {
        String finalPath = '';
        
        String recordId = (String) arguments[0];
        
        CustomerInteractionTopicTree__c topic = [SELECT Id, Name FROM CustomerInteractionTopicTree__c WHERE Id = :recordId];
        
        List<String> lstPath = getPathTree(arguments);
        
        if (lstPath.size() > 0) {
            finalPath = lstPath.get(0);
        }
        /* Inicio alteração - Guilherme Kaiser
		Motivo: substituir o / por > no palito (FrontEnd) */
        
        String delimiter = ' > ';
        
        for (Integer i=1; i<lstPath.size(); i++) {
            //finalPath += '/' + lstPath.get(i);    
            finalPath += delimiter + lstPath.get(i);
        }
        //finalPath += '/' + topic.Name;    
        finalPath += delimiter + topic.Name;
        /* final alteração - Guilherme Kaiser */
        
        return finalPath;
    }   
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método criado para retornar o Role do usuário (trata se é de comunidade)
    * Data.....: 26/12/2022
    */
    public static String getUserRole(List<Object> arguments) {
        
        Id roleId=userinfo.getUserRoleId();
        Id userId=userinfo.getUserId();
        //
        String RoleName     = [Select Id, Name, DeveloperName from UserRole where Id=:roleId].DeveloperName;
        String PartnerGroup = [Select Id, Name, PartnerGroup__c from User where Id=:userId].PartnerGroup__c;
        //
        //this role is used to define when user is from community
        String userRole = PartnerGroup != null ? PartnerGroup : RoleName;
        //
        return userRole;
    }
    
    public Integer getTotalChannels(List<Object> arguments) {
        Map<String, String> mapChannel;
        List<Map<String, String>> lstChannels = new List<Map<String, String>>();
        
        String process = (String) arguments[0];      
        String strChannel = (String) arguments[1];
        Integer page = Integer.valueOf(arguments[2]);
        
        List<String> channels = strChannel.split(';');
        
        List<TopicsAuto__c> lstTopicsAuto = [SELECT Id FROM TopicsAuto__c WHERE Process__c = : process AND Channel__c IN :channels AND Status__c = 'Ativo' ORDER BY LastModifiedDate DESC, Name DESC LIMIT 10 OFFSET :page];
        Integer total = lstTopicsAuto.size();
        
        return total;
    }
    
    public static List<String> reorderComplements(List<Object> arguments) {
        String vlocityString = String.valueOf(arguments[0]);
        System.debug('vlocityString ' + vlocityString);
        String vlocityStringFormated = vlocityString.subString(23, vlocityString.length()-2);
        System.debug('vlocityStringFormated ' + vlocityStringFormated);

        
        List<String> items = vlocityStringFormated.split(', ');
        System.debug('items ' + items);
        
        Integer size = items.size();
        List<String> result = new List<String>();
        
        for (Integer i = 0; i < size; i+=2) {
            if (items[i] != '' || items[i+1] != '') {
                result.add(items[i]);
                result.add(items[i+1]);
            }
        }
        
        while (result.size() < 8) result.add('');
        System.debug('result ' + result);
        return result;
    }
    
    /*
    * Autor....: Henrique Berdu - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método criado para retornar o nome do cliente formatado.
    * Data.....: 27/04/2023
    */
    public static String properCase(List<Object> arguments) {
        String name = (String) arguments[0];
        
        if (name == null) {
            return name;
        }
        
        String[] words = name.split(' ');
        for (Integer i = 0; i < words.size(); i++) {
            words[i] = words[i].substring(0, 1).toUpperCase() + words[i].substring(1).toLowerCase();
        }
        
        return String.join(words, ' ');
    }
    
    /*
    * Autor....: Henrique Berdu - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método criado para retornar a ORG atual.
    * Data.....: 03/08/2023
    */
    public static String orgURL(List<Object> arguments) {
        
        String name = (String) arguments[0];    
        
        if (name == 'getURL') {
            
            String sfdcBaseURL = URL.getOrgDomainUrl().toExternalForm();
            String strValue = String.valueOf( sfdcBaseURL );
            return strValue;   
            
        }
        return name;
    }
    
    /*
    * Autor....: Henrique Berdu - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método criado para retornar a ORG atual.
    * Data.....: 18/08/2023
    */  
    class SubWrapper {
        String value;
        String code;
        String name;
    }
    class Wrapper{
        List<SubWrapper> Attribute;
    }    
    public String mapAttributes(Map<String, Object> inputMap) {
        
        String obj1 = JSON.serialize(inputMap.get('map1'));
        String obj2 = JSON.serialize(inputMap.get('map2'));
        System.debug('obj2 ' + obj2);
        
        Map<String, Object> map1 = (Map<String, Object>) JSON.deserializeUntyped(obj1);
        Wrapper objetoDesserializado = (Wrapper) JSON.deserialize(obj2, Wrapper.class);
        System.debug('objetoDesserializado ' + objetoDesserializado);
        
        for(Subwrapper item : objetoDesserializado.Attribute){
            if(map1.containsKey(item.code)){
                item.value = String.valueOf(map1.get(item.code));
            }
        }  
        return JSON.Serialize(objetoDesserializado.Attribute); 
    }
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método para identificar se usuário está na comunidade
    * Data.....: 18/09/2023
    */
    public static Boolean getUserInCommunity(List<Object> arguments) {
        String sfdcBaseURL = URL.getCurrentRequestUrl().toExternalForm();
        String strValue = String.valueOf( sfdcBaseURL );
        //system.debug('url...'+ strValue);        
        
        return strValue.Contains('my.site.com');
    }        
    
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método para recuperar DependentPicklist values de 1 campo específico
    * Data.....: 09/11/2023
    */
    public class MyPickListInfo {
        public String validFor;    
    }
    
    public static List<Map<String, String>> getDependentPicklist(List<Object> arguments){
        
        String objectName       	= (String) arguments[0];
        String controllingField 	= (String) arguments[1];
        String dependentField   	= (String) arguments[2];
        String pickListValueRequest = (String) arguments[3];
        
        List<Map<String, String>> listLabelValues = new List<Map<String, String>>();        
        Map<String, String> mapItens = new Map<String, String>();
        Map<String, List<String>> controllingInfo = new Map<String, List<String>>();
        
        Schema.SObjectType           objType              = Schema.getGlobalDescribe().get(objectName) ;
        Schema.DescribeSObjectResult describeResult       = objType.getDescribe();
        Schema.DescribeFieldResult   controllingFieldInfo = describeResult.fields.getMap().get(controllingField).getDescribe();
        Schema.DescribeFieldResult   dependentFieldInfo   = describeResult.fields.getMap().get(dependentField).getDescribe();
        
        List<Schema.PicklistEntry>   controllingValues    = controllingFieldInfo.getPicklistValues();
        List<Schema.PicklistEntry>   dependentValues      = dependentFieldInfo.getPicklistValues();
        
        for (Schema.PicklistEntry currControllingValue : controllingValues){
            if(pickListValueRequest ==currControllingValue.getLabel()){
                controllingInfo.put(currControllingValue.getLabel(),new List<String>());
            }
        }
        
        for (Schema.PicklistEntry currDependentValue:dependentValues){
            String  jsonString  = JSON.serialize(currDependentValue) ;
            MyPickListInfo info = (MyPickListInfo)  JSON.deserialize(jsonString,MyPickListInfo.class) ;            
            String  hexString   = EncodingUtil.convertToHex(EncodingUtil.base64Decode(info.validFor)).toUpperCase();            
            Integer baseCount   =  0;
            
            for (Integer curr:hexString.getChars()){                
                Integer  val  =  0;                
                if  (curr  >=  65){
                    val  =  curr - 65 + 10;
                }  else  {
                    val  =  curr - 48;                    
                }
                mapItens = new Map<String, String>();
                //PickList
                mapItens.put('value', currDependentValue.getLabel());
                mapItens.put('label', currDependentValue.getLabel());
                //MultiSelectPickList
				mapItens.put('Key', currDependentValue.getLabel());
                mapItens.put('Value', currDependentValue.getLabel());
                
                if (((val & 8)  ==  8) && (controllingValues[baseCount+0].getLabel()==pickListValueRequest))  {
                    controllingInfo.get (controllingValues[baseCount+0].getLabel()).add(currDependentValue.getLabel());  
                    listLabelValues.add(mapItens);                    
                }                
                if (((val & 4)  ==  4) && (controllingValues[baseCount+1].getLabel()==pickListValueRequest))  {
                    controllingInfo.get (controllingValues[baseCount+1].getLabel()).add(currDependentValue.getLabel());                    
                    listLabelValues.add(mapItens);
                }                
                if (((val & 2)  ==  2) && (controllingValues[baseCount+2].getLabel()==pickListValueRequest))  {
                    controllingInfo.get (controllingValues[baseCount+2].getLabel()).add(currDependentValue.getLabel());
                    listLabelValues.add(mapItens);
                }                
                if (((val & 1)  ==  1) && (controllingValues[baseCount+3].getLabel()==pickListValueRequest))  {
                    controllingInfo.get(controllingValues[baseCount+3].getLabel()).add (currDependentValue.getLabel());
                    listLabelValues.add(mapItens);
                }
                baseCount += 4;
            }            
        }
        return listLabelValues;
    }
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método para recuperar data e hora das últimas 24h
    * Data.....: 09/11/2023
    */
    public static Datetime getDatetimeLast24Hours(List<Object> arguments) {  
        Integer  qtyHours	= (Integer.valueOf(arguments[0])!=null ? Integer.valueOf(arguments[0]) : 24);
        Datetime d 			= datetime.now().addhours(-qtyHours);
        return d;
    }
    
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método para Calcular a data de início e término do Caso
    * Data.....: 12/12/2023
    */    
    public static DateTime getCalcDateCase(List<Object> arguments){
        
        Date    startDate			= Date.valueOf(arguments[0]);
        Integer  qtyDays		 	= Integer.valueOf(arguments[1]);
        String  func     		 	= String.valueOf(arguments[2]);
        Date    endDate;
               
        endDate = startDate.addDays(qtyDays);
        
        Map<Integer, Set<Date>> holidaysMap = new Map<Integer, Set<Date>>();
        
        for (Holiday currHoliday : [SELECT ActivityDate FROM Holiday]) {
            Integer holidayMonth = currHoliday.ActivityDate.month();
            if (!holidaysMap.containsKey(holidayMonth)) {
                holidaysMap.put(holidayMonth, new Set<Date>());
            }
            holidaysMap.get(holidayMonth).add(currHoliday.ActivityDate);
        }
        
        Set<Date> holidaysSet = holidaysMap.containsKey(startDate.month()) ?
            holidaysMap.get(startDate.month()) : new Set<Date>();
        
        if((endDate.month()>startDate.month()) && holidaysMap.containsKey(endDate.month()+1)){
            holidaysSet.AddAll(holidaysMap.get(endDate.month()+1));
        }
        
        for (Date dt = startDate; dt <= endDate; dt = dt.addDays(1)) {
            DateTime currDate = DateTime.newInstance(dt.year(), dt.month(), dt.day());
            String weekDay = currDate.format('EEEE');
            
            if (func == 'SegSex' && (weekDay == 'Saturday' || weekDay == 'Sunday' || holidaysSet.contains(dt))) {
                endDate = endDate.AddDays(1);
            } else if (func == 'SegSab' && (weekDay == 'Sunday' || holidaysSet.contains(dt))) {
                endDate = endDate.AddDays(1);
            } else if (func == 'SegDom' && (holidaysSet.contains(dt))) {
                endDate = endDate.AddDays(1);
            }            
        }
        return DateTime.newInstance(endDate.year(), endDate.month(), endDate.day(),0,0,0);
    }
    
    /*
    * Autor....: Pedro Richtmann - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método para picklis entry API Value para Lable
    * Data.....: 24/11/2023
    */ 
    
    public static String convertPicklistAPINameToLabel(List<Object> arguments) {
        
        String sobjName = (String) arguments[0];
        String objField = (String) arguments[1];
        String fieldApiValue = (String) arguments[2];
        
        List < sObject > sList =Database.query('SELECT toLabel(' + objField + ') fieldLabel, ' + objField + ' FROM ' + sobjName + ' WHERE ' + objField + ' = \'' + fieldApiValue + '\' LIMIT 1' );
        
        if ( !sList.isEmpty()){
            
            String s =  JSON.serialize(sList[0]);
            
            Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(s);
            String result = String.valueOf(m.get('fieldLabel'));
            
            return result;   
        }
        
        return 'Valor nao encontrado';   
    }
    
    /*
    * Autor....: Eduardo Murakami - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método para recuperar data e hora das últimas 24h
    * Data.....: 05/01/2024
    */
    public static Decimal convertCurrencyToNumber(List<Object> argument) {
        String currencyValue = (String) argument[0];
        Decimal convertedAmount=0;
        
        if (currencyValue != null) {
            // Remove o 'R$ ' da string de moeda, deixando apenas o valor numérico
            String numericPart = currencyValue.replaceAll('[^0-9.]', '');
            
            convertedAmount = Decimal.valueOf(numericPart)/100;
            //System.Debug(numericPart);
        }
        
        //System.Debug(currencyValue);
        //System.Debug(convertedAmount);
        return convertedAmount;
    }
    
    /*
    * Autor....: Eduardo Murakami - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método concatenar os valores de uma lista em uma String
    * Data.....: 11/01/2024
    */
    public static String listToCommaSeparatedValues(List<Object> argument) {
        
        System.Debug('Entrou no método');  
        
        List<String> tmp1 = new List<String>();
        String idString;
        
        for(Object obj : argument){
            tmp1.add(String.valueOf(obj));
        }
        
        idString = string.join(tmp1,',');
        
        System.Debug(tmp1);
        System.Debug(idString);
        return idString;
        
    }
    
    // Método para verificar se a string contém o valor especificado
    public static Boolean contains(List<Object> argument) {
        String inputString =  (String) argument[0];
        String valueToCheck =  (String) argument[1];
        if (inputString != null && valueToCheck != null) {
            return inputString.contains(valueToCheck);
        }
        return false;
    }

    /*
    * Autor....: Leonardo Vendrame
    * Projeto..: Contestação Faturas-NTT
    * Descrição: Método para decodificar base64
    * Data.....: 21/03/2024
    */    
    String base64Decode(List<Object> argument) {
        String base64Encoded = (String) argument[0];
        Blob decodedBlob = EncodingUtil.base64Decode(base64Encoded);
        
        return decodedBlob.toString();
    }

	/*
    * Autor....: Alexandre Galante
    * Projeto..: Valentina
    * Descrição: Converter Object para Lista
    * Data.....: 12/04/2024
    */        
	public static LIST<Map<String, Object>> convertObjectToList(List<Object> arguments)
    {
        try{
            LIST<Map<String, Object>> result = new LIST<Map<String, Object>>();
            Map<String,Object> inputlist = (Map<String,Object>)arguments[0];
            String key = (String)arguments[1];
            List<Object> listofElements = (List<Object>)inputlist.get('VLOCITY-FORMULA-LIST');
            for(Object str : listofElements){
                result.add(new Map<String,Object>{key => str});
            }
            return result;
        }catch(Exception e){
            return new LIST<Map<String, Object>>();
        }    
    }

    public static Boolean validaEid(List<Object> arguments) {
        if(arguments == null) {
            return false;
        }
        String numStr = String.valueOf(arguments[0]);
        System.debug('numStr ' +numStr);
        System.debug('numStr ' +numStr.length());
        if (numStr == null || numStr.length() != 32) {
            return false;
        }
        // Converter a string para Decimal para lidar com grandes números
        Decimal numberValidate = Decimal.valueOf(numStr);
        Decimal subtractedValue = numberValidate - 1;
        Decimal result = subtractedValue / 97;
        System.debug('result ' +result);
        return result == result.setScale(0, RoundingMode.DOWN);
    }
    /*
    * Autor....: Joao Quessada
    * Projeto..: Valentina
    * Descrição: Validacao de EID
    * Data.....: 04/06/2024
    */  
    
    public static Boolean validaImei(List<Object> arguments) {
        if(arguments == null) {
            return false;
        }
        
        String imei = String.valueOf(arguments[0]);
        if (imei == null || imei.length() != 15) {
            return false;
        }
        Integer lastDigit = Integer.valueOf(imei.substring(imei.length() - 1));
        Integer result = calculate(imei);
        Integer roundedValue = roundUpToNextTen(result);
        Integer finalResult = roundedValue - result;

        return finalResult == lastDigit;
    }

    public static Integer calculate(String inputValue) {
        Integer sum = 0;
        
        inputValue = inputValue.substring(0, inputValue.length() - 1);
        
        for (Integer i = 0; i < inputValue.length(); i++) {
            Integer digit = Integer.valueOf(inputValue.substring(i, i + 1));
            
            if (Math.mod(i, 2) != 0) {
                digit *= 2;
                
                if (digit >= 10) {
                    sum += Integer.valueOf(Math.floor(digit / 10).intValue());
                    sum += digit - (Integer.valueOf(Math.floor(digit / 10).intValue()) * 10);
                } else {
                    sum += digit;
                }
            } else {
                sum += digit;
            }
        }
        
        return sum;
    }
    public static Integer roundUpToNextTen(Integer num) {
        return (Integer)Math.ceil(num / 10.0) * 10;
    }
         /*
    * Autor....: Joao Quessada
    * Projeto..: Valentina
    * Descrição: Validacao de IMEI
    * Data.....: 04/06/2024
    */  
    public List<Map<String, String>> cloneAsset(List<Object> arguments) {
        List<Map<String, String>> clonedAssets = new List<Map<String, String>>();
        List<vlocity_cmt__InventoryItem__c> newInventoryItems = new List<vlocity_cmt__InventoryItem__c>();
        Map<String, Object> argMap = (Map<String, Object>)arguments[0];
        String oldCustomerAccount = (String) argMap.get('oldAccountId');
        String oldServiceAccount = (String) argMap.get('oldServiceAccount');
        List<String> oldAssetIds = new List<String>();
        for (Object obj : (List<Object>) argMap.get('OldAssetId')) {
            oldAssetIds.add((String) obj);
        }

        List<String> consumerAccounts = new List<String>();
        for (Object obj : (List<Object>) argMap.get('ConsumerAccount')) {
            consumerAccounts.add((String) obj);
        }

        List<String> newBillingAccounts = new List<String>();
        for (Object obj : (List<Object>) argMap.get('NewBillingAccount')) {
            newBillingAccounts.add((String) obj);
        }

        List<String> newServiceAccounts = new List<String>();
        for (Object obj : (List<Object>) argMap.get('NewServiceAccount')) {
            newServiceAccounts.add((String) obj);
        }

        List<String> newSubscriptions = new List<String>();
        for (Object obj : (List<Object>) argMap.get('NewSubscription')) {
            newSubscriptions.add((String) obj);
        }

        List<vlocity_cmt__InventoryItem__c> inventoryItems = [
            SELECT Id,  vlocity_cmt__ServiceAccountId__c, vlocity_cmt__AccountId__c, vlocity_cmt__BillingAccountId__c 
            FROM vlocity_cmt__InventoryItem__c 
            WHERE vlocity_cmt__AccountId__c = :oldCustomerAccount
            AND vlocity_cmt__ServiceAccountId__c = :oldServiceAccount
        ];

        for (vlocity_cmt__InventoryItem__c inventoryItem :inventoryItems) {
            inventoryItem.vlocity_cmt__AccountId__c = consumerAccounts[0];
            inventoryItem.vlocity_cmt__BillingAccountId__c = newBillingAccounts[0];
            inventoryItem.vlocity_cmt__ServiceAccountId__c = newServiceAccounts[0];
            newInventoryItems.add(inventoryItem);
        }
         
        List<Asset> originalAssets = [SELECT Id, AccountId, AssetLevel, AssetProvidedById, AssetServicedById, Cabinet__c,
            ContactId, CreatedById, CreatedDate, Description, DigitalServices__c, ExternalId__c, 
            HasBonus__c, HasBonusFormula__c, HasDiscount__c, HasDiscountFormula__c, 
            HolderDependent__c, IMEI__c, InstallDate, Instance__c, IsCompetitorProduct, IsDeleted, 
            IsHolder__c, IsInternal, LastModifiedById, LastModifiedDate, LastReferencedDate, LastViewedDate, 
            LegacyAssetId__c, LegacyIdentifier__c, LegacySystem__c, MainProductDescription__c, 
            Name, NRCAccount__c, OwnerId, ParentId, PhoneNumber__c, Platform__c, PortfolioType__c, 
            Price, PriceCurrent__c, PriceOver__c, Product2Id, ProductCode, ProductType__c, PurchaseDate, Quantity, 
            RootAssetId, SerialNumber, SourceSystem__c, Speed__c, Status, StockKeepingUnit, Streaming__c, 
            TVOfferFormula__c ,Type__c, UsageEndDate, vlocity_cmt__Action__c, 
            vlocity_cmt__ActivationDate__c, vlocity_cmt__ActivationName__c, vlocity_cmt__AssetReferenceId__c, 
            vlocity_cmt__AttributeSelectedValues__c, vlocity_cmt__BaseOneTimeCharge__c, vlocity_cmt__BaseOneTimeTotal__c, 
            vlocity_cmt__BaseRecurringCharge__c, vlocity_cmt__BaseRecurringTotal__c, vlocity_cmt__BillingAccountId__c, 
            vlocity_cmt__BillingHold__c, vlocity_cmt__CatalogItemReferenceDateTime__c, vlocity_cmt__ConnectDate__c, 
            vlocity_cmt__ContractId__c, vlocity_cmt__ContractNumber__c, vlocity_cmt__CurrencyPaymentMode__c, 
            vlocity_cmt__DeregulationStatus__c, vlocity_cmt__DisconnectDate__c, vlocity_cmt__EffectiveBaseOneTimeTotal__c, 
            vlocity_cmt__EffectiveBaseRecurringTotal__c, vlocity_cmt__EffectiveOneTimeCostTotal__c, 
            vlocity_cmt__EffectiveOneTimeLoyaltyTotal__c, vlocity_cmt__EffectiveOneTimeTotal__c, 
            vlocity_cmt__EffectiveQuantity__c, vlocity_cmt__EffectiveRecurringCostTotal__c, 
            vlocity_cmt__EffectiveRecurringTotal__c, vlocity_cmt__EffectiveUsageCostTotal__c, 
            vlocity_cmt__EffectiveUsagePriceTotal__c, vlocity_cmt__EffectiveUsageQuantity__c, 
            vlocity_cmt__FinancedAmount__c, vlocity_cmt__FinancedAmountTotal__c, vlocity_cmt__FinancedInstallmentAmount__c, 
            vlocity_cmt__InCartQuantityMap__c, vlocity_cmt__InventoryItemId__c, vlocity_cmt__ItemName__c, 
            vlocity_cmt__LineNumber__c, vlocity_cmt__OneTimeCalculatedPrice__c, vlocity_cmt__OneTimeCharge__c, 
            vlocity_cmt__OneTimeCost__c, vlocity_cmt__OneTimeCostTotal__c, vlocity_cmt__OneTimeDiscountPrice__c, 
            vlocity_cmt__OneTimeLoyaltyPrice__c, vlocity_cmt__OneTimeLoyaltyTotal__c, vlocity_cmt__OneTimeManualDiscount__c, 
            vlocity_cmt__OneTimeMargin__c, vlocity_cmt__OneTimeTotal__c, vlocity_cmt__OrderId__c, 
            vlocity_cmt__OrderProductId__c, vlocity_cmt__ParentItemId__c, vlocity_cmt__Password__c, 
            vlocity_cmt__PremisesId__c, vlocity_cmt__PricebookEntryId__c, vlocity_cmt__PriceListId__c, 
            vlocity_cmt__PricingLogData__c, vlocity_cmt__ProductAttribXN__c, vlocity_cmt__ProductGroupKey__c, 
            vlocity_cmt__ProductHierarchyGroupKeyPath__c, vlocity_cmt__ProductHierarchyPath__c, 
            vlocity_cmt__ProvisioningStatus__c, vlocity_cmt__RecurringCalculatedPrice__c, vlocity_cmt__RecurringCharge__c, 
            vlocity_cmt__RecurringCost__c, vlocity_cmt__RecurringCostTotal__c, vlocity_cmt__RecurringDiscountPrice__c, 
            vlocity_cmt__RecurringManualDiscount__c, vlocity_cmt__RecurringMargin__c, vlocity_cmt__RecurringTotal__c, 
            vlocity_cmt__RecurringUOM__c, vlocity_cmt__ReliesOnItemId__c, vlocity_cmt__RootItemId__c, 
            vlocity_cmt__SequenceNumber__c, vlocity_cmt__ServiceAccountId__c, vlocity_cmt__ServiceIdentifier__c, 
            vlocity_cmt__ServicePointId__c, vlocity_cmt__SubscriptionId__c, vlocity_cmt__UsageCostTotal__c, 
            vlocity_cmt__UsageMargin__c, vlocity_cmt__UsageMeasurementId__c, vlocity_cmt__UsagePriceTotal__c, 
            vlocity_cmt__UsageQuantity__c, vlocity_cmt__UsageUnitCost__c, vlocity_cmt__UsageUnitPrice__c, 
            vlocity_cmt__Username__c 
        FROM Asset 
        WHERE Id IN :oldAssetIds 
        LIMIT 3
        ];

        Map<String, Asset> assetMap =  new Map<String, Asset>();
        for (Asset asset : originalAssets) {
            assetMap.put(asset.Id, asset);
        }

        List<Asset> assetsToUpdate = new List<Asset>();
        List<Asset> assetsToInsert = new List<Asset>();

        for (Integer i =0; i<oldAssetIds.size(); i++){
            String assetId = oldAssetIds[i];
            String consumerAccount = consumerAccounts[i];
            String newBillingAccount = newBillingAccounts[i];
            String newServiceAccount = newServiceAccounts[i];
            String newSubscription = newSubscriptions[i];

            Asset originalAsset =  assetMap.get(assetId);
            
            // Clonar o Asset
            Asset clonedAsset = originalAsset.clone(false, false);
            originalAsset.AccountId = consumerAccount;
            originalAsset.vlocity_cmt__BillingAccountId__c = newBillingAccount;
            originalAsset.vlocity_cmt__ServiceAccountId__c = newServiceAccount;
            if (originalAsset.vlocity_cmt__ParentItemId__c==null) {
                originalAsset.vlocity_cmt__SubscriptionId__c = newSubscription;
            }
            if (clonedAsset.LegacyIdentifier__c != null && clonedAsset.LegacyIdentifier__c.length() > 0) {
                clonedAsset.LegacyIdentifier__c = 'X' + clonedAsset.LegacyIdentifier__c.substring(1);
            }
            // if (clonedAsset.ParentId != null) {
            //     clonedAsset.ParentId += '_OLD';
            // }
            if (clonedAsset.vlocity_cmt__AssetReferenceId__c!= null) {
                clonedAsset.vlocity_cmt__AssetReferenceId__c += '_OLD';
            }
            if (clonedAsset.vlocity_cmt__ParentItemId__c!= null) {
                clonedAsset.vlocity_cmt__ParentItemId__c += '_OLD';
            }
            if (clonedAsset.vlocity_cmt__RootItemId__c!= null) {
                clonedAsset.vlocity_cmt__RootItemId__c += '_OLD';
            }
            clonedAsset.Status = 'Desativado';
            clonedAsset.vlocity_cmt__Action__c = 'Disconnect';
            clonedAsset.vlocity_cmt__DisconnectDate__c = Datetime.now();
            // Inserir o novo Asset clonado
            if (originalAsset.Id!=null) {
                assetsToUpdate.add(originalAsset);
            }
            System.debug('assetsToUpdate: ' + originalAsset.vlocity_cmt__RootItemId__c);
            System.debug('assetsToInsert: ' + clonedAsset.vlocity_cmt__RootItemId__c);
            assetsToInsert.add(clonedAsset);
        }

        List<OrderItem> originalOrderItems = [SELECT Id, vlocity_cmt__AssetId__c, vlocity_cmt__ParentItemId__c,
        vlocity_cmt__SubscriptionId__c
        FROM OrderItem 
        WHERE vlocity_cmt__AssetId__c IN :oldAssetIds 
        ];
        
        List<OrderItem> orderItemToUpdate = new List<OrderItem>();

        for (OrderItem originalOrderItem : originalOrderItems){
            if (originalOrderItem.vlocity_cmt__ParentItemId__c == null) {
                originalOrderItem.vlocity_cmt__SubscriptionId__c= newSubscriptions[0];
                orderItemToUpdate.add(originalOrderItem);
            }
        }


        if (!orderItemToUpdate.isEmpty()) {
            update orderItemToUpdate;
        }
        if (!assetsToUpdate.isEmpty()) {
            update assetsToUpdate;
        }
        if (!assetsToInsert.isEmpty()) {
            insert assetsToInsert;
        }
        if(!newInventoryItems.isEmpty()) {
            update newInventoryItems;
        }

        for (Asset asset :assetsToUpdate) {
            Map<String, String> assetMapItem = new Map<String, String>();
            assetMapItem.put('id', asset.Id);
            clonedAssets.add(assetMapItem);
        }

        return clonedAssets;
    }
    /*
    * Autor....: Guilherme Kaiser - Deloitte
    * Projeto..: Vivo - VALENTINA
    * Descrição: Método retornar os produtos elegiveis
    * Data.....: 09/08/2024
    */
    public List<ProductEligibility__c> productEligibilityQuery(List<Object> arguments) {       
        String ddd         = (String) arguments[0];
        String productName = (String) arguments[1];
        String productCode = (String) arguments[2];
        productCode = '%'+productCode + '%';

            // Montando a query com os valores fornecidos         
            List<ProductEligibility__c> productEligibility= [SELECT Id, ProductId__c
                                                               FROM ProductEligibility__c
                                                              WHERE DDD__c INCLUDES ( :ddd )
                                                                AND ProductId__r.Name =  :productName
                                                                AND ProductId__r.ProductCode LIKE :productCode ];
                                 
            return productEligibility;
	}
    
    public static Map<String, Object> removeNullValues(Map<String, Object> inputs) {
        Map<String, Object> balanceData = (Map<String, Object>) inputs.get('balanceData'); 
        List<Object> attributesList = (List<Object>) balanceData.get('attributesList');
        List<Object> filteredList = new List<Object>();
        for (Object obj : attributesList) {
            System.debug(obj);
            if (obj != null) {
                filteredList.add(obj);
            }
        }
        System.debug(filteredList);
        balanceData.put('attributesList', filteredList);
        return inputs;
    }
}