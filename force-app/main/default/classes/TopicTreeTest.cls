/* -------------------------------------------------------------------------
* Autor....: Guilherme Kaiser - Deloitte
* Data.....: 17/10/2023
* Objetivo.: Atualização de pastas e palitos Valentina
* US 535 - Palitagem Manual
*  -------------------------------------------------------------------------
*/
@isTest
public class TopicTreeTest {

    @isTest
    public  static void testCallCenter(){
		TopicTree topic = new TopicTree('CALLCENTER',30,0);
		topic.ExecuteTopicTree();
        //System.debug(output);
    }
    @isTest
    public  static void testLoja(){
		TopicTree topic = new TopicTree('LOJA',30,0);
		topic.ExecuteTopicTree();
        //System.debug(output);
    }    
}