/**  
 * @description Controla a busca e criação do objeto Asset
 */
public without sharing class AssetDAO {
    public static List<Asset> getAssetMobileByAccountAndLastModifiedDate(String accountId, DateTime assetLoadDate) {
        return  [
            SELECT Id,                
                MainProductDescription__c, 
                PhoneNumber__c, 
                HolderDependent__c,
                HasDiscountFormula__c, 
                HasBonusFormula__c, 
                HasDiscount__c, 
                PriceCurrent__c, 
                PriceOver__c , 
                ProductType__c, 
                LegacySystem__c,
                Speed__c,
            	vlocity_cmt__BillingAccountId__c
        FROM 
            Asset 
        WHERE 
            AccountId =: accountId 
        AND Type__c = 'Movel'
        AND LastModifiedDate >: assetLoadDate];
    }

    public static List<Asset> getAssetMobileByAccount(String accountId) {
        return   [
            SELECT Id,
            	Name,                            	
            	Account.RecordType.Id,
                MainProductDescription__c, 
                PhoneNumber__c, 
                Type__c,
                HolderDependent__c,
                HasDiscountFormula__c,
                HasBonusFormula__c, 
                HasDiscount__c, 
                PriceCurrent__c, 
                PriceOver__c, 
                ProductType__c, 
                LegacySystem__c,
                Speed__c,
            	vlocity_cmt__BillingAccountId__c,
            	Account.BillingStreet                
        FROM 
            Asset
        WHERE 
            AccountId =: accountId 
        AND Type__c = 'Movel'];
    }
    
	@AuraEnabled
    public static List<Asset> getAssetMobileMigration(String accountId) {
        return   [
            SELECT Id,                          	
                AccountId,
                Status,
                PhoneNumber__c, 
                BillingAccountFormulaName__c,
                Type__c,
                ProductType__c, 
                MainProductDescription__c,
                SourceSystem__c
        FROM 
            Asset
        WHERE 
            AccountId =: accountId
        AND Status = 'Active'
        AND Type__c = 'Movel'
        AND (NOT MainProductDescription__c  LIKE '%Fam%')];
    }

    public static List<Asset> getAssetFixed(String accountId) {
        return  [
            SELECT Id,              
            ProductType__c, 
            Speed__c, 
            Technology__c              
        FROM Asset 
        WHERE AccountId =: accountId 
        //    AND Account.RecordType.DeveloperName = 'Fixa'
        //    AND ProductType__c = 'BANDA LARGA' 
        //    AND Technology__c = 'FTTH'	
        AND vlocity_cmt__ServiceAccountId__r.ShippingState IN ('SP', 'DF')
        AND type__c = 'Fixa' 

        ];
    }

    public static List<Asset> getAssetFixedByAccountAndLastModifiedDate(String accountId, DateTime assetLoadDate){
        return [
        SELECT Id, 
            TVOfferFormula__c,
            MainProductDescription__c, 
            Instance__c,             
            Technology__c, 
            Cabinet__c, 
            ProductType__c, 
            Speed__c, 
            LegacySystem__c, 
            Streaming__c,
            vlocity_cmt__BillingAccountId__c,
            vlocity_cmt__ServiceAccountId__r.ShippingState,
            vlocity_cmt__ServiceAccountId__r.ShippingCity,
            vlocity_cmt__ServiceAccountId__r.FullAddress__c
        FROM Asset 
        WHERE AccountId =: accountId 
            // AND Account.RecordType.DeveloperName = 'Fixa' 
            AND type__c = 'Fixa'
            AND LastModifiedDate >: assetLoadDate
        ];
    }

    public static List<Asset> getAssetFixedByAccount(String accountId){
        return [
            SELECT
                Id, 
                TVOfferFormula__c,
                MainProductDescription__c, 
                LastModifiedDate, 
                Instance__c,                
                AccountId,
                Technology__c,
                Type__c,
                Cabinet__c, 
                ProductType__c, 
                Speed__c, 
                LegacySystem__c, 
                Streaming__c,
                vlocity_cmt__BillingAccountId__c,
                vlocity_cmt__ServiceAccountId__r.ShippingState,
                vlocity_cmt__ServiceAccountId__r.ShippingCity,
                vlocity_cmt__ServiceAccountId__r.FullAddress__c
            FROM Asset 
            WHERE AccountId =: accountId 
            // AND Account.RecordType.DeveloperName = 'Fixa'
            and type__c = 'Fixa'
        ];
    }
    
    public static List<Asset> getAssetPreByAccount(String accountId){
        return [
            SELECT
                Id, 
                TVOfferFormula__c,
                MainProductDescription__c, 
                LastModifiedDate, 
                Instance__c,                
                AccountId,
                Technology__c,
                Type__c,
                Cabinet__c, 
                ProductType__c, 
                Speed__c, 
                LegacySystem__c, 
                Streaming__c,
                vlocity_cmt__BillingAccountId__c,
                vlocity_cmt__ServiceAccountId__r.ShippingState,
                vlocity_cmt__ServiceAccountId__r.ShippingCity,
                vlocity_cmt__ServiceAccountId__r.FullAddress__c
            FROM Asset 
            WHERE AccountId =: accountId 
             AND Product2.vlocity_cmt__Type__c  = 'Prepaid'
        ];
    }    
    
    public static List<Asset> getByAccountIdRecordtypeDeveloperName(Id accountId, String recordtypeName){
        return[
            SELECT 
                Id,
            	vlocity_cmt__BillingAccountId__c,
            	vlocity_cmt__ServiceAccountId__r.FullAddress__c,
                MainProductDescription__c,
                PhoneNumber__c,
                HolderDependent__c,
                HasDiscountFormula__c,
                HasBonusFormula__c,
                HasDiscount__c,
                PriceCurrent__c,
                PriceOver__c ,
                ProductType__c,
                Speed__c,
                Instance__c,
                LastModifiedDate            	
            FROM 
                Asset 
            WHERE 
                AccountId =: accountId 
            AND 
            	Type__c = :recordtypeName                
        ];
    }

    public static List<Asset> getByAccountIdRecordtypeDeveloperNameLastModifiedDate(Id accountId, String recordtypeName, Datetime lastModifiedDate){
        return[
            SELECT 
                Id,
            	Name,
                vlocity_cmt__BillingAccountId__c,
            	vlocity_cmt__ServiceAccountId__r.FullAddress__c,
                MainProductDescription__c,
                PhoneNumber__c,
                HolderDependent__c,
                HasDiscountFormula__c,
                HasBonusFormula__c,
                HasDiscount__c,
                PriceCurrent__c,
                PriceOver__c ,
                ProductType__c,
                Speed__c,
                Instance__c,
                LastModifiedDate	            
            FROM 
                Asset 
            WHERE 
                AccountId =: accountId 
            AND 
       			Type__c = :recordtypeName
            AND 
                LastModifiedDate > :lastModifiedDate   
        ];
    }

    public static Asset getAssetById(String Id) {
        return   [
            SELECT  Id,
                    toLabel(Status),            		
                    Instance__c,
            		Name,
                    MainProductDescription__c,
                    Product2.vlocity_cmt__Type__c,
                    vlocity_cmt__ServiceIdentifier__c
        FROM 
            Asset 
        WHERE 
            Id =: Id
        LIMIT 1 
        ];
    }

    public static List<Asset> getAssetByName(String Name) {
        return   [
		SELECT Id,
                AccountId,
                Account.Name,
                Account.Id,
                Account.DocumentNumber__c,
                Account.vlocity_cmt__CustomerValue__c,
            	Account.vlocity_cmt__PrimaryContactId__c,
            	Account.phone,
            	PhoneNumber__c,
            	Account.CustomerSegment__c
        FROM 
            Asset 
        WHERE 
            Name =: Name 
        ];
    }

    public static List<Asset> getByAccountId(Id accountId){
        return[
            SELECT  
            	Id, 
            	Status, 
            	Product2.vlocity_cmt__SubType__c, 
            	LegacyIdentifier__c, 
            	vlocity_cmt__ServiceIdentifier__c,
            	StartDateTime__c, 
            	EndDateTime__c, 
            	vlocity_cmt__AttributeSelectedValues__c,
                Name,                
                Account.Name,
                LegacyAssetId__c,
                Type__c
            FROM 
                Asset
            WHERE
                AccountId = :accountId 
        ];
    }
    
    public static List<Asset> getBySetAccountIdWithPromotionProduct(Set<Id> setAccId){
        return[
            SELECT  
                Id,
                Name,                
                Account.Name,
                LegacyAssetId__c,
                Type__c,
                Platform__c,
                vlocity_cmt__ServiceIdentifier__c,
                vlocity_cmt__ServiceAccountId__r.AcceptPromotion__c,
                vlocity_cmt__ServiceAccountId__r.BillingAddressType__c,
                vlocity_cmt__ServiceAccountId__r.BillingCity,
                vlocity_cmt__ServiceAccountId__r.BillingComplement1__c,
                vlocity_cmt__ServiceAccountId__r.BillingComplement2__c,
                vlocity_cmt__ServiceAccountId__r.BillingComplement3__c,
                vlocity_cmt__ServiceAccountId__r.BillingComplement4__c,
                vlocity_cmt__ServiceAccountId__r.BillingComplementType1__c,
                vlocity_cmt__ServiceAccountId__r.BillingComplementType2__c,
                vlocity_cmt__ServiceAccountId__r.BillingComplementType3__c,
                vlocity_cmt__ServiceAccountId__r.BillingComplementType4__c,
                vlocity_cmt__ServiceAccountId__r.BillingNeighborhood__c,
                vlocity_cmt__ServiceAccountId__r.BillingNumber__c,
                vlocity_cmt__ServiceAccountId__r.BillingPostalCode,
                vlocity_cmt__ServiceAccountId__r.BillingState,
                vlocity_cmt__ServiceAccountId__r.BillingStreet,
                vlocity_cmt__ServiceAccountId__r.Id,
                vlocity_cmt__ServiceAccountId__r.RecordType.name

            FROM 
                Asset
            WHERE
                AccountId IN :setAccId AND
                Status != 'Terminado' AND
                Product2.vlocity_cmt__SubType__c = 'Promotion' AND
                vlocity_cmt__ServiceIdentifier__c != ''
        ];
    }

   public static List<Asset> getAccountId(Id accountId){
        return[
            SELECT  
                Id,
                Name,
            	vlocity_cmt__BillingAccountId__c,
                vlocity_cmt__BillingAccountId__r.Name,
                LegacyAssetId__c,
                Type__c
            FROM 
                Asset
            WHERE
                AccountId = :accountId 
        ];
    }    
        
    public static List<Asset> getByBillingAccountId(Set<Id> setBillingAccounId){
        return[
            SELECT
                Id,
                Name,
            	LegacyIdentifier__c,
            	Product2.vlocity_cmt__SubType__c,
            	vlocity_cmt__AttributeSelectedValues__c
            FROM
                Asset
        ];
    }

    public static Asset[] getByParentItemId(String parentItemId)
    {
        return [
            SELECT id,
                productcode,
                product2id,
                name,
                externalid__c,
                price,
                vlocity_cmt__assetreferenceid__c
            FROM Asset
            WHERE (Status = 'Active' AND vlocity_cmt__ParentItemId__c = :parentItemId)];
    }
    
    public static List<Asset> getAssetIdByIdentifiers(String serviceIdentifier, String accountId) {
        return [SELECT Id, vlocity_cmt__ServiceIdentifier__c FROM Asset WHERE vlocity_cmt__ServiceIdentifier__c =: serviceIdentifier 
                                                   AND AccountId =: accountId 
                                                   AND Type__c = 'Fixa' AND SourceSystem__c = 'SIEBEL'
               									   LIMIT 1];
    }
    
    public static List<Asset> getAssetIdWithoutIdentifiers(String accountId) {
        return [SELECT Id, Type__c, SourceSystem__c, vlocity_cmt__ServiceIdentifier__c FROM Asset WHERE AccountId =: accountId AND Type__c = 'Fixa' AND SourceSystem__c = 'SIEBEL' LIMIT 1];
         
    }  
    
    public static List<Asset> getPidAssetMobileByAccount(String accountId) {
        final String STR_STATUS = 'Active';

        final List<String> LST_SUBSTATUS_TO_NOT_SEND = new List<String>{
            'SUSPENSÃO A PEDIDO', 
            'SUSPENSO A PEDIDO',
            'SUSPENSO POR CADASTRO', 
            'SUSPENSO POR ROUBO',
            'SUSPAFRAUDE',
            'SUSPAPEDIDO',
            'SUSPAROUBO',
            'SUSPCADASTRO'
        };

        final String STR_TYPE = 'Movel';
        final String STR_NAMELEN = '___________';

        final Set<String> setProduto = new Set<String>{
            'Pós-Pago',
            'Controle',
            'Pré-Pago'
        };

        return [
            SELECT 
                Name, 
                ProductType__c,
                StartDate__c
            FROM
                Asset
            WHERE 
                AccountId = :accountId AND 
                Status = :STR_STATUS AND 
                StatusDescription__c NOT IN :LST_SUBSTATUS_TO_NOT_SEND AND 
                Type__c = :STR_TYPE AND 
                Name LIKE :STR_NAMELEN AND 
                ProductType__c IN :setProduto AND 
                (NOT MainProductDescription__c LIKE '%Linha Adicional%') AND
                (NOT IsHolder__c = 'dependente')
            ORDER BY 
                StartDate__c ASC
        ];
    }    
    
    public static Asset getPlanByMsisdn(String msisdn)
    {
        
        Asset assetPromo = [SELECT vlocity_cmt__AssetReferenceId__c 
                            FROM Asset 
                            WHERE vlocity_cmt__ServiceIdentifier__c  =:msisdn AND Status  = 'Active' AND Product2.vlocity_cmt__SubType__c = 'Promotion' 
                            LIMIT 1];
        System.debug('assetPromo: '+assetPromo);
        if(assetPromo == null) return null;
        System.debug('assetPromo.vlocity_cmt__AssetReferenceId__c: '+assetPromo.vlocity_cmt__AssetReferenceId__c);
        return [
            SELECT id,
                Productcode,
                Product2id,
                Name,
                vlocity_cmt__AttributeSelectedValues__c
            FROM Asset
            WHERE (vlocity_cmt__ParentItemId__c =:assetPromo.vlocity_cmt__AssetReferenceId__c AND Product2.vlocity_cmt__SubType__c = 'Plan') 
            LIMIT 1];
    }
    
 	public static List<Asset> getBy(String accountId, String identifier, String description)
    {
        return [
            SELECT Id, Instance__c
            FROM Asset
            WHERE AccountId = :accountId
            AND vlocity_cmt__ServiceIdentifier__c = :identifier
            AND MainProductDescription__c = :description
        ];
    }

    public static List<Asset> getBy(String accountId, String externalId)
    {
        return [
            SELECT Id
            FROM Asset
            WHERE accountId = :accountId
            AND ExternalId__c = :externalId
        ];

    }

    public static List<Asset> getBy(Set<Id> assetIds)
    {
        return [
            SELECT Id, Type__c, Technology__c, MainProductDescription__c
            FROM Asset
            WHERE Id = :assetIds
        ];
    }
    
    public static List<Asset> getAssetPhoneByAccount(String accountId) {
        return [
            SELECT
                id,
                vlocity_cmt__ServiceIdentifier__c
            FROM Asset
            WHERE SourceSystem__c = 'NEXT'
            AND ProductType__c IN ('Voz', 'Pós-Pago')
            AND AccountId = :accountId
        ];
    }

    public static Asset getAssetByServiceIdentifier(String serviceIdentifier) {
        List<Asset> lstAsset = [
            SELECT  
                Id,
                Account.DocumentNumber__c,
                Account.Name,
                vlocity_cmt__ServiceAccountId__r.BillingAddressType__c,
                vlocity_cmt__ServiceAccountId__r.BillingCity,
                vlocity_cmt__ServiceAccountId__r.BillingNeighborhood__c,
                vlocity_cmt__ServiceAccountId__r.BillingNumber__c,
                vlocity_cmt__ServiceAccountId__r.BillingPostalCode,
                vlocity_cmt__ServiceAccountId__r.BillingState,
                vlocity_cmt__ServiceAccountId__r.BillingStreet
            FROM 
                Asset 
            WHERE 
                vlocity_cmt__ServiceIdentifier__c =: serviceIdentifier AND
                Status = 'Ativo' AND
                Platform__c != 'SIM Card' AND 
            	vlocity_cmt__SubscriptionId__c != null
        ];

        return (lstAsset.isEmpty() ? null : lstAsset[0]);
    }
}