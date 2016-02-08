global with sharing class AuthenticationLogin implements Process.Plugin {
	
	
// The main method to be implemented. The Flow calls this at runtime.
global Process.PluginResult invoke(Process.PluginRequest request) { 
	   
	   
	  String Ip_Add = (String)request.inputParameters.get('IP_ADDRESS'); 
	  String emailid  = (String)request.inputParameters.get('EMAILADDRESS');
	  String userId  = (String)request.inputParameters.get('USERID');
	  Boolean  validOrNot =  Auth.SessionManagement.inOrgNetworkRange(Ip_Add);
	  String  SecurityCode = '' + (Math.random()*999999).intValue();
	  Map<String , Object> result = new Map<String, Object>();
	  result.put('VALIDORNOT', validOrNot);
	  result.put('SECURITYCODE', SecurityCode);
	  User userobj = [select email ,name from user where id =  :userId];
	  string userEmail = ''+userobj.email;
	  if(emailId.equals(userEmail)) 
	  {
	  	//send secuitycode to email ..
	  	Messaging.Singleemailmessage  emailmsg = new Messaging.Singleemailmessage();
	  	
	  	
	  	
	  	
	  	
	  }
	  return  new Process.Pluginresult(result);
	

      }
// Returns the describe information for the interface
    global Process.PluginDescribeResult describe() { 
    	
    	Process.Plugindescriberesult result = new  Process.Plugindescriberesult();
    	result.description ='this is for authenticate network accessbilit';
    	result.tag = 'saurabh';
    	result.inputParameters = new List<Process.Plugindescriberesult.Inputparameter>{
    		new Process.Plugindescriberesult.Inputparameter('IP_ADDRESS',Process.Plugindescriberesult.Parametertype.String, true),
    		new Process.Plugindescriberesult.Inputparameter('USERID',Process.Plugindescriberesult.Parametertype.String, true),
    		new Process.Plugindescriberesult.Inputparameter('EMAILADDRESS',Process.Plugindescriberesult.Parametertype.String, true)
    		
    	};
    	result.outPutParameters = new List<Process.Plugindescriberesult.Outputparameter>{
    		
    		new Process.Plugindescriberesult.Outputparameter('VALIDORNOT' ,Process.Plugindescriberesult.Parametertype.Boolean),
    		new Process.Plugindescriberesult.Outputparameter('SECURITYCODE' ,Process.Plugindescriberesult.Parametertype.String)
    	};
    	
    	return result;
    }	
    
    

}