/*
---------------------------------------------------
@authors - Pedro Salles 
@company - Telefonica 
@date - 27/04/2020
@description - Classe de Teste da Controller do componente
de userIndicator
---------------------------------------------------

*/
@isTest
public class UserIndicatorControllerTest {    
	@testSetup 
    static void setup(){
        Account lAccount = AccountTestFactory.start().isAccount().create();
        Account lAccountOfferAlta = AccountTestFactory.start().isAccount().create();
        
        CartAccount__c cartAccount = cartAccountTestFactory.start(lAccount.Id).isUseIndicator(lAccount.Id).create();
    
        
    }
    @isTest
    public static void getUserIndicator(){
        Account lAccount = [ SELECT Id, OwnerId FROM Account LIMIT 1];
        
        Test.startTest();   
        CartAccount__c lUserIndicator = userIndicatorController.insertIndicator( lAccount.Id, lAccount.OwnerId);
        Test.stopTest();
       
    } 
    @isTest
    public static void getUserIndicatorCart(){
        CartAccount__c ltCart = [SELECT  Id, AccountId__c, OwnerId, CreatedDate, TotalPrice__c, Discount__c
                                         FROM CartAccount__c ];
        Id idAccount = ltCart.AccountId__c;
        Account lAccount = [ SELECT Id,Name, OwnerId FROM Account WHERE Id !=: idAccount];
        
        Test.startTest();   
        CartAccount__c lUserIndicator = userIndicatorController.insertIndicator( lAccount.Id, lAccount.OwnerId);
        Test.stopTest();
       
    } 
}