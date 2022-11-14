({
    copyTextFieldHelper : function(component,event,text) {
        var hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('value', text);
        document.body.appendChild(hiddenInput);
        hiddenInput.select();
        document.execCommand('copy');
        document.body.removeChild(hiddenInput); 
        
        var originalLabel = event.getSource().get('v.label');
        event.getSource().set('v.iconName' , 'utility:check');
        event.getSource().set('v.label' , 'Copiado');
        setTimeout(function(){ 
            event.getSource().set('v.iconName' , 'utility:copy_to_clipboard'); 
            event.getSource().set('v.label' , originalLabel);
        }, 3000);
    }
})