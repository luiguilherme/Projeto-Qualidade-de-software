public class FibraRuralLeadElegibilidadeService {
    
    
    @InvocableMethod
    public static List<String> flowMethods(List<String> text){
        
        List<String> listParameters = text[0].split(',');
        List<String> returnToFlow = new List<String>();

        if(listParameters[0] == 'unformatString'){
            returnToFlow = FibraRuralLeadElegibilidadeEngine.unformatString(listParameters);
        } 
        else if(listParameters[0] == 'sendEmailController'){
            returnToFlow = FibraRuralLeadElegibilidadeEngine.sendEmailController(listParameters);
        }
        
        return returnToFlow;
        
    }
    
    
}