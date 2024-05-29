@istest
public class ImeiSearchAsPdfControllerTest {
    @istest
    private static void executeStatementtest(){
        string varLineNumber = '11915000024'; // aqui o número da linha está 'chumbado'. usar testSetUp!!!
        Map<String, Object> mapOutput = new Map<String, Object>();
        ImeiSearchAsPdfController ObjImeiSearchController = new ImeiSearchAsPdfController(); // instanciando a classe (que não é de teste)
        test.setCurrentPageReference(new PageReference(varLineNumber));
        ApexPages.currentPage().getParameters().put('LineNumber', varLineNumber); // No map declaramos a chave e o valor!
        test.starttest(); // chamar método
        ObjImeiSearchController.executeStatement(); // chamo a variável criada, para que ela invoque o método
        ObjImeiSearchController.getLineNumber();
        mapOutput = ObjImeiSearchController.getIpOutput();
        test.stoptest();      
        System.debug ('Map output: ' + mapOutput);
        System.AssertNotEquals(null, mapOutput, 'O resultado da execução não pode ser nulo.'); // boa prática: 3 parâmetros; (1. valor esperado 2. variável que criamos no controller da classe 3.) 
    }
}