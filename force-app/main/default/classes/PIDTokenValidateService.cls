public with sharing class PIDTokenValidateService {
    public static vlocity_cmt__CustomerInteraction__c sendToken(Id customerIntId, String phoneNumber) {
        vlocity_cmt__CustomerInteraction__c thisCustomerInt = CustomerInteractionDAO.getCustomerInteractionById(customerIntId);

        try {
            Boolean wasSentSuccessfully = PIDTokenValidateEngine.postTokenValidate(thisCustomerInt.Id, phoneNumber);

            if (wasSentSuccessfully) {
                thisCustomerInt.TokenStatus__c = 'Aguardando validação';
                thisCustomerInt.TokenSendAttempts__c ++;
                thisCustomerInt.TokenFirstDateSend__c = thisCustomerInt.TokenFirstDateSend__c != null ? thisCustomerInt.TokenFirstDateSend__c : System.now();
                thisCustomerInt.TokenSendNumber__c = thisCustomerInt.TokenSendNumber__c != null ? thisCustomerInt.TokenSendNumber__c : Double.valueOf(phoneNumber);
            
            } else {
                thisCustomerInt.TokenStatus__c = 'Falha no envio';
            }
            
            PIDTokenValidateEngine.updatePalitagem(thisCustomerInt);
            
            update thisCustomerInt;

            return thisCustomerInt;
              
        } catch (Exception e) {
            System.debug(e.getMessage());

            return thisCustomerInt;
        }
    }

    public static void updateTokenStatus(String customerIntId, String tokenStatus) {
        PIDTokenValidateEngine.updateTokenStatus(customerIntId, tokenStatus);
    }

    public static PIDTokenValidateDTO getCustomerIntAPX(String aRecordId) {
        PIDTokenValidateDTO thisPIDTokenValidateDTO = new PIDTokenValidateDTO();

        thisPIDTokenValidateDTO.hasAccess = false;

        if (PIDTokenValidateEngine.hasAccess()) {
            vlocity_cmt__CustomerInteraction__c thisCustomerInt = CustomerInteractionDAO.getCustomerInteractionById(aRecordId);
            ServiceAuthorization__mdt pid = ServiceAuthorization__mdt.getInstance('PID');
            Map<String, Object> phoneNumbers = PIDTokenValidateEngine.getPhoneNumbers(thisCustomerInt.vlocity_cmt__AccountId__c);

            thisPIDTokenValidateDTO.accountId = thisCustomerInt.vlocity_cmt__AccountId__c;
            thisPIDTokenValidateDTO.attempts = Integer.valueOf(pid.Attempts__c);
            thisPIDTokenValidateDTO.interval = Integer.valueOf(pid.Interval__c);
            thisPIDTokenValidateDTO.tokenStatus = thisCustomerInt.TokenStatus__c	;
            thisPIDTokenValidateDTO.tokenSendAttempts = Integer.valueOf(thisCustomerInt.TokenSendAttempts__c);
            thisPIDTokenValidateDTO.hasAccess = true;
            thisPIDTokenValidateDTO.phone = (String) phoneNumbers.get('phone');
            thisPIDTokenValidateDTO.phones = (List<String>) phoneNumbers.get('phones');
            thisPIDTokenValidateDTO.sendedPhone = String.valueOf(thisCustomerInt.TokenSendNumber__c);
        }

        return (thisPIDTokenValidateDTO);
    }
}