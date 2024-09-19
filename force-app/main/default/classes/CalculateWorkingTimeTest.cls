/**
 * @author Ronan Michel
 * @company Everis do Brasil
 * @description Classe de teste da classe CalculateWorkingTime.
 **/
@Istest
public class CalculateWorkingTimeTest {

    @Istest
    private static void myTest() {

        Datetime lDateTime = Datetime.newInstance(System.today(), Time.newInstance(20, 00, 0, 0));
        Map<String, DateTime> lMapRegisterDateTime= new Map<String, DateTime>();
        Map<String,Map<String, Integer>> lMapRegisterMinutes= new Map<String,Map<String, Integer>>();
        lMapRegisterDateTime.put('A', lDateTime);
       	Map<String, Integer> lMapStringInteger = new Map<String, Integer>();
        lMapStringInteger.put('A', 120);
        lMapRegisterMinutes.put('A', lMapStringInteger);
        
        Map<String, Id> lMapBusinessIdByRegisterId= new Map<String, Id>();
        for(BusinessHours iBusi : [SELECT Id FROM BusinessHours LIMIT 1]){
           lMapBusinessIdByRegisterId.put('A', iBusi.Id); 
        }
       // CalculateWorkingTime.WrapperTimeWorked iWrapper = new CalculateWorkingTime.WrapperTimeWorked(iCase.Id,iCase.BusinessHoursId, iCase.startedDateSLA__c, iCase.closedDateSLA__c);

        Test.startTest();
        lMapRegisterDateTime = CalculateWorkingTime.calculateTime(lMapRegisterDateTime,lMapRegisterMinutes,lMapBusinessIdByRegisterId, 'A');
        System.assert(lMapRegisterDateTime.containsKey('A') && lMapRegisterDateTime.get('A') != lDateTime); 
        Test.stopTest();
    }
    
}