public class RetrieveBillCycleListForCustomerResponse {

	public class CustomerBillingCycle {
		@InvocableVariable
		public String id;
		@InvocableVariable
		public String statusBillingCycle;
		@InvocableVariable
		public String populationCode;
		@InvocableVariable
		public String frequency;
		@InvocableVariable
		public String status;
	}

	public class CustomerBillingCycleSpecification {
		@InvocableVariable
		public String id;
		@InvocableVariable
		public String description;
	}

	public class BillingCycle {
		@InvocableVariable
		public CustomerBill customerBill;
		@InvocableVariable
		public CustomerBillingCycleSpecification customerBillingCycleSpecification;
		@InvocableVariable
		public CycleInstance cycleInstance;
		@InvocableVariable
		public CycleCloseDate cycleCloseDate;
		@InvocableVariable
		public CustomerBillingCycle customerBillingCycle;
		@InvocableVariable
		public TimePeriod timePeriod;
	}

	@InvocableVariable
	public BillingCycles billingCycles;

	public class CycleInstance {
		@InvocableVariable
		public String parameterQuantity;
	}

	public class BillingCycles {
		@InvocableVariable
		public List<BillingCycle> billingCycle;
		@InvocableVariable
		public Parameter parameter;
		@InvocableVariable
		public CycleInstance totalRowsCount;
	}

	public class TimePeriod {
		@InvocableVariable
		public String startDateTime;
		@InvocableVariable
		public String endDateTime;
		@InvocableVariable
		public String billingDateOffset;
	}

	public class CustomerBill {
		@InvocableVariable
		public String billDate;
	}

	public class Parameter {
		@InvocableVariable
		public String parameter;
		@InvocableVariable
		public String parameterQuantity;
	}

	public class CycleCloseDate {
		@InvocableVariable
		public String billingDateShift;
	}

	
	public static RetrieveBillCycleListForCustomerResponse parse(String json) {
		return (RetrieveBillCycleListForCustomerResponse) System.JSON.deserialize(json, RetrieveBillCycleListForCustomerResponse.class);
	}
}