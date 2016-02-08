global with sharing class restCRUD {
	
	public class JSON2Apex {
        public String id;
        public boolean success;
        public String[] error;
    }
	
	
	
	   public static string acctoken;
	   public static string nexturl;
	
       
//method for login into another salesforce account using rest api

       webservice static void loginintosalesforce() 
       {
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();

        req.setEndpoint('https://ap1.salesforce.com/services/oauth2/token');
        req.setMethod('POST');
        //req.setHeader('Content-Type','application/json');
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


                
        }
        catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res.toString());
        }

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
         //after getting response and authorize with salesforce ,start doing query of account    
            
          public static List<sObject> queryAccount()
          { 
          	 loginintosalesforce();
        List<Sobject> acclist;        
        PageReference   urlPg   = new PageReference(nexturl + '/services/data/v29.0/query');
        urlPg.getParameters().put('q','select id,name from account'); 
 
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
        return acclist;
              
       }
       
       
       //method for fetching data by perticular id
       public static sObject searchAccount(id accid)
          { 
          	 loginintosalesforce();
        Sobject selectedacc;        
        PageReference   urlPg   = new PageReference(nexturl + '/services/data/v29.0/query');
        urlPg.getParameters().put('q','select id,name,phone,Industry,AccountNumber from account where id= \''+accid+'\''); 
 
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
         
        JSONParser jp = JSON.createParser(resq.getBody());
         //Map<String,String> resultquery = (Map<String,String>) JSON.deserialize(resq.getBody(),Map<String,String>.class);
        system.debug(jp);
        do{
            jp.nextToken();
            
        } while(jp.hasCurrentToken() && !'records'.equals(jp.getCurrentName()));
        jp.nextToken();  // token is 'records'
        List<SObject> acclist1 = (List<SObject>) jp.readValueAs(List<SObject>.class);
        selectedacc= acclist1[0];

        system.debug(selectedacc);
        return selectedacc;
              
       }
       
       
       
       
       
       
       
       
       
       
      //method for creating accout in another salesforce accout 
       
       webservice static void createAccount(id localId)
       {
       	   loginintosalesforce();
       	   //PageReference   urlPg   = new PageReference(nexturl + '/services/data/v29.0/query');
       	
       	    HttpRequest req3 = new HttpRequest();
           HttpResponse res3 = new HttpResponse();
            Http http3 = new Http();
            req3.setEndpoint(nexturl+ '/services/data/v29.0/sobjects/Account/');
            req3.setMethod('POST');
            req3.setHeader('Authorization','Bearer ' + accToken);
            req3.setHeader('Content-Type','application/json');
             req3.setHeader('accept','application/json');
            String accname=EncodingUtil.urlEncode('saurabhkumars','UTF-8');
            //JSONObject account1 = new JSONObject();

            //account.put('Name', name);
            //req3.setRequestEntity(new StringRequestEntity(account1.toString(),'application/json', null));
            Account acc3= [select name,Fax,Industry,Phone,Website,AccountNumber ,extId__c from account where id=:localId];
           Account aob= new Account();
           aob.name=acc3.name+'rest';
           aob.Phone= acc3.Phone;
           aob.Industry= acc3.Industry;
           
            
            String body3 = JSON.serializePretty(aob);
            
           // string body3= '{\n'+' "name" : "ashish"\n'+'}';
            req3.setBody(body3);
            
            try {
            res3 = http3.send(req3);
            system.debug(res3);
             if (res3.getStatusCode() != 200)
             system.debug(res3); 
            
          
          System.debug('response body =\n' + res3.getBody());
           JSONParser jp1 = JSON.createParser(res3.getBody());
         JSON2Apex resultcreate = (JSON2Apex) JSON.deserialize(res3.getBody(),JSON2Apex.class);
         acc3.extId__c= resultcreate.id;
         update acc3;
           //Map<String,String> res4 = (Map<String,String>) JSON.deserialize(res3.getBody(),Map<String,String>.class);
            
        //system.debug(res4);
            }
        catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res3.toString());
        }
            //JSONObject account = new JSONObject();

            //account.put('Name', name);

            //PostMethod post = new PostMethod(nexturl+ '/services/data/v20.0/sobjects/Account/');
            //post.setRequestHeader('Authorization', 'OAuth ' + acctoken);

           // post.setRequestEntity(new StringRequestEntity(account.toString(),'application/json', null));

            //httpclient.executeMethod(post);
            //JSONObject response = new JSONObject(new JSONTokener(new InputStreamReader(post.getResponseBodyAsStream())));
             //accountId = response.getString("id");
             //system.debug(response.getString('id'));
          
       	
       	
       }
       
       // method for deleting account in another salesforce account if any account is deleted in present one
       @Future(callout=true)
       webservice static void deleteAccount(Id extId)
       {
       	   loginintosalesforce();
       	    HttpRequest req4 = new HttpRequest();
           HttpResponse res4 = new HttpResponse();
            Http http4 = new Http();
            req4.setEndpoint(nexturl+ '/services/data/v29.0/sobjects/Account/'+extId);
            req4.setMethod('DELETE');
            req4.setHeader('Authorization','Bearer ' + accToken);
           // req3.setHeader('Content-Type','application/json');
            // req4.setHeader('DELETE','text/xml');
            
         
           // string body3= '{\n'+' "name" : "ashish"\n'+'}';
           // req4.setBody(body4);
            
            try {
            res4 = http4.send(req4);
            //system.debug(res4);
             if (res4.getStatusCode() != 200)
             system.debug(res4); 
            
          
          System.debug('response body =\n' + res4.getBody()+'has succesfully deleted');
           //Map<String,String> res4 = (Map<String,String>) JSON.deserialize(res3.getBody(),Map<String,String>.class);
            
        //system.debug(res4);
            }
              catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res4.toString());
        }
            
          
       	
       	
       }
       
       //mehtod for updating sfaccount record simultanuously in both
        @Future(callout=true)
        webservice static void updateAccount(id localId, id accid)
       {
       	   loginintosalesforce();
       	   //PageReference   urlPg   = new PageReference(nexturl + '/services/data/v29.0/query');
       	
       	    HttpRequest req5 = new HttpRequest();
           HttpResponse res5 = new HttpResponse();
            Http http5 = new Http();
            req5.setEndpoint(nexturl+ '/services/data/v29.0/sobjects/Account/'+localId+'/?_HttpMethod=PATCH');
            req5.setMethod('POST');
            req5.setHeader('Authorization','Bearer ' + accToken);
            req5.setHeader('Content-Type','application/json');
           // req5.setHeader('accept','application/json');
            
            Account accupdate= new Account();
            Map<String, Schema.SObjectField> fldObjMap = schema.SObjectType.Account.fields.getMap();
             List<Schema.SObjectField> fldObjMapValues = fldObjMap.values();
             String query= 'select  ';
             String ex ='extId__c';
             //Schema.SObjectField ss= new Schema.SOBjectField(ex);
             for(Schema.SObjectField s : fldobjMapValues)
             {
             if(!s.getDescribe().getName().equals(ex))
             	query += ' '+s+',';
             }
             query= query.subString(0,query.length()-1);
             query +='   from Account where id = \''+accid+'\'';
  
             Account acc= Database.query(query);

             
             accupdate.name=acc.name;
             accupdate.AccountNumber= acc.AccountNumber;
             accupdate.Phone=acc.Phone;
             accupdate.Industry=acc.Industry;
            
            String body5 = JSON.serializePretty(accupdate);
            
           // string body3= '{\n'+' "name" : "ashish"\n'+'}';
            req5.setBody(body5);
            
            try {
            res5 = http5.send(req5);
            system.debug(res5);
             if (res5.getStatusCode() != 200)
             system.debug('not updated'+res5); 
            
          
           System.debug('response body =\n' + res5.getBody());
            }
        catch(System.CalloutException e) {
            System.debug('Callout error: '+ e);
            System.debug(res5.toString());
            }
            
          
       	
  	
       }
            
         
    

}