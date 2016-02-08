trigger InsertOtherOrg on Account (after insert, after update) {
    
partnerSoapSforceCom.LoginResult loginResult;   
partnerSoapSforceCom.Soap sp;
if(loginResult==null)
{
 sp = new partnerSoapSforceCom.Soap();
String username = 'niteshmi@cybage.com';
String password = 'nallasopara@19FixWDirMeby0qmQgkn3O6fJ';
 loginResult = sp.login(username, password);
system.debug('   loginResult ' + loginResult);
}
else
{
sp.endpoint_x = loginResult.serverUrl;

soapSforceCom200608Apex.Apex apexWebSvc = new soapSforceCom200608Apex.Apex();

soapSforceCom200608Apex.SessionHeader_element sessionHeader = new soapSforceCom200608Apex.SessionHeader_element();

sessionHeader.sessionId = loginResult.sessionId;
partnerSoapSforceCom.SessionHeader_element header=new    partnerSoapSforceCom.SessionHeader_element();
     header.sessionId=loginResult.sessionId;
     sp.SessionHeader= header;

 for(Account aa:Trigger.old)
 {
    //spss.type_x='account';
    
     sobjectPartnerSoapSforceCom.SObject_x acc = new sobjectPartnerSoapSforceCom.SObject_x();
acc.type_x='account';

sobjectPartnerSoapSforceCom.SObject_x[] spss = new sobjectPartnerSoapSforceCom.SObject_x[1];
spss[0]=acc;
     sp.update_xSObjects(spss);
    system.debug('after update');
 }
 
}
}