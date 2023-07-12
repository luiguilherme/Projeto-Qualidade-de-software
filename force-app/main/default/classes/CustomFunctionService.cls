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
            when 'trim' 
            {output.put('result', trimValues(arguments));}   
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
            when 'CPFUnderageThirdParty' {return System.Label.CPFUnderageThirdParty;}
            when 'CPFPEPFirstParty' {return System.Label.CPFPEPFirstParty;}
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
            system.debug('Kaiser -> :'+true);
            return true;
        }else{
            system.debug('Kaiser -> :'+false);
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

    
    public static List<Object> GetListRange(List<Object> arguments){
        
        try{
            Map <String, Object> objectsMap =  (Map <String, Object>) arguments[0];
            
            List<Object> objects = (List<Object>) objectsMap.get('Objects');
            
            Integer startIndex = Integer.valueOf(arguments[1]);
            Integer endIndex = Integer.valueOf(arguments[2]);
            
            
            List<Object> filtredList =  new List<Object> ();
            
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
        String vlocityStringFormated = vlocityString.subString(23, vlocityString.length()-2);
        
        List<String> items = vlocityStringFormated.split(', ');
        
        Integer size = items.size();
        List<String> result = new List<String>();
        
        for (Integer i = 0; i < size; i+=2) {
            if (items[i] != '' || items[i+1] != '') {
                result.add(items[i]);
                result.add(items[i+1]);
            }
        }
        
        while (result.size() < 8) result.add('');
        
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

}