public class FibraRuralLeadElegibilidadeCallout {
    
    
    public static Integer sendEmailAPI(String payload){
        
        try{
            
            Webservice__c WSemail = Webservice__c.getValues('API_GW_SendMailCSS');
            HttpClient http = new HttpClient();
            HttpResponse httpResponse = http.post(WSemail, payload);
            return httpResponse.getStatusCode();
            
        } catch(Exception e){
            return 500;
        }
        
    }
    
}