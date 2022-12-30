public class CreditAnalysisResponse {

	public PerformAnalysisCreditResponse performAnalysisCreditResponse;

	public class Parameter {
		public String parameter;
	}

	public class PerformAnalysisCreditResponse {
		public CustomerCreditProfile customerCreditProfile;
		public Parameter parameter;
		public Result result;
		public Parameter legalRepresentativeAssignee;
	}

	public class CustomerCreditProfile {
		public String ID;
		public Integer creditScore;
	}

	public class Result {
		public Integer code;
		public String description;
	}

	
	public static CreditAnalysisResponse parse(String json) {
		return (CreditAnalysisResponse) System.JSON.deserialize(json, CreditAnalysisResponse.class);
	}
}