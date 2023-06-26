/*
* @description - fábrica de Fatura__c para classes de testes
*/
@IsTest
public class DataFactory {
    public static Invoice__c createInvoiceHistory(Id accountId){
        Invoice__c invoiceHistory = new Invoice__c();
        
        invoiceHistory.Name = 'serviceHistory';
        invoiceHistory.AccountId__c = accountId;
        invoiceHistory.InvoiceId__c = '1234567890';
        invoiceHistory.Name = 'Test Invoice';
        invoiceHistory.CreationDate__c = System.today();
        invoiceHistory.StartDate__c = System.today();
        invoiceHistory.EndDate__c = System.today();
        invoiceHistory.DueDate__c = System.today();
        invoiceHistory.PaymentDate__c = System.today();
        invoiceHistory.NextInvoiceDate__c = System.today();
        invoiceHistory.TotalAmount__c = 324.44;
        invoiceHistory.TaxInclude__c = true;
        invoiceHistory.PaymentStatus__c = 'Unpaid';
        invoiceHistory.Downloadurl__c = 'https://invoicedownload.free.beeceptor.com/invoice';

        return invoiceHistory;
    }

    public static Attachment createAttachment(Id invoiceId,String body){
        Attachment attach = new Attachment();
        
        attach.Name = 'myfile';
        attach.parentId = invoiceId;
        attach.contentType = 'application/pdf';
        attach.body = EncodingUtil.base64Decode(body);        

        return attach;
    }
    
    public static Account createAccount(){ 
        Account account = new Account();

        account.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Billing').getrecordTypeId();
        account.Name = 'Account Test';
        account.DocumentNumber__c = '11111111111111';
        account.vlocity_cmt__CustomerClass__c = 'Móvel';
        account.vlocity_cmt__CustomerValue__c = 'PLATINUM';
        account.vlocity_cmt__Active__c = 'Yes';
        account.ExternalId__c = '899941326811';
        
        return account;
    }
    
    public static Asset createAsset(Id accountId, String type){
        Asset asset = new Asset();
        
        asset.Name = 'Test Asset';
        asset.AccountId = accountId;        
        asset.MainProductDescription__c = 'Test ' + type;
        asset.vlocity_cmt__BillingAccountId__c = accountId;
        asset.Type__c = type;
        asset.IsHolder__c = 'Sim';
        asset.HasBonus__c = false;
        asset.HasDiscount__c = false;
        asset.PriceOver__c = 150;
        asset.PriceCurrent__c = 200;
        asset.PhoneNumber__c = '12345678901';
        asset.Speed__c = '30';
        asset.ProductType__c = 'VOZ';
        asset.PhoneNumber__c = '11999999999';
        asset.Technology__c = 'FTTH';
        asset.Cabinet__c = 'Cabinet';
        asset.LegacySystem__c = 'ATLYS';

        return asset;
    }
    
    public static Asset createAsset(Id accountId, Id bAccountId, Id sAccountId, String type){
        Asset asset = new Asset();
        
        asset.Name = 'Test Asset';
        asset.AccountId = accountId;        
        asset.MainProductDescription__c = 'Test ' + type;
        asset.vlocity_cmt__BillingAccountId__c = bAccountId;
        asset.vlocity_cmt__ServiceAccountId__c = sAccountId;
        asset.Type__c = type;
        asset.IsHolder__c = 'Sim';
        asset.HasBonus__c = false;
        asset.HasDiscount__c = false;
        asset.PriceOver__c = 150;
        asset.PriceCurrent__c = 200;
        asset.PhoneNumber__c = '12345678901';
        asset.Speed__c = '30';
        asset.ProductType__c = 'VOZ';
        asset.PhoneNumber__c = '11999999999';
        asset.Technology__c = 'FTTH';
        asset.Cabinet__c = 'Cabinet';
        asset.LegacySystem__c = 'ATLYS';

        return asset;
    }
    
    public static vlocity_cmt__CustomerInteraction__c createCustomerInteraction(Id accountId) {
        vlocity_cmt__CustomerInteraction__c customerInteraction = new vlocity_cmt__CustomerInteraction__c();
        customerInteraction.vlocity_cmt__AccountId__c = accountId;
		customerInteraction.Name = 'Test Customer Interaction';		
		customerInteraction.vlocity_cmt__StartDateTime__c = System.today();
		customerInteraction.InteractionNumber__c = '20220630123456';
		customerInteraction.vlocity_cmt__StartDateTime__c = System.today();
		customerInteraction.vlocity_cmt__Type__c = 'Presencial';
		customerInteraction.vlocity_cmt__Verified__c = false;
        
        return customerInteraction;
    }

    public static Script__c createManualScript(){
        Script__c manualScript = new Script__c();
        
        manualScript.Name = 'Script';
        manualScript.StartDate__c = system.TODAY();
        manualScript.EndDate__c = system.TODAY();
        manualScript.Status__c = 'Draft';
        manualScript.Message__c = 'Message';
        manualScript.Priority__c = 1;
        manualScript.Recurrent__c = 'No';
        manualScript.RecordTypeId = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('ManualWarning').getrecordTypeId();

        return manualScript;
    }
    
    public static ScriptRule__c createScriptRule(Id automaticScriptId, Integer ruleNumber, String value){
        ScriptRule__c scriptRule = new ScriptRule__c();
        
        scriptRule.Script__c = automaticScriptId;
        scriptRule.RuleNumber__c = ruleNumber;
        scriptRule.Object__c = 'conta';
        scriptRule.Field__c = 'Nome';
        scriptRule.Operator__c = 'startsWith';
        scriptRule.Value__c = value;
        scriptRule.ObjectAPI__c = 'Account';
        scriptRule.FieldAPI__c = 'Name';

        return scriptRule;
    }
    
    public static ScriptDetail__c createScripDetailLog(Id manualScriptId, Id accountId){
        ScriptDetail__c scriptDetail = new ScriptDetail__c();
        
        scriptDetail.Script__c = manualScriptId;
        scriptDetail.Account__c = accountId;
        scriptDetail.Name = 'Detalhe Script';
        scriptDetail.RecordTypeId = Schema.SObjectType.ScriptDetail__c.getRecordTypeInfosByDeveloperName().get('WarningLogs').getrecordTypeId();


        return scriptDetail;
    }
    
    public static Script__c createAutomaticScript(){
        Script__c automaticScript = new Script__c();
        
        automaticScript.Name = 'Script';
        automaticScript.StartDate__c = system.TODAY();
        automaticScript.EndDate__c = system.TODAY();
        automaticScript.Status__c = 'Draft';
        automaticScript.Message__c = 'Message';
        automaticScript.Priority__c = 1;
        automaticScript.Recurrent__c = 'No';
        automaticScript.RecordTypeId = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('AutomaticWarning').getrecordTypeId();

        return automaticScript;
    }
    
     public static Script__c createScript(String scriptRecordType){
        Script__c manualScript = new Script__c();
        
        manualScript.Name = 'Script';        
        manualScript.RecordTypeId = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get(scriptRecordType).getrecordTypeId();

        return manualScript;
    }
    
    public static ScriptConfig__c createScriptConfig(Id scriptId, String scriptConfigType){
        ScriptConfig__c scriptConfig = new ScriptConfig__c();
        
        scriptConfig.ParentScript__c = scriptId;
        scriptConfig.AnswerOption__c = 'Sim';
        scriptConfig.ChildScript__c = null;
        scriptConfig.NextScriptConfig__c = null;
        scriptConfig.NextScriptTech__c = scriptId;
        scriptConfig.RecordTypeId = Schema.SObjectType.ScriptConfig__c.getRecordTypeInfosByDeveloperName().get(scriptConfigType).getrecordTypeId();

        return scriptConfig;
    }
    
    public static Script__c createScriptFlow(){
        Script__c scriptFlow = new Script__c();
        
        scriptFlow.Name = 'Script';
        scriptFlow.Type__c = 'SalesSupport';
        scriptFlow.Status__c = 'Active';
        scriptFlow.RecordTypeId = Schema.SObjectType.Script__c.getRecordTypeInfosByDeveloperName().get('Flow').getrecordTypeId();

        return scriptFlow;
    }
    
    public static Offer__c createOfferFixed(Id accountId){
        Offer__c offer = new Offer__c();
        
        
        offer.RecordTypeId = Schema.SObjectType.Offer__c.getRecordTypeInfosByDeveloperName().get('Fixa').getrecordTypeId();
        offer.IsActive__c = true;
        //offer.AccountId__c = accountId;
        offer.TotalPrice__c = 30;
        offer.BroadbandDescription__c = 'Oferta Fixa Teste';
        offer.TVDescription__c = '10';
        offer.FixedLineDiscount__c = 0;
        offer.OfferLevel__c = 'Nivel_1';
        offer.Technology__c = 'FTTH';
        offer.BroadBandAttribute__c = '200';
        offer.Cabinet__c = true;
        offer.FixedLinePlanAttribute__c = true;
        offer.FixedLineDescription__c = 'Vivo Fixo Ilimitado';
        offer.OfferCityCategory__c = 'A';
        offer.BroadbandDiscountDuration__c = 30;
        offer.FixedLineDiscountDuration__c = 10;
        offer.TVDiscountDuration__c = 20;
        return offer;
    }
    
        public static Offer__c createOfferMobile(Id accountId, String recordType){
        Offer__c offer = new Offer__c();
        
        offer.RecordTypeId = Schema.SObjectType.Offer__c.getRecordTypeInfosByDeveloperName().get(recordType).getrecordTypeId();
        offer.IsActive__c = true;
        //offer.AccountId__c = accountId;
        offer.MobilePlan__c = 'Test Movel';
        offer.TotalPrice__c = 150;
        offer.MobileInternetDescription__c = '20';
        offer.MobileDescription__c = 'Test Movel';
        offer.OfferLevel__c = 'Nivel_1';
        offer.BroadBandAttribute__c = '200';
        offer.Cabinet__c = true;
        offer.CustomerType__c = 'Totalizado;Móvel';
        offer.Technology__c = 'FTTH';
        offer.OfferCityCategory__c = 'A';

        return offer;
    }
    
    public static CartAccount__c createCartAccount(Id accountId){
        return createCartAccount(accountId, null);
    }
    
    public static CartAccount__c createCartAccount(Id accountId, String recordTypeName){
        CartAccount__c cartAccount = new CartAccount__c();
        
        // cartAccount.Name = 'Cart Account Test';
        cartAccount.AccountId__c = accountId;
        cartAccount.ContactPhoneNumber__c = '11111111111';
        cartAccount.RpaId__c = '10341';
        cartAccount.DeliveryFirstComplement__c = 'PAT';
        
        if(recordTypeName != null){
            cartAccount.RecordTypeId = Schema.SObjectType.CartAccount__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getrecordTypeId();    
        }
        
        return cartAccount;
    }
    
    public static CartOffer__c createCartOffer(Id cartAccountId, Id offerId){
        CartOffer__c cartOffer = new CartOffer__c();
        
        cartOffer.Active__c = true;
        cartOffer.CartId__c = cartAccountId;
        cartOffer.OfferId__c = offerId;

        return cartOffer;
    }
    
    public static User createUser(String profileId, String roleId) {
        User user = new User();
        
        // Timestamp UTC-3 para garantir a exclusividade de dados únicos.
        Integer intRandomNumber = Integer.valueof((Math.random() * 1000));
        Long timestamp = DateTime.now().addHours(-intRandomNumber).getTime();
        String timestampString = String.valueOf(timestamp);
		
        user.ProfileId = profileId;
        user.UserRoleId = roleId;
        user.FirstName = 'FirstNameTest';
        user.LastName = 'LastNameTest';
        user.Username = 'userTest0A999' + timestamp + '@sample.com';
        user.CommunityNickname = 'userTest0A999' + timestamp + '@sample.com';
        user.Email='userTest0A999' + timestamp + '@sample.com';
        user.Alias = 'ut' + timestampString.substring(timestampString.length() - 6);
        user.TimeZoneSidKey = 'America/Sao_Paulo';
        user.LocaleSidKey = 'en_US';
        user.LanguageLocaleKey = 'en_US';
        user.EmailEncodingKey = 'ISO-8859-1';
            
        return user;
    }
    
    public static User createCommunityUser(String profileId, String partnerGroup, Id contactId) {
        User user = new User();
        
        // Timestamp UTC-3 para garantir a exclusividade de dados únicos.
        Long timestamp = DateTime.now().addHours(-3).getTime();
        String timestampString = String.valueOf(timestamp);
            
        user.ProfileId = profileId;
        user.FirstName = 'FirstNameTest';
        user.LastName = 'LastNameTest';
        user.Username = 'userTest0A999' + timestamp + '@sample.com';
        user.CommunityNickname = 'userTest0A999' + timestamp + '@sample.com';
        user.Email='userTest0A999' + timestamp + '@sample.com';
        user.Alias = 'ut' + timestampString.substring(timestampString.length() - 6);
        user.TimeZoneSidKey = 'America/Sao_Paulo';
        user.LocaleSidKey = 'en_US';
        user.LanguageLocaleKey = 'en_US';
        user.EmailEncodingKey = 'ISO-8859-1';
        user.PartnerGroup__c = partnerGroup;
        user.ContactId = contactId;
            
        return user;
    }
        public static Offer__c createOffer() {
        Offer__c offer = new Offer__c();
        
        offer.RecordTypeId = Schema.SObjectType.Offer__c.getRecordTypeInfosByDeveloperName().get('OfferBook').getrecordTypeId();
        offer.IsActive__c = true;
        offer.TotalPrice__c = 30;
        offer.BroadbandDescription__c = 'Oferta Fixa Teste';
        offer.TVDescription__c = '10';
        offer.FixedLineDiscount__c = 0;
        offer.OfferLevel__c = 'Nivel_1';
        offer.Technology__c = 'FTTH';
        offer.BroadBandAttribute__c = '200';
        offer.Cabinet__c = true;
        offer.FixedLinePlanAttribute__c = true;
        offer.FixedLineDescription__c = 'Vivo Fixo Ilimitado';
        offer.OfferCityCategory__c = 'A';

        return offer;
    }

    public static Offer__c createAdditionalService() {
        Offer__c offer = new Offer__c();
        
        offer.RecordTypeId = Schema.SObjectType.Offer__c.getRecordTypeInfosByDeveloperName().get('ServicosAdicionais').getrecordTypeId();
        offer.IsActive__c = true;
        offer.TotalPrice__c = 30;
        offer.BroadbandDescription__c = 'Oferta Serviço Adicional';
        offer.TVDescription__c = '10';
        offer.FixedLineDiscount__c = 0;
        offer.OfferLevel__c = 'Nivel_1';
        offer.Technology__c = 'FTTH';
        offer.BroadBandAttribute__c = '200';
        offer.Cabinet__c = true;
        offer.FixedLinePlanAttribute__c = true;
        offer.FixedLineDescription__c = 'Vivo Fixo Ilimitado';
        offer.OfferCityCategory__c = 'A';

        return offer;
    }
    
    public static OfferFilter__c createOfferFilter(String recordType){
        OfferFilter__c offerFilter = new OfferFilter__c();
        
        offerFilter.IsActive__c = true;
        offerFilter.RecordTypeId = Schema.SObjectType.OfferFilter__c.getRecordTypeInfosByDeveloperName().get(recordType).getrecordTypeId();
        offerFilter.FilterCode__c = 'A';
        offerFilter.City__c = 'São Paulo';
        offerFilter.StateCode__c = 'SP';
        offerFilter.Technology__c = 'FTTH';
        return offerFilter;
    }
    
    public static OfferFilter__c createOfferFilterCabinet(String recordType){
        OfferFilter__c offerFilter = new OfferFilter__c();

        offerFilter.IsActive__c = true;
        offerFilter.RecordTypeId = Schema.SObjectType.OfferFilter__c.getRecordTypeInfosByDeveloperName().get(recordType).getrecordTypeId();
        offerFilter.FilterCode__c = 'A';
        offerFilter.Cabinet__c = 'Cabinet';
        offerFilter.City__c = 'São Paulo';
        offerFilter.StateCode__c = 'SP';
        offerFilter.Technology__c = 'FTTH';
        return offerFilter;
    }
    
    public static SuggestedSpeed__c createSuggestedSpeed(){
        SuggestedSpeed__c suggestedSpeed = new SuggestedSpeed__c();
        
        suggestedSpeed.CurrentSpeed__c = '30';
        suggestedSpeed.SuggestedSpeed__c = '200';
        
        return suggestedSpeed;
    }
    
    public static Account createConsumerAccount(){ 
        Account account = new Account();
        
        account.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Consumer').getrecordTypeId();
        account.Name = 'Account Test';
        account.DocumentNumber__c = '11111111111111';
        account.vlocity_cmt__CustomerClass__c = 'Totalizado';
        account.vlocity_cmt__CustomerValue__c = 'PLATINUM';
        account.vlocity_cmt__Active__c = 'Yes';
        account.ExternalId__c = '899941326811';
        account.ShippingState = 'SP';
        account.ShippingCity = 'São Paulo';
        
        return account;
    }
    	    
    public static Account createBillingAccount(Id accountId, String accountType){ 
        Account account = new Account();
        
        account.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Billing').getrecordTypeId();
        account.Name = 'Account Test';
        account.vlocity_cmt__CustomerClass__c = 'Totalizado';
        account.DocumentNumber__c = '11111111111111';
        account.BillingAccountType__c = accountType;
        account.vlocity_cmt__CustomerValue__c = 'PLATINUM';
        account.vlocity_cmt__Active__c = 'Yes';
        account.ExternalId__c = '899941326811b'+accountType;
        account.BillingState = 'SP';
        account.BillingCity = 'São Paulo';
        account.ParentId = accountId;
        
        return account;
    }
    
    public static Account createServiceAccount(Id accountId, Id bAccountId, String accountType){ 
        Account account = new Account();
        
        account.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Service').getrecordTypeId();
        account.Name = 'Account Test';
        account.DocumentNumber__c = '11111111111111';
        account.BillingAccountType__c = accountType;
        account.vlocity_cmt__CustomerValue__c = 'PLATINUM';
        account.vlocity_cmt__Active__c = 'Yes';
        account.ExternalId__c = '899941326811s'+accountType;
        account.ShippingState = 'SP';
        account.ShippingCity = 'São Paulo';
        account.ParentId = accountId;
        //account.BillingAccount__c = bAccountId;
        
        return account;
    }
    
    public static Ticket__c createTicketHistory(Id accountId){
        return new Ticket__c(
                        AccountId__c =  accountId,
                        OpeningDate__c = Date.today(),
                        SolutionDate__c = Date.today(),
                        Status__c = 'OPEN',
                        Reason__c = 'Problemas de conexão da Banda Larga'
        );
    }
    
        public static Account createPersonAccount(){ 
        Account account = new Account();

        //account.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getrecordTypeId();
        account.Name = 'Person Account Test';
        account.DocumentNumber__c = '11111111111111';
        //account.CustomerType__c = 'Móvel';
        account.vlocity_cmt__CustomerValue__c = 'PLATINUM';
        //account.Active__c = true;

        return account;
    }
    
        public static ServiceHistory__c createServiceHistory(Id accountId){
        ServiceHistory__c serviceHistory = new ServiceHistory__c();
        
        serviceHistory.Name = 'serviceHistory';
        serviceHistory.Account__c = accountId;
        serviceHistory.StartDate__c = System.now();
        serviceHistory.ContactReason__c = 'Test Reason';
        serviceHistory.LegacyCaseNumber__c = '1910';

        return serviceHistory;
    }
    
    public static Contact createContact(){
        Contact newContact = new Contact();
        newContact.LastName = 'Contact Name';
       
        return newContact;
    }

    public static vlocity_cmt__CustomerInteractionTopic__c createCustomerInteractionTopic(String customerInteractionId, String accountId, String topicType) {
        vlocity_cmt__CustomerInteractionTopic__c topicObj = new vlocity_cmt__CustomerInteractionTopic__c();

        if(topicType == 'CanvasHybris'){
            topicObj.vlocity_cmt__CustomerInteractionId__c = customerInteractionId;
            topicObj.vlocity_cmt__AccountId__c = accountId;
            topicObj.vlocity_cmt__Reason__c = 'Palitagem Móvel';
            topicObj.Origin__c = 'Hybris';
            topicObj.ServiceTree__c = 'Service';
            topicObj.remarkup__c = 'Aguardando escolha da oferta para migração/troca de plano';
        }
        return topicObj;
    }

    public static OrderIssued__c createOrderIssued(String statusCode) {
        OrderIssued__c orderIssued = new OrderIssued__c();

        orderIssued.Status__c = 'CHECKED_VALID';
        orderIssued.StatusCode__c = statusCode;
        orderIssued.OrderStatus__c = 'CHECKED_VALID';
        orderIssued.HybrisOrder__c = String.valueOf( Math.abs(Crypto.getRandomLong()) ).substring(0, 9);
        
        return orderIssued;
    }

    public static OrderIssued__c createOrderIssued(String statusCode, String orderStatus) {
        OrderIssued__c orderIssued = new OrderIssued__c();

        orderIssued.Status__c = 'CHECKED_VALID';
        orderIssued.StatusCode__c = statusCode;
        orderIssued.OrderStatus__c = orderStatus;
        orderIssued.HybrisOrder__c = String.valueOf( Math.abs(Crypto.getRandomLong()) ).substring(0, 9);
        
        return orderIssued;
    }
    
    // public static List<ServiceQualification__c> createServiceQualificationLevels() {
    //     String recordTypeFirstLevelId = Schema.SObjectType.ServiceQualification__c.getRecordTypeInfosByDeveloperName().
    //         get('FirstLevel').getrecordTypeId();
        
    //     String recordTypeSecondLevelId = Schema.SObjectType.ServiceQualification__c.getRecordTypeInfosByDeveloperName().
    //         get('SecondLevel').getrecordTypeId();
        
    //     String recordTypeThirdLevelId = Schema.SObjectType.ServiceQualification__c.getRecordTypeInfosByDeveloperName().
    //         get('ThirdLevel').getrecordTypeId();
        
    //     String recordTypeFouthLevelId = Schema.SObjectType.ServiceQualification__c.getRecordTypeInfosByDeveloperName().
    //         get('FourthLevel').getrecordTypeId();
        
    //     ServiceQualification__c serviceQualificationType = new ServiceQualification__c(   
    //             Name = 'Tipo',
    //             FirstLevel__c = null,
    //             SecondLevel__c = null,
    //             ThirdLevel__c = null,
    //             ProductType__c = 'Mobile',
    //             ServiceTree__c = 'Service',
    //             RecordTypeId = recordTypeFirstLevelId,
    //             Active__c = true
    //     );
            
    //     ServiceQualification__c serviceQualificationReason = new ServiceQualification__c(
    //         Name = 'Motivo',
    //         FirstLevel__c = serviceQualificationType.Id,
    //         SecondLevel__c = null,
    //         ThirdLevel__c = null,
    //         ProductType__c ='Mobile',
    //         ServiceTree__c ='Service',
    //         RecordTypeId = recordTypeSecondLevelId,
    //         Active__c = true
    //     );
            
    //     ServiceQualification__c serviceQualificationSubReason = new ServiceQualification__c(
    //         Name = 'Sub-motivo',
    //         FirstLevel__c = serviceQualificationType.Id,
    //         SecondLevel__c = serviceQualificationReason.Id,
    //         ThirdLevel__c = null,
    //         ProductType__c ='Mobile',
    //         ServiceTree__c ='Service',
    //         RecordTypeId = recordTypeThirdLevelId,
    //         Active__c = true
    //     );
            
    //     ServiceQualification__c serviceQualificationDetail = new ServiceQualification__c(
    //         Name = 'Detalhe',
    //         FirstLevel__c = serviceQualificationType.Id,
    //         SecondLevel__c = serviceQualificationReason.Id,
    //         ThirdLevel__c = serviceQualificationSubReason.Id,
    //         ProductType__c = 'Mobile',
    //         ServiceTree__c = 'Service',
    //         RecordTypeId = recordTypeFouthLevelId,
    //         Active__c = true
    //     );
            
    //     List<ServiceQualification__c> ltServiceQualificationLevels = new List<ServiceQualification__c> {
    //         serviceQualificationType,
    //         serviceQualificationReason,
    //         serviceQualificationSubReason,
    //         serviceQualificationDetail
    //     };
            
    //     return ltServiceQualificationLevels;
    // }
    
// public static List<ServiceQualification__c> createServiceQualificationFixedLevels() {
    //     String recordTypeFirstLevelId = Schema.SObjectType.ServiceQualification__c.getRecordTypeInfosByDeveloperName().
    //         get('FirstLevel').getrecordTypeId();
        
    //     String recordTypeSecondLevelId = Schema.SObjectType.ServiceQualification__c.getRecordTypeInfosByDeveloperName().
    //         get('SecondLevel').getrecordTypeId();
        
    //     String recordTypeThirdLevelId = Schema.SObjectType.ServiceQualification__c.getRecordTypeInfosByDeveloperName().
    //         get('ThirdLevel').getrecordTypeId();
        
    //     String recordTypeFouthLevelId = Schema.SObjectType.ServiceQualification__c.getRecordTypeInfosByDeveloperName().
    //         get('FourthLevel').getrecordTypeId();
        
    //     ServiceQualification__c serviceQualificationType = new ServiceQualification__c(   
    //             Name = 'Tipo',
    //             ProductType__c = 'Fixed',
    //             Instance__c = 'TV',
    //             RecordTypeId = recordTypeFirstLevelId,
    //             Active__c = true,
    //             VisibleTo__c = 'OrgVivo'
    //     );
            
    //     ServiceQualification__c serviceQualificationReason = new ServiceQualification__c(
    //         Name = 'Motivo',
    //         FirstLevel__c = serviceQualificationType.Id,
    //         ProductType__c ='Fixed',
    //         Instance__c = 'TV',
    //         RecordTypeId = recordTypeSecondLevelId,
    //         Active__c = true,
    //         VisibleTo__c = 'OrgVivo'
    //     );
            
    //     ServiceQualification__c serviceQualificationSubReason = new ServiceQualification__c(
    //         Name = 'Sub-motivo',
    //         FirstLevel__c = serviceQualificationType.Id,
    //         SecondLevel__c = serviceQualificationReason.Id,
    //         ThirdLevel__c = null,
    //         ProductType__c ='Fixed',
    //         Instance__c = 'TV',
    //         RecordTypeId = recordTypeThirdLevelId,
    //         Active__c = true,
    //         VisibleTo__c = 'OrgVivo'
    //     );
            
    //     ServiceQualification__c serviceQualificationDetail = new ServiceQualification__c(
    //         Name = 'Detalhe',
    //         FirstLevel__c = serviceQualificationType.Id,
    //         SecondLevel__c = serviceQualificationReason.Id,
    //         ThirdLevel__c = serviceQualificationSubReason.Id,
    //         ProductType__c = 'Fixed',
    //         Instance__c = 'TV',
    //         OperatorSegment__c = 'Gold',
    //         GpsId__c = '1234',
    //         RecordTypeId = recordTypeFouthLevelId,
    //         Active__c = true,
    //         VisibleTo__c = 'OrgVivo'
    //     );
            
    //     List<ServiceQualification__c> ltServiceQualificationLevels = new List<ServiceQualification__c> {
    //         serviceQualificationType,
    //         serviceQualificationReason,
    //         serviceQualificationSubReason,
    //         serviceQualificationDetail
    //     };
            
    //     return ltServiceQualificationLevels;
    // }
    
}