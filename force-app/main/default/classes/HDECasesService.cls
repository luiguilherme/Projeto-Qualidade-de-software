public with sharing class HDECasesService {
    public static void validateNewOwnerSegment(List<Case> lstCases) {
        User currentUser = UserDAO.getById(userinfo.getuserid());

        if(userIsPartner(currentUser)){
            return;
        }
        
        List<Case> lstChangedCase = new List<Case>();
        Set<Id> setOwnerId = new Set<Id>();
        
        for (Case iCase : lstCases) {
            if (iCase.Origin == 'HDE' && !isQueue(iCase.OwnerId) && TriggerHelper.changedField(iCase, new Set<String>{'CaseOwnerFormula__c'})) {
                lstChangedCase.add(iCase);
                setOwnerId.add(iCase.OwnerId);
            }
        }
        
        if (!lstChangedCase.isEmpty()) {
            if (hasPerformancePermission()) {
                return;

            } else if (hasRequiredPermissions()) {
                List<User> lstAllOwnersUsers = UserDAO.getById(setOwnerId);
                Set<String> setOwnersPartnerGroups = new Set<String>{currentUser.UserRole.DeveloperName};

                for (User iUser : lstAllOwnersUsers) {
                    setOwnersPartnerGroups.add(iUser.PartnerGroup__c != null ? iUser.PartnerGroup__c : 'null');
                    setOwnersPartnerGroups.add(iUser.PartnerGroup__c == null ? iUser.UserRole.DeveloperName : 'null');
                }
                List<FromToMapping__mdt> lstSegmentsAvailable = FromToMappingDAO.getLstByUsersRole(setOwnersPartnerGroups);
                if (lstSegmentsAvailable.isEmpty()) {
                    for (Case iCase : lstChangedCase) {
                        iCase.addError('Papel está sem o segmento cadastrado no De/Para');
                    }
                    return;
                }

                Map<String,List<Id>> mapSegmentUser = new Map<String,List<Id>>();
                String currentUserSegment;
                for (FromToMapping__mdt iFromToMdt: lstSegmentsAvailable) {
                    if (iFromToMdt.OperatorSegment__c != null && iFromToMdt.OriginApiName__c == currentUser.UserRole.DeveloperName) {
                        currentUserSegment = iFromToMdt.OperatorSegment__c;
                    } 
                    
                    for (User iUser : lstAllOwnersUsers) {
                        Boolean hasRoleToTransfer;
                        if(userIsPartner(iUser)){
                            hasRoleToTransfer = iFromToMdt.OperatorSegment__c != null && iFromToMdt.OriginApiName__c == iUser.PartnerGroup__c;
                        } else{
                            hasRoleToTransfer = iFromToMdt.OperatorSegment__c != null && iFromToMdt.OriginApiName__c == iUser.UserRole.DeveloperName;
                        }

                        if (hasRoleToTransfer) {
                            if (mapSegmentUser.containsKey(iFromToMdt.OperatorSegment__c)) {
                                List<Id> lstUserTemp = mapSegmentUser.get(iFromToMdt.OperatorSegment__c);
                                lstUserTemp.add(iUser.Id);
                                mapSegmentUser.put(iFromToMdt.OperatorSegment__c, lstUserTemp);
                            } else{
                                mapSegmentUser.put(iFromToMdt.OperatorSegment__c, new List<Id> {iUser.Id});
                            }
                        }
                    }
                }

                for (Case iCase : lstChangedCase) {
                    if (currentUserSegment == null || !iCase.Segment__c.contains(currentUserSegment)) {
                        iCase.addError('Este usuário não pode alterar o proprietário para outro se não estiver no mesmo segmento do caso');
                    } else if(!mapSegmentUser.containsKey(iCase.Segment__c)){
                        if(isQueue(iCase.OwnerId)){
                            continue;
                        }
                        iCase.addError('Não pode alterar o proprietário para outro se usuário destino não estiver no mesmo segmento do caso');
                    }
                }
            } else {
                for (Case iCase : lstChangedCase) {
                    iCase.addError('Não pode fazer a alteração de proprietário');
                }
            }
        }        
    }

    public static Boolean hasPerformancePermission() {
        List<PermissionSetAssignment> lstPermissionsAssigments = PermissionSetDAO.getAllPermissionSetByUserId(UserInfo.getUserId());
        Pattern regexPatternPerformance = Pattern.compile('\\b.*Performance.*\\b'); 
        Pattern regexPatternProcess = Pattern.compile('\\bHDE.*Processos.*Escalonamento\\b'); 
        Boolean hasAtLeastAHDEPermission = false;
        Boolean hasAtLeastPerfomancePermission = false;
        for(PermissionSetAssignment iPerm : lstPermissionsAssigments){
            Matcher matcherProcess = regexPatternProcess.matcher(iPerm.PermissionSet.Label); //Regex para validar se tem as palavras 'HDE' e 'Processos' e 'Escalonamento' na permission Set 
            Matcher matcherPerformance = regexPatternPerformance.matcher(iPerm.PermissionSet.Label); //Regex para validar se tem a palavra 'Perfomance' na permission Set 
            if (matcherProcess.find()) {
                hasAtLeastAHDEPermission = true;
            } else if (matcherPerformance.find()){
                hasAtLeastPerfomancePermission = true;
            }
        }

        return hasAtLeastPerfomancePermission && hasAtLeastAHDEPermission;
    }
    
    public static Boolean hasRequiredPermissions() {
        List<PermissionSetAssignment> lstPermissionsAssigments = PermissionSetDAO.getAllPermissionSetByUserId(UserInfo.getUserId());
        Pattern regexPatternHDEProcessosEscalonamento = Pattern.compile('\\bHDE.*Processos.*Escalonamento\\b'); 
        Pattern regexPatternGuardiaoTriagem = Pattern.compile('\\bGuardião da Triagem\\b');
        Pattern regexPatternGestaoOperacao = Pattern.compile('\\bGestão da Operação\\b');
        Pattern regexPatternGestaoGuardiao = Pattern.compile('\\bGestão do Guardião\\b');
        Boolean hasHDEProcessosEscalonamento = false;
        Boolean hasGuardiaoTriagem = false;
        Boolean hasGestaoOperacao = false;
        Boolean hasGestaoGuardiao = false;
    
        for(PermissionSetAssignment iPerm : lstPermissionsAssigments){
            Matcher matcherHDEProcessosEscalonamento = regexPatternHDEProcessosEscalonamento.matcher(iPerm.PermissionSet.Label);
            Matcher matcherGuardiaoTriagem = regexPatternGuardiaoTriagem.matcher(iPerm.PermissionSet.Label);
            Matcher matcherGestaoOperacao = regexPatternGestaoOperacao.matcher(iPerm.PermissionSet.Label);
            Matcher matcherGestaoGuardiao = regexPatternGestaoGuardiao.matcher(iPerm.PermissionSet.Label);
    
            if (matcherHDEProcessosEscalonamento.find()) {
                hasHDEProcessosEscalonamento = true;
            } else if (matcherGuardiaoTriagem.find()) {
                hasGuardiaoTriagem = true;
            } else if (matcherGestaoOperacao.find()) {
                hasGestaoOperacao = true;
            } else if (matcherGestaoGuardiao.find()) {
                hasGestaoGuardiao = true;
            }
        }
            
        return (hasHDEProcessosEscalonamento && (hasGuardiaoTriagem || hasGestaoOperacao || hasGestaoGuardiao));
    }

    public static Boolean userIsPartner(User pUser) {
        if(pUser.Profile.UserLicense.name != 'Partner Community'){
            return false;
        } else {
            return true;
        }
    }

    public static Boolean isQueue(Id recordId) {
        String ownerId = recordId;
        return ownerId.startsWith('00G');
    }
}