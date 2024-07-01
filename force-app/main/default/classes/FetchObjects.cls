public class FetchObjects {

    // Method for getting All Sobjects
    @auraEnabled(cacheable=true)
    public static list<string> fetchObjectsInfo(){
        try{
            list<string> ListOfSobjects = new list<string>();
            map<string,schema.sobjectType> m=schema.getGlobalDescribe();
            for(string token:m.keySet()){
                schema.describeSobjectResult r=m.get(token).getDescribe();
                ListOfSobjects.add(r.getName());
            }
            ListOfSobjects.sort();
            System.debug('ListOfSobjects == >'+ListOfSobjects);
            return ListOfSobjects;
        }catch(Exception e){
                System.debug('The Error '+e.getMessage() + 'Erron Line '+e.getLineNumber()); 
            }
            return null;
    }

    // Method for getting All Fileds by Passing Object Name
    @auraEnabled(cacheable=true)
    public static list<string> fetchFieldsInfo(string obj){
        System.debug('obj === >'+obj);
        try{
        list<string> ListOfSobjectFields=new list<string>();
        schema.sobjectType objToken=schema.getGlobalDescribe().get(obj);
        System.debug('objToken ==== >'+objToken);
        map<string,sobjectField> m=objToken.getdescribe().fields.getMap();
        System.debug('m Data == >'+m);
        for(string token:m.keySet()){
            schema.describeFieldResult r=m.get(token).getDescribe();
            ListOfSobjectFields.add(r.getName());
        }
        ListOfSobjectFields.sort();
        System.debug('ListOfSobjectFields == >'+ListOfSobjectFields);
        return ListOfSobjectFields;
        }catch(Exception e){
        System.debug('The Error '+e.getMessage() + 'Erron Line '+e.getLineNumber()); 
        }
        return null;
    }

    // Method for Get Dynamic Query
    @auraEnabled(cacheable=true)
    public static list<sobject> fetchResult(string query){
        System.debug('Query === >'+query);
        try{
        list<sobject> data=new list<sobject>();

        string updatedQuery = query+' Limit 10';
        // Database.querylocator q=Database.getquerylocator(query);
        // Database.querylocatoriterator it=q.iterator();

        // while(it.hasNext()){
        //     data.add(it.next());
        // }

        List<sObject> lstOfRecords = Database.query(updatedQuery);
        for (sObject obj: lstOfRecords) {
            data.add(obj); 
            }

        System.debug('data == >'+data);

        return data;
        }catch(Exception e){
        System.debug('The Error '+e.getMessage() + 'Erron Line '+e.getLineNumber()); 
        }
        return null;
    }

}