@isTest
public class UnsualUserTrackingControllerTest {

    @isTest
    public static void execute() {

        insert new GeneralParam__c(
            AccountLoadDate__c  = Datetime.now().addDays(-1),
            AssetLoadDate__c = Datetime.now().addDays(-1),
            BillingAccountLoadDate__c = Datetime.now().addDays(-1),
            InvoiceLoadDate__c = Datetime.now().addDays(-1),
            AddressLoadDate__c = Datetime.now().addDays(-1),
            AssetJob__c = true,
            BillingAccountJob__c = true,
            AccountJob__c = true,
            AddressJob__c = true,
            InvoiceJob__c = true,
            SearchRange__c = 90,
            TotalNumberRecords__c = 100,
            ServiceHistoryExpiration__c = 0,
            AccessesMinute__c = '3/1'
        );

        Datetime myDT = Datetime.now();
        String myDate = myDT.format('HH:mm');

        Cache.SessionPartition sessionPartition = Cache.Session.getPartition('local.PartnerAccessAccount');
        //sessionPartition.put(UserInfo.getUserId(),myDate+';15;15');
        sessionPartition.put(UserInfo.getUserId(),'2/1');

        UnsualUserTrackingController.checkPartnerAccess();
    }
}