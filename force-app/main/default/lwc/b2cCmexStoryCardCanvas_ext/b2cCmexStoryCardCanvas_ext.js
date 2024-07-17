import { LightningElement,track } from 'lwc';
import { BaseLayout } from "vlocity_cmt/baseLayout";
import template from "./b2cCmexStoryCardCanvas_ext.html"
import { cloneDeep, findIndex } from "vlocity_cmt/lodash";

export default class b2cCmexStoryCardCanvas_ext extends BaseLayout(LightningElement) {

    @track menu = [];
    _menuItemObj = [];
    @track filtersMenu = [];
    _filterMenuItem = [];
    originalStoryList = [];
    originalRecords = [];
    totalStoryData = [];
    isTotalDataSet;
    @track storyTitle;
    menuNewBtn = false;

  
    connectedCallback() {
        super.connectedCallback();

        if (this.session) {
            if (this.session.actions) {
                this._menuItemObj = this.session.actions.split(",");
            }

            if (this.session.filters) {
                this._filterMenuItem = this.session.filters.split(",");
            }
        }

        this.setMenuItem();

        if (this.records.StoryTitle) {
            this.storyTitle = this.records.StoryTitle;
        }
    }
    /**
* @method setMenuItem
* 
* @description Sets the menu items for New button
* 
*/
render() {
    return template;
}

    setMenuItem() {
        this.menu = [];
        this.filtersMenu = [];

        this._menuItemObj.forEach((objName,index)=>{
            this.menuNewBtn = true;
            let objSplit = objName.split(":");
            this.menu.push({
                id: index,
                value: objSplit[0].trim(),
                label: objSplit[1] ? objSplit[1].trim() : objSplit[0].trim(),
                url: `/lightning/o/${objSplit[0].trim()}/new`
            });
        }
        );

        this._filterMenuItem.forEach((objName,index)=>{
            let objSplit = objName.split(":");
            this.filtersMenu.push({
                id: index,
                value: objSplit[0].trim(),
                label: objSplit[1] ? objSplit[1].trim() : objSplit[0].trim()
            });
        }
        );
    }
    /**
* @method filterData
* 
* @description Filter the story objects based on Object selected
* 
*/

    filterData(event) {
        let filterValue = event.currentTarget.dataset.filter;
        let storyRecords = [];
        const allStories = cloneDeep(this.totalStoryData);
        let tempData = [];
        tempData = Array.isArray(allStories) ? [...allStories] : [...allStories.Stories];

        if (filterValue != "All") {
            for (const storyRec of tempData) {
                if (storyRec.objAPIName == filterValue) {
                    storyRecords.push(storyRec);
                }
            }
        } else {
            storyRecords = [...tempData];
        }

        this.noRecords = false;
        this.records = [...storyRecords];
        this.setCardsRecords();
        this.originalStoryList = allStories;

        for (const filterRec of this.filtersMenu) {
            if (filterRec.value == filterValue) {
                filterRec.selectedIcon = "utility:check";
            } else {
                filterRec.selectedIcon = "";
            }
        }
    }
    /**
* @method manipulateData
* 
* @description Gets invoked automatically before the data is fed to the cards
*              Keeps a copy of the original story records
* 
*/

    manipulateData() {
        if (this.records.StoryTitle) {
            this.storyTitle = this.records.StoryTitle;
        }

        if (!this.isTotalDataSet) {
            this.isTotalDataSet = true;
            this.totalStoryData = cloneDeep(this.records);
        }

        this.originalStoryList = cloneDeep(this.records);
        let records = [];

        if (this.records.Stories) {
            records = cloneDeep(this.records.Stories);
        } else {
            records = cloneDeep(this.records);
        }

        if (records && records.length > 0) {
            if (records[0].actionFields && records[0].actionFields.length > 0) {
                this._menuItemObj = records[0].actionFields;
                this.setMenuItem();
            }

            if (records[0].onGoing) {
                records[0].showTitle = true;
            }

            let index = findIndex(records, {
                onGoing: false
            });

            if (index !== -1 && records[index].onGoing === false) {
                records[index].showTitle = true;
            }
        } else {
            this.noRecords = true;
        }

        this.records = records;
    }


    

}