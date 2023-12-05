public without sharing class GeolocationController {

     public Static Map<String,String> getLongandLat(String Addresss){
        Map<String,String> responseMap = new Map<String,String>();
        String apikey = 'AIzaSyB4SPqkO0ZQbxT-EU4l886H9Y3ipf1NMW0';
        String baseURL = 'https://maps.googleapis.com/maps/api/geocode/json?address=';
        
        String encodedAddresss = EncodingUtil.urlEncode(Addresss, 'UTF-8');
        String url = baseURL+encodedAddresss+'&key='+apikey;
        System.debug('encoded url ::'+url);
        Http ht =new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');
        req.setHeader('Content-Length', '0');
        HttpResponse res = ht.send(req);
        String response = (res.getBody());
        System.debug('response ::'+response);
        
        //locationparser parsedJson = JSON.deserialize(res.getBody(), LocationParser.Class);
        //system.debug('parsedJson ====> ' + parsedJson);
        
        LocationParser parsedJson = LocationParser.parse(res.getBody());
        system.debug('parsedJson ====> ' + parsedJson);
        system.debug('parsedJson results ====> ' + parsedJson.results);
        
        LocationParser.Results parserResult = parsedJson.results[0];
        LocationParser.Geometry parserGeometry = parserResult.geometry;
        LocationParser.Location parserLocation = parserGeometry.location;
        Double lat = parserLocation.lat;
        Double lang = parserLocation.lng;
        
        responseMap.put('lat',String.valueOf(lat));
        responseMap.put('lang',String.valueOf(lang));
        
        System.debug('responseMap---'+String.valueOf(responseMap));
    
        return responseMap;
    }
}