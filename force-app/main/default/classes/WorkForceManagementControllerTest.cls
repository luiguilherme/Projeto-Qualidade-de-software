@isTest
public with sharing class WorkForceManagementControllerTest {

    @IsTest
    static void testFindById() {

        Webservice__c ws = new Webservice__c(
            Name = 'WorkForceManagementCallout',
            Endpoint__c = 'https://contest.proxy.beeceptor.com/wfm/workOrderManagement/v1/workOrder/{id}',
            ServiceProvider__c = 'APIGW',
            SubscriptionKey__c = '89098b41c7884a3d8d55741b46389b61',
            Headers__c = 'application/json; charset=utf-8'
        );
        insert ws;

        WorkForceManagementController.WorkForceManagementFilter filter = new WorkForceManagementController.WorkForceManagementFilter();
        filter.id = '123456';

        System.debug('filter: ' + filter);

        List<WorkForceManagementController.WorkForceManagementFilter> filters = new List<WorkForceManagementController.WorkForceManagementFilter>();
        filters.add(filter);

        System.debug('filters: ' + filters);

        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new WorkOrderManagementServiceMock());
            List<WorkForceManagementController.Response> result = WorkForceManagementController.findById(filters);
        Test.stopTest();

        System.debug('result: ' + result);

        System.assert(result.size() == 1);
        WorkForceManagementController.Response response = result.get(0);
        System.assert(response.workOrderObject != null);
        System.assert(response.workOrderObject.items.size() > 0);
        WorkOrderItemObject woItem = response.workOrderObject.items.get(0);
        System.assertEquals('123456', woItem.id);
        System.assertEquals('Agendada, Pendente, Encerrada, Cancelada, Execucao', woItem.state);
        System.assertEquals('Triagem', woItem.stateReason);

    }

    private class WorkOrderManagementServiceErrorMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(500);
            return res;
        }
    }

    public class WorkOrderManagementServiceMock implements HttpCalloutMock {

      String jsonResponse = '{\n' + 
      '  "id": "123456",\n' + 
      '  "cancellationDate": "2024-05-21T17:23:11.800Z",\n' + 
      '  "cancellationReason": "string",\n' + 
      '  "category": "string",\n' + 
      '  "completionDate": "2024-05-21T17:23:11.800Z",\n' + 
      '  "description": "string",\n' + 
      '  "expectedCompletionDate": "2024-05-21T17:23:11.800Z",\n' + 
      '  "externalId": "string",\n' + 
      '  "orderDate": "2024-05-21T17:23:11.800Z",\n' + 
      '  "priority": "string",\n' + 
      '  "requestedCompletionDate": "2024-05-21T17:23:11.800Z",\n' + 
      '  "requestedStartDate": "2024-05-21T17:23:11.800Z",\n' + 
      '  "startDate": "2024-05-21T17:23:11.800Z",\n' + 
      '  "stateChangeDate": "2024-05-21T17:23:11.800Z",\n' + 
      '  "version": "string",\n' + 
      '  "orderProtocol": "string",\n' + 
      '  "recentDefect": "string",\n' + 
      '  "relatedParty": [\n' + 
      '    {\n' + 
      '      "id": "string",\n' + 
      '      "name": "string",\n' + 
      '      "documentNumber": "string",\n' + 
      '      "category": "Residencial, SOHO",\n' + 
      '      "role": "string",\n' + 
      '      "@referredType": "Customer",\n' + 
      '      "contactMedium": [\n' + 
      '        {\n' + 
      '          "id": "string",\n' + 
      '          "mediumType": "mobilePhone",\n' + 
      '          "preferred": true,\n' + 
      '          "characteristic": {\n' + 
      '            "id": "string",\n' + 
      '            "city": "string",\n' + 
      '            "contactType": "string",\n' + 
      '            "country": "string",\n' + 
      '            "emailAddress": "string",\n' + 
      '            "faxNumber": "string",\n' + 
      '            "phoneNumber": "string",\n' + 
      '            "postCode": "string",\n' + 
      '            "socialNetworkId": "string",\n' + 
      '            "stateOrProvince": "string",\n' + 
      '            "street1": "string",\n' + 
      '            "street2": "string",\n' + 
      '            "@baseType": "string",\n' + 
      '            "@type": "string"\n' + 
      '          }\n' + 
      '        }\n' + 
      '      ]\n' + 
      '    }\n' + 
      '  ],\n' + 
      '  "state": "Encerrada",\n' + 
      '  "workOrderItem": [\n' + 
      '    {\n' + 
      '      "id": "123456",\n' + 
      '      "description": "string",\n' + 
      '      "action": "add",\n' + 
      '      "place": {\n' + 
      '        "id": "string",\n' + 
      '        "name": "string",\n' + 
      '        "placePhysicalResourceAssoc": {\n' + 
      '          "resourceSpecificationCharacteristic": [\n' + 
      '            {\n' + 
      '              "id": "string",\n' + 
      '              "name": "string",\n' + 
      '              "value": "string",\n' + 
      '              "valueType": "string",\n' + 
      '              "typeOfResource": "string"\n' + 
      '            }\n' + 
      '          ]\n' + 
      '        },\n' + 
      '        "@type": "string",\n' + 
      '        "@referredType": "geographicAddress",\n' + 
      '        "geographicAddress": {\n' + 
      '          "country": "BR",\n' + 
      '          "city": "CURITIBA",\n' + 
      '          "stateOrProvince": "PR",\n' + 
      '          "locality": "JARDIM BOTANICO",\n' + 
      '          "postcode": "80210010",\n' + 
      '          "streetType": "AVENIDA",\n' + 
      '          "streetPrefix": "DOUTOR",\n' + 
      '          "streetName": "DARIO LOPES DOS SANTOS",\n' + 
      '          "streetNr": "2197",\n' + 
      '          "streetCode": "123456",\n' + 
      '          "cnl": "41000",\n' + 
      '          "cnlAcronym": "CTA",\n' + 
      '          "networkOwner": "VIVO2",\n' + 
      '          "externalNetworkOwner": "FIBRASIL",\n' + 
      '          "telephonicArea": "VM",\n' + 
      '          "centralOffice": "BE",\n' + 
      '          "microArea": "AIJ",\n' + 
      '          "geographicLocation": {\n' + 
      '            "uncertain": 89.44,\n' + 
      '            "geoJson": {\n' + 
      '              "type": "Point",\n' + 
      '              "coordinates": [\n' + 
      '                0,\n' + 
      '                0\n' + 
      '              ]\n' + 
      '            }\n' + 
      '          }\n' + 
      '        }\n' + 
      '      },\n' + 
      '      "orderItem": [\n' + 
      '        {\n' + 
      '          "id": "string",\n' + 
      '          "action": "string",\n' + 
      '          "provisioningCode": "string",\n' + 
      '          "name": "string",\n' + 
      '          "portability": true,\n' + 
      '          "status": "Aberto",\n' + 
      '          "pon": "V0001NOEW6",\n' + 
      '          "logicalResourceAssociated": {\n' + 
      '            "id": "string",\n' + 
      '            "category": "string",\n' + 
      '            "name": "string",\n' + 
      '            "status": "string",\n' + 
      '            "validFor": {\n' + 
      '              "endDateTime": "1985-04-12T23:20:50.52Z",\n' + 
      '              "startDateTime": "1985-04-12T23:20:50.52Z"\n' + 
      '            }\n' + 
      '          },\n' + 
      '          "@type": "string",\n' + 
      '          "@referredType": "string"\n' + 
      '        }\n' + 
      '      ],\n' + 
      '      "relatedEntity": [\n' + 
      '        {\n' + 
      '          "id": "string",\n' + 
      '          "name": "string",\n' + 
      '          "role": "string",\n' + 
      '          "@baseType": "string",\n' + 
      '          "@type": "string",\n' + 
      '          "@referredType": "string"\n' + 
      '        }\n' + 
      '      ],\n' + 
      '      "state": "Agendada, Pendente, Encerrada, Cancelada, Execucao",\n' + 
      '      "stateReason": "Triagem",\n' + 
      '      "work": [\n' + 
      '        {\n' + 
      '          "id": "string",\n' + 
      '          "completionDate": "2024-05-21T17:23:11.801Z",\n' + 
      '          "scheduledBy": "string",\n' + 
      '          "resourceId": "string",\n' + 
      '          "canBeAnticipated": true,\n' + 
      '          "description": "string",\n' + 
      '          "expectedCompletionDate": "2024-05-21T17:23:11.801Z",\n' + 
      '          "expectedStartDate": "2024-05-21T17:23:11.801Z",\n' + 
      '          "name": "string",\n' + 
      '          "orderDate":"2024-05-21T17:23:11.801Z",\n' + 
      '          "percentageComplete": 0,\n' + 
      '          "workPriority": "string",\n' + 
      '          "workType": "string",\n' + 
      '          "state": "Encerrado",\n' + 
      '          "stateReason": "Aberta Massiva",\n' + 
      '          "@type": "string",\n' + 
      '          "@baseType": "string",\n' + 
      '          "@referredType": "string",\n' + 
      '          "appointment": {\n' + 
      '               "id":"string", \n' + 
      '               "description":"string",\n' + 
      '               "deliveryTimeSlot": {\n' +
      '                   "endDateTime":"1985-04-12T23:20:50.52Z", \n' + 
      '                   "startDateTime":"1985-04-12T23:20:50.52Z"\n' + 
      '                }\n' +       
      '           },\n' + 
      '          "workSpecification": {\n' + 
      '               "name":"IN_3P, TT_TV, AL_RL, IN_LNPTV",\n' + 
      '               "type":"INSTALLATION"\n' + 
      '           }\n' + 
      '        }\n' + 
      '      ],\n' + 
      '      "workLog": [\n' + 
      '        {\n' + 
      '          "id": "string",\n' + 
      '          "author": "string",\n' + 
      '          "date": "2024-05-21T17:23:11.801Z",\n' + 
      '          "text": "string",\n' + 
      '          "@baseType": "string",\n' + 
      '          "@type": "string"\n' + 
      '        }\n' + 
      '      ],\n' + 
      '      "@baseType": "string",\n' + 
      '      "@type": "string"\n' + 
      '    }\n' + 
      '  ],\n' + 
      '  "baseType": "string",\n' + 
      '  "schemaLocation": "string",\n' + 
      '  "type": "string"\n' + 
      '}';      

      public HTTPResponse respond(HTTPRequest req) {
          HttpResponse res = new HttpResponse();
          res.setHeader('Content-Type', 'application/json');
          res.setBody(this.jsonResponse);
          res.setStatusCode(200);
          return res;
      }
    }

}