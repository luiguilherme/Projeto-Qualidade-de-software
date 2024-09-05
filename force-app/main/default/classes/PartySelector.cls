/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class PartySelector {
 
    public static List<vlocity_cmt__Party__c> selectDependentsByCpfAndLine(String cpfAndLine) {
        return [
            SELECT 
            	Id,
                vlocity_cmt__ContactId__c, 
            	vlocity_cmt__ContactId__r.CPF__c,
                vlocity_cmt__ContactId__r.FirstName, 
                vlocity_cmt__ContactId__r.LastName, 
                vlocity_cmt__ContactId__r.ExternalId__c, 
                vlocity_cmt__ContactId__r.ContactEmail__c, 
                vlocity_cmt__ContactId__r.AssistantPhone, 
                vlocity_cmt__ContactId__r.OtherPhone,
            	vlocity_cmt__ContactId__r.OtherEmail__c,
            	vlocity_cmt__ContactId__r.Nickname__c,
                vlocity_cmt__ContactId__r.MotherName__c,
                vlocity_cmt__ContactId__r.Birthdate, 
            	vlocity_cmt__ContactId__r.Email,
            	vlocity_cmt__ContactId__r.MobilePhone,
            	vlocity_cmt__ContactId__r.HomePhone,
            	vlocity_cmt__ContactId__r.Phone
            FROM vlocity_cmt__Party__c 
            WHERE Id IN (
                SELECT SourceParty__c 
                FROM AssetPartyRelationShip__c 
                WHERE TargetAsset__r.ExternalId__c =: cpfAndLine 
                AND Role__c = 'Usuário'
            )
        ];
    }

    public static List<vlocity_cmt__Party__c> selectAllDependentsByCpf(String cpf) {
        String cpfPattern = cpf + '%';
        return [
 			SELECT 
            	Id,
                vlocity_cmt__ContactId__c, 
            	vlocity_cmt__ContactId__r.CPF__c,
                
                vlocity_cmt__ContactId__r.FirstName, 
                vlocity_cmt__ContactId__r.LastName, 
                vlocity_cmt__ContactId__r.ExternalId__c, 
                vlocity_cmt__ContactId__r.ContactEmail__c, 
                vlocity_cmt__ContactId__r.AssistantPhone, 
                vlocity_cmt__ContactId__r.OtherPhone,
            	vlocity_cmt__ContactId__r.OtherEmail__c,
            	vlocity_cmt__ContactId__r.Nickname__c,
                vlocity_cmt__ContactId__r.MotherName__c,
                vlocity_cmt__ContactId__r.Birthdate, 
            	vlocity_cmt__ContactId__r.Email,
            	vlocity_cmt__ContactId__r.MobilePhone,
            	vlocity_cmt__ContactId__r.HomePhone,
            	vlocity_cmt__ContactId__r.Phone  
            FROM vlocity_cmt__Party__c 
            WHERE Id IN (
                SELECT SourceParty__c 
                FROM AssetPartyRelationShip__c 
                WHERE TargetAsset__r.Account.ExternalId__c LIKE :cpfPattern
                AND Role__c = 'Usuário'
            )
        ];
    }
    
    public static List<AssetPartyRelationShip__c> selectAssetPartyByPartyId(String IdParty ) {
        return [
            SELECT 
            	Id,
            	TargetAsset__r.Name, 
            	Role__c, 
            	TargetAsset__c,
            	ApprovedByOwner__c,
            	TargetAsset__r.PhoneNumber__c,
            	TargetAsset__r.Account.ExternalId__c,
            	Name
            FROM AssetPartyRelationShip__c
            WHERE SourceParty__c = :IdParty 
        ];    
    }

    public static List<vlocity_cmt__Party__c> selectAllContacts(String cpff) {
        return [
            SELECT 
            	Id,
                vlocity_cmt__ContactId__c, 
            	vlocity_cmt__ContactId__r.CPF__c,
                vlocity_cmt__ContactId__r.FirstName, 
                vlocity_cmt__ContactId__r.LastName, 
                vlocity_cmt__ContactId__r.ExternalId__c, 
                vlocity_cmt__ContactId__r.ContactEmail__c, 
                vlocity_cmt__ContactId__r.AssistantPhone, 
                vlocity_cmt__ContactId__r.OtherPhone,
            	vlocity_cmt__ContactId__r.OtherEmail__c,
            	vlocity_cmt__ContactId__r.Nickname__c,
                vlocity_cmt__ContactId__r.MotherName__c,
                vlocity_cmt__ContactId__r.Birthdate, 
            	vlocity_cmt__ContactId__r.Email,
            	vlocity_cmt__ContactId__r.MobilePhone,
            	vlocity_cmt__ContactId__r.HomePhone,
            	vlocity_cmt__ContactId__r.Phone

            FROM vlocity_cmt__Party__c 
            WHERE Id =: cpff
        ];
    }

}