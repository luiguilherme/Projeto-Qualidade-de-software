/*
---------------------------------------------------
@authors -  Rafael Silva
@company - Telefonica 
@date - 09/02/2021
@description - Classe Controller do componente
que detecta anormalidades (como robô) baseado em critérios
---------------------------------------------------

*/
public class UnsualUserTrackingController {

    private static final List<GeneralParam__c> lstGeneralParams = GeneralParamDAO.getLoadParams();
    
    @AuraEnabled
    public static String checkPartnerAccess(){
        
        System.debug('UnsualUserTrackingController:  1');
        if(lstGeneralParams == null || lstGeneralParams.isEmpty()) return '';

        Datetime myDT = Datetime.now();
        String myDate = myDT.format('HH:mm');
        Integer horaAtual = Integer.valueOf(myDT.format('HH'));
        Integer minutoAtual = Integer.valueOf(myDT.format('mm'));
        Integer minutosTotalAtual = (horaAtual * 60) + minutoAtual;

        String keyCache = UserInfo.getUserId(); //esse cache inicial serve pra qdo a chave for o minuto.

        Cache.SessionPartition sessionPartition = Cache.Session.getPartition('local.PartnerAccessAccount');
        Boolean isCached = sessionPartition.contains(keyCache);
        
        //O padrão retornado no campo sempre deve ser: QTDE ACESSOS/MINUTOS;QTDE ACESSOS/MINUTOS; (...)  
        List<String> lstAccessMinuteGeneralParams = lstGeneralParams.get(0).AccessesMinute__c.split(';');
        String[] valuesInCache = (isCached ? ((String) sessionPartition.get(keyCache)).split(';') : null );

        Integer count = 0; //utilizado para auxiliar a posição correta na iteração;
        
        Boolean isLogout = false;

        //PADRAO CHAVE_A/ACESSOS_A;CHAVE_B/ACESSOS_B
        String newValueCache = '';

        for(String item : lstAccessMinuteGeneralParams) {

            //item: QTDE_ACESSOS / MINUTOS
            List<String> acessoMinuto = item.split('/');  
            Integer qtdeAcesso = Integer.valueOf(acessoMinuto.get(0));
            Integer minuto     = Integer.valueOf(acessoMinuto.get(1));

            Integer keyInt = minutosTotalAtual / minuto;
            String key = String.valueOf(keyInt);

            Integer qtdeAcessosRealizados = 1;

            if(isCached) {
                List<String> itemCached = valuesInCache.get(count).split('/');
                Integer itemKey         = Integer.valueOf(itemCached.get(0));
                Integer itemQtdeAcessos = Integer.valueOf(itemCached.get(1));

                if(keyInt == itemKey) {
                    qtdeAcessosRealizados = itemQtdeAcessos + 1;

                    if(qtdeAcessosRealizados > qtdeAcesso) {
                        isLogout = true;
                    } 
                }
            } 

            newValueCache = (newValueCache != '' ? newValueCache + ';' : '');
            newValueCache = newValueCache + key + '/' + qtdeAcessosRealizados;
            
            System.debug('countAccess: ' + key + ';' + qtdeAcessosRealizados);
            count += 1;
        }

        sessionPartition.put(keyCache,newValueCache);

    	if(isLogout) return 'logout';
        
        return '';
    }
        
}