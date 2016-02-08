global with sharing class combocontroller1 {

global  class SobjectWrapper
{
String name;
String id;

global  SobjectWrapper( Object n, Object i)
{

name= (String)n;
id=  (String)i;
}

}

@RemoteAction
global static List<SelectOption> getallObj()
{
 List<Schema.SobjectType> aso = Schema.getGlobalDescribe().Values();
 List<SelectOption> allso = new List<SelectOption>();
 for(Schema.SObjectType  f : aso)
 {
 
 SelectOption so = new SelectOption( f.getDescribe().getLabel(),f.getDescribe().getLabel());
 allso.add(so);
 
 }

return allso;
}

@RemoteAction
global static String getAllRecord(string objname)
{

string query = 'select name, id from '+objname;
string query1 = 'select  id from '+objname;
list<SObject> allsobj = new list<SObject>();
try{
 allsobj  = database.Query(query);
}
catch(Exception e)
{
 allsobj = database.Query(query1);
}
list<SobjectWrapper> allsobjw = new list<SobjectWrapper>();
for(SObject s : allsobj)
{
allsobjw.add( new SobjectWrapper(s.get('name'), s.get('id')));
}
String  jsonallrecord = JSON.serialize(allsobjw);
system.debug(jsonallrecord);
return '{\"Records\":'+jsonallrecord+',\"error\": \"null\", \"status\":\"SUCCESS\", \"count\":\"' + allsobj.size() + '\"}';

}
}