import { LightningElement,api,wire,track} from 'lwc';
import getAllAddresses from "@salesforce/apex/LwcUtility.getAllCustomerAddress";
import getAccountDetails from '@salesforce/apex/LwcUtility.getAccRecord';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
import { CloseActionScreenEvent } from 'lightning/actions';
import { NavigationMixin } from 'lightning/navigation';

export default class CustomAddressLWC extends LightningElement {
     @api recordId;
     selectedAddressIndex = -1;
     selectedBilAddressIndex = -1;
     @track ship_addresses = [];
     @track bill_addresses = [];
     error;
     @track checkedShipAdd;
     @track checkedBillAdd
     @track accRecord;

     connectedCallback(){
          setTimeout(() => {
              this.getRecordDetails();
          }, 300);
     }
     
     getRecordDetails() {
          debugger;
          getAllAddresses({recordId : this.recordId}).then(data => {
              if(data){
                  debugger;
                  let clonedData = JSON.parse(JSON.stringify(data));
                  this.accRecord = clonedData.account;
                  this.ship_addresses = clonedData.customer_ship_addresses;
                  this.bill_addresses = clonedData.customer_bill_addresses;
                  this.selectedAddressIndex = clonedData.ship_selected_index != undefined ? clonedData.ship_selected_index : -1;
                  this.selectedBilAddressIndex = clonedData.bill_selected_index != undefined ? clonedData.bill_selected_index : -1;
                  console.log('RecordId', this.recordId);
                  console.log('Data',clonedData);
                  if(this.ship_addresses && this.bill_addresses ){
                      this.nextBtn = false;
                  }else{
                      this.nextBtn = true;
                  }
              }
         })
      }
}