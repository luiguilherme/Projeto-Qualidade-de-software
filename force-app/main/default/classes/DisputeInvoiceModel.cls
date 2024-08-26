public class DisputeInvoiceModel {

    @AuraEnabled	
    public String period;
	@AuraEnabled
    public String financialAccountId;
	@AuraEnabled
    public String billingAccountId;
	@AuraEnabled
    public String amountCredits;
	@AuraEnabled
    public String totalAmount;
	@AuraEnabled
    public String l9CycleStartDate;
	@AuraEnabled
    public String status;
	@AuraEnabled
    public String referenceMonth;
	@AuraEnabled
    public String paymentProcessDate;
	@AuraEnabled
    public String paymentDueDate;
	@AuraEnabled
    public String paymentDate;
	@AuraEnabled
    public String originalPaymentDueDate;
	@AuraEnabled
    public String invoiceNumber;
	@AuraEnabled
    public String imageType;
	@AuraEnabled
    public String imageNo;
	@AuraEnabled
    public String l9CycleCloseDate;
	@AuraEnabled
    public String cycleCode;
	@AuraEnabled
    public String customerNo;
	@AuraEnabled
    public String closedBalance;
	@AuraEnabled
    public String billOrigin;
	@AuraEnabled
    public String billNo;
	@AuraEnabled
    public String billDate;
	@AuraEnabled
    public String barCode;
	@AuraEnabled
    public Decimal adjustedPaymentAmount;
	@AuraEnabled
    public Boolean adjusted;
    @AuraEnabled
	public String cycleReferenceDate;
    @AuraEnabled
    public Decimal paymentAmount;
    @AuraEnabled
    public Decimal balance;
    @AuraEnabled
    public String l9InvoiceCloseDate;
    @AuraEnabled
    public Decimal amount;
}