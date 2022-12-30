public class TicketServiceReturn {

	public List<TicketResponse> tickets {get; set;}
    
    public class TicketResponse {
		public String ticket_id {get; set;}
		public String start_date {get; set;}
		public String end_date {get; set;}
		public String status {get; set;}
		public String reason {get; set;}
	}
}