@isTest
public with sharing class RetrieveOrdersListResponseTeste {
    @isTest
    static void testParse() {
        String json = '{'+
            '"itemsPerPage": "10",'+
            '"startIndex": "1",'+
            '"totalResults": "20",'+
            '"totalOrdersWithReservations": "5",'+
            '"orders": ['+
                '{'+
                    '"salesChannel": {'+
                        '"salesChannel": "Online",'+
                        '"originatingSalesChannel": "Web"'+
                    '},'+
                    '"creationDate": "2024-05-13",'+
                    '"currency": "USD",'+
                    '"referenceNumber": "REF123",'+
                    '"serviceRequiredDate": "2024-06-01",'+
                    '"status": "Pending",'+
                    '"customer": {'+
                        '"id": "CUST001"'+
                    '},'+
                    '"recurringPrice": {'+
                        '"finalAmount": "50.00"'+
                    '},'+
                    '"oneTimePrice": {'+
                        '"finalAmount": "100.00"'+
                    '},'+
                    '"orderItems": ['+
                        '{'+
                            '"id": "ITEM001",'+
                            '"createdBy": "User123",'+
                            '"isPartOfBundle": true,'+
                            '"lineOfBusiness": "Telecom",'+
                            '"product": {'+
                                '"id": "PROD001",'+
                                '"catalogId": "CAT001",'+
                                '"offeringInstanceId": "OFFER123",'+
                                '"offeringName": "Internet Package",'+
                                '"name": "Internet Plan A",'+
                                '"serviceId": "SRV001"'+
                            '},'+
                            '"actionType": "Add",'+
                            '"referenceNumber": "REF456",'+
                            '"serviceRequiredDate": "2024-06-01",'+
                            '"status": "Active",'+
                            '"implActionTypeX9": "Implementation Action",'+
                            '"implOrderTypeX9": "Implementation Order",'+
                            '"provisioningDate": "2024-05-15",'+
                            '"oacloseDate": "2024-05-20",'+
                            '"reasonCode": "RC001",'+
                            '"replaceOfferIndicator": false,'+
                            '"businessType": {}'+
                        '}'+
                    ']'+
                '}'+
            ']'+
        '}';
        
        RetrieveOrdersListResponse response = RetrieveOrdersListResponse.parse(json);
        
        System.assertEquals('10', response.itemsPerPage);
        System.assertEquals('1', response.startIndex);
        System.assertEquals('20', response.totalResults);
        System.assertEquals('5', response.totalOrdersWithReservations);
        System.assertEquals(1, response.orders.size());
        RetrieveOrdersListResponse.Orders order = response.orders[0];
        System.assertEquals('Online', order.salesChannel.salesChannel);
        System.assertEquals('Web', order.salesChannel.originatingSalesChannel);
        System.assertEquals('2024-05-13', order.creationDate);
        System.assertEquals('USD', order.currency_Z);
        System.assertEquals('REF123', order.referenceNumber);
        System.assertEquals('2024-06-01', order.serviceRequiredDate);
        System.assertEquals('Pending', order.status);
        System.assertEquals('CUST001', order.customer.id);
        System.assertEquals('50.00', order.recurringPrice.finalAmount);
        System.assertEquals('100.00', order.oneTimePrice.finalAmount);
        System.assertEquals(1, order.orderItems.size());
        RetrieveOrdersListResponse.OrderItems orderItem = order.orderItems[0];
        System.assertEquals('ITEM001', orderItem.id);
        System.assertEquals('User123', orderItem.createdBy);
        System.assertEquals(true, orderItem.isPartOfBundle);
        System.assertEquals('Telecom', orderItem.lineOfBusiness);
        System.assertEquals('PROD001', orderItem.product.id);
        System.assertEquals('CAT001', orderItem.product.catalogId);
        System.assertEquals('OFFER123', orderItem.product.offeringInstanceId);
        System.assertEquals('Internet Package', orderItem.product.offeringName);
        System.assertEquals('Internet Plan A', orderItem.product.name);
        System.assertEquals('SRV001', orderItem.product.serviceId);
        System.assertEquals('Add', orderItem.actionType);
        System.assertEquals('REF456', orderItem.referenceNumber);
        System.assertEquals('2024-06-01', orderItem.serviceRequiredDate);
        System.assertEquals('Active', orderItem.status);
        System.assertEquals('Implementation Action', orderItem.implActionTypeX9);
        System.assertEquals('Implementation Order', orderItem.implOrderTypeX9);
        System.assertEquals('2024-05-15', orderItem.provisioningDate);
        System.assertEquals('2024-05-20', orderItem.oacloseDate);
        System.assertEquals('RC001', orderItem.reasonCode);
        System.assertEquals(false, orderItem.replaceOfferIndicator);
    }
}