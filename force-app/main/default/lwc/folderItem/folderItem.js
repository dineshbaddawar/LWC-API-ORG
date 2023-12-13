import { LightningElement, api, wire, track } from 'lwc';
import folderpng from '@salesforce/resourceUrl/folderpng';
import PreviewPDF from '@salesforce/apex/FileExplorerHelper.PreviewPDF';


export default class FolderItem extends LightningElement {
     @api item = [];
     selectedRecordIdPDF;
     showPDF = false;
     error;
     pdfUrl;
     folderfile = folderpng;

     handleItemClickNew(event){
          debugger;
          this.selectedRecordIdPDF = event.currentTarget.dataset.recordId;
          this.getViewPreviewFile();
          console.log('Selected Record ID:', selectedRecordId);
     }
     
     getViewPreviewFile(){
          debugger;
          PreviewPDF({procDocId : this.selectedRecordIdPDF})
          .then(result =>{
              if(result){
              this.showPDF = true;
               if(result){
                   // Create a Blob from base64-encoded string
                  const pdfBlob = this.base64ToBlob(result, 'application/pdf');
                  // Generate a Blob URL for the PDF
                  this.pdfUrl = URL.createObjectURL(pdfBlob);
               }
              }
          })
          .catch(error =>{
           this.error = error;
          })
     }
     
    base64ToBlob(base64String, contentType) {
     debugger;
     const byteCharacters = atob(base64String);
     const byteArrays = [];
     for (let offset = 0; offset < byteCharacters.length; offset += 512) {
         const slice = byteCharacters.slice(offset, offset + 512);
         const byteNumbers = new Array(slice.length);
         for (let i = 0; i < slice.length; i++) {
             byteNumbers[i] = slice.charCodeAt(i);
         }
         const byteArray = new Uint8Array(byteNumbers);
         byteArrays.push(byteArray);
     }
         return new Blob(byteArrays, { type: contentType });
    }
     
     deleteFiles() {
          debugger;
     }
     
     uploadFile() {
          debugger;
     }
     
}