global class BalanceLineController implements vlocity_cmt.VlocityOpenInterface2 {
    
    global Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionMap) {
        
        Boolean success = true;
        String errors;

        try {
            switch on methodName {
                when 'getSmallStepValue' {
                    getSmallStepValue(inputMap, outputMap); 
                }
                when 'parseTextAmountToNumber' {
                    parseTextAmountToNumber(inputMap, outputMap); 
                }
            }

        } catch(Exception e) {
            errors = e.getMessage(); 
            success = false;
        }

        outputMap.put('success', success);
        outputMap.put('error', errors);

        return success;

    }

    @testVisible
    private void getSmallStepValue(Map<String, Object> inpMap, Map<String, Object> outMap) {

        List<PartialRenewalSteps__c> stepLst = (List<PartialRenewalSteps__c>) JSON.deserialize(JSON.serialize(inpMap.get('steps')), List<PartialRenewalSteps__c>.class);
        Decimal smallStepValue = null;

        for (PartialRenewalSteps__c step : stepLst) {
            if (String.isNotBlank(step.Price__c)) {
                Decimal price = parseTextToNumber(step.Price__c);
                if (smallStepValue > price) {
                    smallStepValue = price;
                } else if (smallStepValue == null) {
                    smallStepValue = price;
                }
            }
        }

        outMap.put('result', smallStepValue);

    }

    @testVisible
    private void parseTextAmountToNumber(Map<String, Object> inpMap, Map<String, Object> outMap) {

        Decimal textToNumber = parseTextToNumber(String.valueOf(inpMap.get('textAmount')));
        outMap.put('result', textToNumber);

    }

    @testVisible
    private Decimal parseTextToNumber(String text) {
        return Decimal.valueOf(text.replace('R$', '').replace(',', '.').trim());
    }

    class BalanceLineWrapper {

        String abbreviatedUnit;
        Decimal availableBalance;
        
    }

}