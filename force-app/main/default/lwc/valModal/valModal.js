import { LightningElement, api } from 'lwc';
import { OmniscriptBaseMixin } from "vlocity_cmt/omniscriptBaseMixin";
import pubsub from "vlocity_cmt/pubsub";

export default class ValModal extends OmniscriptBaseMixin(LightningElement) {
    title = '';
    message = '';
    labelButton1 = 'Sim';
    labelButton2 = 'Não';
    isShowModal = false;
    isShowCloseButton = false;
    channel = '';
    eventName1 = '';
    eventName2 = '';

    connectedCallback() {
        console.log('connectedCallback');

        pubsub.register('valmodal', {["showModal"]: this.showModal.bind(this)});
    }

    handleModal() {
        this.isShowModal = !this.isShowModal;
    }

    showModal(data) {
        console.log('>> showModal <<');
        console.log(JSON.stringify(data));

        this.title        = data.title;
        this.message      = data.message;
        this.labelButton1 = data.labelButton1;
        this.labelButton2 = data.labelButton2;
        this.channel      = data.channel;
        this.eventName1   = data.eventName1;
        this.eventName2   = data.eventName2;
        this.isShowCloseButton = data.ShowCloseButton;

        this.handleModal();
    }

    handleButton1() {
        console.log(this.channel +' - ' + this.eventName1 + ' - ');
        console.log('botão 1');
        // pubsub.fire(this.channel, this.eventName1, {changePrincipal: true, fieldChange: this.eventName1});
        pubsub.fire("valSelectOptionRecharge", "topic");
        this.handleModal();
    }

    handleButton2() {
        console.log(this.channel +' - ' + this.eventName2 + ' - ');
        pubsub.fire(this.channel, this.eventName2, {changePrincipal: false, fieldChange: this.eventName2});
        this.handleModal();
    }
}