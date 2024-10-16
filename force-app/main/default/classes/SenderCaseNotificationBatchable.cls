global with sharing class SenderCaseNotificationBatchable implements Database.Batchable<sObject> {
    private final String STATUS_WARNING = 'Atenção';
    private final String STATUS_CRITICAL = 'Crítico';

    private List<User> ltManagers = new List<User>();

    global SenderCaseNotificationBatchable() {
        String dateTimeToCompare = (('' + Datetime.now().addHours(-1)).replace(' ', 'T') + 'Z');

        String query = (
            'SELECT OwnerId FROM Case ' + 
            'WHERE (Status = \'' + STATUS_WARNING + '\' OR Status = \'' + STATUS_CRITICAL + '\')' + 
            (Test.isRunningTest() ? '' : ' AND SLADeadline__c < ' + dateTimeToCompare) + 
            ' GROUP BY OwnerId'
        );

        List<AggregateResult> arOwners = Database.query(query);

        if (arOwners.size() == 0) {
            return;
        }

        Set<Id> ownerIds = new Set<Id>();
        User ownerUser;
        Id ownerId;

        for (AggregateResult ar : arOwners) {
            ownerId = (Id) ar.get('OwnerId');

            if (ownerId != null && !ownerId.to15().startsWith('00G')) {
                ownerIds.add(ownerId);
            }
        }

        Map<Id, User> managersByOwnerIds = new Map<Id, User>([
            SELECT 
                Id, 
                ManagerId, 
                Manager.Email 
            FROM 
                User 
            WHERE 
                Id IN :ownerIds
        ]);

        for (AggregateResult ar : arOwners) {
            ownerUser = (User) managersByOwnerIds.get((Id) ar.get('OwnerId'));

            if (ownerUser != null && ownerUser.ManagerId != null) {
                ltManagers.add(new User(Id = ownerUser.ManagerId));
            }
        }
    }

    global Iterable<User> start(Database.BatchableContext bc) { 
        return (ltManagers);
    }

    public void execute(Database.BatchableContext bc, List<User> ltManagers) {
        if (ltManagers.size() == 0) {
            return;
        }

        List<Id> ltManagersToSend = new List<Id>();

        for (User usr : ltManagers) {
            ltManagersToSend.add(usr.Id);
        }

        SenderCaseNotification senderNotify = new SenderCaseNotification();

        senderNotify.sendToUsers(ltManagersToSend);
    }
    
    global void finish(Database.BatchableContext bc){
        
    }
}