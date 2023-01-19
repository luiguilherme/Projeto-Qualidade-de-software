public with sharing class ProfileDAO {
    public static Profile getById(id profileId) {

        return [SELECT Id, Name FROM Profile WHERE Id =: profileId];

    }
}