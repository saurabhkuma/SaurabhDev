global Class TwilloManager {

    public String fromPhoneNumber;
    Public String accountSid;
    Public String authToken;
    Private Static Final String Default_Version='2010-04-01';
    private String endpoint = 'https://api.twilio.com';
    private static final String VERSION = '3.2.0';
    public String accountName;
    public string tophone{get; set;}
    public string message {get; set;}    
    public TwilloManager(){
     
      MyTwilio_Configuration__c myconfig = MyTwilio_Configuration__c.getInstance();
      
      accountSid = myconfig.accountSID__c;
      authToken = myconfig.authToken__c;
      fromPhoneNumber = myconfig.From_Phone_Number__c;
      accountName = myconfig.AccountName__c;
        tophone= ' ';
       message =' ';
     
    
    }
    
   Public void sendSms()
   {
      system.debug('accountSid='+accountSid);
      system.debug('authToken ='+authToken );
      system.debug('this.authToken ='+this.authToken );
      system.debug('this.accountSid='+this.accountSid);
      integer AChar = tophone.charAt(0);
      String sAChar = String.fromCharArray(new List<Integer>{AChar});
      if(tophone.length() == 10 && sAChar=='9'||sAChar=='8'||sAChar=='7' )
      {
          tophone = '+91'+tophone;
      }
       system.debug(tophone);
      Map<String, String> params = new Map<String, String>();
      params.put('To',tophone);
      params.put('Body', message);
      params.put('From', fromPhoneNumber);
      
      String path = endpoint + '/' +Default_Version+ '/Accounts/' +this.accountSid + '/SMS/Messages.json';
      System.debug('path  :-'+path);
      URL uri = new URL(path);
      //encoding params
      String Entity= '';
      if(params!=null)
      {
       for(String key : params.keyset())
       {
        try{
        
        Entity += (Entity==''?'':'&')+ key+'='+ EncodingUtil.urlEncode(params.get(key), 'UTF-8');
            }
        catch(Exception e)
           {
             System.debug('ERROR' +e);
           }
        }                           
      
       }
       
        System.debug('Entity is --'+Entity);
       //creating httprequest
        HttpRequest request = new HttpRequest();
        request.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);
        request.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);
        request.setHeader('Accept', 'application/json');
        request.setHeader('Accept-Charset', 'utf-8');
        request.setHeader('Authorization', 'Basic '+EncodingUtil.base64Encode(Blob.valueOf(this.accountSid + ':' +this.authToken)));
        request.setEndpoint(uri.toExternalForm());
        request.setMethod('POST');
        request.setBody(Entity);
   
   
      //making request by http(rest)
      HttpResponse response = new Http().send(request);
       System.debug('response   :'+response);
       integer status = Integer.valueOf(response.getStatus());
       
       String responseText = response.getBody();
       map<string, object> responsemap = (map<string, object>)JSON.deserializeUntyped(responseText);

       system.debug('responseText   :-'+responseText);
       if(status >=200 && status<400)
       {
       ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'Message has been sent'));
       apexpages.addMessage(new apexpages.Message(Apexpages.Severity.CONFIRM, 'hi'));
       }
   } 


    
     public void callCustomer()
     {
         
        Map<String,String>  params=new Map<String,String>();
		params.put('From',fromPhoneNumber );
		params.put('To', tophone);
		params.put('Url', 'https://api.twilio.com/2010-04-01/Accounts/AC47c669100ce356873ce603de9e83dc01/Calls.json');
         
     }
}