/*
    ---------------------------------------------------
    @author - Márcio Las
    @company - Telefonica  
    @date - 17/03/2022
    @description - Class "Response" for StoreServiceManager
    ---------------------------------------------------
*/
public with sharing class StoreServiceManagerResponse {
    public class RootEntity {
        public String id {get; set;}
        public String description {get; set;}
        public String name {get; set;}
        public String type {get; set;}
    }

    public class SalesAgent {
        public String id {get; set;}
        public String status {get; set;}
        public RootEntity pauseReason {get; set;}
    }

    public class WorkPosition {
        public String id {get; set;}
        public String status {get; set;}
        public String queue {get; set;}
        public SalesAgent attendant {get; set;}
    }
    
    public class IndividualIdentification {
        public String nationalIdentilyCardNr {get; set;}
        public String documentType	{get; set;}
    }

    public class Customer {
        public IndividualIdentification individualIdentification {get; set;}
        public String name {get; set;}
        public RootEntity segment {get; set;}
        public Boolean specialNeeds {get; set;}
        public Integer priority {get; set;}
    }
    
    public class Duration {
        public String amount {get; set;}
    }

    public class GeographicArea {
        public String code {get; set;}
    }

    public class Network {
        public String networkNumber {get; set;}
    }

    public class Interaction {
        public String id {get; set;}
        public String name {get; set;}
        public RootEntity businessLine {get; set;}
    }
    
    public class Ticket {
        public String id {get; set;}
        public Customer customer {get; set;}
        public String createBy {get; set;}
        public String createAt {get; set;}
        public Duration duration {get; set;}
        public GeographicArea geographicArea {get; set;}
        public Network network {get; set;}
        public Interaction interaction {get; set;}
    }

    public class Tickets {
        public List<Ticket> tickets {get; set;}
    }    

    public class Attendance {
        public Ticket ticket {get; set;}
        public WorkPosition workPosition {get; set;}
        public List<Interaction> interactions {get; set;}
        public Boolean displayAlert {get; set;}
        public String status {get; set;}
        public String notes {get; set;}
    }

    public class OperationalInformations {
        public List<RootEntity> attendantPauseOptions {get; set;}
        public List<RootEntity> businessLines {get; set;}
        public List<RootEntity> quittingReasons {get; set;}
        public List<Interaction> interactions {get; set;}
    }

    public class PointOfService {
        public Integer id {get; set;}
        public String name {get; set;}
        public RootEntity segment {get; set;}
        public SalesAgent attendant  {get; set;}
        public List<WorkPosition> workPosition {get; set;}
    }

    public class RootError {
        public String domain {get; set;}
        public String reason {get; set;}
        public String message {get; set;}
    }

    public class IntegrationError {
        public String code {get; set;}
        public String message {get; set;}
        public List<RootError> errors {get; set;}
    }
}
