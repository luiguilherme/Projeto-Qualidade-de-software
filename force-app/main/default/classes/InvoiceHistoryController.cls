/*
* @description - Classe Controller do componente de Fatura, buscando as informações de Fatura na 4P
*/
public without sharing class InvoiceHistoryController {
    private static final String WEBSERVICE_NAME = 'FourthPlataformInvoiceCallout';

    @AuraEnabled
    public static Boolean validateUserIdInformation(String customerInteractionId){
        
        Id accountId = getAccountIdFromCustomerInteraction(customerInteractionId);        
        Account accountObj = AccountDAO.getByIds(accountId);        
        
        return (accountObj != null && accountObj.UserId__c != null);
    }
    
    @AuraEnabled
    public static Boolean getInvoiceHistory(String accountId){
        
        WebService__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);
        
        integer refreshTime = InvoiceHistoryController.getValidateTime(wsConfig) *-1;
        Datetime searchInvoiceDate = system.now().addSeconds(refreshTime);
        
        List<Invoice__c> ltInvoiceHistory = new List<Invoice__c>();
        ltInvoiceHistory = InvoiceHistoryDAO.getInvoiceByAccountId(accountId,searchInvoiceDate);
        if(ltInvoiceHistory.isEmpty()){
            return false;            
        } else {
            return true;           
        }        
    }
    
    @AuraEnabled
    public static List<Asset> createInvoiceHistory(Id customerInteractionId) {
        Id accountId = getAccountIdFromCustomerInteraction(customerInteractionId);
        
        List<Asset> ltAssetObj = new List<Asset>();
        Webservice__c wsConfig = Webservice__c.getInstance(WEBSERVICE_NAME);
        
        if (wsConfig == null) {            
            return ltAssetObj; 
        }
        
        List<Invoice__c> ltInvoiceHistory = new List<Invoice__c>();
        List<InvoiceItem__c> ltInvoiceItem = new List<InvoiceItem__c>();
        List<GeneralParam__c> lstGeneralParams = new List<GeneralParam__c>();
        lstGeneralParams = GeneralParamDAO.getLoadParams();  
        
        String UserId;
                
        List<Account> ltAccount = new List<Account>([SELECT UserId__c, RecordTypeId FROM Account WHERE ID =: accountId]);	
                
        UserId = ltAccount[0].UserId__c; 
                
        Integer searchRange = Integer.valueOf(lstGeneralParams[0].SearchRangeInvoice__c) *-1;
        
        Date startDate = System.Today().addDays(searchRange);
        Date endDate = System.Today();
        
        String parameters = '/'+ UserId + '/invoices?start_date=' + String.valueOf(startDate) +('T00:00:00Z') + '&end_date=' + String.valueOf(endDate) +('T23:59:59Z') ;
        String endpoint = wsConfig.Endpoint__c + parameters;
        
        HttpClient client = new HttpClient();
        HttpResponse response = client.get(wsConfig, endpoint);
        ServiceResponse invoiceResponse = new ServiceResponse();
        
        List<InvoiceServiceReturn> lstInvoiceReturn = new List<InvoiceServiceReturn>();
        
        if (response.getStatusCode()/100 == 2) {
            String result = response.getBody();
            invoiceResponse.body = result;
            invoiceResponse.success = true;
        } else {
            invoiceResponse.success = false;
        }

        if (invoiceResponse.success) {
            lstInvoiceReturn = (List<InvoiceServiceReturn>) Json.deserialize(invoiceResponse.body, List<InvoiceServiceReturn>.class);
        } 
        
        String sStartDate;
        String sEndDate;
        String sCreateDate;
        String sDueDate;
        String sPaymentDate;
        String sNextInvoiceDate;                
        String sStartDateItem;
        String sEndDateItem; 

        String month;
        string year;
        integer dtmonth;
        integer dtyear;
        
        if(lstInvoiceReturn.isEmpty()){
            return ltAssetObj;
        }

        map<String, String> mapProductsForBillingAccount = new Map<String, String>();
               
        for(InvoiceServiceReturn result : lstInvoiceReturn){
            
            Invoice__c invoiceHistory = new Invoice__c();
            
            invoiceHistory.InvoiceId__c = result.id;
            invoiceHistory.AccountId__c = accountId;  
            if(result.due_date != null && result.due_date.contains('T')){
                sEndDate = result.due_date.replaceAll('T',' ');
                dtmonth = Date.valueOf(sEndDate).month();
                dtyear = Date.valueOf(sEndDate).year();
                year = String.valueOf(dtyear);
            
            } else {
                sEndDate = '';
                dtmonth = null;
                dtyear = null;
                year = '';
            }

            Switch on dtmonth {
                when 01 {
                    month = 'Janeiro';
                }
                when 02{
                    month = 'Fevereiro';
                }
                when 03 {
                    month = 'Março';
                }
                when 04 {
                    month = 'Abril';
                }
                when 05 {
                    month = 'Maio';
                }
                when 06 {
                    month = 'Junho';
                }
                when 07 {
                    month = 'Julho';
                }
                when 08 {
                    month = 'Agosto';
                }
                when 09 {
                    month = 'Setembro';
                }
                when 10 {
                    month = 'Outubro';
                }
                when 11 {
                    month = 'Novembro';
                }
                when 12 {
                    month = 'Dezembro';
                }
                when else {
                    month = '';
                }
            }

            if (!String.isBlank(month)) {
                invoiceHistory.Name = month +'/'+ year;

            } else {
                invoiceHistory.Name = 'Indefinido';
            }
            
            invoiceHistory.CreationDate__c      = getFormatedDate(result.creation_date);
            invoiceHistory.StartDate__c         = getFormatedDate(result.start_date);
            invoiceHistory.EndDate__c           = getFormatedDate(result.end_date);
            invoiceHistory.DueDate__c           = getFormatedDate(result.due_date);
            invoiceHistory.PaymentDate__c       = getFormatedDate(result.payment_date);
            invoiceHistory.NextInvoiceDate__c   = getFormatedDate(result.next_invoice_date);
            
            invoiceHistory.TotalAmount__c = decimal.valueOf(result.Total_amount.value);   
            invoiceHistory.TaxInclude__c = result.Total_amount.tax_included;
            invoiceHistory.PaymentStatus__c = result.payment_status;
            invoiceHistory.Downloadurl__c = result.download_url;

            if (result.secondary_download_urls != null && !result.secondary_download_urls.isEmpty()) {
                invoiceHistory.SecondaryDownloadUrl__c = result.secondary_download_urls[0].url;
                invoiceHistory.InvoiceContestedStatus__c = true;
            }
            
            ltInvoiceHistory.add(invoiceHistory);

            for(String identifier : result.identifiers){
                identifier = identifier.contains('+55') ? identifier.substring(3, identifier.length()) : identifier; 
            }

            mapProductsForBillingAccount.put(String.join(result.identifiers,','), result.account_id);
        }
        
        ltAssetObj = AssetDAO.getByAccountId(accountId);
                
        List<Account> billingAccounts = new List<Account>();
        Set<String> validateName = new Set<String>();
        
        for(Asset assetObj : ltAssetObj){

            for(String keyValue : mapProductsForBillingAccount.keySet()){

                if(keyValue.contains(assetObj.Name)){
                    String billingAccount = mapProductsForBillingAccount.get(keyValue);

                    if(validateName.contains(billingAccount)){
                        continue;
                    }

                    billingAccounts.add(createBillingAccount(
                        billingAccount,
                        'Billing',
                        accountId
                    ));                   

                    validateName.add(billingAccount);
                }
            }
        }

        Map<String,Id> mapIdBillingAccountForName = new Map<String,Id>();
        
        for(Account billingAccountObj : billingAccounts){
            mapIdBillingAccountForName.put(billingAccountObj.Name, billingAccountObj.Id);
        }

        for(Asset assetObj : ltAssetObj){

            for(String keyValue : mapProductsForBillingAccount.keySet()){

                if(keyValue.contains(assetObj.Name)){
                    String name = mapProductsForBillingAccount.get(keyValue);                    
                    assetObj.Name = mapIdBillingAccountForName.get(name);
                }
            }
        }
        
        if(ltInvoiceHistory.size() > 0){
            upsert ltInvoiceHistory InvoiceId__c;
            
            Map<String, Id> mapInvoiceExternalId = new Map<String, Id>();
            
            for(Invoice__c item : ltInvoiceHistory){
                mapInvoiceExternalId.put(item.InvoiceId__c, item.Id);
            }
            
            List<InvoiceItem__c> ltInvoiceItemDelete = new List<InvoiceItem__c>([SELECT Id FROM InvoiceItem__c WHERE Invoice__c IN :mapInvoiceExternalId.values()]);
            
            if(ltInvoiceItemDelete.size() > 0){
                delete ltInvoiceItemDelete;
            }

            for(InvoiceServiceReturn result : lstInvoiceReturn){
                if(mapInvoiceExternalId.containsKey(result.id)){
                    for(InvoiceServiceReturn.billed_items_summary item : result.billed_items_summary){
                        if ((item.parent_id =='1000' || item.parent_id =='-1000') &&
                            (item.description.contains('TV') || item.description.contains('Fixo') || 
                                item.description.contains('Internet') || item.description.contains('Celular')))
                        { 
                            InvoiceItem__c invoiceItemSumary = new InvoiceItem__c();
                            invoiceItemSumary.Invoice__c = mapInvoiceExternalId.get(result.id); //invoiceHistory.id;                                            
                            invoiceItemSumary.ParentId__c = item.parent_id;                            
                            invoiceItemSumary.Value__c = item.amount.value;
                            invoiceItemSumary.TaxInclude__c = item.amount.tax_included;
                            
                            if(item.description.contains('Fixo')){
                                invoiceItemSumary.Type__c = 'Fixa';
                            } else{
                                invoiceItemSumary.Type__c = item.description;
                            }                                
                            
                            invoiceItemSumary.StartDate__c  = getFormatedDate(item.start_date);
                            invoiceItemSumary.EndDate__c    = getFormatedDate(item.end_date);
                                                        
                            invoiceItemSumary.Identifier__c = item.identifier;
                            
                            ltInvoiceItem.add(invoiceItemSumary);
                        }
                    }
                }
            }                
            
            if(ltInvoiceItem.size() > 0){
                insert ltInvoiceItem;
            }
        }
		
        updateCustomerInteractionIdInvoice(accountId, customerInteractionId);
        
        return ltAssetObj;
    }
    
    private static Account createBillingAccount(String name, String recordTypeName, Id accountId) { 
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(recordTypeName).getrecordTypeId();
        return new Account(Id = accountId, Name = name, recordTypeId = recordTypeId);
    }
    
    public static Date getFormatedDate(String stringDate){
        if(stringDate != null && stringDate.contains('T')){
            return Date.valueOf(stringDate.replaceAll('T',' '));
        } else {
            return null;
        }
    }

    public static Integer getValidateTime(Webservice__c wsConfig){
        return Integer.valueOf(wsConfig.Validate__c);
    }
    
    @AuraEnabled
    public static InvoiceHistoryTO.InformationMessageTO getMessage(Id accountId){        
        InvoiceHistoryTO.InformationMessageTO returnTO = new InvoiceHistoryTO.InformationMessageTO();
        returnTO.lstMessage = new List<String>();

        Boolean hasAtlys = false;
        Boolean hasNext = false;
        
        // Consulta para verificar qual sistema de origem do Cliente
        
        List<Asset> ltsearchLegacySystem = new List<Asset>();
        ltsearchLegacySystem = [SELECT Id, LegacySystem__c FROM Asset WHERE AccountId =: accountId];
        
        // Consulta para verificar qual status de pagamento tem nas faturas do cliente
        
        List<Invoice__c> ltsearchInvoices = new List<Invoice__c>();
        ltsearchInvoices = [SELECT ID,PaymentStatus__c, MobileRollup__c, FixedAmount__c, DueDate__c FROM Invoice__c WHERE AccountId__c =: accountId ];
        
        // Consulta para verificar os meses correspondentes as faturas móveis
        
        List<AggregateResult> ltMonthInvoice = new List<AggregateResult>();
        ltMonthInvoice = [SELECT CALENDAR_MONTH(DueDate__c) FROM Invoice__c WHERE AccountId__c =: accountId AND  MobileRollup__c != 0 GROUP BY CALENDAR_MONTH(DueDate__c)];
        
        
        Decimal sunValuesMobile = 0;
        Decimal sunValuesFixed = 0;
        Set<Integer> fixedMonths = new Set<Integer>();
        Set<Integer> mobileMonths = new Set<Integer>();

        for(Invoice__c invoiceObj :ltsearchInvoices){
            
            if(invoiceObj.MobileRollup__c != null){
                sunValuesMobile += invoiceObj.MobileRollup__c;
                mobileMonths.add(invoiceObj.DueDate__c.month());
            }

            if(invoiceObj.FixedAmount__c != null){
                sunValuesFixed += invoiceObj.FixedAmount__c;
                fixedMonths.add(invoiceObj.DueDate__c.month());
            }
        } 

        returnTO.FixedAverage = sunValuesFixed != 0 && fixedMonths.size() != 0 ? (sunValuesFixed/fixedMonths.size()) : 0;
        returnTO.MovingAverage = sunValuesMobile != 0 && mobileMonths.size() != 0 ? (sunValuesMobile/mobileMonths.size()) : 0;
        
        // lógica para verificar se o sistema de origem do produto do cliente possui ou Atlys ou Next
        for(Asset item: ltsearchLegacySystem){
            if(item.LegacySystem__c != null && !String.IsBlank(item.LegacySystem__c)){
                if((item.LegacySystem__c.contains('ATLYS'))){
                    hasAtlys = true;
                } else if((item.LegacySystem__c.contains('NEXT'))){
                    hasNext = true;
                }
            }
        }
              
        /* 
            1)  Se for ATLYS e não tiver nenhuma fatura: 
			Para consulta de faturas deste cliente acessar o Vivo 360 
		*/
        
        if(((hasAtlys == true) && (hasNext == false)) && (ltMonthInvoice.size() <= 0))  {
            returnTO.lstMessage.add(Label.SystemOrigemWithoutInvoice);
        } 
        
        /* 
            2) Se for ATLYS e estiver entre 1 mês e 6 meses na exibição das faturas da móvel:
			Para a consulta do histórico com visão dos últimos 6 meses, consultar o Vivo 360
        */
        
        else if(((hasAtlys == true) && (hasNext == false)) && ((ltMonthInvoice.size() >= 1) && (ltMonthInvoice.size() < 6)) ){
            returnTO.lstMessage.add(Label.SystemOrigemWithInvoice);
        } 
        /*
         	3) Se for ATLYS e estiver em um dos dois cenários acima e ter sistemas de origem diferentes em suas contas faturamento (Ex. Uma conta faturamento no 360 e outra no Next), deve-se mostrar a mensagem: 
			Algumas faturas Móvel deste cliente não migraram para o NEXT. Para consulta de histórico acessar o Vivo 360
         */
        else if(((hasAtlys == true) && (hasNext == true)) && ((ltMonthInvoice.size() >= 1) && (ltMonthInvoice.size() < 6)) ){
            returnTO.lstMessage.add(Label.SystemOrigemAtlysNext);
        } 
        
        /* 
         	Regra para status da Fatura como não pago.
            1)  Mensagem de atualização sistêmica do status de fatura será exibida para toda e qualquer fatura com status "Não pago": 
            A atualização sistêmica do ''Status da Fatura'' ocorre em até 26h

		*/

        for(Invoice__c item : ltsearchInvoices){
            if(item.PaymentStatus__c == 'Unpaid'){
                returnTO.lstMessage.add(Label.StatusInvoiceMessage);
                break;
            } 
        }
        
        return returnTO;
    }

    //Solução adotada para quebrar o contexto do retorno da invoice e atualizar os asset´s
    @AuraEnabled
    public static void updateAssetList(List<Asset> lstAssetObj){
        if(lstAssetObj != null && !lstAssetObj.isEmpty()){
            update lstAssetObj;
        }
    }
    
    // Solução adotada para receber o recordId do objeto Protocolo e retornar o Id da conta relacionada a ele.
    public static Id getAccountIdFromCustomerInteraction(Id recordId) {
        List<vlocity_cmt__CustomerInteraction__c> customerInteraction = [SELECT vlocity_cmt__AccountId__c FROM vlocity_cmt__CustomerInteraction__c WHERE Id =: recordId LIMIT 1];
        return customerInteraction.isEmpty() ? null : customerInteraction[0].vlocity_cmt__AccountId__c;        
    }

    // Atualizar campos CustomerInteractionId nos invoices para que o relatório de faturamento possa funcionar corretamente
    private static void updateCustomerInteractionIdInvoice(Id accountId, Id customerInteractionId) {
         List<Invoice__c> listInvoice = [SELECT Id FROM Invoice__c WHERE AccountId__c = :accountId];
         for(Invoice__c invoice : listInvoice) {
            invoice.CustomerInteraction__c = customerInteractionId;
         }
         update listInvoice;
    }    
}