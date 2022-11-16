public with sharing class OfferController {
  static Integer PAGE_SIZE = 25;
  static String OBJ_NAME = 'Offer__c';
  static String FIELD_SET_OFFER_BOOK = 'dataTableBookIntegrado';

  public class Filters {
    @AuraEnabled
    public String searchKey { get; set; }
    @AuraEnabled
    public String technology { get; set; }
    @AuraEnabled
    public String offerGroup { get; set; }
    @AuraEnabled
    public String bundleType { get; set; }
    @AuraEnabled
    public String broadBand { get; set; }
    @AuraEnabled
    public String tvAttribute { get; set; }
    @AuraEnabled
    public String promotionGroup { get; set; }
    @AuraEnabled
    public String homeAssist { get; set; }
    @AuraEnabled
    public Boolean servAdicionais { get; set; }
    @AuraEnabled
    public Boolean isActive { get; set; }
  }

  public class DatatableInfos {
    public List<DataTableColumns> lstDataTableColumns { get; set; }
    public String fieldsSelect { get; set; }

    public DatatableInfos() {
      lstDataTableColumns = new List<DataTableColumns>();
    }
  }

  private static DataTableColumns getPreviewColumn() {
    TypeAttributes typeAtts = new TypeAttributes('utility:add', '', false, 'preview', 'bare');

    return new DataTableColumns('', '', 'button-icon', true, 30, typeAtts);
  }

  private static DatatableInfos getFieldsFromFieldSet() {
    Schema.SObjectType objType = Schema.getGlobalDescribe().get(OBJ_NAME);
    Schema.DescribeSObjectResult describeObjResult = objType.getDescribe();
    Schema.FieldSet fsObj = describeObjResult.FieldSets.getMap()
      .get(FIELD_SET_OFFER_BOOK);

    List<DataTableColumns> lsDataColumns = new List<DataTableColumns>();
    List<String> lsFieldsToQuery = new List<String>();

    DatatableInfos dbInfos = new DatatableInfos();
    //Inclusão da coluna do botão preview
    lsDataColumns.add(getPreviewColumn());

    for (Schema.FieldSetMember fieldMember : fsObj.getFields()) {
      String dataType = String.valueOf(fieldMember.getType()).toLowerCase();

      DataTableColumns dataCols = new DataTableColumns(
        String.valueOf(fieldMember.getLabel()),
        String.valueOf(fieldMember.getFieldPath()),
        String.valueOf(fieldMember.getType()).toLowerCase(),
        true
      );

      lsDataColumns.add(dataCols);
      lsFieldsToQuery.add(
        dataType == 'datetime'
          ? 'FORMAT(' + String.valueOf(fieldMember.getFieldPath()) + ')'
          : String.valueOf(fieldMember.getFieldPath())
      );
    }

    dbInfos.lstDataTableColumns = lsDataColumns;
    dbInfos.fieldsSelect = String.join(lsFieldsToQuery, ',');

    return dbInfos;
  }

  @AuraEnabled(Cacheable=true)
  public static PagedResult getOffers(Filters filters, Integer pageNumber) {
    String whereClause,
      offerGroup,
      technology,
      bundleType,
      broadBand,
      tvAttribute,
      promotionGroup,
      homeAssist,
      key = '';
    Boolean isActive, servAdicionais;
    String[] criteria = new List<String>{};

    String recordTypeServAdicionais = Schema.SObjectType.Offer__c.getRecordTypeInfosByDeveloperName()
      .get('ServicosAdicionais')
      .getRecordTypeId();
    String recordTypeOfferBook = Schema.SObjectType.Offer__c.getRecordTypeInfosByDeveloperName()
      .get('OfferBook')
      .getRecordTypeId();

    if (filters != null) {
      isActive = filters.isActive;
      criteria.add('IsActive__c = :isActive');

      servAdicionais = filters.servAdicionais;
      if (servAdicionais)
        criteria.add('RecordTypeId = :recordTypeServAdicionais');
      else
        criteria.add('RecordTypeId = :recordTypeOfferBook');

      if (!String.isEmpty(filters.searchKey)) {
        key = '%' + filters.searchKey + '%';
        criteria.add('FixedCampaignRTD__c LIKE :key');
      }

      if (filters.offerGroup != null && filters.offerGroup != '') {
        offerGroup = filters.offerGroup;
        criteria.add('OfferGroup__c = :offerGroup');
      }
      if (filters.technology != null && filters.technology != '') {
        technology = filters.technology;
        criteria.add('Technology__c = :technology');
      }
      if (filters.bundleType != null && filters.bundleType != '') {
        bundleType = filters.bundleType;
        criteria.add('BundleType__c = :bundleType');
      }
      if (filters.broadBand != null && filters.broadBand != '') {
        broadBand = filters.broadBand;
        criteria.add('BroadBandAttribute__c = :broadBand');
      }
      if (filters.tvAttribute != null && filters.tvAttribute != '') {
        tvAttribute = filters.tvAttribute;
        criteria.add('TVAttribute__c = :tvAttribute');
      }
      if (filters.promotionGroup != null && filters.promotionGroup != '') {
        promotionGroup = filters.promotionGroup;
        criteria.add('PromotionGroup__c = :promotionGroup');
      }
      if (filters.homeAssist != null && filters.homeAssist != '') {
        homeAssist = filters.homeAssist;
        if (homeAssist.equalsIgnoreCase('y'))
          criteria.add('HomeAssist__c = true');
        else
          criteria.add('HomeAssist__c = false');
      }
      if (criteria.size() > 0) {
        whereClause = 'WHERE ' + String.join(criteria, ' AND ');
      }
    }

    Integer pageSize = OfferController.PAGE_SIZE;
    Integer offset = (pageNumber - 1) * pageSize;
    DatatableInfos dbInfos = getFieldsFromFieldSet();

    PagedResult result = new PagedResult();
    result.pageSize = pageSize;
    result.pageNumber = pageNumber;
    result.lsColumns = dbInfos.lstDataTableColumns;
    result.totalItemCount = Database.countQuery(
      'SELECT count() FROM Offer__c ' + whereClause
    );

    List<Offer__c> offers = Database.query(
      ' SELECT ID, Description__c, ' +
      dbInfos.fieldsSelect +
      ' FROM Offer__c ' +
      whereClause +
      ' ORDER BY Name LIMIT :pageSize OFFSET :offset'
    );

    result.records = offers;

    return result;
  }

  @AuraEnabled(cacheable=true)
  public static List<Offer__c> getAdditionalServices() {
    String recordTypeServAdicionais = Schema.SObjectType.Offer__c.getRecordTypeInfosByDeveloperName()
      .get('ServicosAdicionais')
      .getRecordTypeId();
      
    return [SELECT ID, FixedCampaignRTD__c,TotalPrice__c 
            FROM Offer__c 
            WHERE RecordTypeId = :recordTypeServAdicionais 
            AND IsActive__c = true
            ORDER BY FixedCampaignRTD__c ASC];
  }
}