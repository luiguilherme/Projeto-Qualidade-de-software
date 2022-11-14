public class FibraRuralLeadElegibilidadeEngine {
    
    
    public static List<String> unformatString(List<String> text){
        
        String textLower = text[1].toLowerCase();
        
        Map<String, String> mapDictionary = new Map<String, String>();
        mapDictionary.put('ä', 'a');
        mapDictionary.put('á', 'a');
        mapDictionary.put('â', 'a');
        mapDictionary.put('à', 'a');
        mapDictionary.put('ã', 'a');
        mapDictionary.put('é', 'e');
        mapDictionary.put('è', 'e');
        mapDictionary.put('ê', 'e');
        mapDictionary.put('ë', 'e');
        mapDictionary.put('í', 'i');
        mapDictionary.put('î', 'i');
        mapDictionary.put('ï', 'i');
        mapDictionary.put('ì', 'i');
        mapDictionary.put('ö', 'o');
        mapDictionary.put('ó', 'o');
        mapDictionary.put('ò', 'o');
        mapDictionary.put('õ', 'o');
        mapDictionary.put('ô', 'o');
        mapDictionary.put('ü', 'u');
        mapDictionary.put('ú', 'u');
        mapDictionary.put('ù', 'u');
        mapDictionary.put('û', 'u');
        mapDictionary.put('ç', 'c');
        
        String aux;
        List<String> response = new List<String>();
        
        for (Integer i = 0; i < textLower.length(); i++){
            aux = textLower.substring(i, i+1);
            if(mapDictionary.containsKey(aux)){
                textLower = textLower.replace(textLower.substring(i, i+1), mapDictionary.get(aux));
            }     
        }
        
        response.add(textLower);
        
        return response;
        
    }
    
    public static List<String> sendEmailController(List<String> parametros) {
        
        Integer CODE_HTTP_SUCCESS = 200;
        List<Parametros> param = new List<Parametros>();
        List<String> retornToService = new List<String>();
        
        Payload pl = new Payload();
        pl.codigoMensagem = parametros[1];
        pl.email = parametros[2];
        
        Parametros p1 = new Parametros();
        p1.chave = 'nome';
        p1.valor = parametros[3];
        param.add(p1);
        pl.Parametros = param;
        
        String payload = JSON.serialize(pl);
        Id jobId = System.enqueueJob(new AsyncFibraRuralElegibilidade(payload, parametros[2], parametros[4]));
        
        return retornToService;
        
    }
           
    public class Payload {
        
        public String codigoMensagem 		{get; set;}
        public String email 				{get; set;}
        public List<Parametros> parametros {get; set;}
    
    }
    
    public class Parametros {
        
        public String chave {get; set;}
        public String valor {get; set;}
    
    }
    
    
}