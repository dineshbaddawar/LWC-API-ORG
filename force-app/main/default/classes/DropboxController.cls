public class DropboxController {
    
	public static void uploadFileByRecord(string recordId){
        try{
        System.debug('recordId == >'+recordId);
        List<ContentDocumentLink> links=[SELECT ContentDocumentId,LinkedEntityId FROM ContentDocumentLink where LinkedEntityId=:recordId];
        System.debug('links == >'+links);
        Set<Id> ids=new Set<Id>();
        for(ContentDocumentLink link:links){
            ids.add(link.ContentDocumentId);
        }
        System.debug('ids == >'+ids);
        List<ContentVersion> versions=[SELECT VersionData,Title,ContentDocumentId,FileExtension FROM ContentVersion WHERE ContentDocumentId = :ids AND IsLatest = true];
        System.debug('versions == >'+versions);
        for(ContentVersion attach:versions){
            System.debug('attach == >'+attach);
                string fileUrl=DropboxService.upload(attach);
                System.debug('fileUrl == >'+fileUrl);
               	if (string.isNotBlank(fileUrl)) {
                    //Store Information in Object
                    //Will be used for retrieving files
                    Attachment fileStore=new Attachment();
                    fileStore.Body=blob.valueof(fileUrl);
                    fileStore.Name=attach.Title+'.'+  attach.FileExtension.toLowerCase();
                    fileStore.parentId=recordId;
                    insert fileStore;
                    System.debug('fileStore == >'+fileStore);
                }
        }
    }
        catch(Exception e){
            System.debug('Error Message ===> '+e.getMessage()+' && Error Line == >'+e.getLineNumber());
         }
    }
    
}