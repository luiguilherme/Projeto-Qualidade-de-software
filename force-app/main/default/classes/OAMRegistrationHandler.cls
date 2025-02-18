/*
* @author: Diego Costa @Deloitte
* @description: Classe Handler para aprovisionamento de conta/contato/usuário.
* @data: 10/06/2022
*
*/
global class OAMRegistrationHandler implements Auth.RegistrationHandler {
	private static final String APPLICATION_NAME = 'OAMRegistrationHandler';
    //Deve pegar o recordtype PartnerAccount, porém ainda não foi migrado comunidades
    private static final String CONST_PARTNER_ACCOUNT_RECORD_TYPE_ID = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Consumer').getrecordTypeId();
	Boolean isActiveFeatureFlag = FeatureFlagService.applicationIsActive(APPLICATION_NAME);

    class RegHandlerException extends Exception {}

    global User createUser (Id portalId, Auth.UserData data) {
        System.debug('start createUser > ' + data);
        return UserProvisioning(data);
    }

    global void updateUser (Id userId, Id portalId, Auth.UserData data) {
        System.debug('start updateUser > ' + data);
        UserProvisioning(data);
    }

    private User userProvisioning (Auth.UserData data) {
        try{
            system.debug('data: ' + data);
            String sandboxName      = getSandboxName();
            String userNameSandbox  = data.username + sandboxName;
            String CNPJResponse     = data.attributeMap.get('CNPJ');
      
            Profile userProfile         = getProfile(data.attributeMap.get('profile_name')); //getProfile('AdministracaoSistema'); 
            String  userLicenseProfile  = userProfile.Id == null ? '' : userProfile.UserLicense.Name;
            Boolean userInternal        = userLicenseProfile != 'Partner Community';
            // Validação de 1º nível.
            fristValidateResponse(data, userInternal);

            User userRecord = getUserData(userNameSandbox);
            
            // Busca existencia de contato na base.
            Contact contactRecord = getContactData(userInternal, userNameSandbox);
            
            String userRole = getRole(data.attributeMap.get('role'), userInternal); //getRole('Telefonica_Brasil', userInternal);
            List<String> ltPermissionSetResponse = getPermissionSet(data.attributeMap.get('permission_sets'));
            List<PermissionSet> ltPermissionSetSF = new List<PermissionSet>([SELECT Id, Name FROM PermissionSet WHERE Name IN :ltPermissionSetResponse AND ProfileId = null]);

            // Validação de 2º nível.
            secondValidateResponse(data, userInternal, userProfile, userLicenseProfile, userRole, contactRecord, 
                                    ltPermissionSetSF, ltPermissionSetResponse);

            //Chama ação de conta, contato e usuário
            return actionAccCttUs(CNPJResponse, userNameSandbox, userInternal , userRecord, sandboxName, 
                                    userProfile, userRole, contactRecord, data, ltPermissionSetResponse, ltPermissionSetSF);
        }
        catch(RegHandlerException e) {
            throw e;
        }
        catch(exception x) {
            throw new RegHandlerException('Erro desconhecido: ' + x.getMessage());
        }
    }
    
    // Função para buscar contato na base.
    private Contact getContactData (Boolean userInternal, String userName) {
        if (userInternal) {
            return new Contact();
        } else{
            List<Contact> ltContact = new List<Contact>([SELECT Id, Name, Email, AccountId, Account.Name FROM Contact WHERE UserIdentifier__c =: userName LIMIT 1]);
            return (ltContact.size() > 0 ? ltContact[0] : new Contact());
        }
    }

    // Função responsável por chamar a ação de conta contato e usuário
    public User actionAccCttUs (String CNPJResponse, 
                                String userNameResponse, 
                                Boolean userInt , 
                                User lUser, 
                                String nomeSandbox, 
                                Profile lProfile, 
                                String role, 
                                Contact lContact, 
                                Auth.UserData data, 
                                List<String> lPermissionSet, 
                                List<PermissionSet> lPermissionSetSF) {
        if (!userInt) {
            //Cria/atualiza conta
            Account lAccountResult = actionAccount(CNPJResponse, data);
            // Cria/atualiza contato
            Contact lContactResult = actionContact(lContact, lAccountResult, data, userNameResponse);
            
            // cria o usuário
            return createUpdateUser(userInt, lUser, nomeSandbox, lProfile, role, lContactResult, data, lPermissionSetSF); 
        } else {
            // Atualizando o usuário
            return createUpdateUser(userInt, lUser, nomeSandbox, lProfile, role, new Contact(), data, lPermissionSetSF); 
        }
    }

    // Função para retornar o perfil de acordo com interno ou parceiro.
    private Profile getProfile (String profileName) {
        List<Profile> ltProfile = new List<Profile>([SELECT Id, Name, UserLicense.Name FROM profile WHERE name=: profileName  LIMIT 1]);

        return (ltProfile.size() > 0 ? ltProfile[0] : new Profile());
    }

    // Função retorna permissionset do response
    private List<String> getPermissionSet (String responsePermisionSet) {
        if (String.isEmpty(responsePermisionSet)) {
            return new List<String>();
        }
        List<String> ltPermissionSet = (List<String>) JSON.deserialize(responsePermisionSet, List<String>.class);

        return ltPermissionSet;
    }

    // Função para montar filtro da query de Papel
    private String getRole (String roleResponse, Boolean userInternal) {
        system.debug('roleResponse: ' + roleResponse);
        if (userInternal) {
            List<UserRole> ltRole = new List<UserRole>([SELECT Id FROM UserRole WHERE DeveloperName = :roleResponse LIMIT 1]);
      system.debug('roleResponse: ' + roleResponse);
            return (ltRole.size() > 0 ? String.valueOf(ltRole[0].Id) : 'null');
        } else {
            Set<String> setPartnerGroup = new Set<String>();
            Schema.DescribeFieldResult field = User.PartnerGroup__c.getDescribe();
            
            for (Schema.PicklistEntry item : field.getPicklistValues()) {
                setPartnerGroup.add(item.getValue());
            }
            System.debug(setPartnerGroup);
            return (setPartnerGroup.contains(roleResponse) ? roleResponse : 'null');
        }
    }

    // Função para trabalhar com usuário
    private User createUpdateUser(Boolean userInternal, 
                                    User userRecord, 
                                    String sandboxName, 
                                    Profile userProfile, 
                                    String userRole, 
                                    Contact contactRecord, 
                                    Auth.UserData data, 
                                    List<PermissionSet> ltPermissionSetSF) {
        try{
            //Atualiza informações do usuário
            userRecord.IsActive     = true;
            userRecord.UserName     = data.username + sandboxName;
            userRecord.Email        = userInternal ? data.email : data.username; 
            userRecord.FirstName    = data.firstName;
            userRecord.LastName     = data.lastName;
            userRecord.FederationIdentifier = data.username; 

            String alias = data.username;
            userRecord.alias = alias.left(8);

            Boolean updateGroupPartner = false;

            //Salva usuário existente
            User oldUser            = userRecord.clone(true,true,true,true);

            if(contactRecord.Id != null && userRecord.Id == null) {
                userRecord.ContactId = contactRecord.Id;
            }
            if(userProfile.Id != null) {
                userRecord.ProfileId = userProfile.Id;
            }
            if(data.attributeMap.containsKey('network_id')) {
                userRecord.Login__c = data.attributeMap.get('network_id');
            }
            if(data.attributeMap.containsKey('adabas')) {
                userRecord.Adabas__c = data.attributeMap.get('adabas');
            }
            if(data.attributeMap.containsKey('employee_number')) {
                userRecord.EmployeeNumber = data.attributeMap.get('employee_number');
            }
            if(data.attributeMap.containsKey('phone_number')) {
                userRecord.MobilePhone = data.attributeMap.get('phone_number');
            }
            if(userInternal) {
                userRecord.UserRoleId = Id.valueOf(userRole);
            } else{
                if(userRecord.PartnerGroup__c != userRole) {
                    updateGroupPartner = true;
                }
                userRecord.PartnerGroup__c = userRole;
            }
            if(data.attributeMap.containsKey('canal_atendimento')) {
            userRecord.ChannelName__c = data.attributeMap.get('canal_atendimento');
             }
          if(data.attributeMap.containsKey('site')) {
            userRecord.Site__c = data.attributeMap.get('site');
          }    
          if(data.attributeMap.containsKey('escritorio_vendas')) {
            SalesOffices__mdt office =  getOffice(data.attributeMap.get('escritorio_vendas'));

                if (office != null) {
                    userRecord.Office__c = office.Office__c;
                    userRecord.Center__c = office.Center__c;
                    userRecord.Store__c = office.Store__c;
                } else {
                    userRecord.Office__c = data.attributeMap.get('escritorio_vendas');
                    userRecord.Center__c = null;
                    userRecord.Store__c = null;
                }
          }            
            userRecord.LanguageLocaleKey    = 'pt_BR';
            userRecord.LocaleSidKey         = 'pt_BR';
            userRecord.TimeZoneSidKey       = 'America/Sao_Paulo';
            userRecord.LocaleSidKey         = 'pt_BR';
            userRecord.EmailEncodingKey     = 'UTF-8';
            
            //Recuperar CNPJ atravês do código Adabas
            userRecord.AdabasAssignedDocument__c = getAdabasAssignedDocumentByAdabasCode(userRecord.ChannelName__c, userRecord.Site__c, userRecord.Adabas__c);
            
			if (userRecord.Id == null) {
                insert userRecord;
            }

            if(isActiveFeatureFlag){			
				if(userHasChanged(userRecord, oldUser)){
					if(isActivating(oldUser)) {
			    		update userRecord;
					} else{
						SObject sObj = userRecord.clone(true, true, true, true);
						database.updateAsync(sObj); //----> @future
					}
				}
			} 				
			else{
					updateUserFuture(JSON.serialize(userRecord));
			}				
            
            if(updateGroupPartner == true) {
				if(isActiveFeatureFlag){
					updatePublicGroup(JSON.serialize(userRecord), JSON.serialize(data.attributeMap.get('role')));
				} else{
					updatePublicGroupFuture(JSON.serialize(userRecord), JSON.serialize(data.attributeMap.get('role')));
				}
            } else {
                List<String> ltPermissionSetResponse = getPermissionSet(data.attributeMap.get('permission_sets'));
                if(isActiveFeatureFlag){
                    updatePublicGroupInternal(JSON.serialize(userRecord), JSON.serialize(data.attributeMap.get('role')),ltPermissionSetResponse);
                } else {
                    updatePublicGroupInternalFuture(JSON.serialize(userRecord), JSON.serialize(data.attributeMap.get('role')),ltPermissionSetResponse);
                }                
            }
            
			if(isActiveFeatureFlag){
				updatePermissionSet(JSON.serialize(userRecord), JSON.serialize(ltPermissionSetSF));
			} else {
				updatePermissionSetFuture(JSON.serialize(userRecord), JSON.serialize(ltPermissionSetSF));
			}
				
            return userRecord;
        } catch (Exception e) {
            System.debug(e);            
            System.debug(e.getStackTraceString());            
            System.debug(e.getCause());            
            throw new RegHandlerException('Erro em criar/atualizar usuário: ' + e.getMessage());
        } 
    }

    // Função para trabalhar com a conta
    public Account actionAccount (String CNPJResponse, Auth.UserData data ) {
        try{
            Account accountToUpdateInsert = AccountDAO.getAccountByCNPJ(CNPJResponse);
            if (accountToUpdateInsert == null) {
                accountToUpdateInsert = new Account();
                accountToUpdateInsert.Name = CNPJResponse; 
                accountToUpdateInsert.DocumentNumber__c = CNPJResponse;
                accountToUpdateInsert.RecordTypeId = CONST_PARTNER_ACCOUNT_RECORD_TYPE_ID;
                Insert accountToUpdateInsert;
            } 

            accountToUpdateInsert.vlocity_cmt__Active__c = 'Yes';
            //accountToUpdateInsert.IsPartner = true;
            update accountToUpdateInsert;
            return accountToUpdateInsert;
        }
        catch (Exception e) {throw new RegHandlerException('Erro em criar/atualizar conta: ' + e.getMessage());}
    }

    // Função para trabalhar com o contato
    public Contact actionContact (Contact con, Account acc, Auth.UserData data, String userNameResponse) {
        try{
            Contact contactToUpsert = con.Id != null ? con : new Contact ();
            contactToUpsert.FirstName = data.FirstName;
            contactToUpsert.LastName = data.LastName;  
            contactToUpsert.UserIdentifier__c = userNameResponse;
            contactToUpsert.AccountId = acc.Id;
            contactToUpsert.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('PartnerContact').getrecordTypeId();
            if (contactToUpsert.Email == '') {
                contactToUpsert.Email = data.email;
            }

            if (data.attributeMap.containsKey('phone_number')) {
                contactToUpsert.Phone = data.attributeMap.get('phone_number');
            }

            upsert contactToUpsert;
            return contactToUpsert;
        }
        catch (Exception e) {throw new RegHandlerException('Erro em criar/atualizar contato: ' + e.getMessage());}
    }

    @future
    public static void updatePermissionSetFuture(String userString, String permissionSetString) {

        User userRecord = (User) JSON.deserialize(userString, User.class);
        List<PermissionSet> ltPermissionSet = (List<PermissionSet>) JSON.deserialize(permissionSetString, List<PermissionSet>.class);
        Set<Id> setPermissonSetId = new Set<Id>();

        for(PermissionSet item : ltPermissionSet) {
            setPermissonSetId.add(item.Id);
        }

        List<PermissionSetAssignment> ltCurrentPSA = new List<PermissionSetAssignment>([SELECT Id, PermissionSetId FROM PermissionSetAssignment 
                                                                                            WHERE AssigneeId = : userRecord.Id AND PermissionSet.ProfileId = null]);
        Set<Id> setCurrentPSA = new Set<Id>();
        List<PermissionSetAssignment> ltInsertPSA = new List<PermissionSetAssignment>();
        List<PermissionSetAssignment> ltDeletePSA = new List<PermissionSetAssignment>();

        for(PermissionSetAssignment item : ltCurrentPSA) {
            if(setPermissonSetId.contains(item.PermissionSetId)) {
                setCurrentPSA.add(item.PermissionSetId);
            } else {
                ltDeletePSA.add(item);
            }
        }

        for(PermissionSet item : ltPermissionSet) {
            if(!setCurrentPSA.contains(item.Id)) {
                ltInsertPSA.add(new PermissionSetAssignment(AssigneeId = userRecord.Id, PermissionSetId = item.Id));
            }
        }

        if(ltDeletePSA.size() > 0) {
            delete ltDeletePSA;
        }

        if(ltInsertPSA.size() > 0) {
            insert ltInsertPSA;
        }

    }

    public static void updatePermissionSet(String userString, String permissionSetString) {

        User userRecord = (User) JSON.deserialize(userString, User.class);
        List<PermissionSet> ltPermissionSet = (List<PermissionSet>) JSON.deserialize(permissionSetString, List<PermissionSet>.class);
        Set<Id> setPermissonSetId = new Set<Id>();

        for(PermissionSet item : ltPermissionSet) {
            setPermissonSetId.add(item.Id);
        }

        List<PermissionSetAssignment> ltCurrentPSA = new List<PermissionSetAssignment>([SELECT Id, PermissionSetId FROM PermissionSetAssignment 
                                                                                            WHERE AssigneeId = : userRecord.Id AND PermissionSet.ProfileId = null]);
        Set<Id> setCurrentPSA = new Set<Id>();
        List<PermissionSetAssignment> ltInsertPSA = new List<PermissionSetAssignment>();
        List<PermissionSetAssignment> ltDeletePSA = new List<PermissionSetAssignment>();

        for(PermissionSetAssignment item : ltCurrentPSA) {
            if(setPermissonSetId.contains(item.PermissionSetId)) {
                setCurrentPSA.add(item.PermissionSetId);
            } else {
                ltDeletePSA.add(item);
            }
        }

        for(PermissionSet item : ltPermissionSet) {
            if(!setCurrentPSA.contains(item.Id)) {
                ltInsertPSA.add(new PermissionSetAssignment(AssigneeId = userRecord.Id, PermissionSetId = item.Id));
            }
        }

        if(ltDeletePSA.size() > 0) {
				List<SObject> SObjectList = new List<SObject>();
				SObjectList.addAll(ltDeletePSA);
				database.deleteAsync(SObjectList); //----> @future
		}		

        if(ltInsertPSA.size() > 0){
			executeAssigmentPermissionFuture(JSON.serialize(ltInsertPSA));
		}
    }

    // Função para atualizar usuário
    @future
    public static void updateUserFuture(String dados) {
        User u = (User)JSON.deserialize(dados,User.class);
        update u;
    }

    @TestVisible
    private String getSandboxName() {
        if(Url.getSalesforceBaseUrl().toExternalForm().contains('comunidade')) {
            // Community User
            return Url.getSalesforceBaseUrl().toExternalForm().contains('-vivo') ?
                            '.' + Url.getSalesforceBaseUrl().toExternalForm().substringAfterLast('//').substringBefore('-') :
                            '';
        } else {
            // Internal User
            return Url.getSalesforceBaseUrl().toExternalForm().contains('--') ? 
                            '.' + Url.getSalesforceBaseUrl().toExternalForm().substringAfterLast('--').substringBefore('.') : 
                            '';
        }
    }

    private User getUserData(String userName){
        List<User> ltUser = new List<User>([SELECT Id, PartnerGroup__c FROM User WHERE username =: userName LIMIT 1]);
        return (ltUser.size() > 0 ? new User(Id=ltUser[0].Id) : new User());
    }

    @future
    public static void updatePublicGroupFuture(String userString, String roleResponse) {
        User userRecord = (User) JSON.deserialize(userString, User.class);
        String role = roleResponse.replaceAll('"','');
        List<PublicGroup__mdt> lstPublicGroup = [SELECT PartnerGroup__c, PublicGroup__c, DeveloperName FROM PublicGroup__mdt WHERE PartnerGroup__c =: role];

        Set<String> setGroupName = new Set<String>();
        Map<Id, GroupMember> mapGroupMember = new Map<Id, GroupMember>();

        for(PublicGroup__mdt publicGroup : lstPublicGroup) {
            setGroupName.add(publicGroup.PublicGroup__c);
        }

        //Busca os grupos relacionados ao metadado
        List<Group> lstGroup = [SELECT Id, DeveloperName FROM Group WHERE DeveloperName IN: setGroupName];        
        List<GroupMember> lstGroupMember = [SELECT Id, GroupId FROM GroupMember WHERE UserOrGroupID =: userRecord.Id];
    
        Set<Id> setCurrentGroupId = new Set<Id>();
        Set<Id> setGroupId = new Set<Id>();
        List<GroupMember> lstInsertGroup = new List<GroupMember>();
        List<GroupMember> lstDeleteGroup = new List<GroupMember>();
        
        for(Group grp : lstGroup) {
            setGroupId.add(grp.Id);
        }
        
        for(GroupMember groupMember : lstGroupMember) {
            if(setGroupId.contains(groupMember.GroupId)) {
                setCurrentGroupId.add(groupMember.GroupId);
            } else {
                lstDeleteGroup.add(groupMember);
            }
        }
        
        for(Group grp : lstGroup) {
            if(!setCurrentGroupId.contains(grp.Id) && userRecord.id != null) {
                GroupMember groupMember = new GroupMember();
                groupMember.GroupId = grp.id;
                groupMember.UserOrGroupId = userRecord.id;
                lstInsertGroup.add(groupMember);
            }
        }

        if(lstDeleteGroup.size() > 0) {
            delete lstDeleteGroup;
        }

        if(lstInsertGroup.size() > 0) {
            insert lstInsertGroup;
        }
    }
	
    @future
    public static void updatePublicGroupInternalFuture(String userString, String roleResponse, List<String> permissionSet) {
        User userRecord = (User) JSON.deserialize(userString, User.class);

        if (userRecord == null || userRecord.Id == null) {
            return;
        }

        List<PublicGroup__mdt> lstPublicGroup = [
            SELECT 
                PartnerGroup__c, 
                PublicGroup__c, 
                DeveloperName, 
                PermissionSet__c 
            FROM 
                PublicGroup__mdt 
            WHERE 
                PermissionSet__c != ''
        ];

        if (lstPublicGroup == null || lstPublicGroup.size() == 0) {
            return;
        }
  
        Set<String> setGroupNameInMdt = new Set<String>();
        Set<String> setGroupNameUser = new Set<String>();
        
        for (PublicGroup__mdt publicGroup : lstPublicGroup) {
            setGroupNameInMdt.add(publicGroup.PublicGroup__c);
            
            if (permissionSet.contains(publicGroup.PermissionSet__c)) {
                setGroupNameUser.add(publicGroup.PublicGroup__c);
            }
        }

        Map<Id, Group> mapGroup = new Map<Id, Group>([
            SELECT 
                Id, 
                DeveloperName 
            FROM 
                Group 
            WHERE 
                DeveloperName IN :setGroupNameInMdt
        ]);        
        
        Map<Id, GroupMember> mapGroupMember = new Map<Id, GroupMember>([
            SELECT 
                Id, 
                GroupId, 
                Group.DeveloperName 
            FROM 
                GroupMember 
            WHERE 
                UserOrGroupID = :userRecord.Id AND 
                GroupId IN :mapGroup.keySet()
        ]);
        
        Set<Id> groupByUser = new Set<Id>();

        for (GroupMember gm : mapGroupMember.values()) {
            groupByUser.add(gm.GroupId);
        }

        List<GroupMember> lstInsertGroup = new List<GroupMember>();
        List<GroupMember> lstDeleteGroup = new List<GroupMember>();
        
        for (Group grp : mapGroup.values()) {
            if (!groupByUser.contains(grp.Id) && setGroupNameUser.contains(grp.DeveloperName)) {
                GroupMember groupMember = new GroupMember();

                groupMember.GroupId = grp.Id;
                groupMember.UserOrGroupId = userRecord.Id;

                lstInsertGroup.add(groupMember);
            }
        }

        for (GroupMember groupMember : mapGroupMember.values()) {
            if (!setGroupNameUser.contains(groupMember.Group.DeveloperName)) {
                lstDeleteGroup.add(groupMember);
            }
        }

        if (lstDeleteGroup.size() > 0) {
            delete lstDeleteGroup;
        }

        if (lstInsertGroup.size() > 0) {
            insert lstInsertGroup;
        }
    }

    public static void updatePublicGroup(String userString, String roleResponse) {
        User userRecord = (User) JSON.deserialize(userString, User.class);
        String role = roleResponse.replaceAll('"','');
        List<PublicGroup__mdt> lstPublicGroup = [SELECT PartnerGroup__c, PublicGroup__c, DeveloperName FROM PublicGroup__mdt WHERE PartnerGroup__c =: role];

        Set<String> setGroupName = new Set<String>();
        Map<Id, GroupMember> mapGroupMember = new Map<Id, GroupMember>();

        for(PublicGroup__mdt publicGroup : lstPublicGroup) {
            setGroupName.add(publicGroup.PublicGroup__c);
        }

        //Busca os grupos relacionados ao metadado
        List<Group> lstGroup = [SELECT Id, DeveloperName FROM Group WHERE DeveloperName IN: setGroupName];        
        List<GroupMember> lstGroupMember = [SELECT Id, GroupId FROM GroupMember WHERE UserOrGroupID =: userRecord.Id];
    
        Set<Id> setCurrentGroupId = new Set<Id>();
        Set<Id> setGroupId = new Set<Id>();
        List<GroupMember> lstInsertGroup = new List<GroupMember>();
        List<GroupMember> lstDeleteGroup = new List<GroupMember>();
        
        for(Group grp : lstGroup) {
            setGroupId.add(grp.Id);
        }
        
        for(GroupMember groupMember : lstGroupMember) {
            if(setGroupId.contains(groupMember.GroupId)) {
                setCurrentGroupId.add(groupMember.GroupId);
            } else {
                lstDeleteGroup.add(groupMember);
            }
        }
        
        for(Group grp : lstGroup) {
            if(!setCurrentGroupId.contains(grp.Id) && userRecord.id != null) {
                GroupMember groupMember = new GroupMember();
                groupMember.GroupId = grp.id;
                groupMember.UserOrGroupId = userRecord.id;
                lstInsertGroup.add(groupMember);
            }
        }

        if(lstDeleteGroup.size() > 0) {
            List<SObject> SObjectList = new List<SObject>();
            SObjectList.addAll(lstDeleteGroup);
            database.deleteAsync(SObjectList); //----> @future
        }

        if(lstInsertGroup.size() > 0){
            executeAssigmentPublicGroupFuture(JSON.serialize(lstInsertGroup));
        } 
    }

    public static void updatePublicGroupInternal(String userString, String roleResponse, List<String> permissionSet) {
        User userRecord = (User) JSON.deserialize(userString, User.class);

        if (userRecord == null || userRecord.Id == null) {
            return;
        }

        List<PublicGroup__mdt> lstPublicGroup = [
            SELECT 
                PartnerGroup__c, 
                PublicGroup__c, 
                DeveloperName, 
                PermissionSet__c 
            FROM 
                PublicGroup__mdt 
            WHERE 
                PermissionSet__c != ''
        ];

        if (lstPublicGroup == null || lstPublicGroup.size() == 0) {
            return;
        }
  
        Set<String> setGroupNameInMdt = new Set<String>();
        Set<String> setGroupNameUser = new Set<String>();
        
        for (PublicGroup__mdt publicGroup : lstPublicGroup) {
            setGroupNameInMdt.add(publicGroup.PublicGroup__c);
            
            if (permissionSet.contains(publicGroup.PermissionSet__c)) {
                setGroupNameUser.add(publicGroup.PublicGroup__c);
            }
        }

        Map<Id, Group> mapGroup = new Map<Id, Group>([
            SELECT 
                Id, 
                DeveloperName 
            FROM 
                Group 
            WHERE 
                DeveloperName IN :setGroupNameInMdt
        ]);        
        
        Map<Id, GroupMember> mapGroupMember = new Map<Id, GroupMember>([
            SELECT 
                Id, 
                GroupId, 
                Group.DeveloperName 
            FROM 
                GroupMember 
            WHERE 
                UserOrGroupID = :userRecord.Id AND 
                GroupId IN :mapGroup.keySet()
        ]);
        
        Set<Id> groupByUser = new Set<Id>();

        for (GroupMember gm : mapGroupMember.values()) {
            groupByUser.add(gm.GroupId);
        }

        List<GroupMember> lstInsertGroup = new List<GroupMember>();
        List<GroupMember> lstDeleteGroup = new List<GroupMember>();
        
        for (Group grp : mapGroup.values()) {
            if (!groupByUser.contains(grp.Id) && setGroupNameUser.contains(grp.DeveloperName)) {
                GroupMember groupMember = new GroupMember();

                groupMember.GroupId = grp.Id;
                groupMember.UserOrGroupId = userRecord.Id;

                lstInsertGroup.add(groupMember);
            }
        }

        for (GroupMember groupMember : mapGroupMember.values()) {
            if (!setGroupNameUser.contains(groupMember.Group.DeveloperName)) {
                lstDeleteGroup.add(groupMember);
            }
        }

        if (lstDeleteGroup.size() > 0) {
            List<SObject> SObjectList = new List<SObject>();
            SObjectList.addAll(lstDeleteGroup);
            database.deleteAsync(SObjectList); //----> @future
        }

        if (lstInsertGroup.size() > 0) {
            executeAssigmentPublicGroupInternalFuture(JSON.serialize(lstInsertGroup));
        }
    }

    //Função validadora Nivel 1
    private void fristValidateResponse(Auth.UserData data, Boolean userInternal) {
        String errorMsg = '';
        
        // LastName para contato quando parceiro
        if((String.isEmpty(data.LastName)) && (userInternal == false)) {
            errorMsg = 'Campo obrigatório de lastName não informado no response.';
        }
        // Profile
        if(data.attributeMap.get('profile_name') == null) {
            errorMsg += 'Campo obrigatório de perfil não informado no response.';
        }
        // Role
        if(data.attributeMap.get('role') == null) {
            errorMsg += 'Campo obrigatório de papel não informado no response.';
        }
        // Sub
        if(String.isEmpty(data.username)) {
            errorMsg += 'Campo obrigatório de Sub (Username) não informado no response.';
        }
        if((userInternal) && (String.isEmpty(data.email))) {
            errorMsg += 'Campo obrigatório de email para usuário interno não informado no response.';
        }

        if(String.isNotEmpty(errorMsg)) {
            throw new RegHandlerException(errorMsg + 'Acesso incorreto, por favor, entrar em contato com o CSL para regularização');
        }
    }

    //Função validadora Nivel 2
    private void secondValidateResponse(Auth.UserData data, 
                                                Boolean userInternal, 
                                                Profile userProfile, 
                                                String userLicenseProfile,
                                                String userRole, 
                                                Contact contactRecord,
                                                List<PermissionSet> ltPermissionSetSF, 
                                                List<String> ltPermissionSetResponse) 
    {
        String errorMsg = '';
        
        // Validação de Perfil 
        if(userProfile.Id == null) {
            errorMsg = 'Perfil de acesso relacionado não encontrado.';
        }
        // Validação de Papel
        if(userRole == 'null') {
            errorMsg += 'Papel informado não encontrado no SalesForce.';
        }
        // Validação usuário interno e sem licensa de perfil 'Partner Community'
        if(userInternal && userLicenseProfile == 'Partner Community') {
            errorMsg += 'Usuário interno, perfil não informado ou atribuído como Partner Community.';
        }
        // Validação usuário parceiro e com licensa de perfil 'Partner Community'
        if(!userInternal) {
            // if(contactRecord.Id == null) {
            //     errorMsg += 'Contato não encontrado.';
            // }
            if(userLicenseProfile != 'Partner Community') {
                errorMsg += 'Usuário Parceiro, perfil não informado ou atribuído diferente de Partner Community.';
            }
        }
        // Validação permissionSet base x response
        if(ltPermissionSetResponse.size() > 0 && ltPermissionSetSF.size() != ltPermissionSetResponse.size()) {
            errorMsg += 'PermissionSet informada(s) no response não corresponde com as do SalesForce.';
        }

        if(String.isNotEmpty(errorMsg)) {
            throw new RegHandlerException(errorMsg + 'Acesso incorreto, por favor, entrar em contato com o CSL para regularização');
        }
    }

    private SalesOffices__mdt getOffice(String office) {
        SalesOffices__mdt center = null;
        List<String> vetOffice = office.split('-');
        
        if (vetOffice.size() > 0) {
            office = vetOffice[0];

            List<SalesOffices__mdt> lstCenter = [SELECT Id, Office__c, Center__c, Store__c FROM SalesOffices__mdt WHERE Office__c = :office AND Active__c = true];
        
            if (lstCenter.size() > 0) {
                center = lstCenter[0];
            }            
        }

        return center;
    }
    
    private String getAdabasAssignedDocumentByAdabasCode(string varChannelName, String varSite, String varAdabas)
    {
        system.debug('OAMRegistrationHandler.getAdabasAssignedDocumentByAdabasCode varChannelName: ' + varChannelName);
        system.debug('OAMRegistrationHandler.getAdabasAssignedDocumentByAdabasCode varSite: ' + varSite);
        system.debug('OAMRegistrationHandler.getAdabasAssignedDocumentByAdabasCode varAdabas: ' + varAdabas);
        
        List<AdabasSite__c> lAdabasSite = new List<AdabasSite__c>();

        //J110 incluir campo Status__c n consulta adabas caso necessário por conta da Carga DO Power Center      
        if(String.isNotEmpty(varChannelName))
        {
            switch on varChannelName 
            {
                when 'Call Center', 'Lojas Proprias' 
                {
                    if(String.isNotEmpty(varSite)) {
                    	lAdabasSite = [SELECT Name, AdabasCode__c, CNPJ__c FROM AdabasSite__c WHERE AdabasCode__c =: varSite]; 
                    }
                }
                
                when 'Lojas Revendas'
                {
                    if(String.isNotEmpty(varAdabas)) {
                      lAdabasSite = [SELECT Name, AdabasCode__c, CNPJ__c FROM AdabasSite__c WHERE AdabasCode__c =: varAdabas];  
                    }
                }            
            }
        }
        
        system.debug('OAMRegistrationHandler.getAdabasAssignedDocumentByAdabasCode sobjectAdabasSite: ' + json.serialize(lAdabasSite));
        
        return (!lAdabasSite.isEmpty() ? lAdabasSite[0].CNPJ__c : NULL);
	}
	
    @future
    public static void executeAssigmentPermissionFuture(string permissionSetAssignmentString){
        List<PermissionSetAssignment> ltInsertPSA = (List<PermissionSetAssignment>) JSON.deserialize(permissionSetAssignmentString, List<PermissionSetAssignment>.class);
        if(!ltInsertPSA.IsEmpty()) insert ltInsertPSA;
    }

    @future
    public static void executeAssigmentPublicGroupFuture(string publicGroupAssignmentString){
        List<GroupMember> lstInsertGroup = (List<GroupMember>) JSON.deserialize(publicGroupAssignmentString, List<GroupMember>.class);
        if(!lstInsertGroup.IsEmpty()) insert lstInsertGroup;
    }

    @future
    public static void executeAssigmentPublicGroupInternalFuture(string publicGroupInternalAssignmentString){
        List<GroupMember> lstInsertGroup = (List<GroupMember>) JSON.deserialize(publicGroupInternalAssignmentString, List<GroupMember>.class);
        if(!lstInsertGroup.IsEmpty()) insert lstInsertGroup;
    }

    @Testvisible
    private static boolean userHasChanged(user userRecord, User oldUser){
        return
        userRecord.IsActive					!= oldUser.isActive ||
        userRecord.ProfileId				!= oldUser.ProfileId ||
        userRecord.FirstName				!= oldUser.FirstName ||
        userRecord.LastName					!= oldUser.LastName ||
        userRecord.FederationIdentifier		!= oldUser.FederationIdentifier ||
        userRecord.Login__c					!= oldUser.Login__c ||
        userRecord.Adabas__c				!= oldUser.Adabas__c ||
        userRecord.EmployeeNumber			!= oldUser.EmployeeNumber ||
        userRecord.MobilePhone				!= oldUser.MobilePhone ||
        userRecord.email					!= oldUser.email;
    }

    
    private static boolean isActivating(User oldUser){
        return !oldUser.IsActive;
    }
}