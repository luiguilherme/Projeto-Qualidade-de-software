public with sharing class StoreServiceManagerRequest {
    public static StoreServiceManagerResponse.WorkPosition getUpdateWorkPositionRequest(String attendantId, String workPositionId, Boolean startService) {
        StoreServiceManagerResponse.WorkPosition request = new StoreServiceManagerResponse.WorkPosition();

        request.id = workPositionId;
        request.status = 'Empty';
        request.queue = 'MS';

        request.attendant = new StoreServiceManagerResponse.SalesAgent();

        request.attendant.id = attendantId;
        request.attendant.status = ((startService) ? 'Alocado' : 'Desalocado');

        request.attendant.pauseReason = new StoreServiceManagerResponse.RootEntity();

        request.attendant.pauseReason.id = '';
        request.attendant.pauseReason.description = '';
        request.attendant.pauseReason.name = '';
        request.attendant.pauseReason.type = '';

        return (request);
    }

    public static StoreServiceManagerResponse.SalesAgent getUpdatePauseAttendantRequest(String attendantId, StoreServiceManagerTO.ItemPicklistValue pauseReason) {
        StoreServiceManagerResponse.SalesAgent request = new StoreServiceManagerResponse.SalesAgent();

        request.id = attendantId;
        request.status = 'Alocado';

        StoreServiceManagerResponse.RootEntity rtPauseReason = new StoreServiceManagerResponse.RootEntity();

        if (pauseReason != null) {
            rtPauseReason.id = pauseReason.value;
            rtPauseReason.name = pauseReason.label;
            rtPauseReason.description = ((pauseReason.instruction != null) ? pauseReason.instruction : '');
            rtPauseReason.type = '';

            if (!String.isBlank(rtPauseReason.description) && rtPauseReason.description == '1') {
                request.status = 'Desalocado';
            }

        } else {
            rtPauseReason.id = '';
            rtPauseReason.name = '';
            rtPauseReason.description = '';
            rtPauseReason.type = '';
        }

        request.pauseReason = rtPauseReason;

        return (request);
    }

    public static StoreServiceManagerResponse.Ticket getGenerateTicketRequest(String attendantId, String scheduleTime, String cellPhone) {
        StoreServiceManagerResponse.Ticket request = new StoreServiceManagerResponse.Ticket();
        
        request.id = null;

        request.customer = new StoreServiceManagerResponse.Customer();

        request.customer.name = '';
        request.customer.specialNeeds = false;
        request.customer.priority = 2;

        request.customer.segment = new StoreServiceManagerResponse.RootEntity();

        request.customer.segment.id = '';
        request.customer.segment.name = '';
        request.customer.segment.description = '';
        request.customer.segment.type = '';

        request.createBy = attendantId;
        request.createAt = scheduleTime;

        request.geographicArea = new StoreServiceManagerResponse.GeographicArea();

        request.geographicArea.code = cellPhone.substring(0, 2);

        request.network = new StoreServiceManagerResponse.Network();

        request.network.networkNumber = cellPhone.substring(2);

        request.duration = new StoreServiceManagerResponse.Duration();

        request.duration.amount = '';

        return (request);
    }

    public static StoreServiceManagerResponse.Attendance getStartAttendanceRequest(StoreServiceManagerTO.ServiceTicket serviceTicket) {
        StoreServiceManagerResponse.Attendance request = new StoreServiceManagerResponse.Attendance();
     
        request.ticket = new StoreServiceManagerResponse.Ticket();

        request.ticket.id = serviceTicket.ticketId;

        request.ticket.customer = new StoreServiceManagerResponse.Customer();

        request.ticket.customer.name = '';
        request.ticket.customer.specialNeeds = false;
        request.ticket.customer.priority = 2;

        request.ticket.customer.segment = new StoreServiceManagerResponse.RootEntity();

        request.ticket.customer.segment.id = '';
        request.ticket.customer.segment.name = '';
        request.ticket.customer.segment.description = '';
        request.ticket.customer.segment.type = '';

        request.ticket.createBy = '';
        request.ticket.createAt = '';

        request.ticket.geographicArea = new StoreServiceManagerResponse.GeographicArea();

        request.ticket.geographicArea.code ='';

        request.ticket.network = new StoreServiceManagerResponse.Network();

        request.ticket.network.networkNumber = '';

        request.ticket.duration = new StoreServiceManagerResponse.Duration();

        request.ticket.duration.amount = '';

        request.workPosition = new StoreServiceManagerResponse.WorkPosition();
                
        request.workPosition.id = serviceTicket.workPositionId;
        request.workPosition.status = '';
        request.workPosition.queue = '';

        request.workPosition.attendant = new StoreServiceManagerResponse.SalesAgent();

        request.workPosition.attendant.id = '';
        request.workPosition.attendant.status = '';

        request.workPosition.attendant.pauseReason = new StoreServiceManagerResponse.RootEntity();

        request.workPosition.attendant.pauseReason.id = '';
        request.workPosition.attendant.pauseReason.name = '';
        request.workPosition.attendant.pauseReason.description = '';
        request.workPosition.attendant.pauseReason.type = '';

        request.displayAlert = serviceTicket.displayAlert;
        request.status = 'Open';

        return (request);
    }
    
    public static StoreServiceManagerResponse.Attendance getEndAttendanceRequest(String attendantId, StoreServiceManagerTO.ServiceTicket serviceTicket, String status) {
        StoreServiceManagerResponse.Attendance request = new StoreServiceManagerResponse.Attendance();

        List<StoreServiceManagerResponse.Interaction> ltInteractions = new List<StoreServiceManagerResponse.Interaction>();

        String notes = '';

        StoreServiceManagerResponse.RootEntity businessLine = new StoreServiceManagerResponse.RootEntity();
            
        businessLine.id = serviceTicket.category;
        businessLine.description = '';
        businessLine.name = serviceTicket.categoryName;
        businessLine.type = '';

        if (status == 'Canceled') {
            StoreServiceManagerTO.ItemPicklistValue giveUpReason = (StoreServiceManagerTO.ItemPicklistValue)
                JSON.deserialize(serviceTicket.giveUpReason, StoreServiceManagerTO.ItemPicklistValue.class);

            StoreServiceManagerResponse.Interaction interaction = new StoreServiceManagerResponse.Interaction();

            interaction.id = giveUpReason.name;
            interaction.name = giveUpReason.label;
            interaction.businessLine = businessLine;

            ltInteractions.add(interaction);

        } else if (status == 'Closed') {
            List<StoreServiceManagerTO.ItemPicklistValue> ltActivities = (List<StoreServiceManagerTO.ItemPicklistValue>)
                JSON.deserialize(serviceTicket.activities, List<StoreServiceManagerTO.ItemPicklistValue>.class);
            
            for (StoreServiceManagerTO.ItemPicklistValue activity : ltActivities) {
                StoreServiceManagerResponse.Interaction interaction = new StoreServiceManagerResponse.Interaction();

                interaction.id = activity.value;
                interaction.name = activity.label;
                interaction.businessLine = businessLine;

                ltInteractions.add(interaction);
            }

            notes = serviceTicket.notes;

        } else {
            StoreServiceManagerResponse.Interaction interaction = new StoreServiceManagerResponse.Interaction();

            interaction.id = '';
            interaction.name = '';
            interaction.businessLine = businessLine;

            ltInteractions.add(interaction);
        }

        StoreServiceManagerResponse.SalesAgent attendant = new StoreServiceManagerResponse.SalesAgent();

        attendant.id = attendantId;
        attendant.status = 'Alocado';

        StoreServiceManagerResponse.WorkPosition workPosition = new StoreServiceManagerResponse.WorkPosition();

        workPosition.id = serviceTicket.workPositionId;
        workPosition.status = 'Empty';
        workPosition.queue = 'MS';
        workPosition.attendant = attendant;

        request.workPosition = workPosition;
        request.ticket = getTicketFromServiceTicket(attendantId, serviceTicket);
        request.interactions = ltInteractions;
        request.notes = notes;
        request.status = status;
        request.displayAlert = serviceTicket.displayAlert;

        return (request);
    }

    private static StoreServiceManagerResponse.Ticket getTicketFromServiceTicket(String attendantId, StoreServiceManagerTO.ServiceTicket serviceTicket) {
        StoreServiceManagerResponse.RootEntity segment = new StoreServiceManagerResponse.RootEntity();

        segment.id = '';
        segment.name = '';
        segment.description = '';
        segment.type = '';

        if (!String.isBlank(serviceTicket.segmentation)) {
            segment.id = serviceTicket.segmentation;
            segment.name = serviceTicket.segmentationName;
        }

        StoreServiceManagerResponse.IndividualIdentification identification = new StoreServiceManagerResponse.IndividualIdentification();
        
        identification.documentType = '';
        identification.nationalIdentilyCardNr = '';

        if (!String.isBlank(serviceTicket.mainDocumentType)) {
            identification.documentType = serviceTicket.mainDocumentType;
        }
        
        if (!String.isBlank(serviceTicket.documentNumber)) {
            identification.nationalIdentilyCardNr = serviceTicket.documentNumber.replaceAll('[a-zA-Z .]{1,}|\\-', '');
        }

        StoreServiceManagerResponse.Customer customer = new StoreServiceManagerResponse.Customer();

        customer.individualIdentification = identification;
        customer.name = serviceTicket.customerName;
        customer.segment = segment;
        customer.specialNeeds = serviceTicket.customerSpecialNeeds;
        customer.priority = serviceTicket.customerPriority;

        String customerCellPhone = serviceTicket.customerCellPhone.replaceAll('[a-zA-Z .]{1,}|\\-', '');
        
        StoreServiceManagerResponse.GeographicArea geographicArea = new StoreServiceManagerResponse.GeographicArea();
       
        geographicArea.code = ((String.isBlank(customerCellPhone) || customerCellPhone.length() < 2) 
            ? '' 
            : customerCellPhone.substring(0, 2)
        );

        StoreServiceManagerResponse.Network network = new StoreServiceManagerResponse.Network();

        network.networkNumber = ((String.isBlank(customerCellPhone) || customerCellPhone.length() < 10)
            ? ''
            : customerCellPhone.substring(2)
        );

        StoreServiceManagerResponse.RootEntity businessLine = new StoreServiceManagerResponse.RootEntity();
                
        businessLine.name = serviceTicket.categoryName;

        StoreServiceManagerResponse.Interaction interaction = new StoreServiceManagerResponse.Interaction();

        interaction.id = serviceTicket.service;
        interaction.name = serviceTicket.serviceName;
        interaction.businessLine = businessLine;

        StoreServiceManagerResponse.Ticket ticket = new  StoreServiceManagerResponse.Ticket();

        ticket.id = serviceTicket.ticketId;
        ticket.customer = customer;
        ticket.createBy = attendantId;
        ticket.createAt = ((DateTime.now()).format('HH:mm:ss'));

        StoreServiceManagerResponse.Duration duration = new StoreServiceManagerResponse.Duration();
        
        serviceTicket.finalTime = (DateTime.now()).format('dd/MM/YYYY HH:mm:ss');
        
        duration.amount = calculateElapsedTime(serviceTicket.startTime, serviceTicket.finalTime);

        ticket.duration = duration;
        ticket.geographicArea = geographicArea;
        ticket.network = network;
        ticket.interaction = interaction;

        return (ticket);
    }

    public static String calculateElapsedTime(String startTime, String finalTime) {
        String elapsedTime = '00:00:00';
 
        try {
            if (!String.isBlank(startTime) && !String.isBlank(finalTime) && !startTime.equals(finalTime)) {
                // Start date/time
                String[] ltStartTime = ((startTime.contains(' '))
                                        ? startTime.split(' ')[1].split(':')
                                        : startTime.split(':')
                                    );
                
                DateTime dtStartTime = Datetime.newInstanceGmt(
                    Datetime.now().year(), 
                    Datetime.now().month(), 
                    Datetime.now().day(), 
                    Integer.valueOf(ltStartTime[0]), 
                    Integer.valueOf(ltStartTime[1]), 
                    Integer.valueOf(ltStartTime[2])
                );
                
                // Final date/time
                String[] ltFinalTime = ((finalTime.contains(' '))
                                        ? finalTime.split(' ')[1].split(':')
                                        : finalTime.split(':')
                                    );
                
                DateTime dtFinalTime = Datetime.newInstanceGmt(
                    Datetime.now().year(), 
                    Datetime.now().month(), 
                    Datetime.now().day(), 
                    Integer.valueOf(ltFinalTime[0]), 
                    Integer.valueOf(ltFinalTime[1]), 
                    Integer.valueOf(ltFinalTime[2])
                );
                
                // Calculate elapsed time
                Double milliseconds = Math.abs(dtFinalTime.getTime() - dtStartTime.getTime());
                
                Integer seconds = Integer.valueOf(Math.floor(milliseconds / 1000));
                Integer minutes = Integer.valueOf(Math.floor(seconds / 60));
                Integer hours = Integer.valueOf(Math.floor(minutes / 60));
                
                seconds = Math.mod(seconds, 60);
                minutes = Math.mod(((seconds >= 30) ? minutes + 1 : minutes), 60);
                hours = Math.mod(hours, 24);
                
                elapsedTime = (
                    String.valueOf(hours).leftPad(2, '0') + ':' +
                    String.valueOf(minutes).leftPad(2, '0') + ':' +
                    String.valueOf(seconds).leftPad(2, '0').substring(0, 2)
                );
            }

        } catch (Exception e) {

        }

        return (elapsedTime);
    }
}
