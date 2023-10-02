public with sharing class PIDTokenValidateService {

    public static vlocity_cmt__CustomerInteraction__c sendToken(Id customerIntId, String phoneNumber) {
        vlocity_cmt__CustomerInteraction__c thisCustomerInt = CustomerInteractionDAO.getCustomerInteractionById(customerIntId);

        try {
            Boolean wasSentSuccessfully = PIDTokenValidateEngine.postTokenValidate(thisCustomerInt.Id, phoneNumber);

            if(wasSentSuccessfully){
                PIDTokenValidateEngine.updateTokenStatus(thisCustomerInt, 'Aguardando validação');
                thisCustomerInt.TokenSendAttempts__c ++;
                thisCustomerInt.TokenFirstDateSend__c = thisCustomerInt.TokenFirstDateSend__c != null ? thisCustomerInt.TokenFirstDateSend__c : System.now();
        
            } else {
                PIDTokenValidateEngine.updateTokenStatus(thisCustomerInt, 'Falha no envio');
            }

            update(thisCustomerInt);
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

        if(PIDTokenValidateEngine.hasAccess()){
            vlocity_cmt__CustomerInteraction__c thisCustomerInt = CustomerInteractionDAO.getCustomerInteractionById(aRecordId);
            ServiceAuthorization__mdt pid = ServiceAuthorization__mdt.getInstance('PID');

            thisPIDTokenValidateDTO.accountId = thisCustomerInt.vlocity_cmt__AccountId__c;
            thisPIDTokenValidateDTO.attempts = Integer.valueOf(pid.Attempts__c);
            thisPIDTokenValidateDTO.interval = Integer.valueOf(pid.Interval__c);
            thisPIDTokenValidateDTO.tokenStatus = thisCustomerInt.TokenStatus__c	;
            thisPIDTokenValidateDTO.tokenSendAttempts = Integer.valueOf(thisCustomerInt.TokenSendAttempts__c);
            thisPIDTokenValidateDTO.hasAccess = true;
            thisPIDTokenValidateDTO.phone = PIDTokenValidateEngine.getPhoneNumber(thisCustomerInt.vlocity_cmt__AccountId__c);
            return thisPIDTokenValidateDTO;
        }

        thisPIDTokenValidateDTO.hasAccess = false;
        return thisPIDTokenValidateDTO;
    }
}