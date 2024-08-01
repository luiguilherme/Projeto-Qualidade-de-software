/*
 * Autor: Leandro Alexandrino Pereira da Silva - Deloitte
 * Criado em: 10/12/2021
*/
 
public with sharing class TestingUtils {
    public static void activateCustomPerm(Id userId, String permissionName) {
        PermissionSet ps = new PermissionSet(
          Name = 'CustomPermissionEnabled',
          Label = 'Custom Permisison Enabled'
          );
        insert ps;
     
        SetupEntityAccess sea = new SetupEntityAccess(
          ParentId = ps.Id,
          SetupEntityId = [
            SELECT Id
            FROM CustomPermission
            WHERE DeveloperName = :permissionName
            LIMIT 1
          ].Id
        );
                     
        PermissionSetAssignment psa = new PermissionSetAssignment(
          AssigneeId = userId,
          PermissionSetId = ps.Id
        );
     
        insert new List<SObject>{ sea, psa };
    }

    public static String getFakeId(Schema.SObjectType sObjectType, Integer sequenceNumber)
    {
        String sequenceNumberString = String.valueOf(sequenceNumber);

        String keyPrefix = sObjectType.getDescribe().getKeyPrefix();
        String paddedSequenceNumber = '0'.repeat(12 - sequenceNumberString.length()) + sequenceNumberString;

        String fakeId = keyPrefix + paddedSequenceNumber;
        System.debug(LoggingLevel.INFO, 'fakeId: ' + fakeId);
        
        return fakeId;
    }
}