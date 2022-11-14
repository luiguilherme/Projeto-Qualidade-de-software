/*
* @author Diego Costa @ Deloitte
* @date 06/06/2022
* @description - classe InvoiceHistoryTO
*/
public with sharing class InvoiceHistoryTO {
  
    public class InformationMessageTO{
        @AuraEnabled
        public Decimal FixedAverage { get; set; }
        @AuraEnabled
        public Decimal MovingAverage { get; set;}
        @AuraEnabled
        public List<String> lstMessage { get; set;}
    }
}