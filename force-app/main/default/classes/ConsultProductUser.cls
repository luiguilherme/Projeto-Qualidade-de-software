/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-27-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@RestResource(urlMapping='/consultProductUser/v1/productUsers/*')
global with sharing class ConsultProductUser {
    
    @httpGet
    global static void getConsultProductUser() {
        GetConsultProductResponseWrapper.ConsultProductUserWrapper response = new GetConsultProductResponseWrapper.ConsultProductUserWrapper();
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        try {
            String headerXAuth = req.headers.get('x-Authorization');
            res.addHeader('Content-Type', 'application/json');
			
            //Retorna forbidden caso o authorization no header esteja vazio.
            if(String.isBlank(headerXAuth)){
                handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
                return;
            }
			
            String[] jwtParts = headerXAuth.split(' ');
            String authorizationHeaderValue = jwtParts[1];

            //retorna forbidden caso o jwt esteja vazio.
            if(!JWTUtility.isValidJwt(authorizationHeaderValue)){
                handleException(res, 'INVALID_X_AUTH_TOKEN', 'Forbidden', 403);
                return;
            }
                        
            String urlLastPart = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);                

            // Verifica se CPF é valido
            if (String.isBlank(urlLastPart) || urlLastPart.length() < 11) {
                handleException(res, 'BAD_REQUEST', 'invalid request', 400);
                return;
            } 
            
            String cpf = urlLastPart.substring(0, 11);
            System.debug(cpf);
            List<vlocity_cmt__Party__c> lstAsset;

            // Validação de consulta por CPF
            if (urlLastPart.length() == 11) {
                lstAsset = PartySelector.selectAllDependentsByCpf(cpf);
                System.debug(' -> aqui' + cpf);
            } else {
                lstAsset = PartySelector.selectDependentsByCpfAndLine(urlLastPart);
                System.debug('urlLastPart -> aqui' + urlLastPart);
            }
            // Retorna erro quando Cpf ou CpfAndLine não é encontrado
            if(lstAsset.isEmpty()) {
                handleException(res, 'NOT_FOUND', 'This operation was not found', 404);
                return;
            }    
                        
            // Preenche o response
            response.totalSize = lstAsset.size();
            response.message = 'Registros retornados com sucesso.';
            response.httpStatusCode = 200;
            response.contactRef = new List<GetConsultProductResponseWrapper.ContactRef>();

            //Consultar todos os registros de dependentes
            for (vlocity_cmt__Party__c party : lstAsset) {
                if(urlLastPart.length() == 11){
                    GetConsultProductResponseWrapper.ContactRef contRef = new GetConsultProductResponseWrapper.ContactRef();
                    contRef.id = party.vlocity_cmt__ContactId__c;
                    contRef.userCPF = party.vlocity_cmt__ContactId__r.ExternalId__c;
                    contRef.firstName = party.vlocity_cmt__ContactId__r.FirstName;
                    contRef.lastName = party.vlocity_cmt__ContactId__r.LastName;
                    contRef.contactEmail = party.vlocity_cmt__ContactId__r.ContactEmail__c;
                    contRef.assistantPhone = party.vlocity_cmt__ContactId__r.AssistantPhone;
                    contRef.otherPhone = party.vlocity_cmt__ContactId__r.OtherPhone;
                    contRef.otherEmail = party.vlocity_cmt__ContactId__r.OtherEmail__c;
                    contRef.nickName = party.vlocity_cmt__ContactId__r.Nickname__c;
                    contRef.motherName = party.vlocity_cmt__ContactId__r.MotherName__c;
                    contRef.birthDate = (party.vlocity_cmt__ContactId__r.Birthdate != null) ? formatDate(party.vlocity_cmt__ContactId__r.Birthdate) : null;                
                    contRef.email = party.vlocity_cmt__ContactId__r.Email;
                    contRef.mobilePhone = party.vlocity_cmt__ContactId__r.MobilePhone;
                    contRef.homePhone = party.vlocity_cmt__ContactId__r.HomePhone;
                    contRef.phone = party.vlocity_cmt__ContactId__r.Phone;
                    contRef.assetPartyRelashionShip = new List<GetConsultProductResponseWrapper.AssetPartyRelashionShip>();
                    
                    // Consulta todos os AssetPartyRelationship associados ao party
                    List<AssetPartyRelationShip__c> assetAll = PartySelector.selectAssetPartyByPartyId(party.Id);
                    for (AssetPartyRelationShip__c assetsRecords : assetAll) {
                        GetConsultProductResponseWrapper.AssetPartyRelashionShip assetPartyRelashion = new GetConsultProductResponseWrapper.AssetPartyRelashionShip();
                        assetPartyRelashion.name = assetsRecords.TargetAsset__r.PhoneNumber__c;
                        assetPartyRelashion.role = assetsRecords.Role__c;
                        assetPartyRelashion.approvedByOwner = assetsRecords.ApprovedByOwner__c;
                        assetPartyRelashion.CreatedDate = Datetime.now();
                        contRef.assetPartyRelashionShip.add(assetPartyRelashion);
                        System.debug('Todos os registros -> ' + contRef.assetPartyRelashionShip);
                    }
                    contRef.totalSize = contRef.assetPartyRelashionShip.size();
                	response.contactRef.add(contRef);
                }
            }	

            //Consultar um unico registros de dependente
            if(urlLastPart.length() > 11){                        
                Set<String> setIdRecordsOne = new Set<String>();
                GetConsultProductResponseWrapper.ContactRef contRef = new GetConsultProductResponseWrapper.ContactRef();
                List<Asset> assetPartyRelationList = getAssetByExternalId(urlLastPart);
                if(!assetPartyRelationList.isEmpty()){
                    System.debug('assetPartyRelationList -> ' + assetPartyRelationList);
                    for (vlocity_cmt__Party__c party : lstAsset) {
                		setIdRecordsOne.add(party.Id);
                        contRef.id = party.vlocity_cmt__ContactId__c;
                        contRef.userCPF = party.vlocity_cmt__ContactId__r.ExternalId__c;
                        contRef.firstName = party.vlocity_cmt__ContactId__r.FirstName;
                        contRef.lastName = party.vlocity_cmt__ContactId__r.LastName;
                        contRef.contactEmail = party.vlocity_cmt__ContactId__r.ContactEmail__c;
                        contRef.assistantPhone = party.vlocity_cmt__ContactId__r.AssistantPhone;
                        contRef.otherPhone = party.vlocity_cmt__ContactId__r.OtherPhone;
                        contRef.otherEmail = party.vlocity_cmt__ContactId__r.OtherEmail__c;
                        contRef.nickName = party.vlocity_cmt__ContactId__r.Nickname__c;
                        contRef.motherName = party.vlocity_cmt__ContactId__r.MotherName__c;
                        contRef.birthDate = (party.vlocity_cmt__ContactId__r.Birthdate != null) ? formatDate(party.vlocity_cmt__ContactId__r.Birthdate) : null;                
                        contRef.email = party.vlocity_cmt__ContactId__r.Email;
                        contRef.mobilePhone = party.vlocity_cmt__ContactId__r.MobilePhone;
                        contRef.homePhone = party.vlocity_cmt__ContactId__r.HomePhone;
                        contRef.phone = party.vlocity_cmt__ContactId__r.Phone;
                        contRef.assetPartyRelashionShip = new List<GetConsultProductResponseWrapper.AssetPartyRelashionShip>();
                    }
                    List<GetConsultProductResponseWrapper.AssetPartyRelashionShip> assetParties = isValidRecordsAssetPartyRelation(setIdRecordsOne, assetPartyRelationList[0].Id, urlLastPart);
                    contRef.assetPartyRelashionShip.addAll(assetParties);
                    System.debug('Unico registro -> ' + contRef.assetPartyRelashionShip);
                }
                contRef.totalSize = contRef.assetPartyRelashionShip.size();
                response.contactRef.add(contRef);
            }
            res.statusCode = 200;
            res.responseBody = Blob.valueOf(JSON.serialize(response));
        } catch (Exception ex) {
            handleException(res, 'INTERNAL_SERVER_ERROR', 'Internal Server Error', 500);
        }
    }   
    private static String formatDate(Date birthDate) {
        Integer year = birthDate.year();
        Integer month = birthDate.month();
        Integer day = birthDate.day();
        return year + '-' + ((month < 10) ? '0' + month : String.valueOf(month)) + '-' + ((day < 10) ? '0' + day : String.valueOf(day));
    }

    public static void handleException(RestResponse res, String errorCode, String errorMessage, Integer statusCode) {
        res.statusCode = statusCode;
        res.responseBody = Blob.valueOf(JSON.serialize(new Map<String, Object>{     
            'message' => errorMessage,
            'errorCode' => errorCode
        }));      
    }

    public static List<GetConsultProductResponseWrapper.AssetPartyRelashionShip> isValidRecordsAssetPartyRelation(Set<String> partyId, String targetAssetId, String isValidationUrl) {
        List<AssetPartyRelationShip__c> selectAssetPartyByPartyId = [ 
            SELECT Id, TargetAsset__r.Name, Role__c, ApprovedByOwner__c, TargetAsset__r.PhoneNumber__c, TargetAsset__r.Account.ExternalId__c, Name
            FROM AssetPartyRelationShip__c 
            WHERE SourceParty__c =:partyId AND TargetAsset__c = :targetAssetId limit 1
        ];    
        
        List<GetConsultProductResponseWrapper.AssetPartyRelashionShip> returnListAssetParty = new List<GetConsultProductResponseWrapper.AssetPartyRelashionShip>();
        DateTime formattedDate = Datetime.now();

        for (AssetPartyRelationShip__c assetParty : selectAssetPartyByPartyId) {
            GetConsultProductResponseWrapper.AssetPartyRelashionShip resAsset = new GetConsultProductResponseWrapper.AssetPartyRelashionShip();
            resAsset.name = assetParty.TargetAsset__r.PhoneNumber__c;
            resAsset.role = assetParty.Role__c;
            resAsset.approvedByOwner = assetParty.ApprovedByOwner__c;
            resAsset.CreatedDate = formattedDate;
            returnListAssetParty.add(resAsset);
        }

        return returnListAssetParty;
    }

    public static List<Asset> getAssetByExternalId(String oneExternalId) {
        return [SELECT Id, Account.ExternalId__c, ContactId, PhoneNumber__c FROM Asset WHERE ExternalId__c = :oneExternalId];
    }
}