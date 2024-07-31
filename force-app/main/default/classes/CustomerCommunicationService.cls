public with sharing class CustomerCommunicationService {
    public static EmailMessagePayload buildEmailPaylod(
        Case caseRec, Account accountRec, Asset assetRec, Contact contactRec, String templateId) {
        EmailMessagePayload payload = new EmailMessagePayload();

        payload.emailSettings = new EmailMessagePayload.EmailSettingsWrapper();
        payload.emailSettings.templateId = templateId;
        payload.emailSettings.recipient = contactRec.Email;

        payload.characteristic = new List<EmailMessagePayload.CharacteristicWrapper>();
        addCharacteristic(payload.characteristic, 'firstName', accountRec.Name);
        addCharacteristic(payload.characteristic, 'protocolNumber', caseRec.Protocol__c);
        addCharacteristic(payload.characteristic, 'recordTypeName', caseRec.RecordType.Name);
        addCharacteristic(payload.characteristic, 'assetMainProductDescription', assetRec.MainProductDescription__c);

        return payload;
    }

    private static void addCharacteristic(
        List<EmailMessagePayload.CharacteristicWrapper> characteristics, String name, String value) {
        EmailMessagePayload.CharacteristicWrapper characteristic = new EmailMessagePayload.CharacteristicWrapper();
        characteristic.name = name;
        characteristic.value = value;
        characteristics.add(characteristic);
    }

    @future(callout=true)
    public static void sendEmailMessage(String payload) {
        String environmentName = Util.getEnvironmentName();
        CustomerCommunicationServiceIntegration customerCommunicationServiceIntegration =
            CustomerCommServiceIntegrationConfig.getService(environmentName);
        
        try {
            HttpResponse response = customerCommunicationServiceIntegration.sendEmailMessage(payload);
            Integer statusCode = response.getStatusCode();
            String status = response.getStatus();
            validadeStatusCode(response.getStatusCode());
            validadeStatus(status);
            System.debug(LoggingLevel.INFO, 'Envio de email.');
            System.debug(LoggingLevel.INFO, 'StatusCode: ' + statusCode);
            System.debug(LoggingLevel.INFO, 'Status: ' + status);
        } 
        catch (CustomerCommunicationException e) {
            System.debug(LoggingLevel.ERROR, e.getMessage());
        }
    }

    public static HttpResponse sendEmailMessage(EmailMessagePayload payload) {
        String environmentName = Util.getEnvironmentName();
        CustomerCommunicationServiceIntegration customerCommunicationServiceIntegration =
            CustomerCommServiceIntegrationConfig.getService(environmentName);
        String payloadSerialized = JSON.serialize(payload);
        HttpResponse response = customerCommunicationServiceIntegration.sendEmailMessage(payloadSerialized);
        return response;
    }

    public static void validadePayload(EmailMessagePayload payload) {
        if (payload != null && !String.isBlank(payload.emailSettings.templateId)
            && !String.isBlank(payload.emailSettings.recipient)) {
            return;
        }
        throw new CustomerCommunicationException('Payload não pode ser nulo.');
    }

    public static void validadeStatusCode(Integer statusCode) {
        if (statusCode == 200) {
            return;
        }
        throw new CustomerCommunicationException('Status code diferente de 200.');
    }

    public static void validadeStatus(String status) {
        if (status == 'OK') {
            return;
        }
        throw new CustomerCommunicationException('Status diferente de \'OK\'');
    }
}