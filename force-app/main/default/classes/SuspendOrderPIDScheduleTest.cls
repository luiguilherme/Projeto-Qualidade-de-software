@isTest
private class SuspendOrderPIDScheduleTest {
    @isTest
    static void testScheduledJob() {
            
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest',
            '0 0 1 * * ?',
            new SuspendOrderPIDSchedule());
        Test.stopTest();
        System.assert(jobId != null, 'Agendamento não foi realizado');
    }
}