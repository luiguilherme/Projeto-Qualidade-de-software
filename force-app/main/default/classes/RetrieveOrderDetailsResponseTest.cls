@isTest
public with sharing class RetrieveOrderDetailsResponseTest {

    @isTest
    static void testParse() {
		String json = '{'+
		'  \"links\": ['+
		'    {'+
		'      \"href\": \"/ecommerce/order/678611636?sc=SS&lo=pt_BR\",'+
		'      \"rel\": \"self\"'+
		'    }'+
		'  ],'+
		'  \"creationDate\": \"1706797791000.00\",'+
		'  \"currency\": \"BRL\",'+
		'  \"id\": \"678611636\",'+
		'  \"referenceNumber\": \"678611636A\",'+
		'  \"serviceRequiredDate\": \"1706842799000.00\",'+
		'  \"status\": \"CLOSED\",'+
		'  \"recurringPrice\": {'+
		'    \"frequency\": \"MONTH\",'+
		'    \"proratedAmount\": \"0.00\",'+
		'    \"proratedDiscountAmount\": \"0.00\",'+
		'    \"proratedTaxAmount\": \"0.00\",'+
		'    \"finalAmount\": \"160.00\",'+
		'    \"finalAmountWithTax\": \"160.00\",'+
		'    \"finalTaxAmount\": \"0.00\",'+
		'    \"originalAmount\": \"160.00\",'+
		'    \"originalTaxAmount\": \"0.00\"'+
		'  },'+
		'  \"oneTimePrice\": {'+
		'    \"finalAmount\": \"0.00\",'+
		'    \"finalAmountWithTax\": \"0.00\",'+
		'    \"finalTaxAmount\": \"0.00\",'+
		'    \"originalAmount\": \"0.00\",'+
		'    \"originalTaxAmount\": \"0.00\"'+
		'  },'+
		'  \"orderItems\": ['+
		'    {'+
		'      \"id\": \"678611686\",'+
		'      \"createdBy\": \"80838980\",'+
		'      \"actionType\": \"ADD_PRODUCT\",'+
		'      \"creationDate\": \"1706797791000.00\",'+
		'      \"description\": \"Móvel\",'+
		'      \"referenceNumber\": \"678611686A\",'+
		'      \"serviceRequiredDate\": \"1706842799000.00\",'+
		'      \"status\": \"DONE\",'+
		'      \"implActionTypeX9\": \"ADD_PRODUCT\",'+
		'      \"provisioningDate\": \"1706799537000.00\",'+
		'      \"oacloseDate\": \"1706799565000.00\",'+
		'      \"recurringPrice\": {'+
		'        \"frequency\": \"MONTH\",'+
		'        \"proratedAmount\": \"0.00\",'+
		'        \"proratedDiscountAmount\": \"0.00\",'+
		'        \"proratedTaxAmount\": \"0.00\",'+
		'        \"finalAmount\": \"160.00\",'+
		'        \"finalAmountWithTax\": \"160.00\",'+
		'        \"finalTaxAmount\": \"0.00\",'+
		'        \"originalAmount\": \"160.00\",'+
		'        \"originalTaxAmount\": \"0.00\"'+
		'      },'+
		'      \"oneTimePrice\": {'+
		'        \"finalAmount\": \"0.00\",'+
		'        \"finalAmountWithTax\": \"0.00\",'+
		'        \"finalTaxAmount\": \"0.00\",'+
		'        \"originalAmount\": \"0.00\",'+
		'        \"originalTaxAmount\": \"0.00\"'+
		'      },'+
		'      \"plan\": {'+
		'        \"action\": \"ADD\",'+
		'        \"catalogItemID\": \"104376172\",'+
		'        \"catalogItemName\": \"TITULAR VIVO POS 35GB\",'+
		'        \"id\": \"674898008\",'+
		'        \"recurringPrice\": {'+
		'          \"frequency\": \"MONTH\",'+
		'          \"proratedAmount\": \"0.00\",'+
		'          \"proratedDiscountAmount\": \"0.00\",'+
		'          \"proratedTaxAmount\": \"0.00\",'+
		'          \"finalAmount\": \"115.00\",'+
		'          \"finalAmountWithTax\": \"115.00\",'+
		'          \"finalTaxAmount\": \"0.00\",'+
		'          \"originalAmount\": \"115.00\",'+
		'          \"originalTaxAmount\": \"0.00\"'+
		'        },'+
		'        \"previousRecurringPrice\": {'+
		'          \"finalAmountWithTax\": \"0.00\",'+
		'          \"taxAmount\": \"0.00\",'+
		'          \"amount\": \"0.00\"'+
		'        },'+
		'        \"oneTimePrice\": {'+
		'          \"finalAmount\": \"0.00\",'+
		'          \"finalAmountWithTax\": \"0.00\",'+
		'          \"finalTaxAmount\": \"0.00\",'+
		'          \"originalAmount\": \"0.00\",'+
		'          \"originalTaxAmount\": \"0.00\"'+
		'        },'+
		'        \"billingIdX9\": \"450521333\"'+
		'      },'+
		'      \"productName\": \"Móvel\",'+
		'      \"services\": ['+
		'        {'+
		'          \"action\": \"ADD\",'+
		'          \"catalogItemID\": \"296412\",'+
		'          \"catalogItemName\": \"Pacotes Adicionais\",'+
		'          \"id\": \"674898019\",'+
		'          \"relationToParentID\": \"298712\",'+
		'          \"serviceType\": \"GROUP\",'+
		'          \"status\": \"ACTIVE\",'+
		'          \"recurringPrice\": {'+
		'            \"frequency\": \"MONTH\",'+
		'            \"proratedAmount\": \"0.00\",'+
		'            \"proratedDiscountAmount\": \"0.00\",'+
		'            \"proratedTaxAmount\": \"0.00\",'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"previousRecurringPrice\": {'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"taxAmount\": \"0.00\",'+
		'            \"amount\": \"0.00\"'+
		'          },'+
		'          \"oneTimePrice\": {'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"containedServices\": ['+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"catalogItemID\": \"434997372\",'+
		'              \"catalogItemName\": \"APPS ILIMITADOS\",'+
		'              \"id\": \"674898020\",'+
		'              \"relationToParentID\": \"298722\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"pricePackages\": ['+
		'                {'+
		'                  \"action\": \"ADD\",'+
		'                  \"catalogItemID\": \"435002052\",'+
		'                  \"catalogItemName\": \"Apps Ilimitados\",'+
		'                  \"id\": \"674898021\",'+
		'                  \"recurringPrice\": {'+
		'                    \"frequency\": \"MONTH\",'+
		'                    \"proratedAmount\": \"0.00\",'+
		'                    \"proratedDiscountAmount\": \"0.00\",'+
		'                    \"proratedTaxAmount\": \"0.00\",'+
		'                    \"finalAmount\": \"0.00\",'+
		'                    \"finalAmountWithTax\": \"0.00\",'+
		'                    \"finalTaxAmount\": \"0.00\",'+
		'                    \"originalAmount\": \"0.00\",'+
		'                    \"originalTaxAmount\": \"0.00\"'+
		'                  },'+
		'                  \"previousRecurringPrice\": {'+
		'                    \"finalAmountWithTax\": \"0.00\",'+
		'                    \"taxAmount\": \"0.00\",'+
		'                    \"amount\": \"0.00\"'+
		'                  },'+
		'                  \"oneTimePrice\": {'+
		'                    \"finalAmount\": \"0.00\",'+
		'                    \"finalAmountWithTax\": \"0.00\",'+
		'                    \"finalTaxAmount\": \"0.00\",'+
		'                    \"originalAmount\": \"0.00\",'+
		'                    \"originalTaxAmount\": \"0.00\"'+
		'                  },'+
		'                  \"billingIdX9\": \"450521336\"'+
		'                }'+
		'              ]'+
		'            },'+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"catalogItemID\": \"395382\",'+
		'              \"catalogItemName\": \"VIVO TRAVEL SEMPRE AME\",'+
		'              \"id\": \"674898022\",'+
		'              \"relationToParentID\": \"298722\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"pricePackages\": ['+
		'                {'+
		'                  \"action\": \"ADD\",'+
		'                  \"catalogItemID\": \"649162\",'+
		'                  \"catalogItemName\": \"Vivo Travel América\",'+
		'                  \"id\": \"674898023\",'+
		'                  \"recurringPrice\": {'+
		'                    \"frequency\": \"MONTH\",'+
		'                    \"proratedAmount\": \"0.00\",'+
		'                    \"proratedDiscountAmount\": \"0.00\",'+
		'                    \"proratedTaxAmount\": \"0.00\",'+
		'                    \"finalAmount\": \"0.00\",'+
		'                    \"finalAmountWithTax\": \"0.00\",'+
		'                    \"finalTaxAmount\": \"0.00\",'+
		'                    \"originalAmount\": \"0.00\",'+
		'                    \"originalTaxAmount\": \"0.00\"'+
		'                  },'+
		'                  \"previousRecurringPrice\": {'+
		'                    \"finalAmountWithTax\": \"0.00\",'+
		'                    \"taxAmount\": \"0.00\",'+
		'                    \"amount\": \"0.00\"'+
		'                  },'+
		'                  \"oneTimePrice\": {'+
		'                    \"finalAmount\": \"0.00\",'+
		'                    \"finalAmountWithTax\": \"0.00\",'+
		'                    \"finalTaxAmount\": \"0.00\",'+
		'                    \"originalAmount\": \"0.00\",'+
		'                    \"originalTaxAmount\": \"0.00\"'+
		'                  },'+
		'                  \"billingIdX9\": \"450521337\"'+
		'                }'+
		'              ]'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"action\": \"ADD\",'+
		'          \"businessType\": \"REGULAR\",'+
		'          \"catalogItemID\": \"4577\",'+
		'          \"catalogItemName\": \"Dados\",'+
		'          \"id\": \"674897997\",'+
		'          \"relationToParentID\": \"5797\",'+
		'          \"serviceType\": \"GROUP\",'+
		'          \"status\": \"ACTIVE\",'+
		'          \"recurringPrice\": {'+
		'            \"frequency\": \"MONTH\",'+
		'            \"proratedAmount\": \"0.00\",'+
		'            \"proratedDiscountAmount\": \"0.00\",'+
		'            \"proratedTaxAmount\": \"0.00\",'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"previousRecurringPrice\": {'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"taxAmount\": \"0.00\",'+
		'            \"amount\": \"0.00\"'+
		'          },'+
		'          \"oneTimePrice\": {'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"containedServices\": ['+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"businessType\": \"REGULAR\",'+
		'              \"catalogItemID\": \"4607\",'+
		'              \"catalogItemName\": \"MMS\",'+
		'              \"id\": \"674897998\",'+
		'              \"relationToParentID\": \"115902\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"action\": \"ADD\",'+
		'          \"catalogItemID\": \"145382\",'+
		'          \"catalogItemName\": \"Serviços de Valor Agregado Incluidos\",'+
		'          \"id\": \"674898024\",'+
		'          \"relationToParentID\": \"145792\",'+
		'          \"serviceType\": \"GROUP\",'+
		'          \"status\": \"ACTIVE\",'+
		'          \"recurringPrice\": {'+
		'            \"frequency\": \"MONTH\",'+
		'            \"proratedAmount\": \"0.00\",'+
		'            \"proratedDiscountAmount\": \"0.00\",'+
		'            \"proratedTaxAmount\": \"0.00\",'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"previousRecurringPrice\": {'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"taxAmount\": \"0.00\",'+
		'            \"amount\": \"0.00\"'+
		'          },'+
		'          \"oneTimePrice\": {'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"containedServices\": ['+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"catalogItemID\": \"434665277\",'+
		'              \"catalogItemName\": \"SERVICO DIGITAL 2 TBF: NBA, SKEELO PREMIUM, GOREAD, SUPERCOMICS\",'+
		'              \"id\": \"674898025\",'+
		'              \"relationToParentID\": \"145822\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"45.00\",'+
		'                \"finalAmountWithTax\": \"45.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"45.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"pricePackages\": ['+
		'                {'+
		'                  \"action\": \"ADD\",'+
		'                  \"catalogItemID\": \"434664957\",'+
		'                  \"catalogItemName\": \"SERVICO DIGITAL 2 TBF: NBA, SKEELO PREMIUM, GOREAD, SUPERCOMICS\",'+
		'                  \"id\": \"674898026\",'+
		'                  \"recurringPrice\": {'+
		'                    \"frequency\": \"MONTH\",'+
		'                    \"proratedAmount\": \"0.00\",'+
		'                    \"proratedDiscountAmount\": \"0.00\",'+
		'                    \"proratedTaxAmount\": \"0.00\",'+
		'                    \"finalAmount\": \"45.00\",'+
		'                    \"finalAmountWithTax\": \"45.00\",'+
		'                    \"finalTaxAmount\": \"0.00\",'+
		'                    \"originalAmount\": \"45.00\",'+
		'                    \"originalTaxAmount\": \"0.00\"'+
		'                  },'+
		'                  \"previousRecurringPrice\": {'+
		'                    \"finalAmountWithTax\": \"0.00\",'+
		'                    \"taxAmount\": \"0.00\",'+
		'                    \"amount\": \"0.00\"'+
		'                  },'+
		'                  \"oneTimePrice\": {'+
		'                    \"finalAmount\": \"0.00\",'+
		'                    \"finalAmountWithTax\": \"0.00\",'+
		'                    \"finalTaxAmount\": \"0.00\",'+
		'                    \"originalAmount\": \"0.00\",'+
		'                    \"originalTaxAmount\": \"0.00\"'+
		'                  },'+
		'                  \"billingIdX9\": \"450521338\"'+
		'                }'+
		'              ]'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"action\": \"ADD\",'+
		'          \"businessType\": \"REGULAR\",'+
		'          \"catalogItemID\": \"4697\",'+
		'          \"catalogItemName\": \"LD & Roaming\",'+
		'          \"id\": \"674897999\",'+
		'          \"relationToParentID\": \"5807\",'+
		'          \"serviceType\": \"GROUP\",'+
		'          \"status\": \"ACTIVE\",'+
		'          \"recurringPrice\": {'+
		'            \"frequency\": \"MONTH\",'+
		'            \"proratedAmount\": \"0.00\",'+
		'            \"proratedDiscountAmount\": \"0.00\",'+
		'            \"proratedTaxAmount\": \"0.00\",'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"previousRecurringPrice\": {'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"taxAmount\": \"0.00\",'+
		'            \"amount\": \"0.00\"'+
		'          },'+
		'          \"oneTimePrice\": {'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"containedServices\": ['+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"businessType\": \"REGULAR\",'+
		'              \"catalogItemID\": \"4757\",'+
		'              \"catalogItemName\": \"LD Internacional\",'+
		'              \"id\": \"674898000\",'+
		'              \"relationToParentID\": \"5927\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              }'+
		'            },'+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"businessType\": \"REGULAR\",'+
		'              \"catalogItemID\": \"4817\",'+
		'              \"catalogItemName\": \"Roaming Internacional\",'+
		'              \"id\": \"674898001\",'+
		'              \"relationToParentID\": \"5937\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              }'+
		'            },'+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"businessType\": \"REGULAR\",'+
		'              \"catalogItemID\": \"4727\",'+
		'              \"catalogItemName\": \"LD Nacional\",'+
		'              \"id\": \"674898002\",'+
		'              \"relationToParentID\": \"5907\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              }'+
		'            },'+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"businessType\": \"REGULAR\",'+
		'              \"catalogItemID\": \"4787\",'+
		'              \"catalogItemName\": \"Roaming Nacional\",'+
		'              \"id\": \"674898003\",'+
		'              \"relationToParentID\": \"5917\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"action\": \"ADD\",'+
		'          \"businessType\": \"REGULAR\",'+
		'          \"catalogItemID\": \"5367\",'+
		'          \"catalogItemName\": \"Mensagens\",'+
		'          \"id\": \"674898004\",'+
		'          \"relationToParentID\": \"5567\",'+
		'          \"serviceType\": \"GROUP\",'+
		'          \"status\": \"ACTIVE\",'+
		'          \"recurringPrice\": {'+
		'            \"frequency\": \"MONTH\",'+
		'            \"proratedAmount\": \"0.00\",'+
		'            \"proratedDiscountAmount\": \"0.00\",'+
		'            \"proratedTaxAmount\": \"0.00\",'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"previousRecurringPrice\": {'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"taxAmount\": \"0.00\",'+
		'            \"amount\": \"0.00\"'+
		'          },'+
		'          \"oneTimePrice\": {'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"containedServices\": ['+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"businessType\": \"REGULAR\",'+
		'              \"catalogItemID\": \"4637\",'+
		'              \"catalogItemName\": \"SMS\",'+
		'              \"id\": \"674898005\",'+
		'              \"relationToParentID\": \"5877\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"action\": \"ADD\",'+
		'          \"businessType\": \"REGULAR\",'+
		'          \"catalogItemID\": \"319762\",'+
		'          \"catalogItemName\": \"Benefício Móvel\",'+
		'          \"id\": \"674898006\",'+
		'          \"relationToParentID\": \"321172\",'+
		'          \"serviceType\": \"GROUP\",'+
		'          \"status\": \"ACTIVE\",'+
		'          \"recurringPrice\": {'+
		'            \"frequency\": \"MONTH\",'+
		'            \"proratedAmount\": \"0.00\",'+
		'            \"proratedDiscountAmount\": \"0.00\",'+
		'            \"proratedTaxAmount\": \"0.00\",'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"previousRecurringPrice\": {'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"taxAmount\": \"0.00\",'+
		'            \"amount\": \"0.00\"'+
		'          },'+
		'          \"oneTimePrice\": {'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"action\": \"ADD\",'+
		'          \"businessType\": \"REGULAR\",'+
		'          \"catalogItemID\": \"1747\",'+
		'          \"catalogItemName\": \"Plano\",'+
		'          \"id\": \"674898007\",'+
		'          \"relationToParentID\": \"1227\",'+
		'          \"serviceType\": \"GROUP\",'+
		'          \"status\": \"ACTIVE\",'+
		'          \"recurringPrice\": {'+
		'            \"frequency\": \"MONTH\",'+
		'            \"proratedAmount\": \"0.00\",'+
		'            \"proratedDiscountAmount\": \"0.00\",'+
		'            \"proratedTaxAmount\": \"0.00\",'+
		'            \"finalAmount\": \"115.00\",'+
		'            \"finalAmountWithTax\": \"115.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"115.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"previousRecurringPrice\": {'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"taxAmount\": \"0.00\",'+
		'            \"amount\": \"0.00\"'+
		'          },'+
		'          \"oneTimePrice\": {'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          }'+
		'        },'+
		'        {'+
		'          \"action\": \"ADD\",'+
		'          \"businessType\": \"REGULAR\",'+
		'          \"catalogItemID\": \"3107\",'+
		'          \"catalogItemName\": \"SIM & Equipamento\",'+
		'          \"id\": \"674898009\",'+
		'          \"relationToParentID\": \"1247\",'+
		'          \"serviceType\": \"GROUP\",'+
		'          \"status\": \"ACTIVE\",'+
		'          \"recurringPrice\": {'+
		'            \"frequency\": \"MONTH\",'+
		'            \"proratedAmount\": \"0.00\",'+
		'            \"proratedDiscountAmount\": \"0.00\",'+
		'            \"proratedTaxAmount\": \"0.00\",'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"previousRecurringPrice\": {'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"taxAmount\": \"0.00\",'+
		'            \"amount\": \"0.00\"'+
		'          },'+
		'          \"oneTimePrice\": {'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"containedServices\": ['+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"businessType\": \"REGULAR\",'+
		'              \"catalogItemID\": \"3137\",'+
		'              \"catalogItemName\": \"SIM\",'+
		'              \"id\": \"674898018\",'+
		'              \"relationToParentID\": \"1257\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              }'+
		'            }'+
		'          ]'+
		'        },'+
		'        {'+
		'          \"action\": \"ADD\",'+
		'          \"businessType\": \"REGULAR\",'+
		'          \"catalogItemID\": \"4347\",'+
		'          \"catalogItemName\": \"Voz\",'+
		'          \"id\": \"674898011\",'+
		'          \"relationToParentID\": \"5527\",'+
		'          \"serviceType\": \"GROUP\",'+
		'          \"status\": \"ACTIVE\",'+
		'          \"recurringPrice\": {'+
		'            \"frequency\": \"MONTH\",'+
		'            \"proratedAmount\": \"0.00\",'+
		'            \"proratedDiscountAmount\": \"0.00\",'+
		'            \"proratedTaxAmount\": \"0.00\",'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"previousRecurringPrice\": {'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"taxAmount\": \"0.00\",'+
		'            \"amount\": \"0.00\"'+
		'          },'+
		'          \"oneTimePrice\": {'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"containedServices\": ['+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"businessType\": \"REGULAR\",'+
		'              \"catalogItemID\": \"4517\",'+
		'              \"catalogItemName\": \"Chamadas entrantes\",'+
		'              \"id\": \"674898012\",'+
		'              \"relationToParentID\": \"5847\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              }'+
		'            },'+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"businessType\": \"REGULAR\",'+
		'              \"catalogItemID\": \"4487\",'+
		'              \"catalogItemName\": \"Chamadas Saintes\",'+
		'              \"id\": \"674898013\",'+
		'              \"relationToParentID\": \"5837\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              }'+
		'            },'+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"businessType\": \"REGULAR\",'+
		'              \"catalogItemID\": \"5337\",'+
		'              \"catalogItemName\": \"Correio de Voz\",'+
		'              \"id\": \"674898014\",'+
		'              \"relationToParentID\": \"5857\",'+
		'              \"serviceType\": \"SERVICE\",'+
		'              \"status\": \"ACTIVE\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              }'+
		'            }'+
		'          ],'+
		'          \"pricePackages\": ['+
		'            {'+
		'              \"action\": \"ADD\",'+
		'              \"catalogItemID\": \"338982\",'+
		'              \"catalogItemName\": \"Vivo Avisa Grátis\",'+
		'              \"id\": \"674898015\",'+
		'              \"recurringPrice\": {'+
		'                \"frequency\": \"MONTH\",'+
		'                \"proratedAmount\": \"0.00\",'+
		'                \"proratedDiscountAmount\": \"0.00\",'+
		'                \"proratedTaxAmount\": \"0.00\",'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"previousRecurringPrice\": {'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"taxAmount\": \"0.00\",'+
		'                \"amount\": \"0.00\"'+
		'              },'+
		'              \"oneTimePrice\": {'+
		'                \"finalAmount\": \"0.00\",'+
		'                \"finalAmountWithTax\": \"0.00\",'+
		'                \"finalTaxAmount\": \"0.00\",'+
		'                \"originalAmount\": \"0.00\",'+
		'                \"originalTaxAmount\": \"0.00\"'+
		'              },'+
		'              \"billingIdX9\": \"450521334\"'+
		'            }'+
		'          ]'+
		'        }'+
		'      ],'+
		'      \"subscriberRoleX9\": \"Owner\",'+
		'      \"offerClassificationX9\": \"PostPaid\",'+
		'      \"originatingSalesChannel\": \"SH\",'+
		'      \"sharedProduct\": false,'+
		'      \"plans\": ['+
		'        {'+
		'          \"action\": \"ADD\",'+
		'          \"catalogItemID\": \"104376172\",'+
		'          \"catalogItemName\": \"TITULAR VIVO POS 35GB\",'+
		'          \"id\": \"674898008\",'+
		'          \"recurringPrice\": {'+
		'            \"frequency\": \"MONTH\",'+
		'            \"proratedAmount\": \"0.00\",'+
		'            \"proratedDiscountAmount\": \"0.00\",'+
		'            \"proratedTaxAmount\": \"0.00\",'+
		'            \"finalAmount\": \"115.00\",'+
		'            \"finalAmountWithTax\": \"115.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"115.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"previousRecurringPrice\": {'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"taxAmount\": \"0.00\",'+
		'            \"amount\": \"0.00\"'+
		'          },'+
		'          \"oneTimePrice\": {'+
		'            \"finalAmount\": \"0.00\",'+
		'            \"finalAmountWithTax\": \"0.00\",'+
		'            \"finalTaxAmount\": \"0.00\",'+
		'            \"originalAmount\": \"0.00\",'+
		'            \"originalTaxAmount\": \"0.00\"'+
		'          },'+
		'          \"billingIdX9\": \"450521333\"'+
		'        }'+
		'      ],'+
		'      \"previousRecurringPrice\": {'+
		'        \"finalAmountWithTax\": \"0.00\",'+
		'        \"taxAmount\": \"0.00\",'+
		'        \"amount\": \"0.00\"'+
		'      },'+
		'      \"productCatalogID\": \"1197\",'+
		'      \"voiceLineMsisdn\": \"11975968534\",'+
		'      \"productLineOfBusiness\": \"WS\",'+
		'      \"person\": {'+
		'        \"personID\": \"23062932992\"'+
		'      },'+
		'      \"equipment\": false,'+
		'      \"productServiceID\": \"11975968534\",'+
		'      \"productID\": \"674897995\"'+
		'    }'+
		'  ],'+
		'  \"originatingSalesChannel\": \"SH\",'+
		'  \"allowCancel\": false,'+
		'  \"currentSalesChannel\": \"SH\",'+
		'  \"previousRecurringPrice\": {'+
		'    \"finalAmountWithTax\": \"0.00\",'+
		'    \"taxAmount\": \"0.00\",'+
		'    \"amount\": \"0.00\"'+
		'  }'+
		'}';
		RetrieveOrderDetailsResponse r = RetrieveOrderDetailsResponse.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		RetrieveOrderDetailsResponse.Services objServices = new RetrieveOrderDetailsResponse.Services(System.JSON.createParser(json));
		System.assert(objServices != null);
		System.assert(objServices.action == null);
		System.assert(objServices.catalogItemID == null);
		System.assert(objServices.catalogItemName == null);
		System.assert(objServices.id == null);
		System.assert(objServices.relationToParentID == null);
		System.assert(objServices.serviceType == null);
		System.assert(objServices.status == null);
		System.assert(objServices.recurringPrice == null);
		System.assert(objServices.previousRecurringPrice == null);
		System.assert(objServices.oneTimePrice == null);
		System.assert(objServices.containedServices == null);
		System.assert(objServices.businessType == null);
		System.assert(objServices.pricePackages == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		RetrieveOrderDetailsResponse.OrderItems objOrderItems = new RetrieveOrderDetailsResponse.OrderItems(System.JSON.createParser(json));
		System.assert(objOrderItems != null);
		System.assert(objOrderItems.id == null);
		System.assert(objOrderItems.createdBy == null);
		System.assert(objOrderItems.actionType == null);
		System.assert(objOrderItems.creationDate == null);
		System.assert(objOrderItems.description == null);
		System.assert(objOrderItems.referenceNumber == null);
		System.assert(objOrderItems.serviceRequiredDate == null);
		System.assert(objOrderItems.status == null);
		System.assert(objOrderItems.implActionTypeX9 == null);
		System.assert(objOrderItems.provisioningDate == null);
		System.assert(objOrderItems.oacloseDate == null);
		System.assert(objOrderItems.recurringPrice == null);
		System.assert(objOrderItems.oneTimePrice == null);
		System.assert(objOrderItems.plan == null);
		System.assert(objOrderItems.productName == null);
		System.assert(objOrderItems.services == null);
		System.assert(objOrderItems.subscriberRoleX9 == null);
		System.assert(objOrderItems.offerClassificationX9 == null);
		System.assert(objOrderItems.originatingSalesChannel == null);
		System.assert(objOrderItems.sharedProduct == null);
		System.assert(objOrderItems.plans == null);
		System.assert(objOrderItems.previousRecurringPrice == null);
		System.assert(objOrderItems.productCatalogID == null);
		System.assert(objOrderItems.voiceLineMsisdn == null);
		System.assert(objOrderItems.productLineOfBusiness == null);
		System.assert(objOrderItems.person == null);
		System.assert(objOrderItems.equipment == null);
		System.assert(objOrderItems.productServiceID == null);
		System.assert(objOrderItems.productID == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		RetrieveOrderDetailsResponse objRetrieveOrderDetailsResponse = new RetrieveOrderDetailsResponse(System.JSON.createParser(json));
		System.assert(objRetrieveOrderDetailsResponse != null);
		System.assert(objRetrieveOrderDetailsResponse.links == null);
		System.assert(objRetrieveOrderDetailsResponse.creationDate == null);
		System.assert(objRetrieveOrderDetailsResponse.currency_Z == null);
		System.assert(objRetrieveOrderDetailsResponse.id == null);
		System.assert(objRetrieveOrderDetailsResponse.referenceNumber == null);
		System.assert(objRetrieveOrderDetailsResponse.serviceRequiredDate == null);
		System.assert(objRetrieveOrderDetailsResponse.status == null);
		System.assert(objRetrieveOrderDetailsResponse.recurringPrice == null);
		System.assert(objRetrieveOrderDetailsResponse.oneTimePrice == null);
		System.assert(objRetrieveOrderDetailsResponse.orderItems == null);
		System.assert(objRetrieveOrderDetailsResponse.originatingSalesChannel == null);
		System.assert(objRetrieveOrderDetailsResponse.allowCancel == null);
		System.assert(objRetrieveOrderDetailsResponse.currentSalesChannel == null);
		System.assert(objRetrieveOrderDetailsResponse.previousRecurringPrice == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		RetrieveOrderDetailsResponse.RecurringPrice objRecurringPrice = new RetrieveOrderDetailsResponse.RecurringPrice(System.JSON.createParser(json));
		System.assert(objRecurringPrice != null);
		System.assert(objRecurringPrice.frequency == null);
		System.assert(objRecurringPrice.proratedAmount == null);
		System.assert(objRecurringPrice.proratedDiscountAmount == null);
		System.assert(objRecurringPrice.proratedTaxAmount == null);
		System.assert(objRecurringPrice.finalAmount == null);
		System.assert(objRecurringPrice.finalAmountWithTax == null);
		System.assert(objRecurringPrice.finalTaxAmount == null);
		System.assert(objRecurringPrice.originalAmount == null);
		System.assert(objRecurringPrice.originalTaxAmount == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		RetrieveOrderDetailsResponse.ContainedServices objContainedServices = new RetrieveOrderDetailsResponse.ContainedServices(System.JSON.createParser(json));
		System.assert(objContainedServices != null);
		System.assert(objContainedServices.action == null);
		System.assert(objContainedServices.catalogItemID == null);
		System.assert(objContainedServices.catalogItemName == null);
		System.assert(objContainedServices.id == null);
		System.assert(objContainedServices.relationToParentID == null);
		System.assert(objContainedServices.serviceType == null);
		System.assert(objContainedServices.status == null);
		System.assert(objContainedServices.recurringPrice == null);
		System.assert(objContainedServices.previousRecurringPrice == null);
		System.assert(objContainedServices.oneTimePrice == null);
		System.assert(objContainedServices.pricePackages == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		RetrieveOrderDetailsResponse.Links objLinks = new RetrieveOrderDetailsResponse.Links(System.JSON.createParser(json));
		System.assert(objLinks != null);
		System.assert(objLinks.href == null);
		System.assert(objLinks.rel == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		RetrieveOrderDetailsResponse.ContainedServices_Z objContainedServices_Z = new RetrieveOrderDetailsResponse.ContainedServices_Z(System.JSON.createParser(json));
		System.assert(objContainedServices_Z != null);
		System.assert(objContainedServices_Z.action == null);
		System.assert(objContainedServices_Z.businessType == null);
		System.assert(objContainedServices_Z.catalogItemID == null);
		System.assert(objContainedServices_Z.catalogItemName == null);
		System.assert(objContainedServices_Z.id == null);
		System.assert(objContainedServices_Z.relationToParentID == null);
		System.assert(objContainedServices_Z.serviceType == null);
		System.assert(objContainedServices_Z.status == null);
		System.assert(objContainedServices_Z.recurringPrice == null);
		System.assert(objContainedServices_Z.previousRecurringPrice == null);
		System.assert(objContainedServices_Z.oneTimePrice == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		RetrieveOrderDetailsResponse.OneTimePrice objOneTimePrice = new RetrieveOrderDetailsResponse.OneTimePrice(System.JSON.createParser(json));
		System.assert(objOneTimePrice != null);
		System.assert(objOneTimePrice.finalAmount == null);
		System.assert(objOneTimePrice.finalAmountWithTax == null);
		System.assert(objOneTimePrice.finalTaxAmount == null);
		System.assert(objOneTimePrice.originalAmount == null);
		System.assert(objOneTimePrice.originalTaxAmount == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		RetrieveOrderDetailsResponse.Plan objPlan = new RetrieveOrderDetailsResponse.Plan(System.JSON.createParser(json));
		System.assert(objPlan != null);
		System.assert(objPlan.action == null);
		System.assert(objPlan.catalogItemID == null);
		System.assert(objPlan.catalogItemName == null);
		System.assert(objPlan.id == null);
		System.assert(objPlan.recurringPrice == null);
		System.assert(objPlan.previousRecurringPrice == null);
		System.assert(objPlan.oneTimePrice == null);
		System.assert(objPlan.billingIdX9 == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		RetrieveOrderDetailsResponse.Person objPerson = new RetrieveOrderDetailsResponse.Person(System.JSON.createParser(json));
		System.assert(objPerson != null);
		System.assert(objPerson.personID == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		RetrieveOrderDetailsResponse.PreviousRecurringPrice objPreviousRecurringPrice = new RetrieveOrderDetailsResponse.PreviousRecurringPrice(System.JSON.createParser(json));
		System.assert(objPreviousRecurringPrice != null);
		System.assert(objPreviousRecurringPrice.finalAmountWithTax == null);
		System.assert(objPreviousRecurringPrice.taxAmount == null);
		System.assert(objPreviousRecurringPrice.amount == null);
	}

}