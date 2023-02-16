/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 20/04/2022
    @description - Class Engine for SSMAttendance
    ---------------------------------------------------
*/
public with sharing class SSMAttendanceEngine {
    private static final String OPERATIONAL_INFORMATIONS = 'OperationalInformations';
    
    private static final String INTERACTIONS = 'Interactions';
    private static final String BUSINESS_LINES = 'BusinessLines';
    private static final String QUITTING_REASONS = 'QuittingReasons';

    private static final String DOCUMENT_TYPES = 'DocumentTypes';

    private static final Integer ERROR_LOADING_COMPONENT = 601;
    private static final Integer GENERIC_ERROR_MESSAGE = 699;

    public static Map<String, Object> fetchAttendanceOperationalInformations() {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            List<StoreServiceManagerTO.ItemPicklistValue> ltCategories = 
                new List<StoreServiceManagerTO.ItemPicklistValue>();

            List<StoreServiceManagerTO.ItemPicklistValue> ltDocumentTypes = 
                new List<StoreServiceManagerTO.ItemPicklistValue>();

            List<StoreServiceManagerTO.ItemPicklistValue> ltActivities = 
                new List<StoreServiceManagerTO.ItemPicklistValue>();

            List<StoreServiceManagerTO.ItemPicklistValue> ltQuittingReasons = 
                new List<StoreServiceManagerTO.ItemPicklistValue>();
            
            List<GenericOptionsLists__c> ltGenericOptions = 
                GenericOptionsListsDAO.getByAPINameUsedInActive(
                    new Set<String>{OPERATIONAL_INFORMATIONS, DOCUMENT_TYPES}, 
                    new Set<String>{BUSINESS_LINES, DOCUMENT_TYPES, INTERACTIONS, QUITTING_REASONS}
                );

            if (ltGenericOptions != null && ltGenericOptions.size() > 0) {
                for (GenericOptionsLists__c genericOption : ltGenericOptions) {
                    StoreServiceManagerTO.ItemPicklistValue itemPicklist = 
                        new StoreServiceManagerTO.ItemPicklistValue();

                    itemPicklist.label = genericOption.Description__c;
                    itemPicklist.value = genericOption.Code__c;
                    itemPicklist.name = genericOption.Code__c;
                    itemPicklist.instruction = genericOption.description2__c;

                    if (genericOption.UsedIn__c == BUSINESS_LINES) {
                        ltCategories.add(itemPicklist);

                    } else if (genericOption.UsedIn__c == DOCUMENT_TYPES) {
                        ltDocumentTypes.add(itemPicklist);

                    } else if (genericOption.UsedIn__c == INTERACTIONS) {
                        ltActivities.add(itemPicklist);

                    } else if (genericOption.UsedIn__c == QUITTING_REASONS) {
                        ltQuittingReasons.add(itemPicklist);                    
                    }
                }
            }
 
            if (ltCategories.size() > 0 && ltDocumentTypes.size() > 0 && 
                ltActivities.size() > 0 && ltQuittingReasons.size() > 0
            ) {
                mapResponse.put('categories', ltCategories);
                mapResponse.put('documentTypes', ltDocumentTypes);
                mapResponse.put('activities', ltActivities);
                mapResponse.put('quittingReasons', ltQuittingReasons);

            } else {
                mapResponse.put('error', ERROR_LOADING_COMPONENT);
            }

        } catch (Exception e) {   
            // mapResponse.put('error', GENERIC_ERROR_MESSAGE);
            mapResponse.put('error', e.getMessage());
        }
        
        return (mapResponse);
    }
    
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

            if (mapResponse.get('success') != null) {
                mapResponse = createCustomerInteraction(mapResponse);
            }

        } catch (Exception e) {
            mapResponse.clear();
    
            // mapResponse.put('error', GENERIC_ERROR_MESSAGE);
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

    public static Map<String, Object> createCustomerInteraction (Map<String, Object> mapResponse) {
        String ipName = 'val_CreateCustomerInteraction';
        Map<String, Object> ipInput = new Map<String, Object> ();
        Map<String, Object> ipOutput = new Map<String, Object> ();
        Map<String, Object> ipOptions = new Map<String, Object> ();
        
        Object responseObject = mapResponse.get('success');
        
        if (responseObject != null && responseObject instanceof Account) {
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
               
        ipOutput = (Map<String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(ipName, ipInput, ipOptions);
        
        if (ipOutput.containsKey('InteractionId')) {
            mapResponse.put('CustomerInteractionId', ipOutput.get('InteractionId'));
        }
        
        return (mapResponse);
    }
}
