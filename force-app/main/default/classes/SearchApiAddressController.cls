public class SearchApiAddressController {
    
    public static string GoogleMapAPIKey = System.Label.GoogleApiKey;
    
    @AuraEnabled
    Public Static list<SuggestionWrapper> getAddress(String searchString){
        if(String.isNotBlank(searchString)){
            List<SuggestionWrapper> suggestions=new List<SuggestionWrapper>();
            searchString = EncodingUtil.urlEncode(searchString, 'UTF-8');
            Http http = new Http();
            HttpRequest Request = new HttpRequest();
            Request.setMethod('GET');
            Request.setEndPoint('https://maps.googleapis.com/maps/api/place/autocomplete/json?input='+searchString+'&key='+GoogleMapAPIKey);
            HttpResponse Response = http.send(Request);
            if(Response.getStatusCode()==200){
                SearchApiAddressWrapper Json2Apex= parseSuggestion(Response.getbody());
                System.debug('Json2Apex == >'+Json2Apex);
                string CompleteAddress = '';
                List<String> completeaddressList = new List<String>();
                if(Json2Apex.Predictions != null){
                    for(SearchApiAddressWrapper.Predictions Prediction : Json2Apex.Predictions){
                        if(string.isNotBlank(Prediction.description)){
                            CompleteAddress = Prediction.description;
                            CompleteAddress = CompleteAddress.replaceAll(',', ' ');
                            suggestions.add(new SuggestionWrapper(CompleteAddress,Prediction.place_id));
                        }
                    }
                }
                System.debug('suggestions == >'+suggestions);
                return suggestions;  
            }
            
        }
        return null;
    }
    
    @AuraEnabled
    public static string getPlaceDetails(String placeId) {
        if(String.isNotBlank(placeId)){
            String strURL = 'https://maps.googleapis.com/maps/api/place/details/json?'
                + 'placeid=' + EncodingUtil.urlEncode(placeId, 'UTF-8')
                + '&key='+'AIzaSyCyROBA-FkMVJVa96WdEJw7J3m8n-TWEYo'; 
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            req.setMethod('GET');
            req.setEndpoint(strURL);
            req.setTimeout(120000);
            res = h.send(req); 
            String responseBody = res.getBody(); 
            system.debug('responseBody == >'+responseBody);
            return responseBody; 
        }else{
            return null;
        }
    }
    
    public class SuggestionWrapper{
        @AuraEnabled
        public String AddComplete{get;set;}
        @AuraEnabled
        public String placeId{get;set;}
        
        public SuggestionWrapper(string AddComplete,String placeId){
            this.AddComplete = AddComplete;
            this.placeId = placeId;
        }
    }        
    
    public static SearchApiAddressWrapper parseSuggestion(String json) {
        return (SearchApiAddressWrapper) System.JSON.deserialize(json, SearchApiAddressWrapper.class);
    }
    
}