import { LightningElement ,api,track} from 'lwc';

export default class Toggeltype extends LightningElement {
   
@api value;
@api context;
@api showcheck;
@track togglevalue;
@track toggleshowcheck;

renderedCallback()
{
    this.togglevalue=this.value;
    this.toggleshowcheck=this.showcheck;
}

  handleChange(event) {
      
      event.preventDefault();
      
      let value = event.target.checked;
      this.value=value;
      this.togglevalue=value;
    
      const toggel = new CustomEvent('toggelselect', {
          composed:true,
          bubbles: true,
          cancelable: true,
          detail: {
              data: { context: this.context, value: this.value, showcheck: this.showcheck }
          }
         
      });
      this.dispatchEvent(toggel);
  }
}