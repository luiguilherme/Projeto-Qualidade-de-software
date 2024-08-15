public with sharing class RetrieveOrderDetailsFacade {

    public static string CONST_STRING_WEBSERVICENAME = 'RetrieveOrderDetailsCallout';

    public static List<OrderItemDetails> findByAccountIdAndOrderNumber(String accountId, String orderNumber) {
        List<OrderItemDetails> orderItemDetails = new List<OrderItemDetails>();

        WebService__c ws = Util.getWebService(CONST_STRING_WEBSERVICENAME);
        String endpoint = ws.Endpoint__c;
        endpoint = endpoint.replace('{accountId}', accountId);
        endpoint = endpoint.replace('{orderNumber}', orderNumber);
        ws.Endpoint__c = endpoint;

        HttpClient hClient = new HttpClient();
        HttpResponse resp = hClient.get(ws);

        RetrieveOrderDetailsResponse response = (RetrieveOrderDetailsResponse)JSON.deserialize(resp.getBody(), RetrieveOrderDetailsResponse.class);

        for(RetrieveOrderDetailsResponse.OrderItems orderItem : response.orderItems) {           
            OrderItemDetails itemDetails = new OrderItemDetails();
            System.debug('dbg 1 voiceLineMsisdn -> ' + orderItem.voiceLineMsisdn);
            itemDetails.serviceId = orderItem.voiceLineMsisdn;
            itemDetails.itemName = orderItem.productName;
            itemDetails.plan = orderItem != null && orderItem.plan != null ? orderItem.plan.catalogItemName : '';
            itemDetails.implActionTypeX9 = orderItem.implActionTypeX9;
            itemDetails.creationDate = getValueAsDateTime(orderItem.serviceRequiredDate);
            itemDetails.closedDate = getValueAsDateTime(orderItem.oacloseDate);
            
            switch on orderItem.implActionTypeX9 {
                when 'ADD_PRODUCT', 'REESTABLISH_PRODUCT', 'ADD_PRODUCT_OFFER','PORT_IN', 'PORT_OUT_REVERSAL', 'PROVIDE_PREPAID', 'MIGRATION_ON_THE_FLY'{
                    itemDetails.action = 'Adicionar';
                }
                when 'REMOVE_PRODUCT','CANCEL', 'FRAUD_CEASE', 'COLLECTION_CEASE', 'PORT_OUT', 'CEASE_REPLACE' {
                    itemDetails.action = 'Desconectar';
                }                
                when else {
                    itemDetails.action = 'Modificar';
                }
            }

            List<OrderItemDetails> children = new List<OrderItemDetails>();
            
            if (orderItem.services != null) {
                for(RetrieveOrderDetailsResponse.Services service: orderItem.services){              
                    OrderItemDetails childItem1 = new OrderItemDetails();
                    childItem1.serviceId = '-';
                    childItem1.itemName = service.catalogItemName;
                    childItem1.plan = '-';
                    childItem1.creationDate = null;
                    childItem1.closedDate = null;
    
                    switch on service.action {
                        when 'ADD' {
                            childItem1.action = 'Adicionar';
                        }
                        when 'NONE' {
                            childItem1.action = 'Nenhuma ação';
                        }
                        when 'REMOVE' {
                            childItem1.action = 'Remover';
                        }
                        when 'RESUME' {
                            childItem1.action = 'Nenhuma ação';
                        }
                        when 'SUSPEND' {
                            childItem1.action = 'Suspender';
                        }
                        when 'CHANGE' {
                            childItem1.action = 'Modificar';
                        }
                    }
    
                    children.add(childItem1);
    
                    if (service.pricePackages != null) {
                        for (RetrieveOrderDetailsResponse.Plan pricePackage : service.pricePackages) {
                            OrderItemDetails childItem2 = new OrderItemDetails();
                            childItem2.serviceId = '-';
                            childItem2.itemName = pricePackage.catalogItemName;
                            childItem2.plan = '-';
                            childItem2.creationDate = null;
                            childItem2.closedDate = null;
        
                            switch on pricePackage.action {
                                when 'ADD' {
                                    childItem2.action = 'Adicionar';
                                }
                                when 'NONE', 'RESUME' {
                                    childItem2.action = 'Nenhuma ação';
                                }
                                when 'REMOVE' {
                                    childItem2.action = 'Remover';
                                }
                                when 'SUSPEND' {
                                    childItem2.action = 'Suspender';
                                }
                                when 'CHANGE' {
                                    childItem2.action = 'Modificar';
                                }
                            }
        
                            children.add(childItem2);
                        }
                    }
                }
            }
            
            System.debug('dbg 2 itemDetails -> ' + itemDetails);
            itemDetails.children = children;
            System.debug('dbg 3 children -> ' + itemDetails.children);
            orderItemDetails.add(itemDetails);
            System.debug('dbg 4 orderItemDetails -> ' + orderItemDetails);
        } 

        return orderItemDetails;
    }
    
    private static DateTime getValueAsDateTime(String value) {
        if (String.isBlank(value)) {
            return null;
        }
        
        String[] splitedValue = value.split('\\.');
        if (splitedValue == null || splitedValue.size() != 2) {
            return null;
        }
        
        if (!splitedValue[0].isNumeric()) {
            return null;
        }
        
        Long dateAsLong = Long.valueOf(splitedValue[0]);
        
        try {
        	return Datetime.newInstance(dateAsLong);    
        } catch (Exception e) {
            System.debug('Ocorreu um erro ao converter o valor ' + value + ' para DateTime - ' + e);
            return null;
        }
    }
}