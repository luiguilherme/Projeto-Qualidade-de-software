import { LightningElement, api, wire } from 'lwc';
import { OmniscriptBaseMixin } from 'vlocity_cmt/omniscriptBaseMixin';
import { IsConsoleNavigation, getFocusedTabInfo, refreshTab } from 'lightning/platformWorkspaceApi';
import pubsub from "vlocity_cmt/pubsub";

export default class valRefreshTab extends OmniscriptBaseMixin(LightningElement) {

    @api robotFire= false;
    get robotFire() {
        return this._robotFire;
    };     
    set robotFire(value) {
        this._robotFire = value;
    }
    @api message= '';
    get message() {
        return this._message;
    };     
    set message(value) {
        this._message = value;
    }    
    @api variant='';
    get variant() {
        return this._variant;
    };     
    set variant(value) {
        this._variant = value;
    }    

    @wire(IsConsoleNavigation) isConsoleNavigation;

    connectedCallback() {
        pubsub.register("refreshTab",{["refresh"]: this.refreshTab.bind(this)});     

      
    }

    async refreshTab() {
        if (!this.isConsoleNavigation) {
            return;
        }
        const { tabId } = await getFocusedTabInfo();
        await refreshTab(tabId, {
            includeAllSubtabs: true
        });
    }
    
}