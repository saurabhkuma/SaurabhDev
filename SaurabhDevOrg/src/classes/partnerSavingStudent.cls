global with sharing class partnerSavingStudent {
	

	
webservice static void updatestudent(id localId){
		
	    partnerSoapSforceCom.LoginResult loginResult;	
        partnerSoapSforceCom.Soap sp;

        sp = new partnerSoapSforceCom.Soap();
        String username = 'niteshmi@cybage.com';
        String password = 'nallasopara@19FixWDirMeby0qmQgkn3O6fJ';
        loginResult = sp.login(username, password);
        system.debug('   loginResult ' + loginResult);



       sp.endpoint_x= loginResult.serverUrl;
       partnerSoapSforceCom.SessionHeader_element header= new    partnerSoapSforceCom.SessionHeader_element();
       header.sessionId=loginResult.sessionId;
       sp.SessionHeader= header;

     
      student__c ac1= [select name,id,city__c,name__c from Student__c where id=:localId];
 	//spss.type_x='studount';
 	
      sobjectPartnerSoapSforceCom.SObject_x stud = new sobjectPartnerSoapSforceCom.SObject_x();
      stud.type_x='Student__c';
      stud.city= ac1.city__c;
      stud.name=ac1.name+'saurabh';
      stud.studname=ac1.name__c+'saurabh';

      sobjectPartnerSoapSforceCom.SObject_x[] spss = new sobjectPartnerSoapSforceCom.SObject_x[1];
      spss[0]=stud;
      //system.debug(sp.create(spss));
      PartnerSoapSforceCom.SaveResult[] responsestud= sp.create(spss);
      for(PartnerSoapSforceCom.SaveResult ps:responsestud)
      {
      ac1.ext_Id__c=ps.id;
      update ac1;
      }
 	  system.debug('after update');
 
 
    }
	
}