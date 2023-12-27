public class LwcUtility {
    
    @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem> getOpplineItemUnderopp(string recordId){
        try{
            return [Select id,Name,OpportunityId,Opportunity.Name,ProductCode,TotalPrice,Quantity,ListPrice,UnitPrice,Product2.Name,Description  from OpportunityLineItem where OpportunityId =:recordId ];
        }catch(Exception e){
            System.debug('Error == >'+e.getlineNumber() + ' && Error Line === >'+e.getLinenumber());
        }
        return null;
    }
    
    @AuraEnabled
    public static string updateOpplineItem(List<OpportunityLineItem> updateOpplineList){
        System.debug('updateOpplineList == >'+updateOpplineList);
        try{
            upsert  updateOpplineList;
            return 'SUCCESS';
        }catch(Exception e){
            System.debug('Error message == >'+e.getMessage() + ' Line no == >'+e.getLineNumber());
        }
        return null;
    }
    
    // Continuation method
    @AuraEnabled
    public static Object startRequest(Id recordId) {
        // Create continuation with a timeout
        Continuation cont = new Continuation(60);
        cont.continuationMethod = 'processResponse';
        
        // Set the callout endpoint URL
        cont.state = recordId; // Pass the recordId to the response
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://buff.ly/3N0BGwJ');
        
        // Add callout request to continuation
        cont.addHttpRequest(req);
        
        // Return the continuation
        return cont;
    }
    
    public static Object processResponse(List<HttpResponse> responses, Object state) {
        // Get the first response
        HttpResponse response = responses[0];
        
        // Process the response
        // You can now use the data however you like, such as updating records in Salesforce
        
        return response.getBody(); // Returning the data
    }

    // ================================================================================================================================
    // Method for getting Field Set for Opportunity Record
    @AuraEnabled
    public static List<String> getOppFieldSetList(){
        try{
            List<String> oppFieldSetList = new List<String>();
            List<Schema.FieldSetMember> FieldSetListFromOPp  = SobjectType.Opportunity.FieldSets.FiledSet_Opp.getFields();
            for(Schema.FieldSetMember fieldsToAdd : FieldSetListFromOPp){
                System.debug('Fields === >'+String.valueOf(fieldsToAdd.sobjectfield));
                 oppFieldSetList.add(String.valueOf(fieldsToAdd.sobjectfield));
            }
            if(oppFieldSetList.size()>0){
                return oppFieldSetList;
            }
        }catch(Exception e){
            System.debug('The Error ::' + e.getMessage() + ' AND Error Line No :' + e.getLineNumber());
            }
           return null;
        }
    
}