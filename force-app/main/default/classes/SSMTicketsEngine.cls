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

    public static Map<String, Object> getPointOfServiceTitckets() {
        Map<String, Object> mapResponse = new Map<String, Object>();

        List<StoreServiceManagerTO.ServiceTicket> ltServiceTickets = new List<StoreServiceManagerTO.ServiceTicket>();
        
        User attendant = UserDAO.getById(UserInfo.getUserId());
        List<ServiceTicket__c> ltTickets = ServiceTicketDAO.getGSSOnHoldByStore(attendant.StoreCode__c);

        if (ltTickets != null && ltTickets.size() > 0) {
            String customerName;
            String customerAlias;
            String customerDocument;
            String geographicAreaCode;
            String networkNumber;
            Boolean customerSpecialNeeds;
            Integer customerPriority; 
            String segmentation;
            String segmentationName;
            String service;
            String serviceName;
            Integer activityPriority;
            String activity;
            String protocol;
            String customerCellPhone;
            String createdDateTime;
            String currentDateTime;
            String waitTime;

            for (ServiceTicket__c ticket : ltTickets) {
                StoreServiceManagerTO.ServiceTicket serviceTicket = new StoreServiceManagerTO.ServiceTicket();

                customerName = ((!String.isBlank(ticket.CustomerName__c)) ? ticket.CustomerName__c : '');
                customerAlias = ((!String.isBlank(ticket.Alias__c)) ? ticket.Alias__c : customerName);
                customerDocument = ((!String.isBlank(ticket.Document__c)) ? ticket.Document__c : '');
                geographicAreaCode = ((!String.isBlank(ticket.GeographicAreaCode__c)) ? ticket.GeographicAreaCode__c.replaceAll('[a-zA-Z .]{1,}|\\-', '') : '');
                networkNumber = ((!String.isBlank(ticket.NetworkNumber__c)) ? ticket.NetworkNumber__c.replaceAll('[a-zA-Z .]{1,}|\\-', '') : '');
                customerSpecialNeeds = ((ticket.SpecialNeeds__c != null) ? ticket.SpecialNeeds__c : false);
                customerPriority = ((ticket.Priority__c != null) ? Integer.valueOf(ticket.Priority__c) : 2);
                segmentation = ((!String.isBlank(ticket.SegmentID__c)) ? ticket.SegmentID__c : '');
                segmentationName = ((!String.isBlank(ticket.SegmentName__c)) ? ticket.SegmentName__c : '');
                service = ((!String.isBlank(ticket.InteractionID__c)) ? ticket.InteractionID__c : '');
                serviceName = ((!String.isBlank(ticket.InteractionName__c)) ? ticket.InteractionName__c : '');
                activityPriority = ((ticket.ActivityPriority__c != null) ? Integer.valueOf(ticket.ActivityPriority__c) : 1);
                activity = ((!String.isBlank(ticket.Activity__c)) ? ticket.Activity__c : '');
                protocol = ((!String.isBlank(ticket.Protocol__c)) ? ticket.Protocol__c : '');
                    
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

                createdDateTime = (DateTime.valueOf(ticket.CreatedDate)).formatGmt('YYYY-MM-dd HH:mm:ss');
                currentDateTime = (DateTime.now()).formatGmt('YYYY-MM-dd HH:mm:ss');
                waitTime = StoreServiceManagerService.calculateElapsedTime(createdDateTime, currentDateTime);
                    
                serviceTicket.Id = ticket.Id;
                serviceTicket.createdDateTime = createdDateTime;
                serviceTicket.type = '';
                serviceTicket.view = '';
                serviceTicket.store = ticket.Store__c;
                serviceTicket.workPositionId = '';
                serviceTicket.displayAlert = false;
                serviceTicket.ticketId = ticket.TicketId__c;
                serviceTicket.externalId = ticket.ExternalID__c;
                serviceTicket.customerSpecialNeeds = customerSpecialNeeds;
                serviceTicket.customerPriority = customerPriority;
                serviceTicket.customerInteractionId = '';
                serviceTicket.customerId = '';
                serviceTicket.customerName = customerName;
                serviceTicket.customerAlias = customerAlias;
                serviceTicket.customerDocument = customerDocument;
                serviceTicket.geographicAreaCode = geographicAreaCode;
                serviceTicket.networkNumber = networkNumber;
                serviceTicket.customerCellPhone = customerCellPhone;
                serviceTicket.segmentation = segmentation;
                serviceTicket.segmentationName = segmentationName;
                serviceTicket.activity = activity;
                serviceTicket.protocol = protocol;
                serviceTicket.waitTime = waitTime;
                serviceTicket.status = ticket.Status__c;
                serviceTicket.userLogin = '';
                serviceTicket.startTime = '';
                serviceTicket.finalTime = '';
                serviceTicket.duration = '';
                serviceTicket.service = service;
                serviceTicket.serviceName = serviceName;
                serviceTicket.activityPriority = activityPriority;
                serviceTicket.category = '';
                serviceTicket.categoryName = '';
                serviceTicket.mainDocumentType = '';
                serviceTicket.mainDocumentTypeName = '';
                serviceTicket.documentNumber = '';
                serviceTicket.giveUpReason = '';
                serviceTicket.activities = '';
                serviceTicket.notes = '';

                ltServiceTickets.add(serviceTicket);
            }
        }

        if (ltServiceTickets.size() > 0) {
            mapResponse.put('success', ltServiceTickets);

        } else {
            mapResponse.put('error', System.Label.StoreServiceManagerTicketsListIsEmpty);
        }

        return (mapResponse);
    }
}
