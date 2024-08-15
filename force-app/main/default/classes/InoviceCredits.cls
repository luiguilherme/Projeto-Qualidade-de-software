public class InoviceCredits {
	@AuraEnabled
    @InvocableVariable
    public String amount;
    @AuraEnabled
    @InvocableVariable
    public String balanceImpactCode;
    @AuraEnabled
    @InvocableVariable
    public String creditType;
    @AuraEnabled
    @InvocableVariable
    public String invoiceNumber;
    @AuraEnabled
    @InvocableVariable
    public String categoryCode;
    @AuraEnabled
    @InvocableVariable
    public String creditId;
    @AuraEnabled
    @InvocableVariable
    public String levelCode;
    @AuraEnabled
    @InvocableVariable
    public String noteExtract;
    @AuraEnabled
    @InvocableVariable
    public String reason;
    @AuraEnabled
    @InvocableVariable
    public String reasonDescription;
    @AuraEnabled
    @InvocableVariable
    public String invoiceId;
    @AuraEnabled
    @InvocableVariable
    public String l9BillingChargeSeqNo;
    @AuraEnabled
    @InvocableVariable
    public String l9ChargeInvoiceId;
    @AuraEnabled
    @InvocableVariable
    public String l9EventId;
    @AuraEnabled
    @InvocableVariable
    public String memoText;
    @AuraEnabled
    @InvocableVariable
    public String restrictedChargeId;
    @AuraEnabled
    @InvocableVariable
    public String reversalReason;
    @AuraEnabled
    @InvocableVariable
    public String restrictedInvoiceNumber;
    @AuraEnabled
    @InvocableVariable
    public String reversalTransId;
    @AuraEnabled
    @InvocableVariable
    public String transactionId;
    
    public InoviceCredits(String amount, String balanceImpactCode, String creditType, String invoiceNumber, String categoryCode,
        String creditId, String levelCode, String noteExtract, String reason, String reasonDescription, String invoiceId,
        String l9BillingChargeSeqNo, String l9ChargeInvoiceId, String l9EventId, String memoText, String restrictedChargeId,
        String reversalReason, String restrictedInvoiceNumber, String reversalTransId, String transactionId) {
        this.amount = amount;
        this.balanceImpactCode = balanceImpactCode;
        this.creditType = creditType;
        this.invoiceNumber = invoiceNumber;
        this.categoryCode = categoryCode;
        this.creditId = creditId;
        this.levelCode = levelCode;
        this.noteExtract = noteExtract;
        this.reason = reason;
        this.reasonDescription = reasonDescription;
        this.invoiceId = invoiceId;
        this.l9BillingChargeSeqNo = l9BillingChargeSeqNo;
        this.l9ChargeInvoiceId = l9ChargeInvoiceId;
        this.l9EventId = l9EventId;
        this.memoText = memoText;
        this.restrictedChargeId = restrictedChargeId;
        this.reversalReason = reversalReason;
        this.restrictedInvoiceNumber = restrictedInvoiceNumber;
        this.reversalTransId = reversalTransId;
        this.transactionId = transactionId;
    }
    
    public InoviceCredits() {
        
    }
}