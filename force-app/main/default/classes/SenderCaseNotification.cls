public with sharing class SenderCaseNotification {
	private Id customNotificationTypeId;
    private Id owea; 
    private Map<String, GeneralSetting__c> mapSettings = new Map<String, GeneralSetting__c>();
    
    public SenderCaseNotification() {
        this.customNotificationTypeId = getCustomNotificationTypeId('CaseOpenedNotification');
        buildMapSettings();
        this.owea = getWideEmailId();
    }

    public void sendHub(List<Case> listCases, String messageType, String sendType, Id OtherOwner) {
        if (String.isBlank(sendType)) {
            throw new IllegalArgumentException('Send type cannot be blank');
        }

        if(sendType.contains('New')){
            if (sendType.contains('notification')) {  
                send(listCases, messageType, null);
            }else if (sendType.contains('email')) {
                sendEmail(listCases, messageType, null);
            }
        }
        
        if (OtherOwner != null) {
            if (sendType.contains('supervisor')) {
                send(listCases, messageType, OtherOwner);           
                sendEmail(listCases, messageType, OtherOwner);
            }else if (sendType.contains('formerOwner')) {
                send(listCases, messageType, OtherOwner);  
            }else if (sendType.contains('notifyOnly1')) {
                if(messageType.contains('FormerOwner')){
                    send(listCases, messageType, OtherOwner);
                }else {
                    send(listCases, messageType, null);
                    sendEmail(listCases, messageType, null);  
                }   
            }
        }

        if (messageType.contains('RoleOuvidoria')){

            Id roleId = [SELECT Id FROM UserRole WHERE Name = 'Atendimento Ouvidoria Adm Performance' LIMIT 1].Id;
            List<User> usersWithRole = [SELECT Id FROM User WHERE UserRoleId = :roleId];

            for (User u : usersWithRole) {
                send(listCases, messageType, u.Id);
                sendEmail(listCases, messageType, u.Id);
            }

        }
    }
    
    public void send(List<Case> listCase, String messageType,Id OtherOwner) {       
        if(listCase == null || listCase.isEmpty()) {
            throw new IllegalArgumentException('The case does not exist');
        }
        if(String.isBlank(messageType) || !mapSettings.containsKey(messageType)) {
            System.debug('GeneralSetting__c for ' +messageType+ ' not found');
            return;
        }
        if(listCase.size() == 1) {
            send(listCase.get(0), messageType, OtherOwner);                     
            return;            
        }

		GeneralSetting__c setting = mapSettings.get(messageType);
        String title = setting.TitleNotificationLittleBellToNCases__c;
        String body = setting.NotificationLittleBellToNCases__c;
        
        String Recipient = OtherOwner != null && (messageType.contains('FormerOwner') || messageType.contains('Above2') || messageType.contains('RoleOuvidoria')) ? 
        OtherOwner : listCase.get(0).OwnerId;
        
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        Set<String> recipientsId = new Set<String>();
        recipientsId.add(Recipient);

        notification.setTitle(title);
        notification.setBody(body);
        notification.setTargetPageRef('{"type":"standard__objectPage","attributes":{"objectApiName":"Case","actionName":"list"},"state":{"filterName":"HDEAllCases"}}');
        notification.setNotificationTypeId(this.customNotificationTypeId);       
        try {
            notification.send(recipientsId);
        }
        catch (Exception e) {
            System.debug('Problem sending notification: ' + e.getMessage());
        }
    }
    
    public void send(Case varCase, String messageType, Id OtherOwner) {
        GeneralSetting__c setting = mapSettings.get(messageType);
        String title = setting.TitleNotificationLittleBellToOneCase__c;
        String body = mergeTokens(varCase, setting.NotificationLittleBellToOneCase__c);

        String Recipient = OtherOwner != null && (messageType.contains('FormerOwner') || messageType.contains('Above2') || messageType.contains('RoleOuvidoria')) ? 
        OtherOwner: varCase.OwnerId;

        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        Set<String> recipientsId = new Set<String>();
        recipientsId.add(Recipient);

        notification.setTitle(title);
        notification.setBody(body);
        notification.setTargetId(varCase.Id);
        notification.setNotificationTypeId(this.customNotificationTypeId);
        try {
            notification.send(recipientsId);
        }
        catch (Exception e) {
            System.debug('Problem sending notification: ' + e.getMessage());
        }
    }

    public void sendEmail(List<Case> listCase, String messageType, Id OtherOwner) {       
        if(listCase == null || listCase.isEmpty()) {
            throw new IllegalArgumentException('The case does not exist');
        }
        if(String.isBlank(messageType) || !mapSettings.containsKey(messageType)) {
            System.debug('GeneralSetting__c for ' +messageType+ ' not found');
            return;
        }
    
        if(listCase.size() == 1) {
            sendEmail(listCase.get(0), messageType, OtherOwner);                     
            return;            
        }
    
        GeneralSetting__c setting = mapSettings.get(messageType);
        String emailSubject = setting.TitleNotificationLittleBellToNCases__c;
        String emailBody = addHrefLink(listCase,setting.NotificationEmailToNCases__c);
        Id recipient = OtherOwner != null && (messageType.contains('FormerOwner') || messageType.contains('Above2') || messageType.contains('RoleOuvidoria')) ? 
        OtherOwner : listCase.get(0).OwnerId;
    
        sendEmails(new List<Id>{Recipient}, emailSubject, emailBody);
    }
    
    public void sendEmail(Case varCase, String messageType, Id OtherOwner) {
        GeneralSetting__c setting = mapSettings.get(messageType);
        String emailSubject = setting.TitleNotificationLittleBellToOneCase__c;
        String emailBody = mergeTokens(varCase, addHrefLink(new List<Case>{varCase},setting.NotificationEmailToOneCase__c));
        Id Recipient = OtherOwner != null && (messageType.contains('FormerOwner') || messageType.contains('Above2') || messageType.contains('RoleOuvidoria')) ?
        OtherOwner : varCase.OwnerId;
    
        sendEmails(new List<Id>{Recipient}, emailSubject, emailBody);
    }
    
    private void sendEmails(List<Id> userIds, String subject, String emailBody) {
        if (userIds == null || userIds.isEmpty()) {
            throw new IllegalArgumentException('The userIds list cannot be empty.');
        }
    
        List<User> users = [SELECT Id, Email FROM User WHERE Id IN :userIds];
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    
        for (User user : users) {
            if (user.Email != null) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] { user.Email });
                mail.setSubject(subject);
                mail.setHtmlBody(emailBody);
                if(this.owea != null){
                    mail.setOrgWideEmailAddressId(this.owea);
                }
                emails.add(mail);
            }
        }
    
        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
    
    public void sendToUsers(List<Id> userIds) {
        sendToUsers(userIds, 'ExpiredSLAUserAbove3rd');
    }

    public void sendToUsers(List<Id> userIds, String messageType) {
        if (userIds == null || userIds.isEmpty()) {
            throw new IllegalArgumentException('The userIds list cannot be empty.');
        }
        
        GeneralSetting__c setting = mapSettings.get(messageType);
        if (setting == null) {
            System.debug('GeneralSetting__c for ' +messageType+ ' not found');
            return;
        }

        String title = setting.TitleNotificationLittleBellToNCases__c;
        String body = setting.NotificationLittleBellToNCases__c;
        String emailSubject = setting.TitleNotificationLittleBellToNCases__c;
        String emailBody = setting.NotificationEmailToNCases__c;
        
        Set<String> recipientsId = new Set<String>();

        for (Id userId : userIds) {
            recipientsId.add(userId);
        }

        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setTitle(title);
        notification.setBody(body);
        notification.setNotificationTypeId(this.customNotificationTypeId);
        notification.setTargetPageRef('{"type":"standard__objectPage","attributes":{"objectApiName":"Case","actionName":"list"},"state":{"filterName":"HDEAllCases"}}');

        try {
            notification.send(recipientsId);
        } catch (Exception e) {
            System.debug('Problem sending notification: ' + e.getMessage());
        }

        sendEmails(userIds, emailSubject, emailBody);
    }
      
    private Id getCustomNotificationTypeId(String customNotificationTypeName) {
        CustomNotificationType notificationType = [SELECT Id 
                                                   FROM CustomNotificationType 
                                                   WHERE DeveloperName = :customNotificationTypeName LIMIT 1];
        return notificationType.Id;
    }

    private Id getWideEmailId() {
        OrgWideEmailAddress wide;
        try {
            wide = [SELECT Id FROM OrgWideEmailAddress WHERE Purpose = 'DefaultNoreply' Limit 1];
            if( wide != null){return wide.Id;}
        } catch (Exception e) {
            System.debug('Problem to define OrgWideEmailAddress: ' + e.getMessage());
        }
        return null;     
    }
    
    private void buildMapSettings() {
        List<GeneralSetting__c> listGeneralSetting = [SELECT Id, 
                                                      Name,
                                                      NotificationName__c,
                                                      NotificationLittleBellToOneCase__c, 
                                                      NotificationLittleBellToNCases__c, 
                                                      NotificationEmailToOneCase__c, 
                                                      NotificationEmailToNCases__c, 
                                                      TitleNotificationLittleBellToNCases__c, 
                                                      TitleNotificationLittleBellToOneCase__c
                                                      FROM GeneralSetting__c 
                                                      WHERE RecordType.DeveloperName = 'UserComunicationSetup'];
        
        for(GeneralSetting__c varGeneralSetting : listGeneralSetting) {
            mapSettings.put(varGeneralSetting.NotificationName__c, varGeneralSetting);
        }
    }
    
    private String urlBaseGet() {
        String baseUrl = URL.getOrgDomainUrl().toExternalForm();
        return baseUrl.replace('.my.salesforce.com', '.lightning.force.com');
    }
    
    private String addHrefLink(List<Case> cases, String message) {
        if(String.isBlank(message)) {
            return '';
        }
        
        String idUrl = 'lightning/o/Case/list?filterName=HDEAllCases';
 
        if (cases.size() == 1) {
            idUrl = cases[0].Id;
        }
                                
        String baseUrl = urlBaseGet();
        String caseUrl = baseUrl + '/' + idUrl;
        if(message.contains('Clique')) {
            message = message.replace('Clique', '<a href="' + caseUrl + '">Clique</a>');
        }
    
        return message;
    }

    private String mergeTokens(Case varCase, String message) {
        if(String.isBlank(message)) {
            return '';
        }
        if(!message.contains('{!')) {
            return message;
        }
        return message.replace('{!CaseNumber}', varCase.CaseNumber).replace('{!Status}', varCase.Status);
    }
    
}