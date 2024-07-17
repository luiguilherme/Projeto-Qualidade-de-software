import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class BackButton extends NavigationMixin(LightningElement){
    @track isWDE = window.external && Object.keys(window.external).length > 0 && !window.document.URL.includes('customerinteraction');

    connectedCallback() {
        this.timeHandler();
    }

    timeHandler(){
        clearTimeout(this.timeoutId); 
        this.timeoutId = setTimeout(this.doExpensiveThing.bind(this), 1000);
        
    }

    doExpensiveThing() {
        this.isWDE = window.external && Object.keys(window.external).length > 0 && !window.document.URL.includes('customerinteraction');
        this.timeHandler();
    }

    handleVoltar() {
        // Navega para a página anterior
        history.back();
    }
}
