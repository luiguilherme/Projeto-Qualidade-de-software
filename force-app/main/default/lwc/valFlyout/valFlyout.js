import { LightningElement, api } from 'lwc';
import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
import pubsub from "vlocity_cmt/pubsub";

export default class ValFlyout extends OmniscriptBaseMixin(LightningElement) {
    title = '';
    message = '';
    labelBtnCancel = 'Cancelar';
    labelBtnSave = 'Salvar';
    isShowModal = false;
    channel = '';
    eventName = '';
    eventCancelName = '';

    connectedCallback() {
        console.log('connectedCallback');

        pubsub.register('valflyout', {["showFlyout"]: this.showModal.bind(this)});
    }

    handleModal() {
        this.isShowModal = !this.isShowModal;
    }

    showModal(data) {
        console.log('>> showModal <<');
        console.log(data);

        this.title = data.title;
        this.message = data.message;
        this.labelBtnCancel = data.labelBtnCancel;
        this.labelBtnSave = data.labelBtnSave;
        this.channel = data.channel;
        this.eventName = data.eventName;
        this.eventCancelName = data.eventCancelName;

        this.handleModal();
    }

    handleBtnSave() {
        pubsub.fire(this.channel, this.eventName, {});
        this.handleModal();
    }

    handleBtnCancel() {
        pubsub.fire(this.channel, this.eventCancelName, {});
        this.handleModal();
    }
}