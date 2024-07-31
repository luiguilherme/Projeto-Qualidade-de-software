import { LightningElement, api, track, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAttachments from '@salesforce/apex/AttachmentController.getAttachments';

export default class AttachmentList extends LightningElement
{
    @api recordId;
    @track attachments = [];
    
    isLoading = false;
    isEmpty = true;

    @wire(CurrentPageReference)
    currentPageReference;

    get tableHeight()
    {
        let size = this.attachments.length;
        let height;
        if (size <= 4) { height = 'min-height: 40px; max-height: 80px;'; }
        else { height = 'height: 80px;'; }
        return height;
    }

    connectedCallback()
    {
        this.handleLoad();
    }

    async handleLoad()
    {
        this.isLoading = true;
        await getAttachments({'caseId': this.recordId})
            .then(data => {
                let tempAttachments = [];
                if (data.length > 0) { 
                    this.isEmpty = false;
                }
                data.forEach(element => 
                {
                    let attach = {
                        id: element.id,
                        name: element.name
                    }
                    tempAttachments.push(attach);
                });
                this.attachments = [...tempAttachments];
            })
            .catch(error => {
                let errorMessage = 'Erro na listagem de Anexos.';
                this.handleShowToast('Error!', errorMessage, 'error');
                console.error(error.body.message);
            });
        this.isLoading = false;
    }

    handleShowAttachment(event)
    {
        event.preventDefault();
        const attachmentId = event.currentTarget.dataset.attachmentId;
        this.openVisualForcePage(attachmentId);
    }

    openVisualForcePage(attachmentId)
    {
        let basePath = window.location.origin;
        let resource = '/apex/openDocument';
        let queryParam = 'document-id=' + attachmentId;

        window.open(basePath + resource + '?' + queryParam);
    }

    handleShowToast(title, message, variant)
    {
        const event = new ShowToastEvent(
        {
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}