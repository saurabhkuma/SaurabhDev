global with sharing class partnersaving 
{
	
webservice static void updatesalesforce(id localId){
		
	    partnerSoapSforceCom.LoginResult loginResult;	
        partnerSoapSforceCom.Soap sp;

        sp = new partnerSoapSforceCom.Soap();
       // String username = 'niteshmi@cybage.com';
        //String password = 'nallasopara@19FixWDirMeby0qmQgkn3O6fJ';
        String username = 'rishuom@sales.com';
        String password = 'saurabh024cE41krFw1xvfIxlZIHQ4kYzWM';
        loginResult = sp.login(username, password);
        system.debug('   loginResult ' + loginResult);



       sp.endpoint_x= loginResult.serverUrl;
       partnerSoapSforceCom.SessionHeader_element header= new    partnerSoapSforceCom.SessionHeader_element();
       header.sessionId=loginResult.sessionId;
       sp.SessionHeader= header;

     
      Account ac1= [select name,id,phone,accountnumber,fax,industry from Account where id=:localId];
 	//spss.type_x='account';
 	
      sobjectPartnerSoapSforceCom.SObject_x acc = new sobjectPartnerSoapSforceCom.SObject_x();
      acc.type_x='Account';
      acc.phone= ac1.Phone;
      acc.AcctNum= ac1.AccountNumber;
      acc.name=ac1.name+'saurabh';
      acc.acctfax= ac1.Fax;
      acc.acctIndustry= ac1.Industry;
     

      sobjectPartnerSoapSforceCom.SObject_x[] spss = new sobjectPartnerSoapSforceCom.SObject_x[1];
      spss[0]=acc;
      system.debug(sp.create(spss));
 	  system.debug('after update');
 
 
    }
	
}