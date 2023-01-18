/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 20/04/2022
    @description - Class Engine for SSMAttendance
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceEngine {
    public static Map<String, Object> getAccount(String phoneNumber, String documentNumber) {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            if (!String.isBlank(phoneNumber)) {
                mapResponse = getAccountByPhoneNumber(phoneNumber);
            }

            if (mapResponse.get('success') == null) {
                if (!String.isBlank(documentNumber)) {
                    mapResponse = getAccountByDocumentNumber(documentNumber);
                }
            }
            mapResponse = createCustomerInteraction(mapResponse);

        } catch (Exception e) {
            mapResponse.clear();
    
            mapResponse.put('error', e.getMessage());
        }

        return (mapResponse);
    }

    public static Map<String, Object> getAccountByPhoneNumber(String phoneNumber) { 
        Map<String, Object> mapResponse = new Map<String, Object>();

        phoneNumber = phoneNumber.replaceAll('[a-zA-Z .]{1,}|\\-', '');

        List<Asset> ltAsset = AssetDAO.getAssetByName(phoneNumber);
		
        if (ltAsset.size() > 0) {
            mapResponse.put('success', ltAsset[0]);
			
            // Resolves segment
            StoreServiceManagerTO.ItemPicklistValue segment = StoreServiceManagerService.getAccountCustomerSegmentGSS(
                ltAsset[0].Account.vlocity_cmt__CustomerValue__c
            );

            mapResponse.put('segment', segment);
			
        } else {
            mapResponse.put('error', 'Not found.');
        }

        return (mapResponse);
    }

    public static Map<String, Object> getAccountByDocumentNumber(String documentNumber) { 
        Map<String, Object> mapResponse = new Map<String, Object>();

        documentNumber = documentNumber.replaceAll('[a-zA-Z .]{1,}|\\-', '');

        Account customer = AccountDAO.getAccountByCNPJ(documentNumber);

        if (customer != null) {
            mapResponse.put('success', customer);

            // Resolves segment
            StoreServiceManagerTO.ItemPicklistValue segment = StoreServiceManagerService.getAccountCustomerSegmentGSS(
                customer.vlocity_cmt__CustomerValue__c
            );

            mapResponse.put('segment', segment);

        } else {
            mapResponse.put('error', 'Not found.');
        }

        return (mapResponse);
    }

    public static Boolean isPartnerCommunityLicense() {
        User currentUser = UserDAO.getById(UserInfo.getUserId());

        if (currentUser == null) {
            return (false);
        }

        return (currentUser.Profile.UserLicense.Name == 'Partner Community');
    }
    
    public static Map<String, Object> createCustomerInteraction (Map<String, Object> mapResponse) {
        
        String procedureName = 'val_CreateCustomerInteraction';
        Map<String, Object> ipInput = new Map<String, Object> ();
        Map<String, Object> ipOutput = new Map<String, Object> ();
        Map<String, Object> ipOptions = new Map<String, Object> ();
        
        Object responseObject = mapResponse.get('success');
        
        if(responseObject != null && responseObject instanceof Account){
            Account account = (Account) responseObject;
            ipInput.put('recordId', account.Id);
            ipInput.put('contactIdCalc', account.vlocity_cmt__PrimaryContactId__c);
            ipInput.put('Name', account.Name);
            ipInput.put('subject', 'Atendimento - GSS');
            ipInput.put('originName', 'GSS');
        } else if (responseObject != null && responseObject instanceof Asset) {
            Asset asset = (Asset) responseObject;
            ipInput.put('recordId', asset.account.Id);
            ipInput.put('contactIdCalc', asset.account.vlocity_cmt__PrimaryContactId__c);
            ipInput.put('Name', asset.account.Name);
            ipInput.put('subject', 'Atendimento - GSS');
            ipInput.put('originName', 'GSS');
        }
               
        ipOutput = (Map<String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(procedureName, ipInput, ipOptions);
        
        if(ipOutput.containsKey('InteractionId')){
            mapResponse.put('CustomerInteractionId', ipOutput.get('InteractionId'));
        }
        
        return (mapResponse);
    }

}