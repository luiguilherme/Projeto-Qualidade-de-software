@isTest
private class CanvasCPQControllerTest {
    @TestSetup
    static void setup() {
	    AccountTestFactory.start().startPersonAccount().isAccount().create();
    }

    @isTest
    static void getCanvasDataTestMovel(){
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Asset ast = new Asset();
        ast.Name = 'Marcos';
        ast.AccountId = acc.Id;
        insert ast;
        String tipoOferta = 'migration';

        

        Test.startTest();
            Asset asts = [ SELECT Id FROM Asset LIMIT 1];
        	CanvasCPQController.CanvasResult result = CanvasCPQController.getCanvasData(new list<String>{ast.Id},tipoOferta);
        Test.stopTest();
        System.assertEquals(result.canOpenCanvas, true);
    } 

    @isTest
    static void getCanvasDataTestFixa(){
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Asset ast = new Asset();
        ast.Name = 'Marcos';
        ast.AccountId = acc.Id;
        ast.Type__c = 'Fixa';
        ast.ProductType__c = 'Controle';
        insert ast;
        String tipoOferta = 'fixaMigration';

        

        Test.startTest();
            Asset asts = [ SELECT Id FROM Asset LIMIT 1];
        	CanvasCPQController.CanvasResult result = CanvasCPQController.getCanvasData(new list<String>{ast.Id},tipoOferta);
        Test.stopTest();
        System.assertEquals(result.canOpenCanvas, true);
    } 

    @isTest
    static void getCanvasDataTestVivoTotal(){
        Account acc = [ SELECT Id FROM Account LIMIT 1];
        Asset ast = new Asset();
        ast.Name = 'Marcos';
        ast.AccountId = acc.Id;
        ast.Type__c = 'Movel';
        ast.ProductType__c = 'Pré-Pago';
        insert ast;
        String tipoOferta = 'vivoTotalMigration';
       

        

        Test.startTest();
            Asset asts = [ SELECT Id FROM Asset LIMIT 1];
        	CanvasCPQController.CanvasResult result = CanvasCPQController.getCanvasData(new list<String>{ast.Id},tipoOferta);
        Test.stopTest();
        System.assertEquals(result.canOpenCanvas, true);
    } 

    @isTest
    static void getCanvasDataTestWithoutRecordId(){

        Test.startTest();       
            CanvasCPQController.CanvasResult result = CanvasCPQController.getCanvasData(new list<String>(),'migration');
        Test.stopTest();
        System.assertEquals(result.canOpenCanvas, false);
    } 
}