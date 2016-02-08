public with sharing class loginRest {
	
	
	
	
public  static list<string> loginintosalesforce() {
       	string acctoken;
	    string nexturl;
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        req.setEndpoint('https://ap1.salesforce.com/services/oauth2/token');
        req.setMethod('POST');
       // req.setHeader('Content-Type','application/json');
        string user=EncodingUtil.urlEncode('rishuom@sales.com','UTF-8');
        string pass=EncodingUtil.urlEncode('saurabh024cE41krFw1xvfIxlZIHQ4kYzWM','UTF-8');
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
          list<string> tokens= new list<string>();
        try {
            res = http.send(req);
            system.debug(res);
             if (res.getStatusCode() != 200)
             system.debug(res); 
            
             
         
        System.debug('response body =\n' + res.getBody());
        Map<String,String> res1 = (Map<String,String>) JSON.deserialize(res.getBody(),Map<String,String>.class);
      
        acctoken   = res1.get('access_token');      // remember these for subsequent calls
        nexturl    = res1.get('instance_url');
        tokens.add(acctoken);
        tokens.add(nexturl);
        system.debug(tokens);
        }
        
         catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }
        return tokens;
        

}}