/* -------------------------------------------------------------------------
* Autor....: Guilherme Kaiser - Deloitte
* Data.....: 21/08/2023
* Objetivo.: Atualização de pastas e palitos Valentina
* US 535 - Palitagem Manual
*  -------------------------------------------------------------------------
* Data: 29/11/2023
* Modificação: Inclusão de campos bloco 9
*  -------------------------------------------------------------------------
* Data: 25/04/2024
* Modificação: Alterado para executar StaticResources
*  PALITOSLOJASRELEASEJULHO2024, 
*  -------------------------------------------------------------------------
* How to execute:

        TopicTree topic = new TopicTree('LOJA',30,0);
        topic.ExecuteTopicTree();

        TopicTree topic = new TopicTree('CALLCENTER',30,0);
        topic.ExecuteTopicTree();

        TopicTree topic = new TopicTree('PALITOSLOJASBLOCO9',30,0);
        topic.ExecuteTopicTree();

        TopicTree topic = new TopicTree('PALITOSCALLCENTERBLOCO9',30,0);
        topic.ExecuteTopicTree();

        TopicTree topic = new TopicTree('PALITOSLOJASRELEASEJULHO2024',30,0);
        topic.ExecuteTopicTree();

        TopicTree topic = new TopicTree('PALITOSCALLCENTERRELEASEJULHO2024',30,0);
        topic.ExecuteTopicTree();

        TopicTree topic = new TopicTree('PALITOSLOJASRELEASESETEMBRO2024',30,0);
        topic.ExecuteTopicTree();

        TopicTree topic = new TopicTree('PALITOSCALLCENTERRELEASESETEMBRO2024',30,0);
        topic.ExecuteTopicTree();

*/
public class TopicTree {

    @TestVisible
    private static String staticResourceLojaseRevendas                    = 'PalitosLojaseRevendas';
    private static String staticResourceCallCenter                        = 'PalitosCallCenter';
    private static String staticResourcePalitosLojasBloco9                = 'PalitosLojasBloco9';
    private static String staticResourcePalitosCallCenterBloco9           = 'PalitosCallCenterBloco9';
    private static String staticResourcePalitosLojasReleaseJulho2024      = 'PalitosLojasReleaseJulho2024';
    private static String staticResourcePalitosCallCenterReleaseJulho2024 = 'PalitosCallCenterReleaseJulho2024';    
    private static String staticResourcePalitosCallCenterReleaseJulho2024V2 = 'PalitosCallCenterReleaseJulho2024V2';
    private static String staticResourcePalitosLojasReleaseSetembro2024      = 'PalitosLojasReleaseSetembro2024';
    private static String staticResourcePalitosCallCenterReleaseSetembro2024 = 'PalitosCallCenterReleaseSetembro2024';    
    //
    Map<String, CustomerInteractionTopicTree__c> mapTopicsDedup = new Map<String, CustomerInteractionTopicTree__c>();    
	// 
    public String file;
    public Integer qtyRecords=0;
    public Integer posRecord=0;
    public Integer countRecord=0;
    public String key;
    
    public String IdLevel0;
    public String IdLevel1;
    public String IdLevel2;
    public String IdLevel3;
    public String IdLevel4;
    public String IdLevel5;
    //
    public Boolean hasLevel0=false;
    public Boolean hasLevel1=false;
    public Boolean hasLevel2=false;
    public Boolean hasLevel3=false;
    public Boolean hasLevel4=false;
    public Boolean hasLevel5=false;
    
    private static StaticResource getResourceLojaseRevendas(){    
        return [SELECT ID, body FROM StaticResource WHERE Name =: staticResourceLojaseRevendas LIMIT 1];
    }    
    private static StaticResource getResourceCallCenter(){
        return [SELECT ID, body FROM StaticResource WHERE Name =: staticResourceCallCenter LIMIT 1];
    }    
    private static StaticResource getResourcestaticResourcePalitosLojasBloco9(){
        return [SELECT ID, body FROM StaticResource WHERE Name =: staticResourcePalitosLojasBloco9 LIMIT 1];
    }    
    private static StaticResource getResourcestaticResourcePalitosCallCenterBloco9(){
        return [SELECT ID, body FROM StaticResource WHERE Name =: staticResourcePalitosCallCenterBloco9 LIMIT 1];
    }        
    private static StaticResource getResourcestaticResourcePalitosLojasReleaseJulho2024(){
        return [SELECT ID, body FROM StaticResource WHERE Name =: staticResourcePalitosLojasReleaseJulho2024 LIMIT 1];
    }            
    private static StaticResource getResourcestaticResourcePalitosCallCenterReleaseJulho2024(){
        return [SELECT ID, body FROM StaticResource WHERE Name =: staticResourcePalitosCallCenterReleaseJulho2024 LIMIT 1];
    } 
    private static StaticResource getResourcestaticResourcePalitosCallCenterReleaseJulho2024V2(){
        return [SELECT ID, body FROM StaticResource WHERE Name =: staticResourcePalitosCallCenterReleaseJulho2024V2 LIMIT 1];
    }                
    private static StaticResource getResourcestaticResourcePalitosLojasReleaseSetembro2024(){
        return [SELECT ID, body FROM StaticResource WHERE Name =: staticResourcePalitosLojasReleaseSetembro2024 LIMIT 1];
    }            
    private static StaticResource getResourcestaticResourcePalitosCallCenterReleaseSetembro2024(){
        return [SELECT ID, body FROM StaticResource WHERE Name =: staticResourcePalitosCallCenterReleaseSetembro2024 LIMIT 1];
    }    
              

	public class Topic {
		public String SEQ;
		public String ProductType;
		public String ServiceTree;
		public String Level0;
		public String Level1;
		public String Level2;
		public String Level3;
		public String Level4;
		public String Level5;
		public String Type;
		public String IdVivoNet;
		public String Active;
		public String CustomerTypes;
		public String LinesTypes;
		public String Segmentations;
		public String Channels;
		public String SendSMS;
		public String Classification;
		public String RelationshipType;
		public String CaseOpening;
		public String CaseReturn;
        public String CaseHandling;
        public String FormType;
        public String SLA;
        public String CustomerFeedback;
        public String VisibleTo;
        public String CaseStatusGenTopic;        
	}
	
	public static List<Topic> parse(String json, Integer qty, Integer pos) {
		return (List<Topic>) System.JSON.deserialize(json, List<Topic>.class);
               
/*    	Integer Count = 0;
        
    	List<Topic> lstNewTopics;
    	List<Topic> lstTopics = (List<Topic>) System.JSON.deserialize(json, List<Topic>.class);
    	system.debug('size....'+ lstTopics.Size());
        if(pos >0){Count = pos;}
        
		for(Topic obj : lstTopics) {
            Count++;
			if((Count > pos) && (Count <= (qty + pos))) {
                System.debug('Count..:'+Count);
				lstNewTopics.add(obj);
			}
	        system.debug('Count.......:'+Count);
	        system.debug('qtyRecords..:'+qty);
    	    system.debug('posRecorde..:'+pos);
		}        
        return lstNewTopics;
*/
	}    
    
    public String getId(String source, String name, String type,String idVivoNet, String classification, String sendSMS ,String productType, String serviceTree, String active, String customerTypes, String linesTypes, String segmentations, String channels, String relationshipType, String caseOpening, String caseReturn, String caseHandling, String formType, String sla, String customerFeedback, String visibleTo, String caseStatusGenTopic){
		//
        String Id=null;
        CustomerInteractionTopicTree__c[] objAuxiliar;        
        
        this.key = 'ParentTopicId__c='+source+'|name='+name+'|type__c='+type;
		system.debug('KEY.:'+this.key);
        
        //map tem a chave do registro já inserido
        if (this.mapTopicsDedup.containsKey(this.key)){
            //se encontrou o registro no map então recupera o id do map e add para fazer um upsert
            //Guarda os valores duplicados
            CustomerInteractionTopicTree__c recordAux = this.mapTopicsDedup.get(key);
            //
            Id = recordAux.Id;
            System.debug('recuperou Id no map..: '+ Id);
            //
        }else{       
            //
            System.debug('não achou Id na mapTopicsDedup para chave..: '+ this.key);
            //
            if( Limits.getQueries() < 100){
                
                if(name=='Início' && type=='Pasta' && source==null){
                	objAuxiliar = [SELECT id, ParentTopicId__c, Name, type__c from CustomerInteractionTopicTree__c where ParentTopicId__c = :source and name = :name and type__c=:type and Active__c= true];
                }else{
                	objAuxiliar = [SELECT id, ParentTopicId__c, Name, type__c from CustomerInteractionTopicTree__c where ParentTopicId__c = :source and name = :name and type__c=:type and ProductType__c= 'Pre' and ServiceTree__c = :serviceTree and Active__c= true];
                }
                Id = (objAuxiliar.size() >0) ? objAuxiliar[0].Id : null;

                if(Id!=null){
        			this.mapTopicsDedup.put(this.key, objAuxiliar[0]);
                    System.debug('Teste key..: '+ this.key);
                    System.debug('ObjAuxiliar[0] .: '+ objAuxiliar[0]);
                }else{
                    if( Limits.getQueries() < 100){
                        if(type=='Pasta'){
                            Id = insertFolder(source, name, productType, serviceTree, active, relationshipType);
                        }else{
                            Id = insertTopic (source, name, idVivoNet, classification, sendSMS, productType, serviceTree, active, customerTypes, linesTypes, segmentations, channels, relationshipType, caseOpening, caseReturn, caseHandling, formType, sla, customerFeedback, visibleTo, caseStatusGenTopic);
                        }                        
                    }else{                
                        System.debug('***** Limite de inserção.  *****'+ Limits.getQueries());
                        System.debug('***** Limite atingido. Execute novamente para inserir os demais registros *****');
                    }
                }			
            }
        }
        System.debug('source:'+ Source + ' name: '+name + ' Id: '+ Id);        
        return Id;
    }

    public String insertFolder(String parentTopic, String folderName, String productType, String serviceTree, String active, String relationshipType){
        CustomerInteractionTopicTree__c record = new CustomerInteractionTopicTree__c(Name= folderName,Type__c='Pasta', RelationshipType__c= relationshipType, Active__c= Boolean.valueOf(active), ProductType__c= productType, ServiceTree__c = serviceTree, ParentTopicId__c= parentTopic);
		Database.insert(record, false);

        this.mapTopicsDedup.put(this.key, record);
        
        String Id = record.Id;
        return Id;
    }    
    public String insertTopic(String parentTopic, String folderName, String idVivoNet, String classification, String sendSMS ,String productType, String serviceTree, String active, String customerTypes, String linesTypes, String segmentations, String channels, String relationshipType, String caseOpening, String caseReturn, String caseHandling, String formType, String sla, String customerFeedback, String visibleTo, String caseStatusGenTopic){
        CustomerInteractionTopicTree__c record = new CustomerInteractionTopicTree__c(Name= folderName,Type__c='Palito', RelationshipType__c= relationshipType, Active__c= Boolean.valueOf(active), ProductType__c= productType , ServiceTree__c = serviceTree ,ParentTopicId__c= parentTopic, idVivoNet__c = idVivoNet ,CustomerTypes__c = customerTypes, LinesTypes__c = linesTypes, Segmentations__c = segmentations, SendSMS__c = Boolean.valueOf(sendSMS), Classification__c= classification, Channels__c= channels, CaseOpening__c = caseOpening, CaseReturn__c = caseReturn, CaseHandling__c= caseHandling, FormType__c = formType, SLA__c = sla, CustomerFeedback__c = customerFeedback, VisibleTo__C = visibleTo, CaseStatusGenTopic__c = caseStatusGenTopic);
		Database.insert(record, true);
        
        system.debug('this.key insertTopic..: '+ this.key);        
        this.mapTopicsDedup.put(this.key, record);
        
        String Id = record.Id;
        return Id;
    }    
    
    public void makeMapTopicsDedup(){   
		
        String serviceTree ='';
        
    	if(this.file=='LOJA' || this.file=='PALITOSLOJASBLOCO9' || this.file=='PALITOSLOJASRELEASEJULHO2024' || this.file=='PALITOSLOJASRELEASESETEMBRO2024'){
            serviceTree = 'Store';
        }else if(this.file=='CALLCENTER' || this.file=='PALITOSCALLCENTERBLOCO9' || this.file=='PALITOSCALLCENTERRELEASEJULHO2024' || this.file=='PALITOSCALLCENTERRELEASEJULHO2024V2' || this.file=='PALITOSCALLCENTERRELEASESETEMBRO2024'){
            serviceTree = 'Service';
        }
        System.debug('--------------------------------------');
        System.debug('makeMapTopicsDedup');
        List<CustomerInteractionTopicTree__c> lstTopicsDatabase = [SELECT id, ParentTopicId__c, Name, type__c from CustomerInteractionTopicTree__c where ProductType__c= 'Pre' and ServiceTree__c = :serviceTree and Active__c= true];
        
        for(CustomerInteractionTopicTree__c topic : lstTopicsDatabase) {
        	this.key = 'ParentTopicId__c='+topic.ParentTopicId__c+'|name='+topic.name+'|type__c='+topic.type__c;
            this.mapTopicsDedup.put(key, topic);
        }
        System.debug('Total Itens Map..: '+this.mapTopicsDedup.Size());
        System.debug('--------------------------------------');            
        this.key = '';
    } 
    
    /**
	* file: {LOJA,CALLCENTER,PALITOSLOJASBLOCO9,'PALITOSLOJASBLOCO9}
    */
    public TopicTree(String File, Integer QtyRecords, Integer PosRecord) {
        this.file = File;
        this.qtyRecords = QtyRecords;
        this.posRecord  = PosRecord;
    }

    public void ExecuteTopicTree() {   
        system.debug('file........:'+this.file);
        system.debug('qtyRecords..:'+this.qtyRecords);        
        system.debug('posRecord...:'+this.posRecord);
        
        makeMapTopicsDedup();
        
        StaticResource sr;
        if(file=='LOJA'){
            sr = getResourceLojaseRevendas();
        }else if(file=='CALLCENTER'){
            sr = getResourceCallCenter();            
        }else if(file=='PALITOSLOJASBLOCO9'){
            sr = getResourcestaticResourcePalitosLojasBloco9();
        }else if(file=='PALITOSCALLCENTERBLOCO9'){
            sr = getResourcestaticResourcePalitosCallCenterBloco9();
        }else if(file=='PALITOSLOJASRELEASEJULHO2024'){
            sr = getResourcestaticResourcePalitosLojasReleaseJulho2024();
        }else if(file=='PALITOSCALLCENTERRELEASEJULHO2024'){
            sr = getResourcestaticResourcePalitosCallCenterReleaseJulho2024();
        }else if(file=='PALITOSCALLCENTERRELEASEJULHO2024V2'){
            sr = getResourcestaticResourcePalitosCallCenterReleaseJulho2024V2();    
        }else if(file=='PALITOSLOJASRELEASESETEMBRO2024'){
            sr = getResourcestaticResourcePalitosLojasReleaseSetembro2024();
        }else if(file=='PALITOSCALLCENTERRELEASESETEMBRO2024'){
            sr = getResourcestaticResourcePalitosCallCenterReleaseSetembro2024();
        }
        if(sr != null && sr.Body != null) {
            String content = sr.Body.toString();
            
            System.debug('content: '+ JSON.serializePretty(content));
            
            if(content!= null) {
                //
                List<Topic> lstTopics = parse(content, this.qtyRecords, this.posRecord);
                //
                system.debug('Qtde elementos no JSON:'+ lstTopics.Size());
				//
                for(Topic topic : (List<Topic>) lstTopics) {
                    String IdLevel1=null;
                    String IdLevel2=null;
                    String IdLevel3=null;
                    String IdLevel4=null;
                    String IdLevel5=null;
                    
                    hasLevel0=(topic.Level0!='');
                    hasLevel1=(topic.Level1!='');
                    hasLevel2=(topic.Level2!='');
                    hasLevel3=(topic.Level3!='');
                    hasLevel4=(topic.Level4!='');
                    hasLevel5=(topic.Level5!='');
                    //
                    System.debug('--------------------------------------');
                    system.debug('SEQ...:'+ topic.SEQ);
                	system.debug('itens no listTopics'+ lstTopics.get(Integer.valueOf(topic.SEQ)));
                    //
                    if(topic.Type=='Pasta'){
                        system.debug('Pasta');
                        //
                        if(hasLevel0){ /* NIVEL 0 */ 
                            IdLevel0 = getId(null, topic.Level0,'Pasta',null,null,null,topic.ProductType, topic.ServiceTree, topic.Active,null,null,null,null,topic.RelationshipType, null, null, null, null, null, null, null, null ); 
                            //
                            if(IdLevel0!=null && hasLevel1){ /* NIVEL 1 */
                                IdLevel1 = getId(IdLevel0 , topic.Level1,'Pasta',null,null,null,topic.ProductType, topic.ServiceTree, topic.Active,null,null,null,null,topic.RelationshipType, null, null, null, null, null, null, null, null);
                                //
                                if(IdLevel1!=null && hasLevel2){ /* NIVEL 2 */
                                    IdLevel2 = getId(IdLevel1 , topic.Level2,'Pasta',null,null,null,topic.ProductType, topic.ServiceTree, topic.Active,null,null,null,null,topic.RelationshipType, null, null, null, null, null, null, null, null);
                                    
                                    if(IdLevel2!=null && hasLevel3){ /* NIVEL 3 */
                                        IdLevel3 = getId(IdLevel2 , topic.Level3,'Pasta',null,null,null,topic.ProductType, topic.ServiceTree, topic.Active,null,null,null,null,topic.RelationshipType, null, null, null, null, null, null, null, null);
                                        
                                        if(IdLevel3!=null && hasLevel4){ /* NIVEL 4 */
                                            IdLevel4 = getId(IdLevel3 , topic.Level4,'Pasta',null,null,null,topic.ProductType, topic.ServiceTree, topic.Active,null,null,null,null,topic.RelationshipType, null, null, null, null, null, null, null, null);
                                            
                                            if(IdLevel4!=null && hasLevel5){ /* NIVEL 5 */
                                                IdLevel5 = getId(IdLevel4 , topic.Level5,'Pasta',null,null,null,topic.ProductType, topic.ServiceTree, topic.Active,null,null,null,null,topic.RelationshipType, null, null, null, null, null, null, null, null);
                                                
                                            }		
                                        }   
                                    }
                                }
                            }
                        }
                    }else if(topic.Type=='Palito'){
                        system.debug('Palito');   
                        
                        if(hasLevel0){ /* NIVEL 0 */ 
                            String IdLevel0 = getId(null, topic.Level0,'Pasta',null,null,null,topic.ProductType, topic.ServiceTree, topic.Active,null,null,null,null,topic.RelationshipType, null, null, null, null, null, null, null, null);
                            //
                            if(IdLevel0!=null && hasLevel1){ /* NIVEL 1 */
                                if(hasLevel2){
                                    IdLevel1 = getId(IdLevel0 , topic.Level1,'Pasta',null,null,null,topic.ProductType, topic.ServiceTree, topic.Active,null,null,null,null,topic.RelationshipType, null, null, null, null, null, null, null, null);
                                }else{
                                    IdLevel1 = getId(IdLevel0, topic.Level1, 'Palito', topic.IdVivoNet, topic.Classification, topic.SendSMS, topic.ProductType, topic.ServiceTree, topic.Active, topic.CustomerTypes, topic.LinesTypes, topic.Segmentations, topic.Channels,topic.RelationshipType, topic.CaseOpening, topic.CaseReturn, topic.CaseHandling, topic.FormType, topic.SLA, topic.CustomerFeedback, topic.VisibleTo, topic.CaseStatusGenTopic);
                                }
                                //
                                if(IdLevel1!=null && hasLevel2){ /* NIVEL 2 */
                                    if(hasLevel3){
                                        IdLevel2 = getId(IdLevel1 , topic.Level2,'Pasta',null,null,null,topic.ProductType, topic.ServiceTree, topic.Active,null,null,null,null,topic.RelationshipType, null, null, null, null, null, null, null, null);
                                    }else{
                                        IdLevel2 = getId(IdLevel1, topic.Level2, 'Palito', topic.IdVivoNet, topic.Classification, topic.SendSMS, topic.ProductType, topic.ServiceTree, topic.Active, topic.CustomerTypes, topic.LinesTypes, topic.Segmentations, topic.Channels,topic.RelationshipType, topic.CaseOpening, topic.CaseReturn, topic.CaseHandling, topic.FormType, topic.SLA, topic.CustomerFeedback, topic.VisibleTo, topic.CaseStatusGenTopic);
                                    }                                        
                                    //
                                    if(IdLevel2!=null && hasLevel3){ /* NIVEL 3 */
                                        if(hasLevel4){
                                            IdLevel3 = getId(IdLevel2 , topic.Level3,'Pasta',null,null,null, topic.ProductType, topic.ServiceTree, topic.Active,null,null,null,null,topic.RelationshipType, null, null, null, null, null, null, null, null);
                                        }else{
                                            IdLevel3 = getId(IdLevel2, topic.Level3, 'Palito', topic.IdVivoNet, topic.Classification, topic.SendSMS, topic.ProductType, topic.ServiceTree, topic.Active, topic.CustomerTypes, topic.LinesTypes, topic.Segmentations, topic.Channels,topic.RelationshipType, topic.CaseOpening, topic.CaseReturn, topic.CaseHandling, topic.FormType, topic.SLA, topic.CustomerFeedback, topic.VisibleTo, topic.CaseStatusGenTopic);
                                        }                                        
                                        //
                                        if(IdLevel3!=null && hasLevel4){ /* NIVEL 4 */                                            
                                            if(hasLevel5){
                                                IdLevel4 = getId(IdLevel3 , topic.Level4,'Pasta',null,null,null,topic.ProductType, topic.ServiceTree, topic.Active,null,null,null,null,topic.RelationshipType, null, null, null, null, null, null, null, null);
                                            }else{
                                                IdLevel4 = getId(IdLevel3, topic.Level4, 'Palito', topic.IdVivoNet, topic.Classification, topic.SendSMS, topic.ProductType, topic.ServiceTree, topic.Active, topic.CustomerTypes, topic.LinesTypes, topic.Segmentations, topic.Channels,topic.RelationshipType, topic.CaseOpening, topic.CaseReturn, topic.CaseHandling, topic.FormType, topic.SLA, topic.CustomerFeedback, topic.VisibleTo, topic.CaseStatusGenTopic);
                                            }                                        
                                            //
                                            if(IdLevel4!=null && hasLevel5){ /* NIVEL 5 */
                                                IdLevel5 = getId(IdLevel4, topic.Level5, 'Palito', topic.IdVivoNet, topic.Classification, topic.SendSMS, topic.ProductType, topic.ServiceTree, topic.Active, topic.CustomerTypes, topic.LinesTypes, topic.Segmentations, topic.Channels,topic.RelationshipType, topic.CaseOpening, topic.CaseReturn, topic.CaseHandling, topic.FormType, topic.SLA, topic.CustomerFeedback, topic.VisibleTo, topic.CaseStatusGenTopic);
                                            }                                        
                                        }		
                                    }   
                                }
                            }
                        }
                    }
                }                    
            }
        }    
    }
}