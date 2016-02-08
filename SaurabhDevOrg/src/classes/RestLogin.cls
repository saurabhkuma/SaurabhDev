global  with sharing class RestLogin {
	
	
	
       

  
       webservice static void loginintosalesforce() {
       	string acctoken;
	    string nexturl;
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        req.setEndpoint('https://ap1.salesforce.com/services/oauth2/token');
        req.setMethod('POST');
       // req.setHeader('Content-Type','application/json');
        string user=EncodingUtil.urlEncode('rishuom@sales.com','UTF-8');
        string pass=EncodingUtil.urlEncode('saurabh15222MFGXOTRtN0Z1gWx8XD337BG7H','UTF-8');
       string consumerId=EncodingUtil.urlEncode('3MVG9Y6d_Btp4xp6RX51A7FqyrJxTzlYwm7tg9GYq93TkUF2rXM9UFL_g1KKfMmQEwotHuuw.ynRf3FWumfXE','UTF-8');
       string securityId=EncodingUtil.urlEncode('2452598771328708177','UTF-8');
        string body1= 'grant_type=password&client_id=' + consumerId + 
                        '&client_secret=' + securityId +
                        '&username=' + user + 
                        '&password=' + pass; 
        req.setBody(body1);
       // if (this.accessToken != null)               // REST requires using the token, once obtained for each request
            //req.setHeader('Authorization','Bearer ' + this.accessToken);
       // req.setCompressed(true); // otherwise we hit a limit of 32000

        try {
            res = http.send(req);
            system.debug(res);
             if (res.getStatusCode() != 200)
             system.debug(res); 
            
             
         
        System.debug('response body =\n' + res.getBody());
        Map<String,String> res1 = (Map<String,String>) JSON.deserialize(res.getBody(),Map<String,String>.class);
 
        acctoken   = res1.get('access_token');      // remember these for subsequent calls
        nexturl    = res1.get('instance_url');
        system.debug(acctoken);
        
        
         //after getting response and authorize with salesforce ,start doing query of account    
            
        List<Sobject> acclist;        
        PageReference   urlPg   = new PageReference(nexturl + '/services/data/v29.0/query');
        urlPg.getParameters().put('q','select name from account'); 
 
        String uri              = urlPg.getUrl(); 
        http h1= new http();
        httpresponse resq= new httpResponse();
        HttpRequest reqq= new HttpRequest();              
        reqq.setMethod('GET');
        reqq.setEndpoint(uri);
        reqq.setHeader('Authorization','Bearer ' + acctoken);
        resq= h1.send(reqq);
        if (resq.getStatusCode() != 200) 
            system.debug(resq);
         
        // Response body comes back as:
        // {"totalSize":10,
        //  "done":true,
        //  "records":[
        //              {"attributes":{
        //                  "type"  : "the sobject",
        //                  "url"   : "/services/data/v29.0/sobjects/the sobject/the id"
        //              },
        //              "field0 in query"   : "value of field 0",
        //              "field1 in query"   : "value of field1",
        //              ...},
        //              next record ...
        //              ]
        //  }
        JSONParser jp = JSON.createParser(resq.getBody());
         //Map<String,String> resultquery = (Map<String,String>) JSON.deserialize(resq.getBody(),Map<String,String>.class);
        system.debug(jp);
        do{
            jp.nextToken();
            
        } while(jp.hasCurrentToken() && !'records'.equals(jp.getCurrentName()));
        jp.nextToken();  // token is 'records'
        acclist = (List<SObject>) jp.readValueAs(List<SObject>.class);
        system.debug(acclist);
              
    }
            
         catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }

    }
    

}