@isTest
global class GetCardOfferCalloutMock implements HttpCalloutMock {
    protected Integer code;
    protected Map<String, String> responseHeaders;
    protected String body;

    public GetCardOfferCalloutMock(Integer code, String body, Map<String, String> responseHeaders) {
        this.code = code;
        this.body = body;
        this.responseHeaders = responseHeaders;
    }

    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(code);
        response.setBody(body);
        if (responseHeaders != null) {
            for (String key : responseHeaders.keySet()) {
                response.setHeader(key, responseHeaders.get(key));
            }
        }
        return response;
    }

    // global HttpResponse respond(HttpRequest request) {
    //     HttpResponse response = new HttpResponse();
    //     response.setHeader('Content-Type', 'application/json');
    //     response.setBody('[{		"card_type": "next-best-offer",		"title": "31255032804",		"container_id": "inlife",		"card_layout": "list",		"cards": [{				"id": "L3TZN7HC_1_UP_FTTH",				"title": "UP FTTH",				"image": {					"url": "https://blablabla.com",					"alt": "DEFAULT SCRIPT"				},				"description": "UPGRADE DE VELOCIDADE FTTH",				"accepts_feedback": false,				"identifiers": [{						"type": "offer_context_key",						"id": " "					}				],				"source": "1",				"rank": "2",				"voucher_code": "279.98",				"sub_offers": [{						"name": "UP FTTH",						"description": "L3TZN7HC_1_UP_FTTH_BL + TV|BL + TV|AQUIS_DUO_FTTH_300_IPTV_ULTIM_MAI21_C_HA",						"categories": "P "					}, {						"name": "UP FTTH",						"description": "L3TZN7HC_1_UP_FTTH_TV|TV|AQUIS_DUO_FTTH_300_IPTV_ULTIM_MAI21_C_HA|149.99",						"categories": "D "					}, {						"name": "UP FTTH",						"description": "L3TZN7HC_1_UP_FTTH_BL|BL|AQUIS_DUO_FTTH_300_IPTV_ULTIM_MAI21_C_HA|129.99",						"categories": "D "					}				]			}, {				"id": "NUQTGBT6_2_MIGRA_FTTH",				"title": "MIGRA FTTH",				"image": {					"url": "https://blablabla.com",					"alt": "DEFAULT SCRIPT"				},				"description": "MIGRACAO DE TECNOLOGIA FTTH",				"accepts_feedback": false,				"identifiers": [{						"type": "offer_context_key",						"id": " "					}				],				"source": "2",				"rank": "1"			}		]	}]');
    //     response.setStatusCode(200);
    //     return response;
    // }
}