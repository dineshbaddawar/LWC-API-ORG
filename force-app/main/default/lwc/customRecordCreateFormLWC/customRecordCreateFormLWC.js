import { LightningElement,api,track } from 'lwc';
import getOppFieldSetList from '@salesforce/apex/LwcUtility.getOppFieldSetList';
import { CloseActionScreenEvent } from 'lightning/actions';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class CustomRecordCreateFormLWC extends NavigationMixin(LightningElement) {
     oppFiedlSet = [];

     data;
     error;
     createdOppRecordId;
     connectedCallback() {
          setTimeout(() => {
               this.callApexMethod();
          }, 300);
     }
     callApexMethod() {
          debugger;
          getOppFieldSetList()
               .then(result => {
                    if (result) {
                         this.data = result;
                         var TempArray = [];
                         for (var key in this.data) {           
                              TempArray.push({ key: key, value:(this.data)[key] });             
                         }  
                         this.oppFiedlSet = TempArray;
                         console.log('key', this.oppFiedlSet); 
               }
               })
               .catch(error => {
                    this.error = error;
          })
     }

     handleSuccess(event) {
          debugger;
          console.log('onsuccess event recordEditForm', event.detail.id)
          this.createdOppRecordId = event.detail.id;
          this.successToastMessage();
          this.navigateToRecordPage();
          }
     closeAction(){
          debugger;
        this.dispatchEvent(new CloseActionScreenEvent());
     }
     handleSubmitButtonClick(event) {
          debugger;
          event.preventDefault(); // Prevent default form submission
          this.template.querySelector('lightning-record-edit-form').submit();
     }
     navigateToRecordPage() {
          debugger;
          this[NavigationMixin.Navigate]({
              type: 'standard__recordPage',
              attributes: {
                  recordId: this.createdOppRecordId,
                  objectApiName: 'Opportunity',
                  actionName: 'view'
              }
          });
     }
     
     successToastMessage() {
          const event = new ShowToastEvent({
              title: 'SUCCESS',
              message: 'Record Created Successfully !',
              variant: 'success',
              mode: 'dismissable'
          });
          this.dispatchEvent(event);
      }
}