import { LightningElement, wire } from 'lwc';
import pubsub from "vlocity_cmt/pubsub";

export default class ShowBase64File extends LightningElement {    

    connectedCallback() {
        this.pubSubOpenPDF = {
            openpdf: this.openBlobInNewTab.bind(this)
        };
        pubsub.register('openfilenewtab', this.pubSubOpenPDF);
    }

    disconnectedCallback() {
        pubsub.unregister('openfilenewtab', this.pubSubOpenPDF);
    }
    
    openBlobInNewTab(event) {    
        const base64String = event.base64;
        const blob = this.base64toBlob(base64String);
        const blobUrl = URL.createObjectURL(blob);

        window.open(blobUrl);
    }

    base64toBlob(base64String) { 
        const contentType = "application/pdf"; 
        const sliceSize = 1024; 
        const byteCharacters = atob(base64String); 
        const byteArrays = []; 
        
        for (let offset = 0; offset < byteCharacters.length; offset += sliceSize) { 
            const slice = byteCharacters.slice(offset, offset + sliceSize); 
            const byteNumbers = new Array(slice.length); 
            
            for (let i = 0; i < slice.length; i++) { 
                byteNumbers[i] = slice.charCodeAt(i); 
            } 
            
            const byteArray = new Uint8Array(byteNumbers); 
            byteArrays.push(byteArray); 
        } 
        
        const blob = new Blob(byteArrays, { type: contentType }); 
        return blob; 
    }
}