import { LightningElement } from 'lwc';
import qrcode from './qrcode.js';
import pubsub from "vlocity_cmt/pubsub";

export default class QrCodeGeneration extends LightningElement {
renderedCallback() {
    pubsub.register('openqrcode', {
        code: this.openQrcode.bind(this)
    }); 
}
openQrcode(data){ 
    var qrcodeflex = data.qrcodeflex;
    const qrCodeGenerated = new qrcode(0, 'H');
    let strForGenearationOfQRCode  = qrcodeflex;
    qrCodeGenerated.addData(strForGenearationOfQRCode);
    qrCodeGenerated.make();
    let element = this.template.querySelector(".qrcode2");
    element.innerHTML = qrCodeGenerated.createSvgTag({});
}

}