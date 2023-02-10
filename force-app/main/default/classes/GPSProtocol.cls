global class GPSProtocol {

    @AuraEnabled
	public String protocol {get; set;}

    @AuraEnabled
	public String serviceExpectation {get; set;}

    @AuraEnabled
	public String ssStatus {get; set;}

    @AuraEnabled
	public String ssNumber {get; set;}

    @AuraEnabled
	public String routineResult {get; set;}

    @AuraEnabled
	public String errorDetail {get; set;}
}