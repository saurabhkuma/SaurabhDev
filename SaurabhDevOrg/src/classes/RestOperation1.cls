public with sharing class RestOperation1 {


public List<Account> accname{get;set;}
public id accselected{get;set;}
public Account selectedAccount{get;set;}

public RestOperation1()
{
accname=  (List<Account>)restCRUD.queryAccount();
system.debug('hi'+accname);

}

public  list<SelectOption> getaccountlist()
    {
    list<selectoption> opt= new list<selectoption>();
    for(Account c:accname)
    {
        
    opt.add(new SelectOption(c.id,c.name));
    }
    return opt;
    }
    
    public void search()
    {
    system.debug('in search');
    selectedAccount= (Account)restCRUD.searchAccount(accselected);
    system.debug(selectedAccount);
   
    }


}