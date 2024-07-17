import { LightningElement } from 'lwc';
import treeListSelector from 'vlocity_cmt/treeListSelector';

export default class ExtendedTreeListSelector extends treeListSelector {

    fireEvent(eventValue,
        eventIsChildItemsPresent,
        eventIsDefault,
        eventLabel,
        extraPayload = {}) {
            console.log('eventIsDefault', eventIsDefault);
            setTimeout(() => {
                super.fireEvent(eventValue,
                    eventIsChildItemsPresent,
                    eventIsDefault,
                    eventLabel,
                    extraPayload)
            }, 600);
    }
}