/*
*
*   Description: Classe útil para Ações do GPS
*
*   Author: Geimison Oliveira
*   Date:   23/06/2021
*
*/
global class GPSAction {
	
    @AuraEnabled
	public String id {get; set;}

    @AuraEnabled
	public String name {get; set;}
    
    @AuraEnabled
	public String type {get; set;}
    
    @AuraEnabled
	public String status {get; set;}
    
    @AuraEnabled
	public String answer {get; set;}

    @AuraEnabled
	public String responseTime {get; set;}

    @AuraEnabled
	public String mediaType {get; set;}

    @AuraEnabled
	public String url {get; set;}

    @AuraEnabled
	public String note {get; set;}

    @AuraEnabled
	public String link {get; set;}

    @AuraEnabled
	public String informacoesAdicionais {get; set;}

    @AuraEnabled
	public String error {get; set;}

    @AuraEnabled
	public String linkAlias {get; set;}

    public GPSAction(String idInicial, String nameInicial, String statusInicial, String typeInicial, String answerInicial, String noteInicial, String responseTimeInicial, String mediaTypeInicial, String urlInicial, String linkInicial, String linkLabel, String informacoesAdicionaisInicial, String errorInicial) {
        id      = idInicial;
        name    = nameInicial;
        status    = statusInicial;
        type    = typeInicial;
        answer  = answerInicial;
        note = noteInicial;
        responseTime = responseTimeInicial;
        mediaType = mediaTypeInicial;

        String newURL;
        if (mediaTypeInicial == 'VIDEO') {
            newURL = urlInicial.replace('/watch?v=','/embed/');
        }  
        if (mediaTypeInicial=='IMAGEM'){
            newURL =  urlInicial;
        }
        url = newURL;
        link = linkInicial;
        linkAlias = linkLabel;
        informacoesAdicionais = informacoesAdicionaisInicial;
        error = errorInicial;
    }
}