public class ServiceQualificationEngine {
    public static List<Asset> getAssetMobileByAccount(Id accountId) {
        List<Asset> ltAsset = AssetDAO.getAssetMobileByAccount(accountId);
        System.debug('Assets ' + ltAsset);       
    
        return ltAsset;
    }
    
    public static User getUserById(Id userId) {
        return UserDAO.getById(userId);
    }
    
    public static List<FromToMapping__mdt> getServiceTreeIdentifier(String userRole) {
        return FromToMappingDAO.getServiceTreeIdentifier(userRole);
    }

    public static Case saveQualificationServiceCase(String qualificationCase, String recordTypeCase, String parentCaseId) {
        Case newQualificationCase = new Case();
        
        try {
        	newQualificationCase = (Case)JSON.deserialize(qualificationCase, Case.class);  
            newQualificationCase.Origin = 'QualificationServiceMobile';
        	newQualificationCase.Subject = 'Palitagem Móvel';
            newQualificationCase.Status = 'Closed';
            newQualificationCase.Priority = 'Low';

        	newQualificationCase.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().
            	get(recordTypeCase).getrecordTypeId();

            try{
                if(parentCaseId != null){
                    Case parentCase = CaseDAO.getCasebyId(parentCaseId);
                    newQualificationCase.CallerDDD__c = parentCase.CallerDDD__c;
                    newQualificationCase.CallerPhone__c = parentCase.CallerPhone__c;
                    newQualificationCase.ProtocolURA__c = parentCase.ProtocolURA__c;
                    newQualificationCase.ParentId = parentCase.Id;
                }
            } catch (Exception e){
                System.debug('Não foi possível obter dados de caso pai: ' + e.getMessage());
            }

		
            insert newQualificationCase;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return newQualificationCase;
    }
    
	public static Map<String, Object> getServiceFlow(String productType, String serviceTree) {
        List<ItemTreeTO> ltFirstLevel   = new List<ItemTreeTO>();
        List<ItemTreeTO> ltSecondLevel  = new List<ItemTreeTO>();
        List<ItemTreeTO> ltThirdLevel   = new List<ItemTreeTO>();
        List<ItemTreeTO> ltFourthLevel  = new List<ItemTreeTO>();

        Map<String, Object> mapServiceFlow = new Map<String, Object>();
        mapServiceFlow.put('firstLevel', ltFirstLevel);
        mapServiceFlow.put('secondLevel', ltSecondLevel);
        mapServiceFlow.put('thirdLevel', ltThirdLevel);
        mapServiceFlow.put('fourthLevel', ltFourthLevel);

        /*ItemTreeTO itemTree;
    
        for(ServiceQualification__c item : ServiceQualificationDAO.getServiceFlowActive(productType, serviceTree)) {
            switch on item.RecordType.DeveloperName {
                when 'FirstLevel' {
                    itemTree = new ItemTreeTO(item.Id, item.Name);
                    ltFirstLevel.add(itemTree);
                }	
                when 'SecondLevel' {
                    itemTree = new ItemTreeTO(item.FirstLevel__c, item.Id, item.Name);
                    ltSecondLevel.add(itemTree);
                }
                when 'ThirdLevel' {
                    itemTree = new ItemTreeTO(item.SecondLevel__c, item.Id, item.Name);
                    ltThirdLevel.add(itemTree);
                }
                when 'FourthLevel' {
                    itemTree = new ItemTreeTO(item.ThirdLevel__c, item.Id, item.Name);
                    ltFourthLevel.add(itemTree);
                }
            }
        }*/

        return mapServiceFlow;
    }

    public static Map<String, Boolean> haveAccessToFlow(Id userId) {        
        String fixa = 'fixa';
        String movel = 'movel';
        Map<String,Boolean> mapToReturn = new Map<String,Boolean>{fixa => false, movel => false};
        User userToCheckAccess =  getUserById(userId);
        String profileName = userToCheckAccess.Profile.Name;
        
        if (profileName == 'AdministracaoSistema' || profileName == 'Gerencia' 
            || profileName == 'Administrador do sistema') {
            mapToReturn.put(fixa, true);
            mapToReturn.put(movel, true);
            return mapToReturn;
        }

        List<String> ltStringOfPermissionSet = new List<String>();
        String stringOfPermissionSetFixa = System.Label.GPSPermissionSetFixa;
        String stringOfPermissionSetMovel = System.Label.GPSPermissionSetMovel;
        ltStringOfPermissionSet.add(stringOfPermissionSetFixa);
        ltStringOfPermissionSet.add(stringOfPermissionSetMovel);
        List<PermissionSetAssignment> ltPermissionSetAssignment = PermissionSetDAO.getByUserIdAndPermissionSetName(userId, ltStringOfPermissionSet);
       
        if (ltPermissionSetAssignment.isEmpty()) {
            return mapToReturn;
        }
        
        for (PermissionSetAssignment permissionAssignment : ltPermissionSetAssignment) {
            if (permissionAssignment.PermissionSet.Name == stringOfPermissionSetFixa) {
                mapToReturn.put(fixa, true);
            }
            if (permissionAssignment.PermissionSet.Name == stringOfPermissionSetMovel) {
                mapToReturn.put(movel, true);
            }            
        }
        
        return mapToReturn;
    }
}