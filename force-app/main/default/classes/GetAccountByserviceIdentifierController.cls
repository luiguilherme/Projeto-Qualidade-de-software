global without sharing class GetAccountByserviceIdentifierController implements vlocity_cmt.VlocityOpenInterface2 {
    global boolean invokeMethod(String methodName, Map<String, Object> inputs, Map<String, Object> output, Map<String, Object> options) {    
        Boolean success = true;
        String errors;

        try {
            switch on methodName {
                when 'getAccountAssetAddress'
                {
                    getAccountAssetAddress(inputs, output);
                } 
            }
        } catch(Exception e) {
            errors = e.getMessage(); 
            success = false;
        }

        if (!Test.isRunningTest()) {
            output.put('success', success);
        }
        
        output.put('error', errors);

        return success;
    }

private void getAccountAssetAddress(Map<String, Object> inputs, Map<String, Object> output) {
        Id accId = (Id) inputs.get('AccId');
        List<Account> lstAccount = AccountDAO.getAccountAndChildrenById(accId); 
        Set<Id> setAccId = (new Map<Id,SObject>(lstAccount)).keySet();
        List<Asset> lstAsset = AssetDAO.getBySetAccountIdWithPromotionProduct(setAccId);
        List<AddressListClass> lstAddressVar = new List<AddressListClass>();
        AddressListClass addressVar = new AddressListClass();
        addressVar.AddressList = new List<AddressClass>();
        
        for (Asset assetVar : lstAsset) {

            AddressClass addressLstVar = new AddressClass();
            addressLstVar.assetId = assetVar.Id != null ? assetVar.Id : '';
            addressLstVar.mailBox = assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplementType1__c == 'caixa postal';
            addressLstVar.platform = assetVar.Platform__c != null ? assetVar.Platform__c : '';
            addressLstVar.addressType = assetVar.vlocity_cmt__ServiceAccountId__r.BillingAddressType__c != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingAddressType__c : '';
            addressLstVar.city = assetVar.vlocity_cmt__ServiceAccountId__r.BillingCity != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingCity : '';
            addressLstVar.complement1 = assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplement1__c != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplement1__c : '';
            addressLstVar.complement2 = assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplement2__c != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplement2__c : '';
            addressLstVar.complement3 = assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplement3__c != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplement3__c : '';
            addressLstVar.complement4 = assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplement4__c != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplement4__c : '';
            addressLstVar.complementType1 = assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplementType1__c != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplementType1__c : '';
            addressLstVar.complementType2 = assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplementType2__c != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplementType2__c : '';
            addressLstVar.complementType3 = assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplementType3__c != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplementType3__c : '';
            addressLstVar.complementType4 = assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplementType4__c != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingComplementType4__c : '';
            addressLstVar.neighborhood = assetVar.vlocity_cmt__ServiceAccountId__r.BillingNeighborhood__c != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingNeighborhood__c : '';
            addressLstVar.number_x = assetVar.vlocity_cmt__ServiceAccountId__r.BillingNumber__c != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingNumber__c : '';
            addressLstVar.postalCode = assetVar.vlocity_cmt__ServiceAccountId__r.BillingPostalCode != null ?  assetVar.vlocity_cmt__ServiceAccountId__r.BillingPostalCode : '';
            addressLstVar.state = assetVar.vlocity_cmt__ServiceAccountId__r.BillingState != null ? assetVar.vlocity_cmt__ServiceAccountId__r.BillingState : '';
            addressLstVar.street = assetVar.vlocity_cmt__ServiceAccountId__r.BillingStreet != null ?  assetVar.vlocity_cmt__ServiceAccountId__r.BillingStreet : '';
            addressLstVar.accountId = assetVar.vlocity_cmt__ServiceAccountId__r.Id != null ? assetVar.vlocity_cmt__ServiceAccountId__r.Id : '';
            addressLstVar.recordType = assetVar.vlocity_cmt__ServiceAccountId__r.RecordType.name != null ?  assetVar.vlocity_cmt__ServiceAccountId__r.RecordType.name : '';
            addressLstVar.serviceIdentifier = assetVar.vlocity_cmt__ServiceIdentifier__c != null ? assetVar.vlocity_cmt__ServiceIdentifier__c : '';

            addressVar.AcceptPromotion = assetVar.vlocity_cmt__ServiceAccountId__r.AcceptPromotion__c;
            
            addressVar.AddressList.add(addressLstVar);
        }

        lstAddressVar.add(addressVar);
        output.put('result', JSON.serialize(new List<Object>{lstAddressVar}));    
    }

    public class AddressListClass {
        List<AddressClass> AddressList;
        String acceptPromotion;
    }

    public class AddressClass {
        Boolean mailBox;
        String assetId;
        String platform;
        String addressType;
        String city;
        String complement1;
        String complement2;
        String complement3;
        String complement4;
        String complementType1;
        String complementType2;
        String complementType3;
        String complementType4;
        String neighborhood;
        String number_x;
        String postalCode;
        String state;
        String street;
        String accountId;
        String recordType;
        String serviceIdentifier;
    }
}