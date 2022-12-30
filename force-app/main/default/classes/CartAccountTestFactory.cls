/*
---------------------------------------------------
@authors - Pedro Salles 
@company - Telefonica 
@date - 27/04/2020
@description - Classe de Teste da Controller do componente
de userIndicator
---------------------------------------------------

*/
public class CartAccountTestFactory {
     private CartAccount__c fCartAccount;
    
    public cartAccountTestFactory( CartAccount__c aCartAccount ){
        fCartAccount = aCartAccount;
    }
    
    public static cartAccountTestFactory start(Id aAccountId ){
        return new cartAccountTestFactory (
			new CartAccount__c(
				AccountId__c = aAccountId
        ) );
    }
    
    public cartAccountTestFactory isUseIndicator(Id aAccountId){
    	fCartAccount.RecordTypeId = Schema.SObjectType.CartAccount__c.getRecordTypeInfosByDeveloperName().get('UseIndicator').getrecordTypeId();
        fCartAccount.AccountId__c = aAccountId;
        return this;
    }
    public cartAccountTestFactory isInsertCart(Id aAccountId){
    	fCartAccount.RecordTypeId = Schema.SObjectType.CartAccount__c.getRecordTypeInfosByDeveloperName().get('SelectCart').getrecordTypeId();
        fCartAccount.AccountId__c = aAccountId;
        return this;
    }
    
	public CartAccount__c create() {
		insert fCartAccount;
		return fCartAccount;
	}


}