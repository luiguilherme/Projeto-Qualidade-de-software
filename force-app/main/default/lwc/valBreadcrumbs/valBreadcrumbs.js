import { LightningElement, api } from 'lwc';
import pubsub from "vlocity_cmt/pubsub";

export default class ValBreadcrumbs extends LightningElement {
    menuName="";    
    menuPathName= "";
    menus = [];
    productType="";
    serviceTree="";
    parmActive="";
    assetId="";
    otherProduct="";
    visibleTo="";

    @api get menusbyname(){
        return this.menus;
    }
    set menusbyname(value){
        //console.log('set.menusbyname: '+value);
        if(value != '' && value.length > 0){
            this.menus = value;
            //console.log('set.menusbyname: (IF) '+value);
        }
    }

    @api get parentname(){
        
        return this.menuName;
    }
    set parentname(value){
        if(value!='{Name}'){
            this.menuName = value;

            if(this.menus.includes(value)){

                let lastMenu = this.menus.indexOf(value)+1;
                this.menus = this.menus.slice(0,lastMenu);

            }else{            
                this.menus.push(value);
            }
        }
    }

    @api get producttype(){        
        return this.productType;
    }
    set producttype(value){
        this.productType = value;
    }

    @api get servicetree(){        
        return this.serviceTree;
    }
    set servicetree(value){
        this.serviceTree = value;
    }

    @api get parmactive(){        
        return this.parmActive;
    }
    set parmactive(value){
        this.parmActive = value;
    }

    @api get assetid(){        
        return this.assetId;
    }
    set assetid(value){
        this.assetId = value;
    }

    @api get otherproduct(){        
        return this.otherProduct;
    }
    set otherproduct(value){
        this.otherProduct = value;
    }

    @api get visibleto(){        
        return this.visibleTo;
    }
    set visibleto(value){
        this.visibleTo = value;
    }    

    menuClick(event){
        pubsub.fire("topicSearch","baseinputvaluechange",{"value":event.target.name,"producttype":this.productType,"servicetree":this.serviceTree,"parmactive":this.parmActive,"assetid":this.assetId,"otherproduct":this.otherProduct,"visibleto":this.visibleTo});
        console.log(this.productType);
        console.log(this.serviceTree);
        console.log(this.parmActive);
        console.log(this.assetId);
        console.log(this.otherProduct);
        console.log(this.visibleTo);        
    }

    renderedCallback(){
        //console.log("renderedCallback: "+this.menusbyname);
    }
}