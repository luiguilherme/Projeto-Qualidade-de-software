global class DatatableDataTO {
    @AuraEnabled
    public String key {get; set;}
    
	@AuraEnabled
    public String value {get; set;}

    public DatatableDataTO() {
    }

    public DatatableDataTO(String chave, String valor) {
		key  = chave;
        value    = valor;
    }
}