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
            when 'validateCPF' 
            	{output.put('result', validateCPF(arguments));}
            when 'validateCNPJ' 
            	{output.put('result', validateCNPJ(arguments));}
            when 'formatDate' 
            	{output.put('result', formatDate(arguments));}            
        }
        return true;
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
}