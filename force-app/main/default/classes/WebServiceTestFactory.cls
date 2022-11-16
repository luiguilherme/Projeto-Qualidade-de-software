@isTest
public class WebServiceTestFactory {
    private Webservice__c current;
    private List<Webservice__c> currentList;

    public WebServiceTestFactory(Webservice__c current) {
        this.current = current;
        if (currentList == null){ 
            currentList = new List<Webservice__c>();
        }
        this.currentList.add(this.current);
    }

    public Webservice__c create(){
        insert current;
        return current;
    }

    public Webservice__c build(){
        return current;
    }

    public List<Webservice__c> createList() {
        insert currentList;
        return currentList;
    }

    /***** RECURSIVE METHODS *****/
    public WebServiceTestFactory next() {
        current = newInstance();
        currentList.add(current);
        return this;
    }
    public WebServiceTestFactory authOAuthProvider(){
        current.Name = 'API_GW';
        return this;
    }

    /***** STATIC METHODS *****/
    public static Webservice__c newInstance(){
        return new Webservice__c(
                Endpoint__c = 'https://api-hml.telefonica.com.br/oauth2/v1/tokens',
            	Certificate__c = 'Basic NTMzNGFjNTdlMDIyNGFiOGI0YmI0ZTA4ZTZjYjE3NTY6OG81NVlZT2g3c2lF',
            	ServiceOperation__c = 'application/x-www-form-urlencoded;charset=UTF-8',
            	Application__c = 'MDAz',
                AppKey__c   = 'b29dcdb3-d14e-41ee-b6bc-3900bd2b2f98	',
                Timeout__c  = 6000,
            	AltEndpoint__c = 'https://api-hml.telefonica.com.br/oauth2/v1/tokens',
            	Password__c	= 'grant_type=password&username=SCV_SFA_B2C&password=Vivo@2019&scope=APIManager.Default'
            );
    }

    public static WebServiceTestFactory start(){
        return new WebServiceTestFactory(newInstance());
    }

    public static List<Webservice__c> getAll(){
        return [SELECT Name, Endpoint__c, Certificate__c, ServiceOperation__c, Application__c, Timeout__c, AppKey__c, AltEndpoint__c, Password__c
                FROM Webservice__c];
    }
}