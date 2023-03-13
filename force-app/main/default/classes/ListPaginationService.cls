/*
*   Classe de serviço responsável por páginar lista
*	Criação: Carlos Davi - 08/12/2022
*	Alteração:
*/
global class ListPaginationService {

    /**
	 * @author Carlos Davi
     * @date 08/12/2022
	 * @description Responsável por retornar Lista paginada
     * @param jsonInput JSON de lista
     * @param pageSize Tamanho da página
     * @param page Número da página
	 */
    global static String getPaginatedList(String jsonInput, Integer pageSize, Integer page) {
        List<Object> lstObject = (List<Object>) JSON.deserializeUntyped(jsonInput);
        List<Object> lstPaginatedObjects = new List<Object>();
        Integer totalRecords = lstObject.size();
        Integer initialValue = 0;
        Integer endValue = totalRecords;
        String result;

        if (pageSize != null && totalRecords > pageSize) {
            Decimal totalPages = Math.ceil((Decimal) totalRecords/pageSize);

            if (totalPages >= page) {
                initialValue = (page * pageSize) - pageSize;
                endValue = initialValue > 0 ? (initialValue + pageSize) : pageSize;
                endValue = endValue > totalRecords ? totalRecords : endValue;

                for (Integer i = initialValue; i < endValue; i++) {
                    lstPaginatedObjects.add(lstObject[i]);
                }

                result = JSON.serialize(lstPaginatedObjects);
            }
        } else {
            result = JSON.serialize(lstObject);
        }

        return result;
    } 
}