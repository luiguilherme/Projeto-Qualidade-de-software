// {
//     "availableAmount": "14.9900",
//     "chargeCategory": "VAS",
//     "code": "UWEMPFACIVFVASF",
//     "codeDescription": "GUIA EMPRESA FACIL",
//     "csp": "0",
//     "endDate": "2222-01-01 19:00:00",
//     "frontEndCode": "2462069",
//     "id": "136508165021000013",
//     "startDate": "1960-01-01 19:50:00",
//     "startTime": "24/04/2024",
//     "totalAmount": "14.9900",
//     "instance": "4130060851",
//     "subscriberId": "51261965",
//     "name": "Listas",
//     "bundleId": "",
//     "comboIndicator": "",
//     "cspOperatorName": "",
//     "discount": "0",
//     "offerId": "0",
//     "offerType": "",
//     "type": "",
//     "ChargeCategory": "VAS"
//   }
public class DisputeChargeModel{
    @AuraEnabled
    public String type;

    @AuraEnabled
	public Decimal totalAmount;

    @AuraEnabled
    public String subscriberId;
    
    @AuraEnabled
    public String startDate;

    @AuraEnabled
    public String offerType;

    @AuraEnabled
    public String offerId;

    @AuraEnabled
    public String name;

    @AuraEnabled
    public String id;

    @AuraEnabled
    public String frontEndCode;

    @AuraEnabled
    public String endDate;

    @AuraEnabled
    public Boolean comboIndicator;

    @AuraEnabled
    public String codeDescription;

    @AuraEnabled
    public String code;

    @AuraEnabled
    public String bundleId;

    @AuraEnabled
    public Decimal availableAmount;

    @AuraEnabled
    public Decimal discount;

    @AuraEnabled
    public String ChargeCategory;
    
    @AuraEnabled
    public String instance;
    
    @AuraEnabled
    public String csp;
    
    @AuraEnabled
    public String cspOperatorName;
    
    @AuraEnabled
    public String startTime;

    @AuraEnabled
    public Boolean haveDiscount;

    @AuraEnabled
    public String customerAccountId;
}