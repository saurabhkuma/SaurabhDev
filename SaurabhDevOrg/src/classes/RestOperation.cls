public with sharing class RestOperation {

public List<Account> accname{get;set;}

public RestOperation()
{
accname=  (List<Account>)restCRUD.queryAccount();
system.debug('hi'+accname);
 /*for(Account sob:acclObj)
{
system.debug(sob);
accname.add(sob.name);
}*/

}
public void setAccname()
{
accname=  (List<Account>)restCRUD.queryAccount();
}


}