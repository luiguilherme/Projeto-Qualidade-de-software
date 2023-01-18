/**
  * @author everis do Brasil
  * @company everis do Brasil
  * @date 30/12/2019
  * @description Classe enviada no pacote da POC de atendimento de retenção
**/
public with sharing class B2C_GraficoMediaFatura{

	@AuraEnabled
	public static String getComboFixa(String accountId) {
        Map<String, Values> mapReturn = new Map<String, Values> ();
        List<Account> lstAccount = new List<Account>();
        List<GeneralParam__c> lstGeneralParams = new List<GeneralParam__c>();
        lstGeneralParams = GeneralParamDAO.getLoadParams();
		List<String> lstCustomerSegment = new List<String>();
        List<String> lstCustomerType = new List<String>();

        DateTime accountLoadDate = lstGeneralParams[0].AccountLoadDate__c;
		DateTime invoiceLoadDate = lstGeneralParams[0].InvoiceLoadDate__c;
        String customerSegment = lstGeneralParams[0].CustomerSegment__c != null ? lstGeneralParams[0].CustomerSegment__c : '';
        /* String customerType = lstGeneralParams[0].CustomerType__c != null ? lstGeneralParams[0].CustomerType__c : '';

		if(customerSegment.contains(';')){
			lstCustomerSegment = customerSegment.split(';');
		}else if(String.isNotBlank(customerSegment)){
			lstCustomerSegment.add(customerSegment);
		}

		if(customerType.contains(';')){
			lstCustomerType = customerType.split(';');
		}else if(String.isNotBlank(customerType)){
			lstCustomerType.add(customerType);
		} */

		lstAccount = [SELECT Id, CustomerSegment__c, WhiteListCharacteristic__c, LastModifiedDate FROM Account WHERE Id = :accountId];
        
        if(lstAccount.isEmpty() || (lstCustomerSegment.contains(lstAccount[0].CustomerSegment__c) && lstAccount[0].LastModifiedDate < accountLoadDate)){
            return JSON.serialize(mapReturn.values());
        }

		Map<String, String> mapMeses = new Map<String, String> { '01' => 'Janeiro', '02' => 'Fevereiro',
			'03' => 'Março', '04' => 'Abril', '05' => 'Maio', '06' => 'Junho', '07' => 'Julho', '08' => 'Agosto',
			'09' => 'Setembro', '10' => 'Outubro', '11' => 'Novembro', '12' => 'Dezembro' };

        /*List<Fatura__c> graficoList = new List<Fatura__c>();

        if(lstCustomerSegment.contains(lstAccount[0].CustomerSegment__c) && lstCustomerType.contains(lstAccount[0].CustomerType__c)){
			graficoList = [select DataReferencia__c,  Media__c, RecordType.DeveloperName
            FROM Fatura__c
            WHERE Cliente__c = :accountId
            AND ( Fat_Total1__c != 0 OR Fat_Total2__c != 0 OR Fat_Total3__c != 0)
            AND LastModifiedDate >: invoiceLoadDate
            ORDER BY DataReferencia__c DESC];
        } else {
            graficoList = [select DataReferencia__c,  Media__c, RecordType.DeveloperName
            FROM Fatura__c
            WHERE Cliente__c = :accountId
            AND ( Fat_Total1__c != 0 OR Fat_Total2__c != 0 OR Fat_Total3__c != 0)
            ORDER BY DataReferencia__c DESC];
        }
					


		for (Fatura__c f : graficoList) {

			if (f.RecordType.DeveloperName == 'Fixa') {
				
                Values vMedia = mapReturn.get('Média');
                if( vMedia == null ) vMedia = new Values();
                vMedia.fixa += f.Media__c;
                vMedia.mes = 'Média';
                mapReturn.put('Média', vMedia);                
			}
			if (f.RecordType.DeveloperName == 'Movel') {
				
                Values vMedia = mapReturn.get('Média');
                if( vMedia == null ) vMedia = new Values();
                vMedia.movel += f.Media__c;
                vMedia.mes = 'Média';
                mapReturn.put('Média', vMedia);    
			}

		}*/
       
        List<Values> lresult = mapReturn.values();
        lresult.sort();
		return JSON.serialize(lresult);

	}


	public class Values implements Comparable {
		@AuraEnabled public String mes;
		@AuraEnabled public Decimal fixa = 0;
		@AuraEnabled public Decimal movel = 0;
        
        public Integer compareTo(Object compareTo) {
            Values valueToCompare = (Values)compareTo;
            if (valueToCompare.mes != 'Média') return -1;
            return 1;     
        }
	}
}