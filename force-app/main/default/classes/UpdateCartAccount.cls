public class UpdateCartAccount {
    /*public static void execute(){
        Map<String, Decimal> mapCartAccount = new Map<String, Decimal>();
        List<CartOffer__c> lstNewCartOffer = new List<CartOffer__c>();
        

        for(CartAccount__c itemTrigger : (List<CartAccount__c>) trigger.new){
            Map<Id, CartAccount__c> oldRecords = (Map<Id, CartAccount__c>) Trigger.oldMap;

            if(itemTrigger.ChipAmount__c != oldRecords.get(itemTrigger.Id).ChipAmount__c) {
                mapCartAccount.put(itemTrigger.Id, itemTrigger.ChipAmount__c);
            }
        }
        
        if(!mapCartAccount.isEmpty()){
            List<CartOffer__c> lstCartOffer = [SELECT CartId__c, OfferId__c, RecordTypeId FROM CartOffer__c WHERE CartId__c IN: mapCartAccount.keySet()  AND RecordType.DeveloperName = 'Mobile'];   
            List<CartOffer__c> lstCartOfferChip = [SELECT CartId__c, OfferId__c FROM CartOffer__c WHERE CartId__c IN: mapCartAccount.keySet() AND RecordType.DeveloperName = 'Chip']; 
            
            if(lstCartOffer.isEmpty()) return;
            
            if (!lstCartOfferChip.isEmpty()) { Database.delete(lstCartOfferChip); }             
            for(String key : mapCartAccount.keySet()) {
                Decimal chipAmount = mapCartAccount.get(key);
                String cartId = key;
                String offerId;

                for (CartOffer__c itemLstCartOffer : lstCartOffer) {
                    if (itemLstCartOffer.CartId__c == cartId) {
                        offerId = itemLstCartOffer.OfferId__c;
                    }
                }

                for(Integer i = 0; i < chipAmount; i++){
                    CartOffer__c newCartOffer = new CartOffer__c(CartId__c=cartId, OfferId__c = offerId);
                    newCartOffer.RecordTypeId = Schema.SObjectType.CartOffer__c.getRecordTypeInfosByDeveloperName().get('Chip').getrecordTypeId();
                    lstNewCartOffer.add(newCartOffer);
                 }
            }

            if (!lstNewCartOffer.isEmpty()) Database.insert(lstNewCartOffer); 
        }              
    }

    public static void validate(){
        Map<String, Decimal> mapCartAccount = new Map<String, Decimal>();
        Map<String, String> mapOffer = new Map<String, String>();

        for(CartAccount__c itemTrigger : (List<CartAccount__c>) trigger.new){
            Map<Id, CartAccount__c> oldRecords = (Map<Id, CartAccount__c>) Trigger.oldMap;
            if(itemTrigger.ChipAmount__c != oldRecords.get(itemTrigger.Id).ChipAmount__c) {
                mapCartAccount.put(itemTrigger.Id, itemTrigger.ChipAmount__c);
            }
        }

        if (!mapCartAccount.isEmpty()) {
            List<CartOffer__c> lstCartOffer = [SELECT CartId__c, OfferId__c FROM CartOffer__c WHERE CartId__c IN :mapCartAccount.keySet() AND RecordType.DeveloperName = 'Mobile'];   

            for (CartOffer__c cartOffer : lstCartOffer) {
                mapOffer.put(cartOffer.CartId__c, cartOffer.OfferId__c);
            }

            List<Offer__c> lstOffers = [SELECT Id, FamilyPlan__c FROM Offer__c WHERE Id =: mapOffer.values()];

            for(CartAccount__c itemTrigger : (List<CartAccount__c>) trigger.new){
                Decimal amountChip = itemTrigger.ChipAmount__c;
                String idOffer = mapOffer.get(itemTrigger.Id);
                for (Offer__c offer : lstOffers) {
                    if (offer.Id == idOffer) {
                       if (!UpdateCartAccount.validaChip(offer.FamilyPlan__c, amountChip)) {
                        itemTrigger.addError('Quantidade de Chip informada fora do permitido para o tipo de plano. Para Plano Família é permitido até 5 chips e para Plano não Família até 3 chips');
                       }
                    }
                }
            }
        }
    }*/

    public static Boolean validaChip(Boolean hasFamilyPlan, Decimal chipAmount){
        if (hasFamilyPlan && (chipAmount >= 1 && chipAmount <= 5)) return true;
        else if (!hasFamilyPlan && (chipAmount >= 1 && chipAmount <= 3)) return true;
        else return false;
    }

    /*public static void validateCartOfferEquality(){
        String recordTypeIdChip = Schema.SObjectType.CartOffer__c.getRecordTypeInfosByDeveloperName().get('Chip').getrecordTypeId();
        Set<Id> setCartAccountId = new set<Id>();
        Boolean hasReasonEmpty = false;
        Integer qtdHabilitacao = 0;
        Integer qtdPortabilidade = 0;
        Integer countChipProducts ;

        for(CartAccount__c itemTrigger : (List<CartAccount__c>) trigger.new){

            Map<Id, CartAccount__c> oldRecords = (Map<Id, CartAccount__c>) Trigger.oldMap;
            if(oldRecords.get(itemTrigger.id).Status__c == 'SaleData' && itemTrigger.Status__c != 'SaleData'){
                setCartAccountId.add(itemTrigger.id);
            }
        }
        if(setCartAccountId.isEmpty()) return;

        List<CartOffer__c> lstCartOffer = [SELECT Id, Reason__c, CartId__c FROM CartOffer__c WHERE CartId__c IN:setCartAccountId AND RecordType.DeveloperName = 'Chip'];
        
        if(lstCartOffer.isEmpty()) return;
        countChipProducts = lstCartOffer.size();

        for(CartOffer__c card : lstCartOffer ){
            if(card.Reason__c == null){
                 hasReasonEmpty = true;
            }
                 
            if(card.Reason__c == 'Enabling'){
                qtdHabilitacao ++;
            }

            if(card.Reason__c == 'Portability'){
                qtdPortabilidade ++;
            }
            
            continue;
        }

        for(CartAccount__c itemTrigger : (List<CartAccount__c>) trigger.new){

            if(hasReasonEmpty){
                itemTrigger.addError('Por Favor!');
                return;
            }

            if((qtdHabilitacao != 0 &&  qtdHabilitacao != countChipProducts) || (qtdPortabilidade != 0 && qtdPortabilidade != countChipProducts )  ){
                itemTrigger.addError('Todos os chips devem conter a mesma Razão!');
                return;
            }
        }

    }*/
}