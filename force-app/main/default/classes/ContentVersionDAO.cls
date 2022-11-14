/** 
 * @author Diego Costa @ Deloitte
 * @date 15/06/2022
 * @description Controla a busca e criação do objeto ContentVersionDAO
 */
public with sharing class ContentVersionDAO {
    
    public static ContentVersion getById(Id idContentVersion){
        return[
            SELECT 
                Id, 
                Title, 
                ContentDocumentId 
            FROM 
                ContentVersion 
            WHERE 
                Id = :idContentVersion
            ];
    }
}