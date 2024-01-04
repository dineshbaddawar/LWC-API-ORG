import { LightningElement } from 'lwc';
import getcontactList from '@salesforce/apex/BootcampLWCHelper.getRecentlycreatedContactList';
export default class Bcampday1_customdatatable extends LightningElement {

        connectedCallback() {
        setTimeout(() => {
        this.callMethod();
        }, 300);
            }

    conList = [];
    error;

    callMethod(){
        getcontactList({})
        .then(result =>{
         if(result){
             this.conList = result;
         }
        })
        .then(error=>{
         this.error= error;
        })
    }

}