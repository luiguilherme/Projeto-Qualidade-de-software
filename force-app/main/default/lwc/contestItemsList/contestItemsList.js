import { LightningElement, track } from 'lwc';
import { OmniscriptActionCommonUtil } from "vlocity_cmt/omniscriptActionUtils";
import pubsub from "vlocity_cmt/pubsub";
import { interpolateWithRegex } from 'vlocity_cmt/flexCardUtility';

const selectionColumns = [
    { label: '', fieldName: 'selectItem', type: 'toggel', editable: false, typeAttributes: { showcheck : { fieldName: 'showCheck' }, value: { fieldName: 'selectItem' }, context: { fieldName: 'recordId' } }, initialWidth: 75, hideDefaultActions: true },
    { label: 'Item', fieldName: 'itemName', type: 'text', wrapText: true, initialWidth: 150 },
    { label: '', fieldName: '', cellAttributes: { iconName: { fieldName: 'itemRuleIcon' } }, initialWidth: 32, hideDefaultActions: true },
    { label: 'Data e Hora', fieldName: 'eventDateTime', type: 'text', hideDefaultActions: true, wrapText: true, initialWidth: 125 },    
    { label: 'Operação', fieldName: 'callType', type: 'text', wrapText: true, initialWidth: 150 }, 
    { label: 'Serviço', fieldName: 'service', type: 'text', wrapText: true, initialWidth: 150 },
    { label: 'Valor Total', fieldName: 'totalAmount', type: 'currency', hideDefaultActions: true, wrapText: true, initialWidth: 100 },
    { label: 'Saldo', fieldName: 'usedUnitOfMeasure', type: 'text', hideDefaultActions: true, initialWidth: 100 },    
    { label: 'Valor', fieldName: 'valorTotal', type: 'number', hideDefaultActions: true, initialWidth: 75 },                
    { label: 'Status', fieldName: 'contestStatus', type: 'text', editable: false, hideDefaultActions: true, initialWidth: 135 },
];

const filteredColumns = [
    { label: '', fieldName: 'selectItem', type: 'toggel', editable: false, typeAttributes: { showcheck : { fieldName: 'showCheck' }, value: { fieldName: 'selectItem' }, context: { fieldName: 'recordId' } }, initialWidth: 75, hideDefaultActions: true },
    { label: 'Item', fieldName: 'itemName', type: 'text', wrapText: true, initialWidth: 150 },
    { label: '', fieldName: '', cellAttributes: { iconName: { fieldName: 'itemRuleIcon' } }, initialWidth: 32, hideDefaultActions: true},
    { label: 'Data e Hora', fieldName: 'eventDateTime', type: 'text', hideDefaultActions: true, wrapText: true, initialWidth: 125 },    
    { label: 'Operação', fieldName: 'callType', type: 'text', wrapText: true, initialWidth: 150 }, 
    { label: 'Serviço', fieldName: 'service', type: 'text', wrapText: true, initialWidth: 150 },    
    { label: 'Valor Total', fieldName: 'totalAmount', type: 'currency', hideDefaultActions: true, wrapText: true, initialWidth: 100 },     
    { label: 'Saldo', fieldName: 'usedUnitOfMeasure', type: 'text', hideDefaultActions: true, initialWidth: 100 },   
    { label: 'Valor', fieldName: 'valorTotal', type: 'number', hideDefaultActions: true, initialWidth: 75 },                
    { label: 'Status', fieldName: 'contestStatus', type: 'text', editable: false, hideDefaultActions: true, initialWidth: 135 },
    { label: 'Motivo Contestação', fieldName: 'reason', type: 'picklistColumn', editable: true, typeAttributes: { placeholder: '', options: { fieldName: 'pickListOptions' }, value: { fieldName: 'reason' }, context: { fieldName: 'recordId' } }, initialWidth: 175, wrapText: true }
];

export default class ContestItemsList extends LightningElement {
    @track itemsList = [];
    @track pagedItems = [];
    @track filteredItems = [];

    //@track currentPage = 1;
    @track displayAmount = 10;

    @track draftValues = [];
    @track filteredDraftValues = [];

    @track hasSelectedItems = false;
    @track hasFilteredItems = false;
    @track hasFilteredSelectedItems = false;
    @track hasEmptyReason = false;
    @track hasRecord = false; 
    @track isPageButton = false;

    @track contestButtonEnabled = false;

    @track rule = null;

    @track responseIP;
    @track _actionUtil;

    @track pageNumber = 1;
    @track pageSum = 0;
    @track state;
    @track isFirstPage;
    @track isLastPage;
    @track operation;
    @track initialDate;
    @track endDate;
    @track serviceIdentifier;
    @track interactionId;
    @track accountId;
    @track assetId; 
    @track spinner = false;  

    selectionColumns = selectionColumns;
    filteredColumns = filteredColumns;
    
    pubsubEvents = {};
    _allMergeFields = {};    
    _regexPattern = /\{([a-zA-Z.0-9_]+)\}/g;     

    connectedCallback() {
        //pubsub.register("Contest",{["SearchEventsAndOperations"]: this.handleSearch.bind(this)});
        //pubsub.register("Contest",{["ResetVariables"]: this.handleResetVariables.bind(this)});
        //pubsub.register("Contest",{["GetSelectedItems"]: this.handleGetSelectedItems.bind(this)});

        this.subscribeToEvent('Contest', 'SearchEventsAndOperations', this.handleSearch.bind(this));      
        this.subscribeToEvent('Contest', 'ResetVariables', this.handleResetVariables.bind(this));      
        this.subscribeToEvent('Contest', 'GetSelectedItems', this.handleGetSelectedItems.bind(this));      
    }

    disconnectedCallback(){
        this.unsubscribeFromAllEvents();
    }

    subscribeToEvent(channel, event, callback){
        const channelKey = interpolateWithRegex(channel, this._allMergeFields, this._regexPattern, 'noparse');

        if (!this.pubsubEvents[channelKey]) {
            this.pubsubEvents[channelKey] = {};
        }

        const eventKey = interpolateWithRegex(event, this._allMergeFields, this._regexPattern, 'noparse');
        this.pubsubEvents[channelKey][eventKey] = callback;
        pubsub.register(channelKey, this.pubsubEvents[channelKey]);
    }

    unsubscribeFromAllEvents(){
        Object.keys(this.pubsubEvents).forEach((channelKey) => {
            pubsub.unregister(channelKey, this.pubsubEvents[channelKey]);
        });
    }     

    handleResetVariables(data) {
        this.hasRecord = false;    
    }

    handleSearch(data) {
        this.isPageButton = false;
        this.pageNumber = 1;
        this.pageSum = 0;

        this.operation = data.Operation;
        this.initialDate = data.InitialDate;
        this.endDate = data.EndDate;
        this.serviceIdentifier = data.ServiceIdentifier;
        this.interactionId = data.InteractionId;
        this.accountId = data.AccountId;
        this.assetId = data.AssetId;

        this.searchEvents();
    }

    handleNext() {
        //pubsub.fire("Contest", "ShowSpinner", {}); 
        this.spinner = true;       
        this.pageSum = 1; 
        this.isPageButton = true;
        this.searchEvents();   
    }

    handlePrevious() {
        //pubsub.fire("Contest", "ShowSpinner", {}); 
        this.spinner = true;        
        this.pageSum = -1; 
        this.isPageButton = true;
        this.searchEvents();
    }    

    searchEvents() {
        this._actionUtil = new OmniscriptActionCommonUtil();

        const options = {};
        const params = {
            input: { 
                Operation : this.operation,
                InitialDate : this.initialDate,
                EndDate : this.endDate,
                NetworkNumber : this.serviceIdentifier,
                InteractionId : this.interactionId,
                AccountId : this.accountId,
                AssetId : this.assetId,
                PageNumber : this.pageNumber,
                PageSum : this.pageSum
            },

            sClassName: "vlocity_cmt.IntegrationProcedureService",
            sMethodName: "val_SearchEventsAndOperations",
            options: JSON.stringify(options)
        };

        this._actionUtil
            .executeAction(params, null, this, null, null)
            .then((response) => {
                this.responseIP = response.result.IPResult;
                this.itemsList = Array.isArray(this.responseIP.Items) ? this.responseIP.Items : [this.responseIP.Items];

                if (this.responseIP.pageControl != "") {
                    this.pageNumber = this.responseIP.pageControl.pageNumber;
                    this.state = this.responseIP.pageControl.state;
                } else if (this.isPageButton) {
                    this.state = 2;  
                    this.pageNumber = this.pageNumber + 1;   
                }
            
                //this.currentPage = 1;
                this.updatePagedItems(); 
            })
            .catch((error) => {
                this.responseIP = null;
                console.log('searchEvents - error: ' + error);
            }).finally(()=>{
                this.spinner = false; 
                pubsub.fire("Contest", "SearchResults", {"HasRecord" : this.hasRecord,"HasSearch" : true});
            });
    }
 
    handleItemsCellChange(event) {
        this.handleCellChange(event, "Items"); 
    }

    handleFilteredCellChange(event) {        
        this.handleCellChange(event, "Filtered");  
    }

    handleCellChange(event, type) {
        let draftValues = event.detail.draftValues;
        draftValues.forEach(ele=>{
            this.updateColumnData(ele, type);
        })

        if (type == "Filtered") {
            this.hasEmptyReason = this.filteredItems.findIndex(item => item.reason == null || item.reason == '') >= 0 ? true : false;

            if(!this.hasEmptyReason) {
                if (!this.contestButtonEnabled) {
                    pubsub.fire("Contest", "EnableContestButton", {});
                    this.contestButtonEnabled = true;
                }
            } else {
                if (this.contestButtonEnabled) {
                    pubsub.fire("Contest", "DisableContestButton", {});
                    this.contestButtonEnabled = false;
                }                
            }

            this.filteredDraftValues = [];
        }
    }

    handleItemsToggelSelect(event) {
        this.handleToggelSelect(event, "Items");  
    }

    handleFilteredToggelSelect(event) {
        this.handleToggelSelect(event, "Filtered");  
    }    

    handleToggelSelect(event, type) {
        event.stopPropagation();
        let toggleid = event.detail.data.context;
        let toggleValue = event.detail.data.value;

        let updatedItem = { recordId: toggleid, selectItem: toggleValue };
        this.updateColumnData(updatedItem, type); 
        
        if (type == "Items") {
            this.hasSelectedItems = this.pagedItems.findIndex(item => item.selectItem === true) >= 0 ? true : false;
        } else {
            this.hasFilteredSelectedItems = this.filteredItems.findIndex(item => item.selectItem === true) >= 0 ? true : false;
        }
    }

    updateColumnData(updatedItem, type)
    {      
        let copyData;
        copyData = type == "Items" ? JSON.parse(JSON.stringify(this.pagedItems)) : JSON.parse(JSON.stringify(this.filteredItems));
 
        copyData.forEach(item => {
            if (item.recordId === updatedItem.recordId) {
                for (let field in updatedItem) {
                    item[field] = updatedItem[field];
                }
            }
        });
 
        if (type == "Items") {
            this.pagedItems = [...copyData];
        } else {
            this.filteredItems = [...copyData];
        }
    }    

    insertItems(data) {
        let hasError = false;
        let IncludeItemsMessage = '';

        if (!this.hasSelectedItems) {
            hasError = true;
            IncludeItemsMessage = "Nenhum item selecionado";
        } else {
            const uniqueRules = [];
            const ruleSet = {};
 
            this.pagedItems.forEach(item => {  
                if (item.selectItem === true) {
                    if (!ruleSet[item.itemRule]) {
                        ruleSet[item.itemRule] = true;
                        uniqueRules.push(item.itemRule);
                        
                    }
                }
            });

            this.filteredItems.forEach(item => {  
                if (!ruleSet[item.itemRule]) {
                    ruleSet[item.itemRule] = true;
                    uniqueRules.push(item.itemRule);
                }
            });            

            if (uniqueRules.length > 1) {
                hasError = true;
                IncludeItemsMessage = "Os itens selecionados contemplam regras de impugnação diferentes";                
            } else {
                this.rule = uniqueRules[0].itemRule;
            }
        }

        pubsub.fire("Contest", "SetIncludeItemsError", {"IncludeItemsMessage" : IncludeItemsMessage});                    

        if(!hasError) {
            for (let i = 0; i < this.pagedItems.length; i++) { 
                if (this.pagedItems[i].selectItem == true) {                
                    //this.filteredItems.push(this.pagedItems[i]); 
                    this.filteredItems.push(...this.pagedItems.splice(i, 1)); 
                    i--;                                                       
                }          
            }

            /*for (let i = 0; i < this.pagedItems.length; i++) { 
                if (this.pagedItems[i].selectItem == true) {
                    this.pagedItems.splice(i, 1);
                    i--;     
                }          
            } */         

            this.filteredItems = [...this.filteredItems];
            this.pagedItems = [...this.pagedItems];
        }
        
        this.hasSelectedItems = this.pagedItems.findIndex(item => item.selectItem === true) >= 0 ? true : false;        

        if (this.filteredItems.length > 0) {
            this.hasFilteredItems = true;
            this.hasFilteredSelectedItems = true;
            this.hasEmptyReason = this.filteredItems.findIndex(item => item.reason == null || item.reason == '') >= 0 ? true : false;        

            if(this.hasEmptyReason) {
                pubsub.fire("Contest", "DisableContestButton", {});
                this.contestButtonEnabled = false;
            } else {
                if (!this.contestButtonEnabled) {
                    pubsub.fire("Contest", "EnableContestButton", {});
                    this.contestButtonEnabled = true;
                }
            }          
        }  

        this.draftValues = [];
    }  

    removeItems(data) {
        let hasError = false;
        let RemoveItemsMessage;

        if (!this.hasFilteredSelectedItems) {
            hasError = true;
            RemoveItemsMessage = "Nenhum item selecionado";
        } 

        if (hasError) {   
            pubsub.fire("Contest", "SetIncludeItemsError", {"IncludeItemsMessage" : RemoveItemsMessage});                            
        } else {
            const itemsToKeep = [];
            const itemsToMove = [];
    
            this.filteredItems.forEach(item => {
                if (item.selectItem === true) {
                    item.selectItem = false;
                    
                    if (item.pickListOptions.length > 2) {
                        item.reason = "";
                    }
                    itemsToMove.push(item);
                } else {
                    itemsToKeep.push(item);
                }
            });

            this.filteredItems = itemsToKeep;
            this.pagedItems = [...this.pagedItems, ...itemsToMove];
    
            if (this.filteredItems.length == 0) {  
                this.hasFilteredItems = false;
                this.hasFilteredSelectedItems = false;
    
                pubsub.fire("Contest", "DisableContestButton", {});
                this.contestButtonEnabled = false;  
            } else {
                this.hasFilteredSelectedItems = this.filteredItems.findIndex(item => item.selectItem === true) >= 0 ? true : false;        
            }

            pubsub.fire("Contest", "SetIncludeItemsError", {"IncludeItemsMessage" : ""});            
        }  
    }    

    handleGetSelectedItems(data) {
        pubsub.fire("Contest", "SetSelectedItems", {SelectedItems : this.filteredItems,
            ContactType : data.ContactType,
            Email : data.Email,
            Comments : data.Comments,
            ServiceIdentifier : data.ServiceIdentifier
        });
    }    

    updatePagedItems() {
        this.pagedItems = this.itemsList;

        for (let i = 0; i < this.pagedItems.length; i++) { 
            let index = this.filteredItems.findIndex(filteredElement => filteredElement.recordId === this.pagedItems[i].recordId);            

            if (index >= 0) {
                this.pagedItems.splice(i, 1);
                i--;     
            }          
        }     

        this.hasRecord = this.pagedItems.length > 0 || this.isPageButton ? true : false;

        if (this.state == "1") {
            this.isFirstPage = true;
            this.isLastPage = true;
        } else if (this.state == "2") {
            this.isFirstPage = false;
            this.isLastPage = true;
        } else if (this.state == "3") {
            this.isFirstPage = true;
            this.isLastPage = false;
        } else if (this.state == "4") {
            this.isFirstPage = false;
            this.isLastPage = false;
        }
    }
}