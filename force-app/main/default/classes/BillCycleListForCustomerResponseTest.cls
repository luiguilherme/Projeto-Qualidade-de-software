@isTest
private class BillCycleListForCustomerResponseTest {

    @isTest
    static void testParse() {
        String json = '{'+
            '"billingCycles": {'+
                '"billingCycle": ['+
                    '{'+
                        '"customerBill": {'+
                            '"billDate": "2024-05-13"'+
                        '},'+
                        '"customerBillingCycleSpecification": {'+
                            '"id": "SPEC001",'+
                            '"description": "Monthly Billing Cycle"'+
                        '},'+
                        '"cycleInstance": {'+
                            '"parameterQuantity": "5"'+
                        '},'+
                        '"cycleCloseDate": {'+
                            '"billingDateShift": "2024-06-01"'+
                        '},'+
                        '"customerBillingCycle": {'+
                            '"id": "CYCLE001",'+
                            '"statusBillingCycle": "Active",'+
                            '"populationCode": "POP001",'+
                            '"frequency": "Monthly",'+
                            '"status": "Active"'+
                        '},'+
                        '"timePeriod": {'+
                            '"startDateTime": "2024-05-01",'+
                            '"endDateTime": "2024-05-31",'+
                            '"billingDateOffset": "5"'+
                        '}'+
                    '}'+
                '],'+
                '"parameter": {'+
                    '"parameter": "ParamValue",'+
                    '"parameterQuantity": "10"'+
                '},'+
                '"totalRowsCount": {'+
                    '"parameterQuantity": "20"'+
                '}'+
            '}'+
        '}';


        Test.startTest();
        RetrieveBillCycleListForCustomerResponse response = RetrieveBillCycleListForCustomerResponse.parse(json);
        

        // Asserts for BillingCycles
        System.assertEquals('ParamValue', response.billingCycles.parameter.parameter);
        System.assertEquals('10', response.billingCycles.parameter.parameterQuantity);
        System.assertEquals('20', response.billingCycles.totalRowsCount.parameterQuantity);

        // Asserts for BillingCycle
        RetrieveBillCycleListForCustomerResponse.BillingCycle billingCycle = response.billingCycles.billingCycle.get(0);
        System.assertEquals('2024-05-13', billingCycle.customerBill.billDate);
        System.assertEquals('SPEC001', billingCycle.customerBillingCycleSpecification.id);
        System.assertEquals('Monthly Billing Cycle', billingCycle.customerBillingCycleSpecification.description);
        System.assertEquals('5', billingCycle.cycleInstance.parameterQuantity);
        System.assertEquals('2024-06-01', billingCycle.cycleCloseDate.billingDateShift);

        // Asserts for CustomerBillingCycle
        System.assertEquals('CYCLE001', billingCycle.customerBillingCycle.id);
        System.assertEquals('Active', billingCycle.customerBillingCycle.statusBillingCycle);
        System.assertEquals('POP001', billingCycle.customerBillingCycle.populationCode);
        System.assertEquals('Monthly', billingCycle.customerBillingCycle.frequency);
        System.assertEquals('Active', billingCycle.customerBillingCycle.status);

        // Asserts for TimePeriod
        System.assertEquals('2024-05-01', billingCycle.timePeriod.startDateTime);
        System.assertEquals('2024-05-31', billingCycle.timePeriod.endDateTime);
        System.assertEquals('5', billingCycle.timePeriod.billingDateOffset);

        Test.stopTest();
    }
}