global with sharing class UserOperation {

    public String  Name{get; set;}
    public Map<String, User> mUser{get; set;}
    public Boolean newuser{get; set;} 
    public User nUser{get{return new User();} set;}
    
    public UserOperation()
    {
        
        Name ='';
        
        //mUser = new Map<String, User>();
    }
    public UserOperation(ApexPages.StandardController controller)
    {
        Name ='';
        //nUser = new User();
       // mUser = new Map<String, User>();
    }
    public void searchUser()
    {
        newuser= false;
        if(Name!='')
        {
        Name= '%'+Name +'%';
        mUser = new Map<String, User>([select Id,Name, Email,isActive, title,Profile.name , userRole.name from user where name like :Name]);
        }
        
        
    }
    
    public void deactivateUser()
    {
        String  userid = ApexPages.currentPage().getParameters().get('selectedUserId');
        User u = mUser.get(userid);
        u.isActive = false;
        update u;    
    }
    public void activateUser()
    {
        String  userid = ApexPages.currentPage().getParameters().get('selectedUserId');
        User u = mUser.get(userid);
        u.isActive = true;
        update u;    
    }
    
    //method for editing User
    public PageReference editUser()
    {
         PageReference pref = new PageReference('/'+ApexPages.currentPage().getParameters().get('selectedUserId')+'/e?retURL='+ApexPages.currentPage().getParameters().get('selectedUserId')+'');
        return pref;
    
    }
    
    //pop up related function
    
    public PageReference showcontroller()
    {
        system.debug('before=='+newuser);
        if(newuser==false || newuser==null)
        {
        newuser= true;
        }
        else 
        newuser= false;
              system.debug('after=='+newuser);
        return null;
    }
    
    //method for creating new user
    public void  createNewUser()
    {
        
         
        system.debug(nUser.FirstName);
        if(nUser.LastName!=null&& nUser.LastName != '' && nUser.Email !=null && nuser.Email != '')
        {
          
            
         insert nUser ;   
            
         ApexPages.addMessage( new  ApexPages.Message(Apexpages.Severity.CONFIRM, 'user has been created'));
        }
        else
        {
           ApexPages.addMessage( new  ApexPages.Message(ApexPages.Severity.ERROR,'last name and email is required'));  
        }
      
        
        
    }
    //method for reset password of user
    @RemoteAction
    global static String  doResetPassword(String UserId)
    {
        String result = doChangePassword(UserId, 'password1234');
        system.debug(result);
        return result;
    }
      @RemoteAction
    global static String doChangePassword(String UserId, String newPassword)
    {
          System.debug(UserId);
         String  result ='';
        if(newPassword==null||newPassword=='')
        {
                System.Resetpasswordresult passresult = System.resetPassword(UserId,True);
                result ='new mail with password link has been sent to user : default password is'+passresult.getPassword()+'';
                system.debug(result);
        }       
        else
        {
                System.setPassword( userID, newPassword);
                result ='password has been changed to '+newPassword+'';
                
        }
        system.debug(result);
        return result;
        
    }
    
}