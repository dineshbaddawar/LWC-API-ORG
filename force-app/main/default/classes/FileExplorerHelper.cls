public class FileExplorerHelper {
    
    public class DocumentTreeWrapper {
        public String documentID;
        public String documentName;
        public List<DocumentTreeWrapper> childNodes = new List<DocumentTreeWrapper>();
        
        public DocumentTreeWrapper(String documentID, String documentName) {
            this.documentID = documentID;
            this.documentName = documentName;
        }
    }
    
    @AuraEnabled
    public static List<DocumentTreeWrapper> getAllDocumentsForRecord(String recordId) {
        if(String.isNotBlank(recordId)){
            Map<Id,DocumentTreeWrapper> uiWrapper = new Map<Id,DocumentTreeWrapper>();
            List<Document_Category__c> docList=  [Select id,Name from Document_Category__c where Opportunity__c =:recordId];
            System.debug('docList size === >'+docList.size());
            String Obj = '';
            if(docList.size() > 0){
                for(Document_Category__c appDoc : [SELECT Id, Name,(SELECT Id, Name FROM Document_Files__r) FROM Document_Category__c WHERE Opportunity__c =:recordId ORDER BY CreatedDate]) {
                    DocumentTreeWrapper appDocWrapper;
                    appDocWrapper = new DocumentTreeWrapper(appDoc.Id, appDoc.Name); 
                    if(!appDoc.Document_Files__r.isEmpty()){
                        for(Document_File__c appAttachment : appDoc.Document_Files__r) {
                            appDocWrapper.childNodes.add(new DocumentTreeWrapper(appAttachment.Id, appAttachment.Name));
                        }
                    }
                    uiWrapper.put(appDoc.Id, appDocWrapper);
                }
            }
            system.debug('uiWrapper value size == >'+uiWrapper.values());
            return uiWrapper.values();
        }
        return null;
    }
    
    @AuraEnabled 
    public static List<Document_Category__c> getDocCateList(String opportunityId){
          List<Document_Category__c> DocCategoryList = new List<Document_Category__c>();
        try{
            if(String.isNotBlank(opportunityId)){
                 DocCategoryList =[SELECT Id, Name,(SELECT Id, Name FROM Document_Files__r) FROM Document_Category__c WHERE Opportunity__c =:opportunityId ORDER BY CreatedDate];
                if(DocCategoryList.size()>0){
                    System.debug('DocCategoryList Record === >'+DocCategoryList);
                    return DocCategoryList;
                }  
            }
        }catch(Exception e){
            System.debug('The Error ::'+e.getMessage() +' AND Error Line No :'+e.getLineNumber());
        }
       return null;
    }
    
}