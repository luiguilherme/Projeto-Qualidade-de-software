/*
 *
 *   Description: Classe útil para itens de um component Tree
 *
 *   Author: Geimison Oliveira
 *   Date:   15/06/2021
 *
 */
global class ItemTreeTO {
    @AuraEnabled
    public String parent {get; set;}

	@AuraEnabled
    public String name {get; set;}

	@AuraEnabled
	public String label {get; set;}

    public ItemTreeTO(String nameInicial, String labelInicial) {
		parent  = null;
        name    = nameInicial;
        label   = labelInicial;
    }

    public ItemTreeTO(String parentInicial, String nameInicial, String labelInicial) {
		parent  = parentInicial;
        name    = nameInicial;
        label   = labelInicial;
    }
}