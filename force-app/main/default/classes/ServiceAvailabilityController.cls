public class ServiceAvailabilityController {
    private static final String WEBSERVICE_GEOGRAPHICADDRESS = 'GeographicAddressCallout';
    private static final String WEBSERVICE_GEOGRAPHICADDRESSVALIDATION = 'GeographicAddressValidationCallout';
    private static final String WEBSERVICE_SERVICECOVERAGEAVAILABILITY = 'ServiceCoverageAvailabilityCallout';
    
    @AuraEnabled
    public static Account getAccountId(Id accountId){
        Account account = new Account();
        account = AccountDAO.getByIds(accountId);   
        return account;
    }

    @AuraEnabled
    public static ServiceAvailabilityResponse getGeographicAddress(String zipCode, String stNumber, String freeText){

        Webservice__c wsConfig = Webservice__c.getInstance(WEBSERVICE_GEOGRAPHICADDRESS);

        if(wsConfig == null){
            ServiceAvailabilityResponse serviceResponse = new ServiceAvailabilityResponse();
            serviceResponse.success = false;
            serviceResponse.body = Label.ServiceAvailabilityCalloutError;

            return serviceResponse;
        }

        String parameters = '';

        if(freeText != ''){
            parameters = 'retrieveAddressesWithCoordinates?freeText=' + EncodingUtil.urlEncode(freeText, 'UTF-8');

        } else {
            parameters = 'retrieveAddressesWithCoordinates?postcode=' + zipCode + '&streetnr=' + stNumber;
        }
        
        String endpoint = wsConfig.Endpoint__c + parameters;
        ServiceAvailabilityResponse serviceResponse = new ServiceAvailabilityResponse();
        try{
            HttpClient client = new HttpClient();
            HttpResponse response = client.get(wsConfig, endpoint);
        
            if (response.getStatusCode()/100 == 2) {    
				BrazilianUrbanPropertyAddressTO result = (BrazilianUrbanPropertyAddressTO) System.JSON.deserialize(response.getBody(), BrazilianUrbanPropertyAddressTO.class);
                serviceResponse.body = JSON.serialize(result);
                serviceResponse.success = true;
            } else {    
                serviceResponse.success = false;
                serviceResponse.body = Label.ServiceAvailabilityCalloutResponseError;
            }
            return serviceResponse;
            
        } catch (Exception e){
            System.debug(e);
            System.debug(e.getStackTraceString());
            serviceResponse.success = false;
            serviceResponse.calloutError = true;
            serviceResponse.body = Label.ServiceAvailabilityCalloutError;

            return serviceResponse; 
        }
        
    }

    @AuraEnabled
    public static ServiceAvailabilityResponse getGeographicAddressValidation(String requestJSON){
        Webservice__c wsConfig = Webservice__c.getInstance(WEBSERVICE_GEOGRAPHICADDRESSVALIDATION);

        if(wsConfig == null){
            ServiceAvailabilityResponse serviceResponse = new ServiceAvailabilityResponse();
            serviceResponse.success = false;
            serviceResponse.body = Label.ServiceAvailabilityCalloutError;

            return serviceResponse;
        }

        ValidationResultTO validationResult;        
        String payload = requestJSON.replaceAll('brazilianUrbanPropertyAddress', 'submittedGeographicAddress').replaceAll('streetNrFirst', 'streetNr');
        
        HttpClient client = new HttpClient();
        HttpResponse response = client.post(wsConfig, payload);
        ServiceAvailabilityResponse serviceResponse = new ServiceAvailabilityResponse();
    
        if (response.getStatusCode()/100 == 2) {
            String result = response.getBody();
            // String result = '{"validationResult":"SUCCESS","alternateGeographicAddress":[{"country":"BR","city":"SAO PAULO","stateOrProvince":"SP","streetType":"RUA","streetName":"TAUARI","streetNrFirst":"70","complementSummary":{"complement":[]},"geographicLocation":{"geoJson":{"type":"Point","coordinates":["-46.698963","-23.652172"]}},"systemOriginator":"SAGRE","database":"SP_SAO_PAULO","streetCode":"36479","cnl":"11000","networkOwner":"VIVO2","aliasedGeographicAddress":[{"id":"SAGRE:SP_SAO_PAULO:11000:36479:70:::::::-46.6989634:-23.6521729:200:20210415194129","country":"BR","city":"SAO PAULO","stateOrProvince":"SP","streetType":"RUA","streetName":"TAUARI","streetNrFirst":"70","complementSummary":{"complement":[]},"geographicLocation":{"uncertain":"66.72","geoJson":{"type":"Point","coordinates":["-46.698963","-23.652172"]}},"systemOriginator":"SAGRE","database":"SP_SAO_PAULO","streetCode":"36479","cnl":"11000","networkOwner":"VIVO2"}]},{"country":"BR","streetType":"RUA","streetName":"TAUARI","streetNrFirst":"70","complementSummary":{"complement":[]},"geographicLocation":{"geoJson":{"type":"Point","coordinates":["-46.69939","-23.652555"]}},"systemOriginator":"OSP","database":"TLF_BR_SPO_VM","streetCode":"252425","cnl":"11000","networkOwner":"VIVO1","telephonicArea":"AT","aliasedGeographicAddress":[{"id":"OSP:TLF_BR_SPO_VM:11000:252425:70:::::::-46.6993888:-23.6525554:200:20210415194133","country":"BR","streetType":"R.","streetName":"TAUARI","streetNrFirst":"70","complementSummary":{"complement":[]},"geographicLocation":{"uncertain":"6.74","geoJson":{"type":"Point","coordinates":["-46.69939","-23.652555"]}},"systemOriginator":"OSP","database":"TLF_BR_SPO_VM","streetCode":"252425","cnl":"11000","networkOwner":"VIVO1","telephonicArea":"AT"}]}],"state":"DONE"}';
            serviceResponse.body = result;
            serviceResponse.success = true;
        } else {
                serviceResponse.success = false;
                serviceResponse.body = Label.ServiceAvailabilityCoverageCalloutResponseError;
                return serviceResponse;
        }
        
        if (serviceResponse.success) {
            validationResult = (ValidationResultTO)Json.deserialize(response.getBody(), ValidationResultTO.class);
        }
        List<AlternateGeographicAddress> ltAliasedAddress = new List<AlternateGeographicAddress>();
        
        if(validationResult != null){
            if(validationResult.alternateGeographicAddress.size() > 0){

                for(ValidationResultTO.AlternateGeographicAddress validation : validationResult.alternateGeographicAddress){
                  
                    if(validation.aliasedGeographicAddress.isEmpty()){
                        continue;
                    }
                    if(validation.aliasedGeographicAddress.isEmpty()){
                        continue;
                    }

                    AlternateGeographicAddress alternateAddress = new AlternateGeographicAddress();
                    
                    alternateAddress.country = validation.country;
                    alternateAddress.city = validation.city;
                    alternateAddress.stateOrProvince = validation.stateOrProvince;
                    alternateAddress.streetType = validation.streetType;
                    alternateAddress.streetPrefix = validation.streetPrefix;
                    alternateAddress.streetName = validation.streetName;
                    alternateAddress.streetNrFirst = validation.streetNrFirst;

                    if(validation.complementSummary.complement.size() > 0){
                        alternateAddress.complement = validation.complementSummary.complement[0].name + ' ' + validation.complementSummary.complement[0].value;
                    }


                    AliasedGeographicAddress aliasedAddress = new AliasedGeographicAddress();
                    aliasedAddress.id = validation.aliasedGeographicAddress[0].systemOriginator + ':' + validation.aliasedGeographicAddress[0].streetCode;
                    aliasedAddress.systemOriginator = validation.aliasedGeographicAddress[0].systemOriginator;
                    aliasedAddress.country = validation.aliasedGeographicAddress[0].country;
                    aliasedAddress.city = validation.aliasedGeographicAddress[0].city;
                    aliasedAddress.stateOrProvince = validation.aliasedGeographicAddress[0].stateOrProvince;
                    aliasedAddress.locality = validation.aliasedGeographicAddress[0].locality;
                    aliasedAddress.streetType = validation.aliasedGeographicAddress[0].streetType;
                    aliasedAddress.streetPrefix = validation.aliasedGeographicAddress[0].streetPrefix;
                    aliasedAddress.streetName = validation.aliasedGeographicAddress[0].streetName;
                    aliasedAddress.streetNrFirst = validation.aliasedGeographicAddress[0].streetNrFirst;
                    aliasedAddress.postcode = validation.aliasedGeographicAddress[0].postcode;
                    aliasedAddress.database = validation.aliasedGeographicAddress[0].database;
                    aliasedAddress.streetCode = validation.aliasedGeographicAddress[0].streetCode;
                    aliasedAddress.cnl = validation.aliasedGeographicAddress[0].cnl;
                    aliasedAddress.networkOwner = validation.aliasedGeographicAddress[0].networkOwner;
                    aliasedAddress.telephonicArea = validation.aliasedGeographicAddress[0].telephonicArea;

                    
                    if(validation.complementSummary.complement.size() > 0) {
                        for (ValidationResultTO.Complement index : validation.aliasedGeographicAddress[0].complementSummary.complement){
                            List<Complement> ltComplement = new List<Complement>();
                            Complement complement = new Complement();

                            complement.order = index.order;
                            complement.name = index.name;
                            complement.value = index.value;
                            
                            if(aliasedAddress.complementSummary == null){
                                aliasedAddress.complementSummary = new ComplementSummary();
                                aliasedAddress.complementSummary.complement = new List<Complement>();
                            }else{
                                ltComplement = aliasedAddress.complementSummary.complement;
                            }
                            ltComplement.add(complement);
                            aliasedAddress.complementSummary.complement = ltComplement;
                        }

                    }
                                   
                    alternateAddress.aliasedGeographicAddress = aliasedAddress;    
                    ltAliasedAddress.add(alternateAddress);
                }
            }
        }
        ltAliasedAddress = orderAlternateGeographicAddressByNetworkOwner(ltAliasedAddress);
        serviceResponse.body = JSON.serialize(ltAliasedAddress);

        return serviceResponse;
    }
 

    public static List<AlternateGeographicAddress> orderAlternateGeographicAddressByNetworkOwner (List<AlternateGeographicAddress> ltAliasedAddress){
        Map<String,List<AlternateGeographicAddress>> mapAlternateGeographicAddressByNetworkOwner = new Map<String,List<AlternateGeographicAddress>>();
        List<AlternateGeographicAddress> ltReturn = new  List<AlternateGeographicAddress>();

        for(AlternateGeographicAddress alternateObj :ltAliasedAddress){
            // AliasedGeographicAddress obj = (ServiceAvailabilityController.AliasedGeographicAddress)Json.deserialize(alternateObj.aliasedGeographicAddress, ServiceAvailabilityController.AliasedGeographicAddress.class);
            AliasedGeographicAddress obj = alternateObj.aliasedGeographicAddress;

            if(!mapAlternateGeographicAddressByNetworkOwner.containsKey(obj.networkOwner)){
                mapAlternateGeographicAddressByNetworkOwner.put(obj.networkOwner, new List<AlternateGeographicAddress>());
            }

            List<AlternateGeographicAddress> ltRecord = mapAlternateGeographicAddressByNetworkOwner.get(obj.networkOwner);
            ltRecord.add(alternateObj);
        }

        List<String> networkOwners = new List<String>{'VIVO1','VIVO2','ATC'};

        for(String networkOwner : networkOwners){
            if(mapAlternateGeographicAddressByNetworkOwner.containsKey(networkOwner)){
                ltReturn.AddAll(mapAlternateGeographicAddressByNetworkOwner.get(networkOwner));
            }
        }

        return ltReturn;
    }

    @AuraEnabled
    public static ServiceAvailabilityResponse getAddressCoverage(String requestJSON){
        Webservice__c wsConfig = Webservice__c.getInstance(WEBSERVICE_SERVICECOVERAGEAVAILABILITY);
        if(wsConfig == null){
            ServiceAvailabilityResponse serviceResponse = new ServiceAvailabilityResponse();
            serviceResponse.success = false;
            serviceResponse.body = Label.ServiceAvailabilityCalloutError;

            return serviceResponse;
        }

        requestJSON = '{"physicalResourceAvailability":[{"brazilianUrbanPropertyAddress":' + requestJSON + '}]}';
        HttpClient client = new HttpClient();
        HttpResponse response = client.post(wsConfig, requestJSON);
        ServiceAvailabilityResponse serviceResponse = new ServiceAvailabilityResponse();
    
        if (response.getStatusCode()/100 == 2) {
            String result = response.getBody();
            // String result = '{"physicalResourceAvailability":{"brazilianUrbanPropertyAddress":{"id":"SAGRE:46566","city":"CURITIBA","streetCode":"46566","streetNrFirst":"178","stateOrProvince":"PR","cnl":"41000","networkOwner":"VIVO2","placePhysicalResourceAssoc":{"physicalLink":{"accessTechnology":"GPON","voiceProtocol":"SIP"}}},"cabinet":{"name":"PRCTA_O1D41","id":"O1D41","distance":"0.0","switchesAssociated":{"name":"PRCTA_VMS02"},"terminalBox":{"id":"D41G0008","available":"15"},"technology":[{"name":"GPON","available":"15","maxBroadbandSpeed":"1024000"},{"name":"IPTV","tvPlatform":"OPEN_PLATFORM"}]}}}';
            serviceResponse.body = result;
            serviceResponse.success = true;
        } else {     
            serviceResponse.success = false;
            serviceResponse.body = Label.ServiceAvailabilityCoverageCalloutResponseError;
        }
        
        return serviceResponse;
    }

    public class AlternateGeographicAddress {
		@AuraEnabled public String id;
		@AuraEnabled public String country;
		@AuraEnabled public String city;
		@AuraEnabled public String stateOrProvince;
        @AuraEnabled public String locality;
		@AuraEnabled public String streetType;
		@AuraEnabled public String streetPrefix;
		@AuraEnabled public String streetName;
		@AuraEnabled public String streetNrFirst;
		@AuraEnabled public String systemOriginator;
		@AuraEnabled public String streetCode;
		@AuraEnabled public AliasedGeographicAddress aliasedGeographicAddress;
        @AuraEnabled public String networkOwner;
        @AuraEnabled public ComplementSummary complementSummary;
        @AuraEnabled public String complement;

    }

    public class AliasedGeographicAddress {
        @AuraEnabled public String id;
        @AuraEnabled public String country;
        @AuraEnabled public String city;
        @AuraEnabled public String stateOrProvince;
        @AuraEnabled public String locality;
        @AuraEnabled public String streetType;
        @AuraEnabled public String streetPrefix;
        @AuraEnabled public String streetName;
        @AuraEnabled public String streetNrFirst;
        @AuraEnabled public String systemOriginator;
        @AuraEnabled public String database;
        @AuraEnabled public String streetCode;
        @AuraEnabled public String cnl;
        @AuraEnabled public String networkOwner;
        @AuraEnabled public String telephonicArea;
        @AuraEnabled public String centralOffice;
        @AuraEnabled public String postcode;
        @AuraEnabled public ComplementSummary complementSummary;

    }

    public class ComplementSummary {
        @AuraEnabled public List<Complement> complement;
    }

    public class Complement {
        @AuraEnabled public String order;
        @AuraEnabled public String name;
        @AuraEnabled public String value;
    }
    
    public class ServiceAvailabilityResponse {
        @AuraEnabled public String body;
        @AuraEnabled public boolean success;
        @AuraEnabled public boolean calloutError;
    
    }

    public class KeyValuePicklists { 
        @AuraEnabled public String Label {get; set;}
        @AuraEnabled public String Value {get; set;}
    }

    @AuraEnabled
    public static List<KeyValuePicklists> getAddressPicklistValues() {
    
        List<KeyValuePicklists> optionlist = new List<KeyValuePicklists>();  
        Schema.DescribeFieldResult fieldResult = Account.ComplementServiceAvailability__c.getDescribe();
        List<Schema.PicklistEntry> picklistValues = fieldResult.getPickListValues();    
        
        KeyValuePicklists keyValuePicklistsObj;
 
        for(Schema.PicklistEntry picklistEntryObj : picklistValues){
            keyValuePicklistsObj = new KeyValuePicklists();
            keyValuePicklistsObj.Label = picklistEntryObj.getLabel();
            keyValuePicklistsObj.Value = picklistEntryObj.getValue();

            optionlist.add(keyValuePicklistsObj);
        }

        return optionlist;
    }

    @AuraEnabled
    public static List<String> getAddressSpecialCities(){
        List<String> ltSpecialCities = new List<String>();

        GeneralParam__c gp = GeneralParam__c.getInstance();
        ltSpecialCities = gp.CitySpecial__c.split(';');
        
        return ltSpecialCities;
    }

    @AuraEnabled
    public static List<String> getAddressBlockLotCities(){
        List<String> ltBlockLotCities = new List<String>();

        GeneralParam__c gp = GeneralParam__c.getInstance();
        ltBlockLotCities = gp.CityBlockLot__c.split(';');

        return ltBlockLotCities;
    }
}