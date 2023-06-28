/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 28/03/2022
    @description - Class Engine for SSMTickets
    ---------------------------------------------------
*/
public with sharing class SSMTicketsEngine {
    private static final Integer GENERIC_ERROR_MESSAGE = 699;

    public static Map<String, Object> getPointOfServiceTitckets() {
        Map<String, Object> mapResponse = new Map<String, Object>();

        try {
            Map<String, Object> mapResponseCallout = PointOfServiceTicketsCallout.execute();

            List<StoreServiceManagerTO.ServiceTicket> ltServiceTickets;

            String customerName;
            String customerDocument;
            String geographicAreaCode;
            String networkNumber;
            String customerCellPhone;
            Boolean customerSpecialNeeds;
            Integer customerPriority;
            String segmentation;
            String segmentationName;
            String waitTime;
            String service;
            String serviceName;

            if (mapResponseCallout.get('success') != null) {
                String jsonResponse = (String) mapResponseCallout.get('success');

                List<StoreServiceManagerResponse.Ticket> ltTickets = (List<StoreServiceManagerResponse.Ticket>) 
                    JSON.deserialize(jsonResponse, List<StoreServiceManagerResponse.Ticket>.class);

                if (ltTickets != null && ltTickets.size() > 0) {
                    ltServiceTickets = new List<StoreServiceManagerTO.ServiceTicket>();

                    for (StoreServiceManagerResponse.Ticket ticket : ltTickets) {
                        StoreServiceManagerTO.ServiceTicket serviceTicket = new StoreServiceManagerTO.ServiceTicket();

                        customerName = ((ticket.customer != null && ticket.customer.name != null) ? ticket.customer.name : '');
                        customerDocument = ((ticket.customer != null && ticket.customer.individualIdentification != null && !String.isBlank(ticket.customer.individualIdentification.nationalIdentilyCardNr)) ? ticket.customer.individualIdentification.nationalIdentilyCardNr : '');
                        geographicAreaCode = ((ticket.geographicArea != null && ticket.geographicArea.code != null) ? ticket.geographicArea.code.replaceAll('[a-zA-Z .]{1,}|\\-', '') : '');
                        networkNumber = ((ticket.network != null && ticket.network.networkNumber != null) ? ticket.network.networkNumber.replaceAll('[a-zA-Z .]{1,}|\\-', '') : '');
                        customerSpecialNeeds = ((ticket.customer != null && ticket.customer.specialNeeds != null) ? ticket.customer.specialNeeds : false);
                        customerPriority = ((ticket.customer != null && ticket.customer.priority != null) ? ticket.customer.priority : 2);
                        segmentation = ((ticket.customer != null && ticket.customer.segment.id != null) ? ticket.customer.segment.id : '');
                        segmentationName = ((ticket.customer != null && ticket.customer.segment != null && ticket.customer.segment.name != null) ? ticket.customer.segment.name : '');
                        
                        try {
                            waitTime = ((ticket.duration != null && ticket.duration.amount != null) ? ticket.duration.amount.substring(11) : '');
                        
                        } catch (Exception e) {
                            waitTime = '';
                        }                        
                        
                        service = ((ticket.interaction != null && ticket.interaction.id != null) ? ticket.interaction.id : '');
                        serviceName = ((ticket.interaction != null && ticket.interaction.name != null) ? ticket.interaction.name : '');
                       
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
                        serviceTicket.customerSpecialNeeds = customerSpecialNeeds;
                        serviceTicket.customerPriority = customerPriority;
                        serviceTicket.customerId = '';
                        serviceTicket.customerName = customerName;
                        serviceTicket.customerAlias = customerName;
                        serviceTicket.customerDocument = customerDocument;
                        serviceTicket.customerCellPhone = customerCellPhone;
                        serviceTicket.segmentation = segmentation;
                        serviceTicket.segmentationName = segmentationName;
                        serviceTicket.activity = '';
                        serviceTicket.protocol = '';
                        serviceTicket.waitTime = waitTime;
                        serviceTicket.startTime = '';
                        serviceTicket.finalTime = '';
                        serviceTicket.duration = waitTime;
                        serviceTicket.service = service;
                        serviceTicket.serviceName = serviceName;
                        serviceTicket.category = '';
                        serviceTicket.categoryName = '';
                        serviceTicket.mainDocumentType = '';
                        serviceTicket.documentNumber = '';
                        serviceTicket.giveUpReason = '';
                        serviceTicket.activities = '';
                        serviceTicket.notes = '';

                        ltServiceTickets.add(serviceTicket);
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

        return (mapResponse);
    }
}
