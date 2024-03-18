/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 28/03/2022
    @description - Class Engine for SSMTickets

    @PTI3946-120 - 06/11/2023 - Márcio Las
    @description - Recuperação das Senhas de Atendimento | Salesforce x GSS
    ---------------------------------------------------
*/
public with sharing class SSMTicketsEngine {
    private static final Integer GENERIC_ERROR_MESSAGE = 699;
    private static final String CUSTOM_SETTING_NAME = 'SSMUseServiceTicketObject';
    
    public static Map<String, Object> getPointOfServiceTitckets() {
        
        Map<String, Object> mapResponse = new Map<String, Object>();

        List<StoreServiceManagerTO.ServiceTicket> ltServiceTickets = new List<StoreServiceManagerTO.ServiceTicket>();
        
        if(FeatureFlagEngine.applicationIsActive(CUSTOM_SETTING_NAME)){

            User attendant = UserDAO.getById(UserInfo.getUserId());
            List<ServiceTicket__c> ltTickets = ServiceTicketDAO.getGSSOnHoldByStore(attendant.StoreCode__c);

            if (ltTickets != null && ltTickets.size() > 0) {
                for (ServiceTicket__c ticket : ltTickets) {
                    ltServiceTickets.add(createTicket(null, ticket));
                }
            }

            if (ltServiceTickets.size() > 0) {
                mapResponse.put('success', ltServiceTickets);

            } else {
                mapResponse.put('error', System.Label.StoreServiceManagerTicketsListIsEmpty);
            }

        }else{
            try {
                Map<String, Object> mapResponseCallout = PointOfServiceTicketsCallout.execute();
    
                if (mapResponseCallout.get('success') != null) {
                    String jsonResponse = (String) mapResponseCallout.get('success');
    
                    List<StoreServiceManagerResponse.Ticket> ltTickets = (List<StoreServiceManagerResponse.Ticket>) 
                        JSON.deserialize(jsonResponse, List<StoreServiceManagerResponse.Ticket>.class);
    
                    if (ltTickets != null && ltTickets.size() > 0) {
                        ltServiceTickets = new List<StoreServiceManagerTO.ServiceTicket>();
    
                        for (StoreServiceManagerResponse.Ticket ticket : ltTickets) {
                            ltServiceTickets.add(createTicket(ticket, null));
                        }
                    }
                }
    
                if (ltServiceTickets != null) {
                    mapResponse.put('success', ltServiceTickets);
    
                } else {
                    mapResponse.put('error', mapResponseCallout.get('error'));
                }
    
            } catch (Exception e) {
                mapResponse.clear();
        
                mapResponse.put('error', GENERIC_ERROR_MESSAGE);
            }
        }
        

        return (mapResponse);
    }

    //Criar dois métodos um para cada tipo de objeto.
    private static StoreServiceManagerTO.ServiceTicket createTicket(StoreServiceManagerResponse.Ticket ticket, ServiceTicket__c objectTicket){
        StoreServiceManagerTO.ServiceTicket serviceTicket = new StoreServiceManagerTO.ServiceTicket();
        String customerCellPhone;
        String geographicAreaCode;
        String networkNumber;

        if(ticket != null){
            geographicAreaCode = ((ticket.geographicArea != null && ticket.geographicArea.code != null) ? ticket.geographicArea.code.replaceAll('[a-zA-Z .]{1,}|\\-', '') : '');
            networkNumber = ((ticket.network != null && ticket.network.networkNumber != null) ? ticket.network.networkNumber.replaceAll('[a-zA-Z .]{1,}|\\-', '') : '');

            try {
                customerCellPhone = (
                    geographicAreaCode + 
                    ((!String.isBlank(geographicAreaCode) && !String.isBlank(networkNumber)) 
                        ? ' ' + networkNumber.substring(0, 5) + '-' + networkNumber.substring(5)
                        : ''
                    ) 
                );

            } catch (Exception e) {
                customerCellPhone = '';
            }


            serviceTicket.type = '';
            serviceTicket.view = '';
            serviceTicket.workPositionId = '';
            serviceTicket.displayAlert = false;
            serviceTicket.ticketId = ticket.id;
            serviceTicket.customerSpecialNeeds = ((ticket.customer != null && ticket.customer.specialNeeds != null) ? ticket.customer.specialNeeds : false);
            serviceTicket.customerPriority  = ((ticket.customer != null && ticket.customer.priority != null) ? ticket.customer.priority : 2);
            serviceTicket.customerId = '';
            serviceTicket.customerName = ((ticket.customer != null && ticket.customer.name != null) ? ticket.customer.name : '');
            serviceTicket.customerAlias = serviceTicket.customerName;
            serviceTicket.customerDocument = ((ticket.customer != null && ticket.customer.individualIdentification != null && !String.isBlank(ticket.customer.individualIdentification.nationalIdentilyCardNr)) ? ticket.customer.individualIdentification.nationalIdentilyCardNr : '');
            serviceTicket.customerCellPhone = customerCellPhone;
            serviceTicket.segmentation = ((ticket.customer != null && ticket.customer.segment.id != null) ? ticket.customer.segment.id : '');
            serviceTicket.segmentationName = ((ticket.customer != null && ticket.customer.segment != null && ticket.customer.segment.name != null) ? ticket.customer.segment.name : '');
            serviceTicket.activity = '';
            serviceTicket.protocol = '';
            serviceTicket.startTime = '';
            serviceTicket.finalTime = '';
            serviceTicket.duration = '';
            serviceTicket.service = ((ticket.interaction != null && ticket.interaction.id != null) ? ticket.interaction.id : '');
            serviceTicket.serviceName = ((ticket.interaction != null && ticket.interaction.name != null) ? ticket.interaction.name : '');
            serviceTicket.category = '';
            serviceTicket.categoryName = '';
            serviceTicket.mainDocumentType = '';
            serviceTicket.documentNumber = '';
            serviceTicket.giveUpReason = '';
            serviceTicket.activities = '';
            serviceTicket.notes = '';

            try {
                serviceTicket.waitTime = ((ticket.duration != null && ticket.duration.amount != null) ? ticket.duration.amount.substring(11) : '');
            
            } catch (Exception e) {
                serviceTicket.waitTime = '';
            } 

        }else if(objectTicket != null){
            geographicAreaCode = ((!String.isBlank(objectTicket.GeographicAreaCode__c)) ? objectTicket.GeographicAreaCode__c.replaceAll('[a-zA-Z .]{1,}|\\-', '') : '');
            networkNumber = ((!String.isBlank(objectTicket.NetworkNumber__c)) ? objectTicket.NetworkNumber__c.replaceAll('[a-zA-Z .]{1,}|\\-', '') : '');

            try {
                customerCellPhone = (
                    geographicAreaCode + 
                    ((!String.isBlank(networkNumber)) 
                        ? (networkNumber.substring(0, 5) + '-' + networkNumber.substring(5))
                        : ''
                    )
                );

            } catch (Exception e) {
                customerCellPhone = '';
            }

            String createdDateTime = (DateTime.valueOf(objectTicket.CreatedDate)).formatGmt('YYYY-MM-dd HH:mm:ss');
            String currentDateTime = (DateTime.now()).formatGmt('YYYY-MM-dd HH:mm:ss');
            
            serviceTicket.waitTime = StoreServiceManagerService.calculateElapsedTime(createdDateTime, currentDateTime);
            
            serviceTicket.id = objectTicket.Id;
            serviceTicket.createdDateTime = createdDateTime;
            serviceTicket.type = '';
            serviceTicket.view = '';
            serviceTicket.store = objectTicket.Store__c;
            serviceTicket.workPositionId = '';
            serviceTicket.displayAlert = false;
            serviceTicket.ticketId = objectTicket.TicketId__c;
            serviceTicket.externalId = objectTicket.ExternalID__c;
            serviceTicket.customerSpecialNeeds = ((objectTicket.SpecialNeeds__c != null) ? objectTicket.SpecialNeeds__c : false);
            serviceTicket.customerPriority = ((objectTicket.Priority__c != null) ? Integer.valueOf(objectTicket.Priority__c) : 2);
            serviceTicket.customerInteractionId = '';
            serviceTicket.customerId = '';
            serviceTicket.customerName = ((!String.isBlank(objectTicket.CustomerName__c)) ? objectTicket.CustomerName__c : '');
            serviceTicket.customerAlias = ((!String.isBlank(objectTicket.Alias__c)) ? objectTicket.Alias__c : serviceTicket.customerName);
            serviceTicket.customerDocument = ((!String.isBlank(objectTicket.Document__c)) ? objectTicket.Document__c : '');
            serviceTicket.geographicAreaCode = geographicAreaCode;
            serviceTicket.networkNumber = networkNumber;
            serviceTicket.customerCellPhone = customerCellPhone;
            serviceTicket.segmentation = ((!String.isBlank(objectTicket.SegmentID__c)) ? objectTicket.SegmentID__c : '');
            serviceTicket.segmentationName = ((!String.isBlank(objectTicket.SegmentName__c)) ? objectTicket.SegmentName__c : '');
            serviceTicket.activity = ((!String.isBlank(objectTicket.Activity__c)) ? objectTicket.Activity__c : '');
            serviceTicket.protocol = ((!String.isBlank(objectTicket.Protocol__c)) ? objectTicket.Protocol__c : '');
            serviceTicket.status = objectTicket.Status__c;
            serviceTicket.userLogin = '';
            serviceTicket.startTime = '';
            serviceTicket.finalTime = '';
            serviceTicket.duration = '';
            serviceTicket.service = ((!String.isBlank(objectTicket.InteractionID__c)) ? objectTicket.InteractionID__c : '');
            serviceTicket.serviceName = ((!String.isBlank(objectTicket.InteractionName__c)) ? objectTicket.InteractionName__c : '');
            serviceTicket.activityPriority = ((objectTicket.ActivityPriority__c != null) ? Integer.valueOf(objectTicket.ActivityPriority__c) : 1);
            serviceTicket.category = '';
            serviceTicket.categoryName = '';
            serviceTicket.mainDocumentType = '';
            serviceTicket.mainDocumentTypeName = '';
            serviceTicket.documentNumber = '';
            serviceTicket.giveUpReason = '';
            serviceTicket.activities = '';
            serviceTicket.notes = '';
        }

        return serviceTicket;
    }
}