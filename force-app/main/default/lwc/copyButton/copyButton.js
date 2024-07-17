import { api, LightningElement} from 'lwc';

export default class CopyButton extends LightningElement {
    @api messageCopied;

    handleClick(event) {
        let el = document.createElement('textarea');
        el.value = this.messageCopied.replace(/<[^>]*>?/gm, '');
        el.setAttribute('readonly', '');
        el.style = {position: 'absolute', left: '-9999px'};
        document.body.appendChild(el);
        el.select();
        document.execCommand('copy');
        document.body.removeChild(el);
    }
       
}