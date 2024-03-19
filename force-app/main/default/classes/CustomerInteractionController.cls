/*
*   Classe responsável por manipular JSON de Protocolos
*	Criação: Carlos Davi - 24/11/2022
*	Alteração: US-441-442-443 - Carlos Davi e João Pedro - 07/12/2022
*/
global class CustomerInteractionController implements vlocity_cmt.VlocityOpenInterface2 {

    global Boolean invokeMethod(String methodName, Map<String, Object> inputMap, Map<String, Object> outputMap, Map<String, Object> optionMap) {


        Boolean success = true;
        String errors;

        try {
            switch on methodName {
                when 'getHierarchyProtocols' {
                    getHierarchyProtocols(inputMap, outputMap); 
                }
            }

        } catch(Exception e) {
            errors = e.getMessage(); 
            success = false;
        }

        outputMap.put('success', success);
        outputMap.put('error', errors);

        return success;
    }

    /**
	 * @author Carlos Davi
     * @date 24/11/2022
	 * @description Responsável por retornar JSON de Protocolos no padrão esperado
     * @param jsonInput JSON retornado pelo serviço
	 */
    private void getHierarchyProtocols(Map<String, Object> inpMap, Map<String, Object> outMap) {

        CurrentProtocolItemsWrapper currentProtocol = (CurrentProtocolItemsWrapper) JSON.deserialize(JSON.serialize(inpMap), CurrentProtocolItemsWrapper.class);
        Map<String, ExpectedProtocolItemsWrapper> mapProtocols = new Map<String, ExpectedProtocolItemsWrapper>();

        for (ProtocolItems item : currentProtocol.protocolItems) {
            String protocolNumber = item.protocol.protocolNumber;
            item.ItemProtocol.IdProtocolItem = item.idProtocolItem;
            if (!mapProtocols.containsKey(protocolNumber)) {
                ExpectedProtocolItemsWrapper pt = new ExpectedProtocolItemsWrapper(
                    protocolNumber,
                    item.network.geographicAreaCode +''+ item.network.networkNumber,
                    item.relatedProtocol.protocolNumber,
                    item.protocol.protocolStatus,
                    item.sourceSystem.systemName,
                    item.protocol.openingDate,
                    item.protocol.closingDate,
                    new List<ItemProtocol> {item.itemProtocol}
                );

                mapProtocols.put(protocolNumber, pt);
            } else {
                mapProtocols.get(protocolNumber).itemsProtocol.add(item.itemProtocol);
            }
        }

        List<ExpectedProtocolItemsWrapper> allExpectedProtocolItemsLst = mapProtocols.values();

        String paginatedList = ListPaginationService.getPaginatedList(
            JSON.serialize(allExpectedProtocolItemsLst), 
            currentProtocol.PageSize, 
            currentProtocol.CurrentPage
        );
        
        outMap.put('protocols', paginatedList);
    }

    /* Inicio - Protocolo retornado */
    class CurrentProtocolItemsWrapper {
        Integer CurrentPage;
        Integer PageSize;
        List<ProtocolItems> protocolItems;
    }

    class ProtocolItems {
        RelatedProtocol relatedProtocol;
        SourceSystem sourceSystem;
        ItemProtocol itemProtocol;
        Network network;
        Protocol protocol;
        String idProtocolItem;
    }

    class RelatedProtocol {
        String protocolNumber;
    }

    class SourceSystem {
        String systemName;
    }

    class ItemProtocol {
        String closingDate;
        String openingDate;
        String subStatus;
        String status;
        String description;
        String idProtocolItem;
    }

    class Network {
        Integer digitNetwork;
        Integer networkNumber;
        Integer geographicAreaCode;
    }

    class Protocol {
        String protocolStatus;
        String protocolType;
        String closingDate;
        String openingDate;
        String smsClassification;
        String submissionStatus;
        String protocolNumber;
    }
    /* Fim - Protocolo retornado */

    /* Inicio - Protocolo esperado */
    class ExpectedProtocolItemsWrapper {
        String protocolNumber;
        String lineNumber;
        String relatedProtocol;
        String status;
        String systemName;
        String openingDate;
        String closingDate;
        List<ItemProtocol> itemsProtocol;

        ExpectedProtocolItemsWrapper(String protocolNumber, String lineNumber, String relatedProtocol, String status, String systemName, String openingDate, String closingDate, List<ItemProtocol> itemsProtocol) {
            this.protocolNumber = protocolNumber;
            this.lineNumber = lineNumber;
            this.relatedProtocol = relatedProtocol;
            this.status = status;
            this.systemName = systemName;
            this.openingDate = openingDate;
            this.closingDate = closingDate;
            this.itemsProtocol = itemsProtocol;
        }
    }
    /* Fim - Protocolo esperado */
}