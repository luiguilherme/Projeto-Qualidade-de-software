/**
  * @author Danieli
  * @date 02/01/2020
  * @description fábrica de Account para classes de testes
**/
@isTest
public class AccountTestFactory {
    
    private Account fAccount;
    
    public AccountTestFactory( Account aAccount ){
        fAccount = aAccount;
    }
    
    public static AccountTestFactory start(){
        return new AccountTestFactory (
            new Account(
                Name = 'Account Test',
                DocumentNumber__c = '11111111111111'
            ) );
    }
    
    public AccountTestFactory isAccount(){
        fAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Consumer').getrecordTypeId();

        return this;
    }
    
    public Account create() {
        insert fAccount;
        return fAccount;
    }
    
    public Account build() {
        return fAccount;
    }
    public AccountTestFactory isPerson(){
        fAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getrecordTypeId();
        return this;
    }
    public AccountTestFactory startPersonAccount(){
  		Contact contact = new Contact();
        contact.MotherName__c='Kate Lucia';
		contact.Birthdate=System.today();
  		contact.MailingStreet='test@yahoo.com';
  		contact.MailingPostalCode='12345';
  		contact.MailingCity='SFO';
  		contact.Email='test@yahoo.com';
  		contact.HomePhone='1234567';
  		contact.MobilePhone='12345678';
        contact.LastName='Test Name';
        insert contact;
        fAccount.vlocity_cmt__PrimaryContactId__c = contact.Id;
        
		fAccount.DocumentNumber__c='11111111111111' ;
        fAccount.CreditScoreDate__c = System.now().addDays(-2);
        return this;
    }
    
}